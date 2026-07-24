using Microsoft.EntityFrameworkCore;
using RetailInventory.Data;
using RetailInventory.DTOs;
using RetailInventory.Models;
using EFCore.BulkExtensions;

// ---------------------------------------------------------------------------
// EF Core 8.0 Hands-On Exercises - Retail Inventory System
// Each lab from the exercise sheet is wired up as its own method so it can
// be run independently from the console menu below.
// ---------------------------------------------------------------------------

Console.WriteLine("=== Retail Inventory - EF Core 8 Demo ===\n");

bool exit = false;
while (!exit)
{
    PrintMenu();
    var choice = Console.ReadLine();

    try
    {
        switch (choice)
        {
            case "1": await Lab4_InsertInitialData(); break;
            case "2": await Lab5_RetrieveData(); break;
            case "3": await Lab6_UpdateAndDelete(); break;
            case "4": await Lab7_LinqQueries(); break;
            case "5": await Lab10_LoadingStrategies(); break;
            case "6": await Lab11_Relationships(); break;
            case "7": await Lab12_CircularReferenceHandling(); break;
            case "8": await Lab13_NoTrackingAndCompiledQuery(); break;
            case "9": await Lab14_BulkOperations(); break;
            case "10": await Lab15_ConcurrencyHandling(); break;
            case "0": exit = true; break;
            default: Console.WriteLine("Invalid option.\n"); break;
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Error: {ex.Message}\n");
    }
}

static void PrintMenu()
{
    Console.WriteLine("Choose a lab to run:");
    Console.WriteLine(" 1. Lab 4  - Insert initial data");
    Console.WriteLine(" 2. Lab 5  - Retrieve data (ToListAsync / Find / FirstOrDefault)");
    Console.WriteLine(" 3. Lab 6  - Update and delete records");
    Console.WriteLine(" 4. Lab 7  - LINQ queries (Where / OrderBy / Select DTO)");
    Console.WriteLine(" 5. Lab 10 - Eager / Explicit / Lazy loading");
    Console.WriteLine(" 6. Lab 11 - One-to-one and many-to-many relationships");
    Console.WriteLine(" 7. Lab 12 - Circular reference handling with DTOs");
    Console.WriteLine(" 8. Lab 13 - AsNoTracking and compiled queries");
    Console.WriteLine(" 9. Lab 14 - Bulk operations");
    Console.WriteLine("10. Lab 15 - Optimistic concurrency with RowVersion");
    Console.WriteLine(" 0. Exit");
    Console.Write("> ");
}

// Lab 4: Inserting Initial Data
static async Task Lab4_InsertInitialData()
{
    using var context = new AppDbContext();

    var electronics = new Category { Name = "Electronics" };
    var groceries = new Category { Name = "Groceries" };
    await context.Categories.AddRangeAsync(electronics, groceries);

    var product1 = new Product { Name = "Laptop", Price = 75000, Category = electronics, StockQuantity = 15 };
    var product2 = new Product { Name = "Rice Bag", Price = 1200, Category = groceries, StockQuantity = 200 };
    await context.Products.AddRangeAsync(product1, product2);

    await context.SaveChangesAsync();
    Console.WriteLine("Inserted seed categories and products.\n");
}

// Lab 5: Retrieving Data
static async Task Lab5_RetrieveData()
{
    using var context = new AppDbContext();

    var products = await context.Products.ToListAsync();
    foreach (var p in products)
        Console.WriteLine($"{p.Name} - Rs.{p.Price}");

    var product = await context.Products.FindAsync(1);
    Console.WriteLine($"Found by id 1: {product?.Name}");

    var expensive = await context.Products.FirstOrDefaultAsync(p => p.Price > 50000);
    Console.WriteLine($"First product over Rs.50000: {expensive?.Name}\n");
}

// Lab 6: Updating and Deleting Records
static async Task Lab6_UpdateAndDelete()
{
    using var context = new AppDbContext();

    var product = await context.Products.FirstOrDefaultAsync(p => p.Name == "Laptop");
    if (product != null)
    {
        product.Price = 70000;
        await context.SaveChangesAsync();
        Console.WriteLine("Updated Laptop price to Rs.70000.");
    }

    var toDelete = await context.Products.FirstOrDefaultAsync(p => p.Name == "Rice Bag");
    if (toDelete != null)
    {
        context.Products.Remove(toDelete);
        await context.SaveChangesAsync();
        Console.WriteLine("Deleted Rice Bag.\n");
    }
}

// Lab 7: Writing Queries with LINQ
static async Task Lab7_LinqQueries()
{
    using var context = new AppDbContext();

    var filtered = await context.Products
        .Where(p => p.Price > 1000)
        .OrderByDescending(p => p.Price)
        .ToListAsync();

    Console.WriteLine("Products over Rs.1000, most expensive first:");
    foreach (var p in filtered)
        Console.WriteLine($" - {p.Name}: Rs.{p.Price}");

    var productSummaries = await context.Products
        .Select(p => new { p.Name, p.Price })
        .ToListAsync();

    Console.WriteLine("Projected DTO-style results:");
    foreach (var p in productSummaries)
        Console.WriteLine($" - {p.Name}: Rs.{p.Price}\n");
}

// Lab 10: Eager, Explicit, and Lazy Loading
static async Task Lab10_LoadingStrategies()
{
    using var context = new AppDbContext();

    // Eager loading
    var products = await context.Products
        .Include(p => p.Category)
        .ToListAsync();
    Console.WriteLine("Eager loaded products with categories:");
    foreach (var p in products)
        Console.WriteLine($" - {p.Name} ({p.Category?.Name})");

    // Explicit loading
    var firstProduct = await context.Products.FirstAsync();
    await context.Entry(firstProduct).Reference(p => p.Category).LoadAsync();
    Console.WriteLine($"Explicitly loaded category for {firstProduct.Name}: {firstProduct.Category?.Name}\n");

    // Lazy loading requires UseLazyLoadingProxies() in AppDbContext.OnConfiguring
    // and navigation properties marked `virtual` - left as an opt-in configuration.
}

// Lab 11: One-to-One and Many-to-Many Relationships
static async Task Lab11_Relationships()
{
    using var context = new AppDbContext();

    var product = await context.Products.FirstOrDefaultAsync();
    if (product == null)
    {
        Console.WriteLine("No products found - run Lab 4 first.\n");
        return;
    }

    // One-to-one
    if (!await context.ProductDetails.AnyAsync(pd => pd.ProductId == product.Id))
    {
        context.ProductDetails.Add(new ProductDetail
        {
            ProductId = product.Id,
            WarrantyInfo = "1 year manufacturer warranty"
        });
    }

    // Many-to-many
    var onSaleTag = await context.Tags.FirstOrDefaultAsync(t => t.Name == "On Sale")
        ?? new Tag { Name = "On Sale" };

    product.Tags.Add(onSaleTag);
    await context.SaveChangesAsync();

    Console.WriteLine($"Attached warranty info and 'On Sale' tag to {product.Name}.\n");
}

// Lab 12: Navigating Circular References
static async Task Lab12_CircularReferenceHandling()
{
    using var context = new AppDbContext();

    var productDTOs = await context.Products
        .Include(p => p.Category)
        .Select(p => new ProductDTO
        {
            Name = p.Name,
            CategoryName = p.Category!.Name,
            Price = p.Price
        }).ToListAsync();

    Console.WriteLine("Products projected to DTOs (safe for API serialization):");
    foreach (var dto in productDTOs)
        Console.WriteLine($" - {dto.Name} | {dto.CategoryName} | Rs.{dto.Price}\n");
}

// Lab 13: Query Caching and Tracking Behavior
static async Task Lab13_NoTrackingAndCompiledQuery()
{
    using var context = new AppDbContext();

    var readOnlyProducts = await context.Products
        .AsNoTracking()
        .ToListAsync();
    Console.WriteLine($"Read {readOnlyProducts.Count} products without change tracking.");

    Console.WriteLine("Compiled query results (Price > 10000):");
    await foreach (var p in CompiledQueries.ExpensiveProducts(context, 10000))
        Console.WriteLine($" - {p.Name}: Rs.{p.Price}");
    Console.WriteLine();
}

// Lab 14: Batch Processing and Bulk Operations
static async Task Lab14_BulkOperations()
{
    using var context = new AppDbContext();

    var productList = await context.Products.ToListAsync();
    foreach (var p in productList)
        p.StockQuantity += 10;

    // Bulk update via EFCore.BulkExtensions - much faster than SaveChangesAsync
    // for large batches (1000+ rows) because it avoids per-row round trips.
    await context.BulkUpdateAsync(productList);
    Console.WriteLine($"Bulk-updated stock quantity for {productList.Count} products.\n");
}

// Lab 15: Handling Concurrency with RowVersion
static async Task Lab15_ConcurrencyHandling()
{
    using var context = new AppDbContext();

    var product = await context.Products.FirstOrDefaultAsync();
    if (product == null)
    {
        Console.WriteLine("No products found - run Lab 4 first.\n");
        return;
    }

    product.StockQuantity -= 1;

    try
    {
        await context.SaveChangesAsync();
        Console.WriteLine($"Stock updated for {product.Name} without conflict.\n");
    }
    catch (DbUpdateConcurrencyException)
    {
        Console.WriteLine("Concurrency conflict detected - another user modified this row first.\n");
    }
}

// Compiled query used by Lab 13
static class CompiledQueries
{
    public static readonly Func<AppDbContext, decimal, IAsyncEnumerable<Product>> ExpensiveProducts =
        EF.CompileAsyncQuery((AppDbContext ctx, decimal price) =>
            ctx.Products.Where(p => p.Price > price));
}
