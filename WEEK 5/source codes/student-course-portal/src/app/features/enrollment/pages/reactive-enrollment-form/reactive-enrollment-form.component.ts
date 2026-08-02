import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AbstractControl,
  FormArray,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  ValidationErrors,
  Validators
} from '@angular/forms';
import { CanComponentDeactivate } from '../../../../guards/unsaved-changes.guard';

// Hands-On 5: reactive form - the whole model lives in TypeScript, the template
// just binds to it. This makes the form logic fully unit-testable without a DOM.
@Component({
  selector: 'app-reactive-enrollment-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './reactive-enrollment-form.component.html',
  styleUrl: './reactive-enrollment-form.component.css'
})
export class ReactiveEnrollmentFormComponent implements OnInit, CanComponentDeactivate {
  enrollForm!: FormGroup;

  constructor(private fb: FormBuilder) {}

  ngOnInit(): void {
    this.enrollForm = this.fb.group({
      studentName: ['', [Validators.required, Validators.minLength(3)]],
      studentEmail: this.fb.control('', [Validators.required, Validators.email], [this.simulateEmailCheck]),
      courseId: [null, [Validators.required, this.noCourseCode]],
      preferredSemester: ['Odd', Validators.required],
      agreeToTerms: [false, Validators.requiredTrue],
      additionalCourses: this.fb.array([])
    });
  }

  // Hands-On 5, Task 2, Step 53: custom synchronous validator - rejects course
  // codes starting with the disallowed 'XX' prefix.
  noCourseCode(control: AbstractControl): ValidationErrors | null {
    const value = control.value;
    if (typeof value === 'string' && value.startsWith('XX')) {
      return { noCourseCode: true };
    }
    return null;
  }

  // Hands-On 5, Task 2, Step 55: custom async validator - simulates a server-side
  // "email already taken" check. Fires only after sync validators pass, to avoid
  // wasting calls on obviously-invalid input.
  simulateEmailCheck(control: AbstractControl): Promise<ValidationErrors | null> {
    return new Promise((resolve) => {
      setTimeout(() => {
        const taken = typeof control.value === 'string' && control.value.includes('test@');
        resolve(taken ? { emailTaken: true } : null);
      }, 800);
    });
  }

  // Hands-On 5, Task 2, Step 57: typed getter instead of casting in the template -
  // keeps the `as FormArray` cast in one place and gives autocomplete/type-checking
  // everywhere else the array is used.
  get additionalCourses(): FormArray {
    return this.enrollForm.get('additionalCourses') as FormArray;
  }

  addCourse(): void {
    this.additionalCourses.push(this.fb.control('', Validators.required));
  }

  removeCourse(index: number): void {
    this.additionalCourses.removeAt(index);
  }

  onSubmit(): void {
    console.log('Reactive form value (excludes disabled controls):', this.enrollForm.value);
    console.log('Reactive form raw value (includes disabled controls):', this.enrollForm.getRawValue());
  }

  // Hands-On 7, Task 2: implements CanComponentDeactivate for unsavedChangesGuard
  hasUnsavedChanges(): boolean {
    return this.enrollForm.dirty;
  }
}
