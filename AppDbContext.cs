namespace RetailInventory.Models
{
    public class ProductDetail
    {
        public int ProductDetailId { get; set; }
        public string WarrantyInfo { get; set; } = string.Empty;

        // Foreign key - one-to-one with Product
        public int ProductId { get; set; }
        public Product? Product { get; set; }
    }
}
