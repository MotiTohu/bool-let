<script lang="ts">
  import client from '../lib/client'
  import ScanQRCode from './components/ScanQRCode.svelte'

  let scanning = true
  const onResulted = async (result: string): Promise<void> => {
    if (!scanning) return
    scanning = false
    if (result && result.length > 0) {
      const res = await client.auth.$get({
        query: {
          id: result
        }
      })
      if (res.ok) {
        const data = await res.json()
        console.log(data)
        if (data.status) {
          window.electron.ipcRenderer.send('run', 'shooting')
          return
        }
      }
      alert('auth failed')
    }
    scanning = true
  }
  window.electron.ipcRenderer.on('fin', (_event, args) => {
    scanning = true
    console.log('ipcRenderer.ipcRenderer.send', args)
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
