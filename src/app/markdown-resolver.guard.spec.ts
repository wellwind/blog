import { TestBed } from '@angular/core/testing';

import { BlogContentResolve } from './blog-content-resolve.service';

describe('MarkdownResolverGuard', () => {
  let guard: BlogContentResolve;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    guard = TestBed.inject(BlogContentResolve);
  });

  it('should be created', () => {
    expect(guard).toBeTruthy();
  });
});
