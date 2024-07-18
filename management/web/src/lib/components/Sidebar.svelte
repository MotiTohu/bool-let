<script lang="ts">
	import { ChartPieSolid, CirclePlusOutline } from 'flowbite-svelte-icons';
	import { DarkMode, Sidebar, SidebarGroup, SidebarItem, SidebarWrapper } from 'flowbite-svelte';

	const iconClass = 'w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white';
</script>

<div class="flex">
	<Sidebar>
		<SidebarWrapper divClass="h-screen overflow-y-auto py-4 px-3 bg-gray-200 dark:bg-gray-600">
			<SidebarGroup ulClass="h-full flex flex-col">
				<SidebarItem label="Register" href="/">
					<svelte:fragment slot="icon">
						<CirclePlusOutline class={iconClass} />
					</svelte:fragment>
				</SidebarItem>
				<SidebarItem label="List" href="/list">
					<svelte:fragment slot="icon">
						<ChartPieSolid class={iconClass} />
					</svelte:fragment>
				</SidebarItem>
				<div class="mt-auto">
					<DarkMode />
				</div>
			</SidebarGroup>
		</SidebarWrapper>
	</Sidebar>
	<main class="flex-grow overflow-auto min-h-screen">
		<slot />
	</main>
</div>