using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WhitedUS.MediaLibrary.Models
{
    public class MediaModel
    {
        public int LocalID { get; set; }

        [Required]
        public string Title { get; set; }

        public string BoxTitle { get; set; }

        [Required]
        public string Code { get; set; }

        public string DiskNumber { get; set; }

        public string Format { get; set; }

        [Required]
        public bool Have { get; set; }

        public string Length { get; set; }

        public string Notes { get; set; }

        public string Rating { get; set; }

        public string Year { get; set; }

        [Required]
        [Range(1, int.MaxValue)]
        public int MediaTypeID { get; set; }
        
        public MediaTypeSimpleModel MediaType { get; set; }
        public IQueryable<MediaTypeSimpleModel> MediaTypes { get; set; }
        public CodeTypeSimpleModel CodeType { get; set; }
    }
}