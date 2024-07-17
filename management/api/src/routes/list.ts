import {Hono} from "hono";
import {z} from "zod";
import {zValidator} from "@hono/zod-validator";
import type {Bindings} from "../index";
import {drizzle} from "drizzle-orm/d1";
import {users} from "../schema";
import {asc, count, desc} from "drizzle-orm";

const app = new Hono<{ Bindings: Bindings }>();

const schema = z.object({
    asc: z.preprocess((v) => JSON.parse(`${v ?? true}`), z.boolean().default(true)),
    offset: z.preprocess((v) => JSON.parse(`${v ?? 0}`), z.number().default(0)),
});

const route = app.get('/', zValidator('query', schema), async (c) => {
    const is_asc = c.req.valid('query').asc;
    const offset = c.req.valid('query').offset;
    const db = drizzle(c.env.DB);
    const cnt = await db.select({count: count()}).from(users).get();
    const result = await db.select().from(users).orderBy(is_asc ? asc(users.count) : desc(users.count)).limit(10).offset(offset*10).all();

    return c.json({
        success: true,
        result,
        offset,
        count: cnt?.count ?? 0
    });
});

export default route;