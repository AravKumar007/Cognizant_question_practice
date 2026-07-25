using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace RetailInventory.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public decimal Price { get; set; }

        // Lab 8: stock tracking
        public int StockQuantity { get; set; }

        // Foreign key - many-to-one with Category
        public int CategoryId { get; set; }
        public Category? Category { get; set; }

        // Lab 11: one-to-one with ProductDetail
        public ProductDetail? ProductDetail { get; set; }

        // Lab 11: many-to-many with Tag
        public List<Tag> Tags { get; set; } = new();

        // Lab 15: concurrency token
        [Timestamp]
        public byte[]? RowVersion { get; set; }
    }
}
