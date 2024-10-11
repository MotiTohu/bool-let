import { db } from '$lib/db';
import { result_table } from '$lib/schema';
import { error } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const POST: RequestHandler = async (e) => {
    const json = await e.request.json();
    console.log('json:');
    console.log(json,{depth:3});
    const score = json.score as number;
    if (typeof score !== 'number') {
        return error(400, 'Invalid score');
    }
    await (await db).insert(result_table).values({score}).execute();
    return new Response('ok');

}