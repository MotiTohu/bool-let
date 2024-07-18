<script lang="ts">
  import client from '../lib/client'
  import ScanQRCode from './components/ScanQRCode.svelte'

  let scanning = true
  let id = ''
  const onResulted = async (result: string): Promise<void> => {
    if (!scanning) return
    scanning = false
    console.log('qr result:', result)
    if (result && result.length > 0) {
      console.log('result passed')
      const res = await client.auth.$get({
        query: {
          id: result
        }
      })
      console.log('api result', res.ok)
      if (res.ok) {
        const data = await res.json()
        console.log('api data', data)
        if (data.status) {
          id = result
          window.electron.ipcRenderer.send('run', 'shooting')
          return
        }
      }
      alert('auth failed')
    }
    scanning = true
  }
  window.electron.ipcRenderer.on('fin', async () => {
    scanning = true
    console.log('game finish got, id = ', id)
    if (id)
      await client.query.$post({
        json: { id, diff: -1 }
      })
    id = ''
  })

  const force_enable_scanning = (): void => {
    scanning = true
  }

  const force_enable_run_game = (): void => {
    window.electron.ipcRenderer.send('enable_game')
  }
</script>

<ScanQRCode bind:scanning options={{ onResulted }} />
{#if !scanning}
  <button on:click={force_enable_scanning}>enable scan</button>
{/if}
<button on:click={force_enable_run_game}>enable game run</button>
