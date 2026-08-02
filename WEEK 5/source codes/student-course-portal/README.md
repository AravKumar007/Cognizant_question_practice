# Angular Hands-On - Student Course Portal

A single Angular v20 (standalone components) application built incrementally
across all 10 Digital Nurture 5.0 Angular hands-on exercises, per the
submission guideline: one evolving project, not separate projects per exercise.

## Getting Started

```bash
cd student-course-portal
npm install

# Terminal 1: mock REST API (Hands-On 8+)
json-server --watch db.json --port 3000

# Terminal 2: the app
ng serve
```
Open `http://localhost:4200`.

Run tests (Hands-On 10):
```bash
ng test
ng test --code-coverage   # writes a report to coverage/
```

## Project Structure
```
student-course-portal/
├── notes.txt                  # Hands-On 1, Task 1 - file-by-file notes
├── db.json                    # Hands-On 8 - mock API data for json-server
├── src/app/
│   ├── app.config.ts           # router + HttpClient/interceptors + NgRx wiring
│   ├── app.routes.ts            # Hands-On 7 - routes, nested routes, guards, lazy loading
│   ├── models/course.model.ts   # Hands-On 6 - shared Course interface
│   ├── components/
│   │   ├── header/               # Hands-On 1
│   │   ├── course-card/          # Hands-On 2, 3, 6, 9
│   │   └── notification/         # Hands-On 6 - component-scoped DI demo
│   ├── pages/
│   │   ├── home/                 # Hands-On 1, 2 - dashboard, all binding types, lifecycle hooks
│   │   ├── course-list/          # Hands-On 2, 3, 6, 7, 8, 9
│   │   ├── courses-layout/       # Hands-On 7 - nested route parent
│   │   ├── course-detail/        # Hands-On 7 - route param lookup
│   │   ├── student-profile/      # Hands-On 6, 9
│   │   └── not-found/            # Hands-On 7 - wildcard route
│   ├── features/enrollment/      # Hands-On 4, 5, 7 - LAZY LOADED feature
│   │   ├── enrollment.routes.ts
│   │   └── pages/
│   │       ├── enrollment-form/            # Hands-On 4 - template-driven form
│   │       └── reactive-enrollment-form/   # Hands-On 5 - reactive form, FormArray, custom+async validators
│   ├── directives/highlight.directive.ts   # Hands-On 3 - custom @HostListener directive
│   ├── pipes/credit-label.pipe.ts          # Hands-On 3 - custom PipeTransform
│   ├── services/
│   │   ├── course.service.ts      # Hands-On 6, 8 - HttpClient + RxJS operators
│   │   ├── enrollment.service.ts  # Hands-On 6 - service-to-service injection
│   │   ├── auth.service.ts        # Hands-On 7 - backs authGuard
│   │   ├── loading.service.ts     # Hands-On 8 - backs the global spinner
│   │   └── notification.service.ts# Hands-On 6 - component-scoped, not root
│   ├── guards/
│   │   ├── auth.guard.ts             # Hands-On 7 - CanActivate
│   │   └── unsaved-changes.guard.ts  # Hands-On 7 - CanDeactivate
│   ├── interceptors/
│   │   ├── auth.interceptor.ts          # Hands-On 8 - attaches bearer token
│   │   ├── error-handler.interceptor.ts # Hands-On 8 - global 401/500 handling
│   │   └── loading.interceptor.ts       # Hands-On 8 - drives LoadingService
│   └── store/                       # Hands-On 9 - NgRx
│       ├── course/    (actions, reducer, selectors, effects)
│       └── enrollment/(actions, reducer, cross-slice selectors)
```

## Hands-On -> Where to look

| # | Topic | Key files |
|---|---|---|
| 1 | Setup, structure, first component | `notes.txt`, `angular.json`, `components/header/` |
| 2 | Binding, lifecycle, @Input/@Output | `pages/home/`, `components/course-card/` (ngOnChanges) |
| 3 | Directives & pipes | `directives/highlight.directive.ts`, `pipes/credit-label.pipe.ts`, `pages/course-list/` (*ngIf/else, trackBy) |
| 4 | Template-driven forms | `features/enrollment/pages/enrollment-form/` |
| 5 | Reactive forms, FormArray, validators | `features/enrollment/pages/reactive-enrollment-form/` |
| 6 | Services & DI | `services/course.service.ts`, `services/enrollment.service.ts`, `components/notification/` |
| 7 | Routing, guards, lazy loading | `app.routes.ts`, `guards/`, `features/enrollment/enrollment.routes.ts` |
| 8 | HttpClient, RxJS, interceptors | `services/course.service.ts`, `interceptors/` |
| 9 | NgRx store | `store/course/`, `store/enrollment/`, `app.config.ts` |
| 10 | Unit testing | every `*.spec.ts`, especially `course-card.component.spec.ts`, `course.service.spec.ts`, `course-list.component.spec.ts` (MockStore) |

## Notes on design decisions
- Built with **standalone components** throughout (Angular 17+ default, continued
  in v20) - no `NgModule`s except the generated Angular workspace config.
- `CourseCardComponent` intentionally shows **both** the service-based
  (`EnrollmentService`) and NgRx-based (`store.dispatch`) enrollment toggle
  side-by-side, since Hands-On 6 and 9 both build toward the same feature -
  this documents how the implementation evolved rather than silently dropping
  the earlier approach.
- Guards and interceptors use the modern **functional** style
  (`CanActivateFn`, `HttpInterceptorFn`) rather than class-based, matching
  Angular 20's current recommended pattern.
- `EnrollmentService.getStudentsByCourse` and the `switchMap` usage described
  in Hands-On 8, Task 2, Step 87 is wired for a course-detail "enrolled
  students" panel - extend `CourseDetailComponent` to call it if your
  submission needs that panel visibly rendered.
