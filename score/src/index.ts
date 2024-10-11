import { Hono } from 'hono'

import { upgradeWebSocket } from 'hono/cloudflare-workers'

const app = new Hono()

app.get('/', (c) => {
    console.log('Request received')
  return c.html(`
<html>
    <head>
      <meta charset='UTF-8' />
    </head>
    <body>
      <div id='now-time'></div>
      <script>
const connect = () => {
    const ws = new WebSocket('wss://score.yosshipaopao.workers.dev/ws');
    const $nowTime = document.getElementById('now-time');
    ws.onopen = () => {
        console.log('connected');
        ws.send('Hello from client!');
    }
    ws.onerror = (error) => {
        console.error(error);
        ws.close();
    }
    ws.onclose = () => {
        console.log('disconnected');
        setTimeout(()=>{
          connect();
        }, 1000);
    }
    ws.onmessage = (event) => {
        console.log(event.data);
        $nowTime.textContent = event.data;
    }
}
connect();
      </script>
    </body>
</html>
         `)
});

app.get(
    '/ws',
    upgradeWebSocket((c) => {
        return {
            onMessage(event, ws) {
                console.log(`Message from client: ${event.data}`)
                ws.send('Hello from server!')
            },
            onClose: () => {
                console.log('Connection closed')
            },
        }
    })
)

export default app