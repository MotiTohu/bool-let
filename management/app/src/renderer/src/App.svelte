<script lang="ts">
  import Versions from './components/Versions.svelte'
  import electronLogo from './assets/electron.svg'
  import { ScanQRCode } from '@kuiper/svelte-scan-qrcode'

  let result = ''
  const ipcHandle = (): void => window.electron.ipcRenderer.send('ping')
  window.electron.ipcRenderer.on('ev',(event, args)=>{
    console.log('ipcRenderer.ipcRenderer.send', args)
  })
</script>

<img alt="logo" class="logo" src={electronLogo} />
<div class="creator">Powered by electron-vite</div>
<div class="text">
  Build an Electron app with
  <span class="svelte">Svelte</span>
  and
  <span class="ts">TypeScript</span>
</div>
<p class="tip">Please try pressing <code>F12</code> to open the devTool</p>
<div class="actions">
  <div class="action">
    <a href="https://electron-vite.org/" target="_blank" rel="noreferrer">Documentation</a>
  </div>
  <div class="action">
     <button on:click={ipcHandle}>Send IPC</button>
  </div>
</div>
<ScanQRCode bind:scanResult={result} enableQRCodeReaderButton={false} options={{}} />
<Versions />
