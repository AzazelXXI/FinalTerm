using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FinalTerm.Models
{
    public class HomeViewModel
    {
        public List<string> Banners { get; set; } = new List<string>();
        public List<Category> Categories { get; set; } = new List<Category>();
        public List<Product> SalesProducts { get; set; } = new List<Product>();
        public List<Product> RecommendedProducts { get; set; } = new List<Product>();
    }

    public class Category
    {
        public string Name { get; set; }
        public string ImageUrl { get; set; }
    }

    public class Product
    {
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string ImageUrl { get; set; }
    }
}