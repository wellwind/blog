import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { filter, map, switchMap, tap } from 'rxjs/operators';
import * as markdownIt from 'markdown-it';
import { environment } from '../../../environments/environment';

const markdown = markdownIt();

@Component({
  selector: 'app-blog-post',
  templateUrl: './blog-post.component.html',
  styleUrls: ['./blog-post.component.scss']
})
export class BlogPostComponent implements OnInit {

  content$ = this.route.paramMap.pipe(
    map(paramMap => paramMap.get('slug')),
    filter(slug => !!slug),
    switchMap(slug => this.getMarkdownContent(slug!))
  );

  constructor(private httpClient: HttpClient, private route: ActivatedRoute, private domSanitizer: DomSanitizer) {
  }

  ngOnInit(): void {

  }

  private getMarkdownContent(slug: string) {
    console.log(`${environment.url}assets/blog/${slug}/${slug}.md`);
    return this.httpClient
      .get(`${environment.url}assets/blog/${slug}/${slug}.md`, { responseType: 'text' })
      .pipe(
        map(content => markdown.render(content)),
        map(content => content.replace(/\{% asset_img (.*) (.*)%\}/g, `<img src="./assets/blog/${slug}/$1" alt="$2" />`)),
        map(content => this.domSanitizer.bypassSecurityTrustHtml(content))
      );
  }
}
