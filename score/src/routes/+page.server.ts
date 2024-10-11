import type { PageServerLoad } from "./$types";
import { db } from "$lib/db";
import { result_table } from "$lib/schema";
import { desc } from "drizzle-orm";

export const load: PageServerLoad = async ({request}) => {
    const top = await (await db)
        .select({score: result_table.score, time: result_table.created_at})
        .from(result_table)
        .orderBy(desc(result_table.score))
        .limit(5);
    const resent = await (await db)
        .select({score: result_table.score, time: result_table.created_at})
        .from(result_table)
        .orderBy(desc(result_table.created_at))
        .limit(5);
    return {top, resent};
}