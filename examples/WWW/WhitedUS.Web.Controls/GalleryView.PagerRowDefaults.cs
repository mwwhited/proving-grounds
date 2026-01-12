using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WhitedUS.Web.Controls
{
    public partial class GalleryView
    {
        private string BuildCallbackArgument(int pageIndex)
        {
            return string.Concat(new object[] { "\"", pageIndex, "\"" }); 
        }

        private int FirstDisplayedPageIndex
        {
            get
            {
                object obj2 = this.ViewState["FirstDisplayedPageIndex"];
                if (obj2 != null)
                {
                    return (int)obj2;
                }
                return -1;
            }
            set
            {
                this.ViewState["FirstDisplayedPageIndex"] = value;
            }
        }

        private void CreateNextPrevPager(Control ctrl, 
                                         bool addFirstLastPageButtons)
        {
            IList<object> pagedDataSource = PagedDataSource;
            PagerSettings pagerSettings = this.PagerSettings;
            string previousPageImageUrl = pagerSettings.PreviousPageImageUrl;
            string nextPageImageUrl = pagerSettings.NextPageImageUrl;
            bool isFirstPage = PageIndex == 0;
            bool isLastPage = PageIndex >= PageCount - 1;

            if (addFirstLastPageButtons && !isFirstPage)
            {
                IButtonControl control;
                string firstPageImageUrl = pagerSettings.FirstPageImageUrl;
                if (firstPageImageUrl.Length > 0)
                {
                    control = new DataControlImageButton(this)
                    {
                        ImageUrl = firstPageImageUrl,
                        AlternateText = HttpUtility.HtmlDecode(
                                                pagerSettings.FirstPageText)
                    };
                    ((DataControlImageButton)control).EnableCallback(
                                                this.BuildCallbackArgument(0));

                }
                else
                {
                    control = new DataControlPagerLinkButton(this)
                    {
                        Text = pagerSettings.FirstPageText
                    };
                    ((DataControlPagerLinkButton)control).EnableCallback(
                                                this.BuildCallbackArgument(0));
                }
                control.CommandName = "Page";
                control.CommandArgument = "First";
                ctrl.Controls.Add((Control)control);
            }
            if (!isFirstPage)
            {
                IButtonControl control2;
                if (previousPageImageUrl.Length > 0)
                {
                    control2 = new DataControlImageButton(this)
                    {
                        ImageUrl = previousPageImageUrl,
                        AlternateText = HttpUtility.HtmlDecode(
                                                pagerSettings.PreviousPageText)
                    };
                    ((DataControlImageButton)control2).EnableCallback(
                            this.BuildCallbackArgument(this.PageIndex - 1));
                }
                else
                {
                    control2 = new DataControlPagerLinkButton(this)
                    {
                        Text = pagerSettings.PreviousPageText
                    };
                    ((DataControlPagerLinkButton)control2).EnableCallback(
                            this.BuildCallbackArgument(this.PageIndex - 1));
                }
                control2.CommandName = "Page";
                control2.CommandArgument = "Prev";
                ctrl.Controls.Add((Control)control2);
            }
            if (!isLastPage)
            {
                IButtonControl control3;
                if (nextPageImageUrl.Length > 0)
                {
                    control3 = new DataControlImageButton(this)
                    {
                        ImageUrl = nextPageImageUrl,
                        AlternateText = HttpUtility.HtmlDecode(
                                                    pagerSettings.NextPageText)
                    };
                    ((DataControlImageButton)control3).EnableCallback(
                            this.BuildCallbackArgument(this.PageIndex + 1));
                }
                else
                {
                    control3 = new DataControlPagerLinkButton(this)
                    {
                        Text = pagerSettings.NextPageText
                    };
                    ((DataControlPagerLinkButton)control3).EnableCallback(
                            this.BuildCallbackArgument(this.PageIndex + 1));
                }
                control3.CommandName = "Page";
                control3.CommandArgument = "Next";
                ctrl.Controls.Add((Control)control3);
            }
            if (addFirstLastPageButtons && !isLastPage)
            {
                IButtonControl control4;
                string lastPageImageUrl = pagerSettings.LastPageImageUrl;
                if (lastPageImageUrl.Length > 0)
                {
                    control4 = new DataControlImageButton(this)
                    {
                        ImageUrl = lastPageImageUrl,
                        AlternateText = HttpUtility.HtmlDecode(
                                                    pagerSettings.LastPageText)
                    };
                    ((DataControlImageButton)control4).EnableCallback(
                            this.BuildCallbackArgument(this.PageCount - 1));
                }
                else
                {
                    control4 = new DataControlPagerLinkButton(this)
                    {
                        Text = pagerSettings.LastPageText
                    };
                    ((DataControlPagerLinkButton)control4).EnableCallback(
                            this.BuildCallbackArgument(this.PageCount - 1));
                }
                control4.CommandName = "Page";
                control4.CommandArgument = "Last";
                ctrl.Controls.Add((Control)control4);
            }

            ///TODO: theme this control
            ctrl.Controls.Add(new LiteralControl("&nbsp;&nbsp;"));
        }

        private void CreateNumericPager(Control ctrl, 
                                        bool addFirstLastPageButtons)
        {
            IList<object> pagedDataSource = PagedDataSource;

            PagerSettings pagerSettings = PagerSettings;

            int pages = this.PageCount;
            int currentPage = this.PageIndex + 1;
            int pageSetSize = pagerSettings.PageButtonCount;
            int pagesShown = pageSetSize;

            // first page displayed on last postback
            int firstDisplayedPage = FirstDisplayedPageIndex + 1;

            // ensure the number of pages we show isn't more than the 
            // number of pages that do exist
            if (pages < pagesShown)
                pagesShown = pages;

            // initialize to the first page set, i.e., pages 1 through 
            // number of pages shown 
            int firstPage = 1;
            int lastPage = pagesShown;

            if (currentPage > lastPage)
            {
                // The current page is not in the first page set, then 
                // we need to slide the range of pages shown by adjusting 
                // firstPage and lastPage 
                int currentPageSet = this.PageIndex / pageSetSize;
                bool currentPageInLastDisplayRange = 
                    currentPage - firstDisplayedPage >= 0 && 
                    currentPage - firstDisplayedPage < pageSetSize;
                if (firstDisplayedPage > 0 && currentPageInLastDisplayRange)
                {
                    firstPage = firstDisplayedPage;
                }
                else
                {
                    firstPage = currentPageSet * pageSetSize + 1;
                }
                lastPage = firstPage + pageSetSize - 1;

                // now bring back lastPage into the range if its exceeded 
                // the number of pages
                if (lastPage > pages)
                    lastPage = pages;

                // if theres room to show more pages from the previous page 
                // set, then adjust the first page accordingly 
                if (lastPage - firstPage + 1 < pageSetSize)
                    firstPage = Math.Max(1, lastPage - pageSetSize + 1);

                FirstDisplayedPageIndex = firstPage - 1;
            }

            LinkButton button;
            if (addFirstLastPageButtons && currentPage != 1 && firstPage != 1)
            {
                string firstPageImageUrl = pagerSettings.FirstPageImageUrl;

                IButtonControl firstButton;
                if (firstPageImageUrl.Length > 0)
                {
                    firstButton = new DataControlImageButton(this)
                    {
                        ImageUrl = firstPageImageUrl,
                        AlternateText = HttpUtility.HtmlDecode(
                                                pagerSettings.FirstPageText)
                    };
                    ((DataControlImageButton)firstButton).EnableCallback(
                                                BuildCallbackArgument(0));
                }
                else
                {
                    firstButton = new DataControlPagerLinkButton(this)
                    {
                        Text = pagerSettings.FirstPageText
                    };
                    ((DataControlPagerLinkButton)firstButton).EnableCallback(
                                                BuildCallbackArgument(0));
                }
                firstButton.CommandName = DataControlCommands.PageCommandName;
                firstButton.CommandArgument = 
                                DataControlCommands.FirstPageCommandArgument;
                ctrl.Controls.Add((Control)firstButton);
            }

            if (firstPage != 1)
            {
                button = new DataControlPagerLinkButton(this);
                button.Text = "...";
                button.CommandName = DataControlCommands.PageCommandName;
                button.CommandArgument = 
                    (firstPage - 1).ToString(NumberFormatInfo.InvariantInfo);
                ((DataControlPagerLinkButton)button).EnableCallback(
                                        BuildCallbackArgument(firstPage - 2));
                ctrl.Controls.Add(button);
            }

            for (int i = firstPage; i <= lastPage; i++)
            {
                var pageString = (i).ToString(NumberFormatInfo.InvariantInfo);
                if (i == currentPage)
                {
                    Label label = new Label();

                    label.Text = pageString;
                    ctrl.Controls.Add(label);
                }
                else
                {
                    button = new DataControlPagerLinkButton(this)
                    {
                        Text = pageString,
                        CommandName = DataControlCommands.PageCommandName,
                        CommandArgument = pageString
                    };
                    ((DataControlPagerLinkButton)button).EnableCallback(
                                                BuildCallbackArgument(i - 1));
                    ctrl.Controls.Add(button);
                }
            }

            if (pages > lastPage)
            {
                button = new DataControlPagerLinkButton(this)
                {
                    Text = "...",
                    CommandName = DataControlCommands.PageCommandName,
                    CommandArgument = 
                        (lastPage + 1).ToString(NumberFormatInfo.InvariantInfo)
                };
                ((DataControlPagerLinkButton)button).EnableCallback(
                                            BuildCallbackArgument(lastPage));
                ctrl.Controls.Add(button);
            }

            bool isLastPageShown = lastPage == pages;
            if (addFirstLastPageButtons && 
                currentPage != pages &&
                !isLastPageShown)
            {
                string lastPageImageUrl = pagerSettings.LastPageImageUrl;
                IButtonControl lastButton;
                if (lastPageImageUrl.Length > 0)
                {
                    lastButton = new DataControlImageButton(this)
                    {
                        ImageUrl = lastPageImageUrl,
                        AlternateText = HttpUtility.HtmlDecode(
                                                    pagerSettings.LastPageText)
                    };
                    ((DataControlImageButton)lastButton).EnableCallback(
                                    BuildCallbackArgument(this.PageCount - 1));
                }
                else
                {
                    lastButton = new DataControlPagerLinkButton(this)
                    {
                        Text = pagerSettings.LastPageText
                    };
                    ((DataControlPagerLinkButton)lastButton).EnableCallback(
                                    BuildCallbackArgument(this.PageCount - 1));
                }
                lastButton.CommandName = DataControlCommands.PageCommandName;
                lastButton.CommandArgument = 
                                DataControlCommands.LastPageCommandArgument;
                ctrl.Controls.Add((Control)lastButton);
            }

            ///TODO: theme this control
            ctrl.Controls.Add(new LiteralControl("&nbsp;&nbsp;"));
        }
    }
}
