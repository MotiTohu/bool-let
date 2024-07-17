<script lang="ts">
	import client from '$lib/client';
	import { goto } from '$app/navigation';

	let count = 0;
	const add = async () => {
		const res = await client.register.$post({
			json: {
				count
			}
		});
		if (res.ok) {
			const data = await res.json();
			console.log(data);
			await goto(`/qr/${data.id}`);
		}
	};
</script>
<div class="w-full h-full flex items-center justify-center">
	<div>
		<label for="count">count</label>
		<input id="count" type="number" required bind:value={count} />
		<button on:click={add}>add</button>
	</div>
</div>
