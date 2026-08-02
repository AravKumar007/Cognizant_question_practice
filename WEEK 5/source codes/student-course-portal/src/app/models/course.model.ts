// Hands-On 6: shared Course type used across components, services, and the NgRx store
export interface Course {
  id: number;
  name: string;
  code: string;
  credits: number;
  gradeStatus: 'passed' | 'failed' | 'pending';
}
