namespace RetailInventory.DTOs
{
    // Used to shape API/response data and avoid circular reference issues
    // when serializing Product <-> Category navigation properties (Lab 12).
    public class ProductDTO
    {
        public string Name { get; set; } = string.Empty;
        public string CategoryName { get; set; } = string.Empty;
        public decimal Price { get; set; }
    }
}
