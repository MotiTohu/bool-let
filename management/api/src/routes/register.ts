import {Hono} from "hono";
import {z} from "zod";
import {zValidator} from "@hono/zod-validator";
import {drizzle} from "drizzle-orm/d1";
import type {Bindings} from "../index";
import {users} from "../schema";

const app = new Hono<{ Bindings: Bindings }>();

const schema = z.object({
    count: z.number().int()
});

const route = app.post('/', zValidator('json', schema), async (c) => {
    const count = c.req.valid('json').count;
    const id = Math.random().toString(32).substring(2);
    const backup = Math.random().toString(32).substring(2);
    const db = drizzle(c.env.DB);
    const data = await db.insert(users).values({
        id,
        backup_id: backup,
        count,
    }).returning({id: users.id, count: users.count, backup: users.backup_id}).get();

    return c.json({
        success: true,
        id: data.id,
        count: data.count,
        backup: data.backup,
    });
});

export default route;