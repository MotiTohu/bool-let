import {Hono} from "hono";
import {z} from "zod";
import {zValidator} from "@hono/zod-validator";
import type {Bindings} from "../index";
import {drizzle} from "drizzle-orm/d1";
import {users} from "../schema";
import {eq, or} from "drizzle-orm";

const app = new Hono<{ Bindings: Bindings }>();

const schema = z.object({
    id: z.string(),
    diff: z.number()
});

const route = app.post('/', zValidator('json', schema), async (c) => {
    const id = c.req.valid('json').id;
    const diff = c.req.valid('json').diff;
    const db = drizzle(c.env.DB);
    const current = await db.select({count: users.count}).from(users).where(or(eq(users.backup_id, id), eq(users.id, id))).get();
    if (!current) return c.json({success: false, id});
    await db.update(users).set({count: Math.max(0, current.count + diff)}).where(eq(users.id, id));

    return c.json({
        success: true,
        id
    });
});

export default route;