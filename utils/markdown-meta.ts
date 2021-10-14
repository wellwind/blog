export interface MarkdownMeta {
    title: string;
    date: Date;
    categories: string[];
    tags: string[];
    draft?: boolean;
    summary: string;
    content: string;
    originalContent: string;
}
