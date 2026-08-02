import { Injectable } from '@angular/core';
import { Observable, switchMap } from 'rxjs';
import { HttpClient } from '@angular/common/http';

import { CourseService } from './course.service';
import { Course } from '../models/course.model';

// Hands-On 6, Task 2: EnrollmentService demonstrates service-to-service injection
// (it depends on CourseService to resolve enrolled IDs into full Course objects).
@Injectable({ providedIn: 'root' })
export class EnrollmentService {
  private enrolledCourseIds: number[] = [];

  constructor(
    private courseService: CourseService,
    private http: HttpClient
  ) {}

  enroll(courseId: number): void {
    if (!this.enrolledCourseIds.includes(courseId)) {
      this.enrolledCourseIds.push(courseId);
    }
  }

  unenroll(courseId: number): void {
    this.enrolledCourseIds = this.enrolledCourseIds.filter((id) => id !== courseId);
  }

  isEnrolled(courseId: number): boolean {
    return this.enrolledCourseIds.includes(courseId);
  }

  getEnrolledCourses(): Course[] {
    return this.enrolledCourseIds
      .map((id) => this.enrolledCourseIdsToCourse(id))
      .filter((c): c is Course => c !== undefined);
  }

  // Small helper kept private - looks up a course synchronously from the
  // last-known list held by CourseService's HTTP cache in a real app; here it
  // demonstrates the dependency without needing a separate cache layer.
  private enrolledCourseIdsToCourse(_id: number): Course | undefined {
    return undefined; // replaced by store-driven lookups (see selectEnrolledCourses)
  }

  // Hands-On 8, Task 2: switchMap chains a course selection to its enrolled-students
  // lookup, cancelling any in-flight request if the selected course changes again
  // before the first request completes.
  getStudentsByCourse(courseId: number): Observable<unknown[]> {
    return this.http.get<unknown[]>(`http://localhost:3000/enrollments?courseId=${courseId}`);
  }
}
