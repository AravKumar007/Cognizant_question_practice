import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { Course } from '../../models/course.model';
import { HighlightDirective } from '../../directives/highlight.directive';
import { CreditLabelPipe } from '../../pipes/credit-label.pipe';
import { EnrollmentService } from '../../services/enrollment.service';
import { selectEnrolledIds } from '../../store/enrollment/enrollment.selectors';
import { enrollInCourse, unenrollFromCourse } from '../../store/enrollment/enrollment.actions';

// Hands-On 2 & 3 & 6 & 9: Input/Output, lifecycle hooks, directives, pipes,
// service-based + NgRx-based enrollment toggling all live in this one card.
@Component({
  selector: 'app-course-card',
  standalone: true,
  imports: [CommonModule, HighlightDirective, CreditLabelPipe],
  templateUrl: './course-card.component.html',
  styleUrl: './course-card.component.css'
})
export class CourseCardComponent implements OnChanges {
  @Input() course!: Course;
  @Output() enrollRequested = new EventEmitter<number>();

  isExpanded = false;

  // Hands-On 9: cross-slice selector tells us if this course is enrolled via the store
  enrolledIds$: Observable<number[]>;

  constructor(
    private enrollmentService: EnrollmentService,
    private store: Store
  ) {
    this.enrolledIds$ = this.store.select(selectEnrolledIds);
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['course']) {
      console.log(
        'CourseCardComponent.course changed - previous:',
        changes['course'].previousValue,
        'current:',
        changes['course'].currentValue
      );
    }
  }

  onEnrollClick(): void {
    this.enrollRequested.emit(this.course.id);

    // Hands-On 6: service-based toggle
    if (this.enrollmentService.isEnrolled(this.course.id)) {
      this.enrollmentService.unenroll(this.course.id);
    } else {
      this.enrollmentService.enroll(this.course.id);
    }

    // Hands-On 9: NgRx-based toggle, kept in sync alongside the service
    this.store.dispatch(enrollInCourse({ courseId: this.course.id }));
  }

  isEnrolledViaService(): boolean {
    return this.enrollmentService.isEnrolled(this.course.id);
  }

  toggleExpanded(): void {
    this.isExpanded = !this.isExpanded;
  }

  // Hands-On 3, Task 2, Step 32: getter form of ngClass keeps the template clean -
  // no inline object literal cluttering the HTML, and the logic is unit-testable.
  get cardClasses() {
    return {
      'card--enrolled': this.isEnrolledViaService(),
      'card--full': this.course?.credits >= 4,
      expanded: this.isExpanded
    };
  }

  get borderStyle() {
    const colors: Record<Course['gradeStatus'], string> = {
      passed: '#2f9e44',
      failed: '#e5484d',
      pending: '#adb5bd'
    };
    return { 'border-left-color': colors[this.course?.gradeStatus] ?? '#adb5bd' };
  }
}
