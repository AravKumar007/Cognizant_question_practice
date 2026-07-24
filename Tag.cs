using System.Collections.Generic;

namespace RetailInventory.Models
{
    public class Category
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;

        // Navigation property - one category has many products
        public List<Product> Products { get; set; } = new();
    }
}
