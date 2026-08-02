import { Injectable } from '@angular/core';

// Hands-On 6, Task 2, Step 67: provided at COMPONENT level (see NotificationComponent),
// not root - so each component that provides it gets its own isolated instance
// instead of sharing one app-wide singleton.
@Injectable()
export class NotificationService {
  private messages: string[] = [];

  push(message: string): void {
    this.messages.push(message);
  }

  getMessages(): string[] {
    return this.messages;
  }
}
