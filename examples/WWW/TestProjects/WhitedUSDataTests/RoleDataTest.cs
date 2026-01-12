using WhitedUS.Data.MembershipRoleProvider;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace WhitedUSDataTests
{
    
    
    /// <summary>
    ///This is a test class for RoleDataTest and is intended
    ///to contain all RoleDataTest Unit Tests
    ///</summary>
    [TestClass()]
    [DeploymentItem("WhitedUSDataTests.dll.config")] 
    public class RoleDataTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for GetUsersInRole
        ///</summary>
        [TestMethod()]
        public void GetUsersInRoleTest()
        {
            Assert.IsTrue(RoleData.GetUsersInRole("Admin").Length > 0);
        }

        /// <summary>
        ///A test for GetAllRoles
        ///</summary>
        [TestMethod()]
        public void GetAllRolesTest()
        {
            var results = RoleData.GetAllRoles();
            Assert.IsTrue(results.Length > 0);
        }

        /// <summary>
        ///A test for RoleData Constructor
        ///</summary>
        [TestMethod()]
        public void RoleDataConstructorTest()
        {
            RoleData target = new RoleData();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        /// <summary>
        ///A test for FindUsersInRole
        ///</summary>
        [TestMethod()]
        public void FindUsersInRoleTest()
        {
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            string usernamePattern = string.Empty; // TODO: Initialize to an appropriate value
            string[] expected = null; // TODO: Initialize to an appropriate value
            string[] actual;
            actual = RoleData.FindUsersInRole(roleName, usernamePattern);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for DeleteRole
        ///</summary>
        [TestMethod()]
        public void DeleteRoleTest()
        {
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            RoleData.DeleteRole(roleName);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for CreateRole
        ///</summary>
        [TestMethod()]
        public void CreateRoleTest()
        {
            string roleName = "Friends"; // TODO: Initialize to an appropriate value
            RoleData.CreateRole(roleName);
        }

        /// <summary>
        ///A test for RoleData Constructor
        ///</summary>
        [TestMethod()]
        public void RoleDataConstructorTest1()
        {
            RoleData target = new RoleData();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
