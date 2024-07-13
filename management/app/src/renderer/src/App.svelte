<script lang="ts">
  import ScanQRCode from './components/ScanQRCode.svelte'

  let scanning = true
  const onResulted = (result: string): void => {
    if (!scanning) return
    if (result && result.length > 0) {
      window.electron.ipcRenderer.send('run', result)
      scanning = false
    }
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
<button on:click={force_enable_run_game}>enable game run</button>/
