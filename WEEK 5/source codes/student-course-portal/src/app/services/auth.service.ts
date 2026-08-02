import { Injectable } from '@angular/core';

// Hands-On 7: minimal auth stand-in so AuthGuard has something to check.
// A real app would call a login API and store a token; this is intentionally
// hardcoded per the exercise's own instructions.
@Injectable({ providedIn: 'root' })
export class AuthService {
  isLoggedIn = true;
}
