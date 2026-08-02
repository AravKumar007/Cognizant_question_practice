import { Component, OnDestroy, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { CourseService } from '../../services/course.service';

// Hands-On 1 & 2: dashboard page - all four binding types + ngOnInit/ngOnDestroy live here
@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent implements OnInit, OnDestroy {
  portalName = 'Student Course Portal';
  isPortalActive = true;
  message = '';
  searchTerm = '';
  coursesAvailable = 12;
  enrolledCount = 3;
  gpa = 3.8;

  constructor(private courseService: CourseService) {}

  ngOnInit(): void {
    console.log('HomeComponent initialised - courses loaded');
    // In a fuller build this would subscribe to courseService.getCourses() and
    // set coursesAvailable from the live count; kept simple here per Hands-On 2's scope.
  }

  ngOnDestroy(): void {
    console.log('HomeComponent destroyed');
  }

  onEnrollClick(): void {
    this.message = 'Enrollment opened!';
  }

  // Step 15: [property] is one-way (component -> DOM only, e.g. [disabled]).
  // [(ngModel)] is two-way - component -> DOM AND DOM -> component, so typing
  // in the bound <input> updates searchTerm immediately, and setting searchTerm
  // in code updates the input's displayed value too.
}
