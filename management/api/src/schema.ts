import {sql} from "drizzle-orm";
import {sqliteTable, integer, text} from "drizzle-orm/sqlite-core";

export const users = sqliteTable("users", {
    id: text("id").primaryKey(),
    backup_id: text("backup_id").unique().notNull(),
    count: integer("count").default(0).notNull(),
    createdAt: integer("created_at", {mode: "timestamp"}).default(
        sql`(strftime('%s', 'now'))`
    ).notNull(),
    updatedAt: integer("updated_at", {mode: "timestamp"}).default(
        sql`(strftime('%s', 'now'))`
    ).notNull(),
});
