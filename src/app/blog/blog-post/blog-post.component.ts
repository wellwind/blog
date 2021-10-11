import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { ActivatedRoute } from '@angular/router';
import { filter, map, switchMap } from 'rxjs/operators';
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
    map(content => content.replace(/\{% asset_img (.*) (.*)%\}/, '<img src="$1" alt="$2" />')),
    map(content => markdown.render(content)),
    map(content => this.domSanitizer.bypassSecurityTrustHtml(content))
  )

  constructor(private route: ActivatedRoute, private httpClient: HttpClient, private domSanitizer: DomSanitizer) {
  }

  ngOnInit(): void {
  }

  private getMarkdownContent(slug: string) {
    return this.httpClient.get(`assets/blog/${slug}/${slug}.md`, { responseType: 'text' });
  }

}
