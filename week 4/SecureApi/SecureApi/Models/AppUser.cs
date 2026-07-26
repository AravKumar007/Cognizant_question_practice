namespace SecureApi.Models
{
    public class LoginRequest
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class AppUser
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty; // plain text for demo purposes only
        public string Role { get; set; } = "User";
    }
}
