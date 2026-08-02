import { createAction, props } from '@ngrx/store';
import { Course } from '../../models/course.model';

// Hands-On 9, Task 1: [Course] prefix groups these in the Redux DevTools timeline
export const loadCourses = createAction('[Course] Load Courses');

export const loadCoursesSuccess = createAction(
  '[Course] Load Courses Success',
  props<{ courses: Course[] }>()
);

export const loadCoursesFailure = createAction(
  '[Course] Load Courses Failure',
  props<{ error: string }>()
);
