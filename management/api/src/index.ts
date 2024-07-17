import {Hono} from 'hono';
import {cors} from "hono/cors";
import auth from "./routes/auth";
import register from "./routes/register";
import query from "./routes/query";
import list from "./routes/list";

export type Bindings = {
    DB: D1Database;
}

const app = new Hono<{ Bindings: Bindings }>();

app.use('/*', cors())
app.get('/', (c) => c.text('Hello Hono!'));

const routes = app
    .route('/auth', auth)
    .route('/register', register)
    .route('/query', query)
    .route('/list', list);

export default app;
export type AppType = typeof routes;