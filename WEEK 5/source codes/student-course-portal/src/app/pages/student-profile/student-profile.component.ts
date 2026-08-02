import { Component, OnInit } from '@angular/core';
import { CommonModule, AsyncPipe } from '@angular/common';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';

import { EnrollmentService } from '../../services/enrollment.service';
import { Course } from '../../models/course.model';
import { selectEnrolledCourses } from '../../store/enrollment/enrollment.selectors';

// Hands-On 6 & 9: shows enrolled courses via EnrollmentService, then via the store
@Component({
  selector: 'app-student-profile',
  standalone: true,
  imports: [CommonModule, AsyncPipe],
  templateUrl: './student-profile.component.html'
})
export class StudentProfileComponent implements OnInit {
  enrolledCoursesFromService: Course[] = [];
  enrolledCourses$: Observable<Course[]>;

  constructor(
    private enrollmentService: EnrollmentService,
    private store: Store
  ) {
    this.enrolledCourses$ = this.store.select(selectEnrolledCourses);
  }

  ngOnInit(): void {
    this.enrolledCoursesFromService = this.enrollmentService.getEnrolledCourses();
  }
}
