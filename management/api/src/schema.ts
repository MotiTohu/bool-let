import {sql} from "drizzle-orm";
import {sqliteTable, integer, text, int, uniqueIndex, unique} from "drizzle-orm/sqlite-core";

export const users = sqliteTable("users", {
    num: int("num").primaryKey({autoIncrement: true}),
    id: text("id").unique().notNull(),
    backup_id: text("backup_id").unique().notNull(),
    count: integer("count").default(0).notNull(),
    createdAt: integer("created_at", {mode: "timestamp"}).default(
        sql`(strftime('%s', 'now'))`
    ).notNull(),
    updatedAt: integer("updated_at", {mode: "timestamp"}).default(
        sql`(strftime('%s', 'now'))`
    ).notNull(),
}, (table) => ({
    unique_id: unique().on(table.id, table.backup_id)
}));
