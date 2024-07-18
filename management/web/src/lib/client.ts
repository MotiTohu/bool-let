import { dev } from '$app/environment';
import type { AppType } from 'api/src';
import { hc } from 'hono/client';

type Fetch = ((input: (RequestInfo | URL), requestInit?: RequestInit, Env?: never, executionCtx?: ExecutionContext) => (Response | Promise<Response>));

const client = hc<AppType>(
	dev
		? 'http://localhost:8787/'
		: 'https://bootlet-management-api.yosshipaopao.workers.dev/'
);

export default client;

export const make_client = (fetch: Fetch) => {
	return hc<AppType>(
		dev
			? 'http://localhost:8787/'
			: 'https://bootlet-management-api.yosshipaopao.workers.dev/',
		{ fetch }
	);
};