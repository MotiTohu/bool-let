<script lang="ts">
	import type { PageData } from './$types';
	import {
		Pagination,
		Table,
		TableBody,
		TableBodyCell,
		TableBodyRow,
		TableHead,
		TableHeadCell
	} from 'flowbite-svelte';
	import { ChevronLeftOutline, ChevronRightOutline } from 'flowbite-svelte-icons';
	import { goto } from '$app/navigation';


	export let data: PageData;

	let pages: { name: string, href: string }[] = [];
	const update_pages = ({ offset, count }: { offset: number, count: number }) => {
		const max_offset = Math.ceil(count / 10) - 1;
		let start = Math.max(0, offset - 3);
		let end = Math.min(max_offset, start + 7);
		pages = [];
		for (let i = start; i < end + 1; i++) {
			pages.push({
				name: `${i}`,
				href: `/list/${i}`
			});
		}
	};
	$:update_pages(data);
</script>

<div class="flex flex-col gap-2">
	<Table>
		<TableHead>
			<TableHeadCell>id</TableHeadCell>
			<TableHeadCell>backup id</TableHeadCell>
			<TableHeadCell>count</TableHeadCell>
			<TableHeadCell>created At</TableHeadCell>
			<TableHeadCell>updated At</TableHeadCell>
		</TableHead>
		<TableBody tableBodyClass="divide-y">
			{#each data.result as res}
				<TableBodyRow>
					<TableBodyCell>{res.id}</TableBodyCell>
					<TableBodyCell>{res.backup_id}</TableBodyCell>
					<TableBodyCell>{res.count}</TableBodyCell>
					<TableBodyCell>{res.createdAt}</TableBodyCell>
					<TableBodyCell>{res.updatedAt}</TableBodyCell>
				</TableBodyRow>
			{/each}
		</TableBody>
	</Table>
	<div class="w-full flex justify-end">
		<Pagination {pages}
								on:previous={()=>goto(`/list/${Math.max(0,data.offset-1)}`)}
								on:next={()=>goto(`/list/${Math.min(data.offset+1,Math.ceil(data.count / 10)-1)}`)}
		>
			<svelte:fragment slot="prev">
				<ChevronLeftOutline class="w-6 h-6" />
			</svelte:fragment>
			<svelte:fragment slot="next">
				<ChevronRightOutline class="w-6 h-6" />
			</svelte:fragment>
		</Pagination>
	</div>
</div>