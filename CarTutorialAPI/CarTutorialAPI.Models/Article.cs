using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;
using CarTutorialAPI.Models.EntityBase;

namespace CarTutorialAPI.Models
{
    public class Article : EntityBaseClass
    {
        //public  MyProperty { get; set; }
        
        public long BrandForeignKey { get; set; }

        [ForeignKey("BrandForeignKey")]
        public Brand Brand { get; set; }

        public long CategoryForeignKey { get; set; }

        [ForeignKey("CategoryForeignKey")]
        public Category Category { get; set; }

        public string Subject{ get; set; }
        public string ToolsNeeded { get; set; }
        public int Level { get; set; }
        public string MakeModel { get; set; }
        public string Contents { get; set; }
        
    }
}
