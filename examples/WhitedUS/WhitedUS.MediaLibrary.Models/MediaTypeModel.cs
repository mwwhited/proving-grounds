using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;

namespace WhitedUS.MediaLibrary.Models
{
    public class MediaTypeModel
    {
        public int LocalID { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        [Range(1,int.MaxValue)]
        public int CodeTypeID { get; set; }

        public CodeTypeSimpleModel CodeType { get; set; }
        public IQueryable<CodeTypeSimpleModel> CodeTypes { get; set; }
    }
}
