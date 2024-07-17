<script lang="ts">
	import '../app.css';
	import {
		ArrowRightToBracketOutline,
		CartSolid,
		ChartPieSolid, CirclePauseOutline, CirclePlusOutline,
		EditOutline, GridSolid,
		MailBoxSolid, PlusOutline, UserSolid
	} from 'flowbite-svelte-icons';
	import {
		Sidebar,
		SidebarDropdownItem,
		SidebarDropdownWrapper,
		SidebarGroup,
		SidebarItem,
		SidebarWrapper
	} from 'flowbite-svelte';

	const spanClass = 'flex-1 ms-3 whitespace-nowrap';
	const iconClass = 'w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white';

</script>
<div class="flex">
	<Sidebar>
		<SidebarWrapper divClass="h-screen overflow-y-auto py-4 px-3 rounded bg-gray-200">
			<SidebarGroup>
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
				<SidebarDropdownWrapper label="E-commerce">
					<svelte:fragment slot="icon">
						<CartSolid class={iconClass} />
					</svelte:fragment>
					<SidebarDropdownItem label="Products" />
					<SidebarDropdownItem label="Billing" />
					<SidebarDropdownItem label="Invoice" />
				</SidebarDropdownWrapper>
				<SidebarItem label="Kanban" {spanClass}>
					<svelte:fragment slot="icon">
						<GridSolid class={iconClass} />
					</svelte:fragment>
					<svelte:fragment slot="subtext">
						<span
							class="inline-flex justify-center items-center px-2 ms-3 text-sm font-medium text-gray-800 bg-gray-200 rounded-full dark:bg-gray-700 dark:text-gray-300"> Pro </span>
					</svelte:fragment>
				</SidebarItem>
				<SidebarItem label="Inbox" {spanClass}>
					<svelte:fragment slot="icon">
						<MailBoxSolid
							class="w-6 h-6 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white" />
					</svelte:fragment>
					<svelte:fragment slot="subtext">
						<span
							class="inline-flex justify-center items-center p-3 ms-3 w-3 h-3 text-sm font-medium text-primary-600 bg-primary-200 rounded-full dark:bg-primary-900 dark:text-primary-200"> 3 </span>
					</svelte:fragment>
				</SidebarItem>
				<SidebarItem label="Users">
					<svelte:fragment slot="icon">
						<UserSolid class={iconClass} />
					</svelte:fragment>
				</SidebarItem>
				<SidebarItem label="Sign In">
					<svelte:fragment slot="icon">
						<ArrowRightToBracketOutline class={iconClass} />
					</svelte:fragment>
				</SidebarItem>
				<SidebarItem label="Sign Up">
					<svelte:fragment slot="icon">
						<EditOutline class={iconClass} />
					</svelte:fragment>
				</SidebarItem>
			</SidebarGroup>
		</SidebarWrapper>
	</Sidebar>
	<main class="flex-grow overflow-auto min-h-screen">
		<slot />
	</main>
</div>
