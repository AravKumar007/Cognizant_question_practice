using System.Collections.Generic;

namespace RetailInventory.Models
{
    public class Tag
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;

        // Navigation property - many-to-many with Product (EF Core 8 handles the join table automatically)
        public List<Product> Products { get; set; } = new();
    }
}
