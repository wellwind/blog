import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import {  filter, map, switchMap, tap } from 'rxjs/operators';
import * as markdownIt from 'markdown-it';

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
    switchMap(slug => this.getMarkdownContent(slug!)),
    map((result: { content: string, slug: string}) => ({
      slug: result.slug,
      content: result.content.replace(/\{% asset_img (.*) (.*)%\}/g, '<img src="$1" alt="$2" />')
    })),
    map(result => ({
      slug: result.slug,
      content: result.content.replace(/<img src="([^"]+)"(.*)>/g, `<img src="http://localhost:4200/assets/blog/${result.slug}/$1"$2>`)
    })),
    map(result => result),
    map(result => markdown.render(result.content)),
    map(content => this.domSanitizer.bypassSecurityTrustHtml(content))
  );

  constructor(private httpClient: HttpClient, private route: ActivatedRoute, private domSanitizer: DomSanitizer) {
  }

  ngOnInit(): void {

  }

  private getMarkdownContent(slug: string) {
    return this.httpClient
      .get(`http://localhost:4200/assets/blog/${slug}/${slug}.md`, { responseType: 'text' })
      .pipe(
        map(content => ({
          content: content,
          slug: slug
        }))
      );
  }
}
