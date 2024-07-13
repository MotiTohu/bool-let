CREATE TABLE `users` (
	`id` text PRIMARY KEY NOT NULL,
	`backup_id` text NOT NULL,
	`count` integer DEFAULT 0 NOT NULL,
	`created_at` integer DEFAULT (strftime('%s', 'now')) NOT NULL,
	`updated_at` integer DEFAULT (strftime('%s', 'now')) NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `users_backup_id_unique` ON `users` (`backup_id`);