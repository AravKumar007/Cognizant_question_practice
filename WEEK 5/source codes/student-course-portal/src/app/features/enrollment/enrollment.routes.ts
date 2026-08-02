import { Routes } from '@angular/router';
import { unsavedChangesGuard } from '../../guards/unsaved-changes.guard';

// Hands-On 7, Task 2: this whole feature is lazy-loaded from app.routes.ts via
// loadChildren - its JS chunk only downloads the first time /enroll is visited.
export const ENROLLMENT_ROUTES: Routes = [
  {
    path: '',
    loadComponent: () =>
      import('./pages/enrollment-form/enrollment-form.component').then((m) => m.EnrollmentFormComponent)
  },
  {
    path: 'reactive',
    canDeactivate: [unsavedChangesGuard],
    loadComponent: () =>
      import('./pages/reactive-enrollment-form/reactive-enrollment-form.component').then(
        (m) => m.ReactiveEnrollmentFormComponent
      )
  }
];
