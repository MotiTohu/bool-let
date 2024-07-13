import {Hono} from "hono";
import {z} from "zod";
import {zValidator} from "@hono/zod-validator";
import type {Bindings} from "./";
import {drizzle} from "drizzle-orm/d1";
import {users} from "./schema";
import {eq} from "drizzle-orm";

const app = new Hono<{ Bindings: Bindings }>();

const schema = z.object({
    id: z.string()
});

const route = app.get('/', zValidator('query', schema), async (c) => {
    const id = c.req.valid('query').id;
    const db = drizzle(c.env.DB);
    const result = await db.select({count: users.count}).from(users).where(eq(users.id, id)).get();
    console.log(result)
    if (result && result.count > 0) await db.update(users).set({count: result.count - 1}).where(eq(users.id, id))

    return c.json({
        success: true,
        status: !!(result && result.count > 0),
        id
    });
});

export default route;