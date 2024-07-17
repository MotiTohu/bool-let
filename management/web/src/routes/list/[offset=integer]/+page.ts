import type { PageLoad } from './$types';
import client from '$lib/client';

export const load: PageLoad = async ({ params }) => {
	const res = await client.list.$get({
		query: {
			asc: 'true',
			offset: params.offset
		}
	});
	const data = await res.json();
	return {
		data
	};
};