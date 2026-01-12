using System;
using System.Collections;
using System.ComponentModel;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.Design.WebControls;
using System.Diagnostics;
using System.Linq;
using System.Collections.Generic;

namespace WhitedUS.Web.Controls
{
    [ToolboxData("<{0}:GalleryView runat=server></{0}:GalleryView>")]
    [DefaultProperty("DataSource")]
    [DefaultEvent("ItemCommand")]
    [PersistChildren(false)]
    [ParseChildren(true)]
    [AspNetHostingPermission(SecurityAction.LinkDemand | 
                                SecurityAction.InheritanceDemand, 
                             Level = AspNetHostingPermissionLevel.Minimal)]
    public partial class GalleryView : Repeater, 
                                        IPostBackContainer, 
                                        IPostBackEventHandler 
                                        //, INamingContainer
    {
        private ArrayList itemsArray;
        private Table table = new Table();
        private PagerSettings _pagerSettings;
        private IList<object> _pagedDataSource;
        private int _pageCount = 0;

        private void OnPagerPropertyChanged(object sender, EventArgs e)
        {
            if (base.Initialized)
                base.RequiresDataBinding = true;
        }

        protected override void CreateControlHierarchy(bool useDataSource)
        {
            ICollection data = null;
            int dataItemCount = -1;
            if (this.itemsArray != null)
                this.itemsArray.Clear();
            else
                this.itemsArray = new ArrayList();

            if (table != null)
                this.table.Rows.Clear();
            else
                this.table = new Table();

            if (!useDataSource)
            {
                dataItemCount = (int)this.ViewState["_!ItemCount"];
                if (dataItemCount != -1)
                {
                    data = new DummyDataSource(dataItemCount);
                    this.itemsArray.Capacity = dataItemCount;
                }
            }
            else
            {
                data = (ICollection)PagedDataSource;
                ICollection is2 = data as ICollection;
                if (is2 != null)
                    this.itemsArray.Capacity = is2.Count;
            }

            if (data != null && data.Count > 0)
            {
                data.OfType<object>().Count();

                int itemIndex = 0;
                bool flag = this.SeparatorTemplate != null;
                dataItemCount = 0;
                if (this.HeaderTemplate != null)
                    this.CreateRow(ListItemType.Header, useDataSource, null);

                int rowCnt = -1;
                int cellCnt = -1;
                TableRow row = new TableRow();
                foreach (object obj2 in data)
                {
                    dataItemCount++;
                    itemIndex++;

                    var itemType = ((itemIndex % 2) == 0) 
                                        ? ListItemType.Item 
                                        : ListItemType.AlternatingItem;
                    this.CreateItem(itemIndex, dataItemCount, itemType, 
                                    useDataSource, obj2, row);

                    cellCnt++;
                    if (cellCnt >= GalleryWidth - 1)
                    {
                        cellCnt = -1;
                        table.Rows.Add(row);
                        row = new GridViewRow(rowCnt, 
                                              dataItemCount, 
                                              DataControlRowType.DataRow, 
                                              DataControlRowState.Normal);
                        rowCnt++;
                        if (rowCnt >= GalleryHeight - 1 && AllowPaging)
                            break;
                    }
                }
                if (cellCnt > -1)
                {
                    if (SeparatorTemplate != null)
                        for (int i = 0; i < GalleryWidth - cellCnt - 1; i++)
                            this.CreateItem(itemIndex++, 
                                            -1, 
                                            ListItemType.Separator, 
                                            useDataSource, 
                                            null, 
                                            row);

                    table.Rows.Add(row);
                }

                if (AllowPaging)
                    this.CreateRow(ListItemType.Pager, useDataSource, null);

                if (this.FooterTemplate != null)
                    this.CreateRow(ListItemType.Footer, useDataSource, null);

                this.Controls.Add(table);

                if (table.Rows.Count > 0 && useDataSource)
                    table.DataBind();

            }
            if (useDataSource)
                this.ViewState["_!ItemCount"] = (data != null) 
                                                    ? dataItemCount 
                                                    : -1;
        }

        protected virtual void CreateRow(ListItemType itemType, 
                                         bool dataBind, 
                                         object dataItem)
        {
            var item = this.CreateItem(-1, itemType);
            if (itemType == ListItemType.Pager)
            {
                item.Controls.Add(InitializePager());
            }
            var e = new RepeaterItemEventArgs(item);
            this.InitializeItem(item);
            if (dataBind)
                item.DataItem = dataItem;

            this.OnItemCreated(e);

            var row = new TableRow();
            var cell = new TableCell() { ColumnSpan = this.GalleryWidth };
            cell.Controls.Add(item);
            row.Cells.Add(cell);
            table.Rows.Add(row);
        }

        protected virtual void CreateItem(int itemIndex, 
                                          int dataItemIndex, 
                                          ListItemType itemType, 
                                          bool dataBind, 
                                          object dataItem, 
                                          TableRow row)
        {
            var item = new RepeaterItem(itemIndex, itemType);
            var e = new RepeaterItemEventArgs(item);

            this.InitializeItem(item);

            if (dataBind)
                item.DataItem = dataItem;

            this.OnItemCreated(e);

            var cell = new TableCell();
            cell.Controls.Add(item);
            row.Cells.Add(cell);
            this.itemsArray.Add(cell);
        }

        protected override void OnDataBinding(EventArgs e)
        {
            _pagedDataSource = null;
            base.OnDataBinding(e);
        }

        protected virtual IList<object> PagedDataSource
        {
            get
            {
                if (_pagedDataSource == null)
                {
                    IEnumerable eData = GetData();
                    if (eData != null)
                    {
                        if (AllowPaging)
                        {
                            IEnumerable<object> data = eData.OfType<object>();
                            _pagedDataSource = data.Skip(PageSize * PageIndex)
                                                   .Take(PageSize)
                                                   .ToList();
                            _pageCount = (int)Math.Ceiling(
                                                (float)data.Count() / 
                                                (float)this.PageSize
                                                );
                        }
                        else
                        {
                            _pagedDataSource = eData.OfType<object>().ToList();
                            _pageCount = 0;
                        }
                    }
                }
                return _pagedDataSource;
            }
        }

        protected virtual Control InitializePager()
        {
            Control ctrl = new Control();
            PagerSettings pagerSettings = this.PagerSettings;
            if (this.PagerTemplate != null)
            {
                PagerTemplate.InstantiateIn(ctrl);
            }
            else
            {
                switch (pagerSettings.Mode)
                {
                    case PagerButtons.NextPrevious:
                        this.CreateNextPrevPager(ctrl, false);
                        break;

                    case PagerButtons.Numeric:
                        this.CreateNumericPager(ctrl, false);
                        break;

                    case PagerButtons.NextPreviousFirstLast:
                        this.CreateNextPrevPager(ctrl, true);
                        break;

                    case PagerButtons.NumericFirstLast:
                        this.CreateNumericPager(ctrl, true);
                        break;
                }
            }
            return ctrl;
        }

        #region Properties

        [DefaultValue(true)]
        public bool AllowPaging
        {
            get
            {
                object _obj = this.ViewState["AllowPaging"];
                if (_obj != null)
                    return (bool)_obj;
                return true;
            }
            set
            {
                if (this.AllowPaging != value)
                {
                    this.ViewState["AllowPaging"] = value;
                    if (base.Initialized)
                        base.RequiresDataBinding = true;
                }
            }
        }

        [DefaultValue(5)]
        public int GalleryHeight
        {
            get
            {
                object _obj = this.ViewState["GalleryHeight"];
                if (_obj != null)
                    return (int)_obj;
                return 5;
            }
            set
            {
                if (value < 1)
                    throw new ArgumentOutOfRangeException("value");
                if (this.GalleryHeight != value)
                {
                    this.ViewState["GalleryHeight"] = value;
                    if (base.Initialized)
                        base.RequiresDataBinding = true;
                }
            }
        }

        [DefaultValue(5)]
        public int GalleryWidth
        {
            get
            {
                object _obj = this.ViewState["GalleryWidth"];
                if (_obj != null)
                    return (int)_obj;
                return 5;
            }
            set
            {
                if (value < 1)
                    throw new ArgumentOutOfRangeException("value");
                if (this.GalleryHeight != value)
                {
                    this.ViewState["GalleryWidth"] = value;
                    if (base.Initialized)
                        base.RequiresDataBinding = true;
                }
            }
        }

        [DesignerSerializationVisibility(
            DesignerSerializationVisibility.Hidden)]
        [NotifyParentProperty(true)]
        public int PageSize { get { return GalleryHeight * GalleryWidth; } }

        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(
            DesignerSerializationVisibility.Content)]
        [NotifyParentProperty(true)]
        public virtual PagerSettings PagerSettings
        {
            get
            {
                if (this._pagerSettings == null)
                {
                    this._pagerSettings = new PagerSettings();
                    if (base.IsTrackingViewState)
                    {
                        ((IStateManager)this._pagerSettings).TrackViewState();
                    }
                    this._pagerSettings.PropertyChanged += 
                        new EventHandler(this.OnPagerPropertyChanged);
                }
                return this._pagerSettings;
            }
        }

        [Browsable(false)]
        [DefaultValue((string)null)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(
            DesignerSerializationVisibility.Content)]
        [TemplateContainer(typeof(RepeaterItem))]
        public virtual ITemplate PagerTemplate { get; set; }

        [DefaultValue(0)]
        [Browsable(false)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        [DesignerSerializationVisibility(
            DesignerSerializationVisibility.Hidden)]
        public int PageIndex
        {
            get {
                if (this.ViewState["PageIndex"] != null)
                    return (int)this.ViewState["PageIndex"];
                else
                    return 0;
            }
            set
            {
                if (value < 0)
                    throw new ArgumentOutOfRangeException("value");
                
                if (this.ViewState["PageIndex"] == null ||
                    ((int)this.ViewState["PageIndex"]) != value)
                {
                    this.ViewState["PageIndex"] = value;
                    if (base.Initialized)
                        base.RequiresDataBinding = true;
                }
            }
        }

        [Browsable(false)]
        [DesignerSerializationVisibility(
            DesignerSerializationVisibility.Hidden)]
        public int PageCount
        {
            get
            {
                if (this._pageCount < 0)
                    _pageCount = 0;

                return this._pageCount;
            }
        }

        #endregion

        #region IPostBackContainer Members

        PostBackOptions IPostBackContainer.GetPostBackOptions(
            IButtonControl buttonControl)
        {
            if (buttonControl == null)
            {
                throw new ArgumentNullException("buttonControl");
            }
            if (buttonControl.CausesValidation)
            {
                throw new InvalidOperationException(
                    "CannotUseParentPostBackWhenValidating");
            }
            var options = new PostBackOptions(this, 
                                              buttonControl.CommandName + "$" 
                                              + buttonControl.CommandArgument);
            options.RequiresJavaScriptProtocol = true;
            return options;
        }

        #endregion

        #region IPostBackEventHandler Members

        public void RaisePostBackEvent(string eventArgument)
        {
            int index = eventArgument.IndexOf('$');
            if (index >= 0)
            {
                string commandName = eventArgument.Substring(0, index);
                string commandArg = eventArgument.Substring(index + 1);

                if (string.Compare("Page", commandName, true) == 0)
                {
                    if (string.Compare(commandArg, "Next", true) == 0)
                        PageIndex++;
                    else if (string.Compare(commandArg, "Prev", true) == 0)
                        PageIndex--;
                    else if (string.Compare(commandArg, "First", true) == 0)
                        PageIndex = 0;
                    else if (string.Compare(commandArg, "Last", true) == 0)
                        PageIndex = this.PageCount - 1;
                    else
                    {
                        int pageIndex = 0;
                        if (int.TryParse(commandArg, out pageIndex))
                            PageIndex = pageIndex - 1;
                    }

                }
            }
        }

        #endregion
    }
}
