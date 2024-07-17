<script lang="ts">
	import type { PageData } from './$types';
	import QRCode from '@castlenine/svelte-qrcode';

	export let data: PageData;
</script>

<QRCode data={data.id} />