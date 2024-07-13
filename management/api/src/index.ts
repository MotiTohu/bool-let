import {Hono} from 'hono';
import {serveStatic} from 'hono/cloudflare-workers';
// @ts-ignore
import manifest from '__STATIC_CONTENT_MANIFEST';
import auth from "./auth";
import register from "./register";
import {cors} from "hono/cors";

export type Bindings = {
    DB: D1Database;
}

const app = new Hono<{ Bindings: Bindings }>();

app.use('/*', cors())
app.get('/', (c) => c.text('Hello Hono!'));
app.get('/qr/*', serveStatic({path: './qr.html', manifest}));

const routes = app
    .route('/auth', auth)
    .route('/register', register);

export default app;
export type AppType = typeof routes;