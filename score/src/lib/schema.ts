import { sqliteTable, integer } from "drizzle-orm/sqlite-core";

export const result_table = sqliteTable("result", {
    id: integer({ mode: 'number' }).primaryKey({ autoIncrement: true }),
    score: integer({ mode: 'number' }).notNull(),
    created_at: integer({ mode: 'timestamp_ms' }).$default(() => new Date()),
});