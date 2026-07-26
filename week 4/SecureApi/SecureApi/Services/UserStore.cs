using SecureApi.Models;

namespace SecureApi.Services
{
    // Simple in-memory user store for demo purposes.
    // In a real service this would be backed by a database with hashed passwords.
    public class UserStore
    {
        private readonly List<AppUser> _users = new()
        {
            new AppUser { Username = "arav",  Password = "user123",  Role = "User" },
            new AppUser { Username = "admin", Password = "admin123", Role = "Admin" }
        };

        public AppUser? Validate(string username, string password)
        {
            return _users.FirstOrDefault(u =>
                u.Username.Equals(username, StringComparison.OrdinalIgnoreCase) &&
                u.Password == password);
        }
    }
}
