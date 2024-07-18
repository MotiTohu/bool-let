<script lang="ts">
	import type { PageData } from './$types';
	import {
		ArrowKeyDown,
		Button, Label,
		Pagination,
		Table,
		TableBody,
		TableBodyCell,
		TableBodyRow,
		TableHead,
		TableHeadCell
	} from 'flowbite-svelte';
	import { ChevronLeftOutline, ChevronRightOutline, EditOutline } from 'flowbite-svelte-icons';
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';
	import client from '$lib/client';

	$:offset = parseInt($page.params.offset);
	$:query = $page.url.searchParams;

	const get_url = (offset: number, order: string = '') => {
		const _query = new URLSearchParams(query);
		if (order !== '') {
			if (_query.get('order') === order) {
				if (_query.has('asc')) _query.delete('asc');
				else _query.set('asc', '');
			} else {
				_query.set('order', order);
				_query.delete('asc');
			}
		}
		return `/list/${offset}?${_query.toString()}`;
	};

	const get_list = async (offset: number, query: URLSearchParams) => {
		const res = await client.list.$get({
			query: {
				asc: query.has('asc').toString().toLowerCase(),
				offset: offset.toString(),
				order: query.get('order') ?? 'count'
			}
		});
		return await res.json();
	};

	const get_pages = ({ offset, count }: { offset: number, count: number }) => {
		const max_offset = Math.ceil(count / 10) - 1;
		let start = Math.max(0, offset - 3);
		let end = Math.min(max_offset, start + 7);
		const pages = [];
		for (let i = start; i < end + 1; i++) {
			pages.push({
				name: `${i}`,
				href: get_url(i)
			});
		}
		return pages;
	};
</script>
{#await get_list(offset, query)}
	<p>Loading...</p>
{:then list}
	<div class="flex flex-col gap-2">
		<Table hoverable={true}>
			<TableHead>
				<TableHeadCell>No</TableHeadCell>
				<TableHeadCell>id</TableHeadCell>
				<TableHeadCell>backup id</TableHeadCell>
				<TableHeadCell>
					<Label>
						count
						<Button color="alternative" size="xs" on:click="{()=>goto(get_url(offset,'count'))}">
							<ArrowKeyDown />
						</Button>
					</Label>
				</TableHeadCell>
				<TableHeadCell>
					<Label>
						created At
						<Button color="alternative" size="xs" on:click="{()=>goto(get_url(offset,'create'))}">
							<ArrowKeyDown />
						</Button>
					</Label>
				</TableHeadCell>
				<TableHeadCell>
					<Label>
						updated At
						<Button color="alternative" size="xs" on:click="{()=>goto(get_url(offset,'update'))}">
							<ArrowKeyDown />
						</Button>
					</Label>
				</TableHeadCell>
				<TableHeadCell />
			</TableHead>
			<TableBody tableBodyClass="divide-y">
				{#each list.result as res}
					<TableBodyRow>
						<TableBodyCell>{res.num}</TableBodyCell>
						<TableBodyCell>{res.id}</TableBodyCell>
						<TableBodyCell>{res.backup_id}</TableBodyCell>
						<TableBodyCell>{res.count}</TableBodyCell>
						<TableBodyCell>{new Date(res.createdAt).toLocaleString()}</TableBodyCell>
						<TableBodyCell>{new Date(res.updatedAt).toLocaleString()}</TableBodyCell>
						<TableBodyCell>
							<Button href="/edit/{res.id}">
								<EditOutline />
							</Button>
						</TableBodyCell>
					</TableBodyRow>
				{/each}
			</TableBody>
		</Table>
		<div class="w-full flex justify-end gap-4">
			<div class="flex items-center justify-center w-24">
				<p class="text-base dark:text-white">{list.offset * 10 + 1} - {Math.min((list.offset + 1) * 10, list.count)}
					/ {list.count}</p>
			</div>
			<Pagination pages={get_pages(list)} current={list.offset}
									on:previous={()=>goto(get_url(Math.max(list.offset-1,0)))}
									on:next={()=>goto(get_url(Math.min(list.offset+1,Math.ceil(list.count/10)-1)))}
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
{:catch error}
	<p>{error.message}</p>
{/await}