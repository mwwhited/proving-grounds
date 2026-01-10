using OobDev.InfrastructureSurvey.Accessors;
using OobDev.InfrastructureSurvey.Common.Xml.Schema;
using OobDev.InfrastructureSurvey.Common.Xml.Xsl;
using OobDev.InfrastructureSurvey.Identity;
using OobDev.InfrastructureSurvey.Models.Questionnaires;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;
using System.Xml.Schema;

namespace OobDev.InfrastructureSurvey.Web.Areas.Survey.Controllers
{
    [RoutePrefix("Questionnaire")]
    [Authorize]
    public class QuestionnairesController : Controller
    {
        public QuestionnairesController()
        {

        }

        private QuestionnaireAccessor _accessor;
        public QuestionnaireAccessor Accessor
        {
            get { return _accessor ?? (_accessor = new QuestionnaireAccessor()); }
            private set { _accessor = value; }
        }

        private Task<ItricaIdentity> GetUser()
        {
            return this.UserManager.FindByIdAsync(Guid.Parse(this.User.Identity.GetUserId()));
        }
        public ItricaUserManager _userManager { get; set; }
        public ItricaUserManager UserManager
        {
            get { return _userManager ?? (_userManager = this.HttpContext.GetOwinContext().GetUserManager<ItricaUserManager>()); }
            private set { _userManager = value; }
        }

        [Route]
        public ActionResult Index()
        {
            //return View(this.Accessor.Surveys());
            throw new NotImplementedException();
        }

        [Route("Survey/{surveyName}")]
        public async Task<ActionResult> Survey(string surveyName)
        {
            var user = await this.GetUser();

            if (user == null || string.IsNullOrEmpty(user.UserName))
            {
                return this.RedirectToAction("Profile", "Account", new { area = "" });
            }

            var submittedData = new Dictionary<string, string>{
                {"CustomerName", user.FullName},
                {"CustomerCompany", user.Company},
                {"CustomerTitle", user.Title},
                {"CustomerEmailAddress", user.EmailAddress},
                {"CustomerPhoneNumber", user.PhoneNumber},
            }.Concat(this.Request.Form.AsKeyValuePair())
             .AsSurveyData();

            var xmlStylesheetPath = this.HttpContext.Server.MapPath("~/Views/Questionnaires/Survey.xslt");
            var surveyTemplatePath = this.HttpContext.Server.MapPath("~/Views/Questionnaires/" + surveyName + ".xml");

            var form = XslCompiledTransformEx.Transform(xmlStylesheetPath, surveyTemplatePath, submittedData, this.Url);

            return this.View(model: form);
        }

        [Route("Survey/{surveyName}")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> SurveyPost(string surveyName)
        {
            var user = await this.GetUser();

            if (user == null || string.IsNullOrEmpty(user.UserName))
            {
                return this.RedirectToAction("Profile", "Account", new { area = "" });
            }

            var submittedData = this.Request.Form.AsSurveyData();

            await this.Accessor.Submit(surveyName, user.UserId, submittedData);

            var xmlStylesheetPath = this.HttpContext.Server.MapPath("~/Views/Questionnaires/Survey.xslt");
            var surveyTemplatePath = this.HttpContext.Server.MapPath("~/Views/Questionnaires/" + surveyName + ".xml");
            var form = XslCompiledTransformEx.Transform(xmlStylesheetPath, surveyTemplatePath, submittedData, this.Url);

            return this.View(viewName: "Survey", model: form);
        }

        [Route("Survey/{surveyName}")]
        [HttpPut]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> SurveyPut(string surveyName)
        {
            var user = await this.GetUser();
            var submittedData = this.Request.Form.AsSurveyData();

            await this.Accessor.Save(surveyName, user.UserId, submittedData);

            return this.Json(new { result = true, });
        }

        [Route("Manage")]
        [Authorize(Roles = "Questionnaires.FormEditor")]
        public ActionResult Manage()
        {
            var query = this.Accessor.List();
            return this.View(query);
        }

        [Route("Manage/{id:int}")]
        [Authorize(Roles = "Questionnaires.FormEditor")]
        public ActionResult Edit(int id)
        {
            var model = this.Accessor.List().SingleOrDefault(q => q.FormID == id) ?? new FormModel { };
            return this.View(model);
        }

        [Route("Manage/{id:int}")]
        [Authorize(Roles = "Questionnaires.FormEditor")]
        [ValidateInput(false)]
        [HttpPost]
        public async Task<ActionResult> Edit(int id, FormModel model)
        {
            if (this.ModelState.IsValid)
            {
                // Note: Validation XML against XSD
                var validator = new XmlSchemaValidatorEx(new[]
                {
                      this.Server.MapPath("~/Content/XmlSchemas/Survey.xsd"),
                      //this.Server.MapPath("~/Content/XmlSchemas/Survey-Data.xsd"),
                });
                var validationResults = validator.GetResults(model.DefinitionXml);
                var result = true;
                foreach (var validationResult in validationResults)
                {
                    this.ModelState.AddModelError("", $"XSD {validationResult.Severity}: {validationResult.Message}");
                    if (validationResult.Severity == XmlSeverityType.Error)
                        result = false;
                }

                if (result)
                {
                    await this.Accessor.Save(model);
                    //return this.RedirectToAction("Manage");
                }
            }

            return this.View(model);
        }
    }
}