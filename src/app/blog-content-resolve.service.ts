import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Resolve, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError, timeout } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class BlogContentResolve implements Resolve<string> {
  constructor(private httpClient: HttpClient) {
  }

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<string> | Promise<string> | string {
    return this.getMarkdownContent(route.paramMap.get('slug') as string)
      .pipe(
        timeout(3000),
        catchError(() => of('404'))
      );
  }

  private getMarkdownContent(slug: string) {
    return this.httpClient.get(`http://localhost:4200/assets/blog/${slug}/${slug}.md`, { responseType: 'text' });
  }
}
