import { db } from '$lib/db';
import { result_table } from '$lib/schema';
import type { Actions } from './$types';

export const actions = {
	default: async ({request}) => {
        const data = await request.formData();
        const score = parseInt(data.get('score')?.toString()??'0');
        await (await db).insert(result_table).values({score}).execute();
        return {success: true};
	},
} satisfies Actions;