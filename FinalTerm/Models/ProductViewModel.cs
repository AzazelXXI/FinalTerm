using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinalTerm.Models
{
    public class ProductViewModel
    {
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public decimal OldPrice { get; set; }
        public decimal NewPrice { get; set; }
    }
}