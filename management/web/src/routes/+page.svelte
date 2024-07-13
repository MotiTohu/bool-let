<script lang="ts">
	import client from '$lib/client';

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
			window.open(`http://localhost:8787/qr/${data.id}`,'_blank');
		}
	};
</script>

<label for="count">count</label>
<input id="count" type="number" required bind:value={count} />
<button on:click={add}>add</button>