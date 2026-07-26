using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace SecureApi.Controllers
{
    // Exercise 2: Secure an API Endpoint Using JWT
    [ApiController]
    [Route("api/[controller]")]
    public class SecureController : ControllerBase
    {
        [HttpGet("data")]
        [Authorize]
        public IActionResult GetSecureData()
        {
            var username = User.Identity?.Name ?? "unknown";
            return Ok(new { message = $"Hello {username}, this is protected data." });
        }
    }
}
