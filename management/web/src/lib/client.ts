import { dev } from '$app/environment';
import type { AppType } from 'api/src';
import { hc } from 'hono/client';

const client = hc<AppType>(
	dev
		? 'http://localhost:8787/'
		: 'https://bootlet-management-api.yosshipaopao.workers.dev/'
);

export default client;
