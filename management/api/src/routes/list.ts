import {Hono} from "hono";
import {z} from "zod";
import {zValidator} from "@hono/zod-validator";
import type {Bindings} from "../index";
import {drizzle} from "drizzle-orm/d1";
import {users} from "../schema";
import {asc, count, desc, SQLWrapper} from "drizzle-orm";

const app = new Hono<{ Bindings: Bindings }>();

const schema = z.object({
    order: z.union([z.literal('count'), z.literal('create'), z.literal('update')]).default('count'),
    asc: z.preprocess((v) => JSON.parse(`${v ?? true}`), z.boolean().default(true)),
    offset: z.preprocess((v) => JSON.parse(`${v ?? 0}`), z.number().default(0)),
});

const route = app.get('/', zValidator('query', schema), async (c) => {
    const order = c.req.valid('query').order;
    const is_asc = c.req.valid('query').asc;
    const offset = c.req.valid('query').offset;
    const db = drizzle(c.env.DB);
    const cnt = await db.select({count: count()}).from(users).get();

    let orderBy: SQLWrapper = users.count;
    if (order === 'create') orderBy = users.createdAt;
    if (order === 'update') orderBy = users.updatedAt;

    const result = await db.select().from(users).orderBy(is_asc ? asc(orderBy) : desc(orderBy)).limit(10).offset(offset * 10).all();

    return c.json({
        success: true,
        result,
        offset,
        count: cnt?.count ?? 0
    });
});

export default route;