import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NotificationService } from '../../services/notification.service';

// Hands-On 6, Task 2, Step 67: `providers: [NotificationService]` here (instead of
// `providedIn: 'root'` on the service itself) creates a NEW NotificationService
// instance scoped to this component and its children, rather than sharing the
// app-wide singleton other services use. Useful when each instance of this
// component needs its own isolated notification queue (e.g. multiple widgets
// on the same page that shouldn't share state).
@Component({
  selector: 'app-notification',
  standalone: true,
  imports: [CommonModule],
  providers: [NotificationService],
  template: `
    <div class="notification-widget">
      <button type="button" (click)="addSample()">Add Notification</button>
      <ul>
        <li *ngFor="let msg of notificationService.getMessages()">{{ msg }}</li>
      </ul>
    </div>
  `
})
export class NotificationComponent {
  constructor(public notificationService: NotificationService) {}

  addSample(): void {
    this.notificationService.push('New course added to the catalog.');
  }
}
