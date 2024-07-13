import type { AppType } from 'api/src'
import { hc } from 'hono/client'

const client = hc<AppType>(
  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  window.envVars.NODE_ENV === 'development'
    ? 'http://localhost:8787/'
    : 'https://bootlet-management-api.yosshipaopao.workers.dev/'
)

export default client
