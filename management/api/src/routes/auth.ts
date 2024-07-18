import {Hono} from "hono";
import {z} from "zod";
import {zValidator} from "@hono/zod-validator";
import type {Bindings} from "../index";
import {drizzle} from "drizzle-orm/d1";
import {users} from "../schema";
import {eq, or} from "drizzle-orm";

const app = new Hono<{ Bindings: Bindings }>();

const schema = z.object({
    id: z.string()
});

const route = app.get('/', zValidator('query', schema), async (c) => {
    const id = c.req.valid('query').id;
    const db = drizzle(c.env.DB);
    const result = await db.select({count: users.count}).from(users).where(or(eq(users.backup_id, id), eq(users.id, id))).get();

    return c.json({
        success: true,
        status: !!(result && result.count > 0),
        id
    });
});

export default route;