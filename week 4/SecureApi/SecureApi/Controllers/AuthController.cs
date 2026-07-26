using Microsoft.AspNetCore.Mvc;
using SecureApi.Models;
using SecureApi.Services;

namespace SecureApi.Controllers
{
    // Exercise 1: Implement JWT Authentication in ASP.NET Core Web API
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly UserStore _userStore;
        private readonly TokenService _tokenService;

        public AuthController(UserStore userStore, TokenService tokenService)
        {
            _userStore = userStore;
            _tokenService = tokenService;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            var user = _userStore.Validate(request.Username, request.Password);
            if (user is null)
            {
                return Unauthorized(new { message = "Invalid username or password." });
            }

            var token = _tokenService.GenerateToken(user);
            return Ok(new
            {
                token,
                username = user.Username,
                role = user.Role
            });
        }
    }
}
