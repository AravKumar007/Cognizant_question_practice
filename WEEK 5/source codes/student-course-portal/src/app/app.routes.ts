import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { StudentProfileComponent } from './pages/student-profile/student-profile.component';
import { NotFoundComponent } from './pages/not-found/not-found.component';
import { CoursesLayoutComponent } from './pages/courses-layout/courses-layout.component';
import { CourseListComponent } from './pages/course-list/course-list.component';
import { CourseDetailComponent } from './pages/course-detail/course-detail.component';
import { authGuard } from './guards/auth.guard';

// Hands-On 7: route config, nested routes, lazy loading, guards
export const routes: Routes = [
  { path: '', component: HomeComponent },

  // Nested routes: /courses (list) and /courses/:id (detail) share a layout
  {
    path: 'courses',
    component: CoursesLayoutComponent,
    children: [
      { path: '', component: CourseListComponent },
      { path: ':id', component: CourseDetailComponent }
    ]
  },

  // Protected route - redirects to '/' if authGuard returns false
  { path: 'profile', component: StudentProfileComponent, canActivate: [authGuard] },

  // Lazy-loaded enrollment feature (Hands-On 4 & 5 forms, code-split on demand)
  {
    path: 'enroll',
    canActivate: [authGuard],
    loadChildren: () => import('./features/enrollment/enrollment.routes').then((m) => m.ENROLLMENT_ROUTES)
  },

  // Wildcard must always be last
  { path: '**', component: NotFoundComponent }
];
