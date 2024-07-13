<!-- https://github.com/kofkuiper/svelte-scan-qrcode/blob/main/src/lib/components/ScanQRCode.svelte -->
<script lang="ts">
  import { onMount } from 'svelte'
  import jsQR from 'jsqr'

  type optionsType = {
    onPermissionError?: () => void
    onResulted?: (result: string) => void
  }

  export let scanResult: string = ''
  export let options: optionsType
  export let scanning: boolean

  let video: HTMLVideoElement
  let canvas: HTMLCanvasElement

  onMount(() => {
    requestCamera()
  })

  function requestCamera(): void {
    navigator.mediaDevices
      .getUserMedia({
        audio: false,
        video: {
          facingMode: 'environment'
        }
      })
      .then((userStream) => {
        video.srcObject = userStream
        video.setAttribute('playsinline', 'true')
        video.play()
        startScan()
      })
      .catch((err) => {
        if (options?.onPermissionError != undefined) {
          options.onPermissionError()
        } else {
          alert(err)
        }
      })
  }

  function startScan(): void {
    if (!scanning) setTimeout(startScan, 500)
    const context = canvas.getContext('2d', { willReadFrequently: true })
    const { width, height } = canvas

    context.drawImage(video, 0, 0, width, height)

    const imageData = context.getImageData(0, 0, width, height)
    const qrCode = jsQR(imageData.data, width, height)

    if (qrCode) {
      scanResult = qrCode.data
      if (options?.onResulted != undefined) {
        options.onResulted(qrCode.data)
      } else {
        alert(qrCode.data)
      }
    }
    setTimeout(startScan, 500)
  }

  function onCanPlay(): void {
    canvas.width = video.videoWidth
    canvas.height = video.videoHeight
    startScan()
  }
</script>

<canvas bind:this={canvas} style="display: none;" />
<!-- svelte-ignore a11y-media-has-caption -->
<video on:canplay={onCanPlay} bind:this={video} />
