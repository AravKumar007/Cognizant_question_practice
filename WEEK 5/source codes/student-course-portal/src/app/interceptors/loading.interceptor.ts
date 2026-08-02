import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { finalize } from 'rxjs/operators';
import { LoadingService } from '../services/loading.service';

// Hands-On 8, Task 3: drives the global spinner - show() before the request,
// hide() in finalize() so it fires whether the request succeeds or fails
export const loadingInterceptor: HttpInterceptorFn = (req, next) => {
  const loadingService = inject(LoadingService);

  loadingService.show();
  return next(req).pipe(finalize(() => loadingService.hide()));
};
