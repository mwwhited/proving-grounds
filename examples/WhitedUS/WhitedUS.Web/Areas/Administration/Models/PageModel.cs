using System;
using System.Collections.Generic;

namespace WhitedUS.Web.Areas.Administration.Models
{
    public class PageModel
    {
        public static PageModel<T> ToModel<T>(int page, int pageSize, int count, IEnumerable<T> rows)
        {
            return new PageModel<T>
            {
                Page = page,
                PageSize = pageSize,
                TotalRowCount = count,
                TotalPageCount = (int)Math.Ceiling((decimal)count / (decimal)pageSize),
                Rows = rows,
            };
        }
    }
    public class PageModel<T> : PageModel
    {
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalRowCount { get; set; }
        public int TotalPageCount { get; set; }
        public IEnumerable<T> Rows { get; set; }
    }
}