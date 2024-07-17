import type { LayoutLoad } from './$types';
import { browser } from '$app/environment';

export const load: LayoutLoad = ({ fetch }) => {
	//if (browser) window.fetch = fetch;
	return;
};