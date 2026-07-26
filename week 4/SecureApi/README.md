# SecureApi - JWT Authentication & Authorization (ASP.NET Core 8 Web API)

A minimal microservice demonstrating JWT-based authentication and
role-based authorization, built for the Week 4 "Authentication and
Authorization in ASP.NET Core Web API Microservices" exercises.

## Project Structure
```
SecureApi/
├── SecureApi.sln
├── .gitignore
├── README.md
└── SecureApi/
    ├── SecureApi.csproj
    ├── Program.cs                  # auth setup, DI, Swagger, custom 401/403 handling
    ├── appsettings.json             # Jwt:Key / Issuer / Audience / DurationInMinutes
    ├── Models/
    │   └── AppUser.cs               # LoginRequest + AppUser
    ├── Services/
    │   ├── UserStore.cs             # in-memory demo user list (arav/user, admin/admin)
    │   └── TokenService.cs          # builds and signs the JWT
    └── Controllers/
        ├── AuthController.cs        # POST /api/auth/login
        ├── SecureController.cs      # GET  /api/secure/data   [Authorize]
        └── AdminController.cs       # GET  /api/admin/dashboard [Authorize(Roles="Admin")]
```

## Getting Started

```bash
cd SecureApi
dotnet restore
dotnet run
```

Swagger UI will be available at `https://localhost:<port>/swagger` in
development mode - use it to try the endpoints without a separate REST client.

## Demo users
| Username | Password  | Role  |
|----------|-----------|-------|
| arav     | user123   | User  |
| admin    | admin123  | Admin |

## Exercise -> Implementation Mapping

| Exercise | Topic | Where |
|---|---|---|
| 1 | JWT authentication, login endpoint | `Controllers/AuthController.cs`, `Services/TokenService.cs`, `Program.cs` (`AddJwtBearer`) |
| 2 | Secure an endpoint with `[Authorize]` | `Controllers/SecureController.cs` |
| 3 | Role-based authorization | `Services/TokenService.cs` (Role claim), `Controllers/AdminController.cs` (`[Authorize(Roles = "Admin")]`) |
| 4 | Handle expired/invalid tokens gracefully | `Program.cs` -> `JwtBearerEvents` (`OnAuthenticationFailed`, `OnChallenge`, `OnForbidden`) |

## Trying it out

1. **Login as a regular user**
   ```
   POST /api/auth/login
   { "username": "arav", "password": "user123" }
   ```
   Copy the returned `token`.

2. **Call the protected endpoint**
   ```
   GET /api/secure/data
   Authorization: Bearer <token>
   ```

3. **Try the admin endpoint as a regular user** -> expect a `403 Forbidden`
   with a custom JSON message.
   ```
   GET /api/admin/dashboard
   Authorization: Bearer <token from step 1>
   ```

4. **Login as admin and retry** -> expect `200 OK`.
   ```
   POST /api/auth/login
   { "username": "admin", "password": "admin123" }
   ```

5. **Expired/invalid token** -> without a token, or with a garbled one,
   `/api/secure/data` returns a `401 Unauthorized` with a custom JSON body
   ("You are not authorized...") instead of the default empty response,
   and a `Token-Expired: true` response header specifically when the
   token has expired.

## Notes
- `UserStore` is an in-memory list for demo purposes only - a real service
  would back this with a database and hashed passwords (e.g. via
  `Microsoft.AspNetCore.Identity` or a custom password hasher), never
  plain-text passwords like here.
- The JWT signing key in `appsettings.json` is a placeholder for local
  development - replace it with a securely generated secret (and load it
  from environment variables or a secrets manager) before deploying anywhere.
