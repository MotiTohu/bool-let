CREATE TABLE `users` (
	`num` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`id` text NOT NULL,
	`backup_id` text NOT NULL,
	`count` integer DEFAULT 0 NOT NULL,
	`created_at` integer DEFAULT (strftime('%s', 'now')) NOT NULL,
	`updated_at` integer DEFAULT (strftime('%s', 'now')) NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `users_id_unique` ON `users` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_backup_id_unique` ON `users` (`backup_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_id_backup_id_unique` ON `users` (`id`,`backup_id`);