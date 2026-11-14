import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const pages = defineCollection({
  loader: glob({ pattern: '**', base: './src/content/pages' }),
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    order: z.number().optional(),
  }),
});

const posts = defineCollection({
  loader: glob({ pattern: '**', base: './src/content/posts' }),
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()).default([]),
  }),
});

const nav = defineCollection({
  loader: glob({ pattern: '**', base: './src/content/nav' }),
  schema: z.object({
    label: z.string(),
    href: z.string(),
    order: z.number().optional(),
  }),
});

export const collections = { pages, posts, nav };
