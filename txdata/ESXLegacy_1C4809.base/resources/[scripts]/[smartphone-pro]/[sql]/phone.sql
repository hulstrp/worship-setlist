DROP TABLE IF EXISTS `crypto_transactions`;

CREATE TABLE `crypto_transactions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `citizenid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `title` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `message` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `date` TIMESTAMP NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `citizenid` (`citizenid`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `darkchat_messages`;

CREATE TABLE `darkchat_messages` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `owner` varchar(46) DEFAULT NULL,
    `name` varchar(50) DEFAULT '',
    `messages` text DEFAULT NULL,
    `password` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `id` (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `instagram_accounts`;

CREATE TABLE `instagram_accounts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `username` VARCHAR(50) NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `password` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `avatar` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `bio` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `verified` INT(11) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `username` (`username`) USING BTREE,
    INDEX `phone` (`phone`) USING BTREE,
    INDEX `id` (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 19;

DROP TABLE IF EXISTS `instagram_follow`;

CREATE TABLE `instagram_follow` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `follower` int(11) NOT NULL DEFAULT 0,
    `following` int(11) NOT NULL DEFAULT 0,
    `updatedDate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 104 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `instagram_messages`;

CREATE TABLE `instagram_messages` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `sender` int(11) NOT NULL DEFAULT 0,
    `receiver` int(11) NOT NULL DEFAULT 0,
    `time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `messages` text COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 169 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `instagram_notifications`;

CREATE TABLE `instagram_notifications` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `userId` int(11) NOT NULL DEFAULT 0,
    `targetId` int(11) NOT NULL DEFAULT 0,
    `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
    `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 116 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `instagram_posts`;

CREATE TABLE `instagram_posts` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `updatedDate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `userId` int(11) DEFAULT NULL,
    `data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 14 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `instagram_stories`;

CREATE TABLE `instagram_stories` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `userId` int(11) NOT NULL DEFAULT 0,
    `updatedDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `data` text COLLATE armscii8_bin NOT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 DEFAULT CHARSET = armscii8 COLLATE = armscii8_bin;

DROP TABLE IF EXISTS `mail_accounts`;

CREATE TABLE `mail_accounts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(50) NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `mail` VARCHAR(50) NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `name` VARCHAR(50) NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `password` VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    `phone` VARCHAR(50) NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 14;

DROP TABLE IF EXISTS `phone_gallery`;

CREATE TABLE `phone_gallery` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `content` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `type` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `data` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `filter` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 151;

DROP TABLE IF EXISTS `phone_messages`;

CREATE TABLE `phone_messages` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `number` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `messages` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `created` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `unreaded` INT(11) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 150;

DROP TABLE IF EXISTS `phone_notifies`;

CREATE TABLE `phone_notifies` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `msg_content` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `msg_head` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `app_name` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `msg_time` TIMESTAMP NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `phone_recipes`;

CREATE TABLE `phone_recipes` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `phone_reminders`;

CREATE TABLE `phone_reminders` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `header` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `note` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `date` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `time` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `player_contacts`;

CREATE TABLE `player_contacts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `name` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `number` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `iban` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `display` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `note` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `pp` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `isBlocked` INT(11) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `identifier` (`identifier`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 67;

DROP TABLE IF EXISTS `player_mails`;

CREATE TABLE `player_mails` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `taker` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `sender` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `subject` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `message` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `read` TINYINT(4) NULL DEFAULT '0',
    `mailid` INT(11) NULL DEFAULT NULL,
    `date` TIMESTAMP NULL DEFAULT current_timestamp(),
    `button` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `medias` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `identifier` (`taker`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `tiktok_users`;

CREATE TABLE `tiktok_users` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `username` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `password` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `phone` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `pp` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `name` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `bio` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `birthday` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `videos` TEXT NOT NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
    `followers` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `following` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `liked` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
    `verified` INT(11) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `username` (`username`) USING BTREE,
    INDEX `id` (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `tiktok_videos`;

CREATE TABLE `tiktok_videos` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `userID` int(11) DEFAULT NULL,
    `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `market_accounts`;

CREATE TABLE `market_accounts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    `created` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    `phone` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `username` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `avatar` TEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `password` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `username` (`username`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 3;

DROP TABLE IF EXISTS `market_messages`;

CREATE TABLE `market_messages` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `sender` INT(11) NOT NULL,
    `receiver` INT(11) NOT NULL,
    `time` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `messages` TEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `isMarket` INT(11) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 3;

DROP TABLE IF EXISTS `market_markets`;

CREATE TABLE `market_markets` (
    `id` INT(11) NOT NULL,
    `name` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    `description` TEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `job` TEXT NOT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
    `ratings` TEXT NOT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
    `coords` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `twitter_accounts`;

CREATE TABLE `twitter_accounts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(46) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `created` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `phone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `username` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `password` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `avatar` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `bio` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `verified` INT(11) NULL DEFAULT NULL,
    `background` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `username` (`username`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 4;

DROP TABLE IF EXISTS `twitter_follow`;

CREATE TABLE `twitter_follow` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `follower` INT(11) NULL DEFAULT NULL,
    `following` INT(11) NULL DEFAULT NULL,
    `updatedDate` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 14;

DROP TABLE IF EXISTS `twitter_messages`;

CREATE TABLE `twitter_messages` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `sender` INT(11) NOT NULL,
    `receiver` INT(11) NOT NULL,
    `time` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `messages` TEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 2;

DROP TABLE IF EXISTS `twitter_notifications`;

CREATE TABLE `twitter_notifications` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userId` INT(11) NOT NULL DEFAULT '0',
    `targetUserId` INT(11) NOT NULL DEFAULT '0',
    `type` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `tweetId` INT(11) NULL DEFAULT NULL,
    `time` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 28;

DROP TABLE IF EXISTS `twitter_retweets`;

CREATE TABLE `twitter_retweets` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userId` INT(11) NOT NULL DEFAULT '0',
    `tweetId` INT(11) NOT NULL DEFAULT '0',
    `created` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 8;

DROP TABLE IF EXISTS `twitter_tweets`;

CREATE TABLE `twitter_tweets` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userId` INT(11) NOT NULL,
    `time` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    `text` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `media` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `likes` TEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
    `mentions` TEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
    `comments` TEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
    `retweets` TEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 19;

DROP TABLE IF EXISTS `phone_metadata`;

CREATE TABLE `phone_metadata` (
    `identifier` VARCHAR(46) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    `metadata` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `phoneNumber` VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`identifier`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `phone_yellowpages`;

CREATE TABLE `phone_yellowpages` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `title` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `description` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `image` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `price` INT(11) NULL DEFAULT '0',
    `created` TIMESTAMP NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 4;

DROP TABLE IF EXISTS `phone_bills`;

CREATE TABLE `phone_bills` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `price` INT(11) NOT NULL DEFAULT '0',
    `identifier` VARCHAR(46) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `timestamp` TIMESTAMP NULL DEFAULT current_timestamp(),
    `sender` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `label` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `id` (`id`) USING BTREE,
    INDEX `identifier` (`identifier`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `whatsapp_accounts`;

CREATE TABLE `whatsapp_accounts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `name` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `avatar` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `bio` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
    `group_creator` INT(11) NULL DEFAULT NULL,
    `created` TIMESTAMP NULL DEFAULT current_timestamp(),
    `hide_receipts` INT(11) NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `whatsapp_call_history`;

CREATE TABLE `whatsapp_call_history` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `caller` INT(11) NOT NULL DEFAULT '0',
    `calledId` INT(11) NULL DEFAULT NULL,
    `time` TIMESTAMP NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `whatsapp_call_history_users`;

CREATE TABLE `whatsapp_call_history_users` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userId` INT(11) NOT NULL DEFAULT '0',
    `callId` INT(11) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `whatsapp_chats`;

CREATE TABLE `whatsapp_chats` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `sender` INT(11) NOT NULL DEFAULT '0',
    `receiver` INT(11) NOT NULL DEFAULT '0',
    `wallpaper` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `isGroup` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `time` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `messages` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 21;

DROP TABLE IF EXISTS `whatsapp_group_admins`;

CREATE TABLE `whatsapp_group_admins` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userId` INT(11) NOT NULL DEFAULT '0',
    `groupId` INT(11) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 11;

DROP TABLE IF EXISTS `whatsapp_group_members`;

CREATE TABLE `whatsapp_group_members` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userId` INT(11) NOT NULL DEFAULT '0',
    `groupId` INT(11) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 28;

DROP TABLE IF EXISTS `whatsapp_status`;

CREATE TABLE `whatsapp_status` (
    `userId` INT(11) NOT NULL DEFAULT '0',
    `data` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`userId`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `phone_app_store`;

CREATE TABLE `phone_app_store` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `application` VARCHAR(50) NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `ratings` TEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_general_ci',
    `downloads` INT(11) NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `weazel`;

CREATE TABLE `weazel` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `title` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `content` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `image` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
    `created` VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 2;

DROP TABLE IF EXISTS `tinder_accounts`;

CREATE TABLE `tinder_accounts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `name` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `owner` VARCHAR(70) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `photos` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `dob` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `bio` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `password` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `gender` VARCHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `interested` VARCHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 7;

DROP TABLE IF EXISTS `tinder_messages`;

CREATE TABLE `tinder_messages` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `unread` INT(11) NOT NULL DEFAULT '0',
    `sender` INT(11) NOT NULL DEFAULT '0',
    `receiver` INT(11) NOT NULL DEFAULT '0',
    `time` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `messages` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 5;

DROP TABLE IF EXISTS `tinder_swipers`;

CREATE TABLE `tinder_swipers` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userId` INT(11) NOT NULL DEFAULT '0',
    `targetId` INT(11) NOT NULL DEFAULT '0',
    `liked` INT(11) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 21;

DROP TABLE IF EXISTS `uber_rider_last_transactions`;

CREATE TABLE `uber_rider_last_transactions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `date` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    `target` VARCHAR(80) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `targetName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `plate` VARCHAR(80) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `price` INT(11) NULL DEFAULT NULL,
    `type` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 6;

DROP TABLE IF EXISTS `phone_chatrooms`;

CREATE TABLE `phone_chatrooms` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `room_code` VARCHAR(10) NOT NULL COLLATE 'utf8mb4_general_ci',
    `room_name` VARCHAR(15) NOT NULL COLLATE 'utf8mb4_general_ci',
    `room_owner_id` INT(11) NULL DEFAULT NULL,
    `room_owner_name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `room_members` TEXT NULL DEFAULT '{}' COLLATE 'utf8mb4_general_ci',
    `room_pin` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `unpaid_balance` DECIMAL(10, 2) NULL DEFAULT '0.00',
    `is_masked` TINYINT(1) NULL DEFAULT '0',
    `is_pinned` TINYINT(1) NULL DEFAULT '0',
    `created` DATETIME NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `room_code` (`room_code`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 1;

INSERT INTO
    `phone_chatrooms` (
        `room_code`,
        `room_name`,
        `room_owner_id`,
        `room_owner_name`,
        `is_pinned`
    )
VALUES
    ('411', '411', -1, 'Government', 1),
    (
        'lounge',
        'The Lounge',
        -1,
        'Government',
        1
    ),
    ('events', 'Events', -1, 'Government', 1);

DROP TABLE IF EXISTS `phone_chatroom_messages`;

CREATE TABLE `phone_chatroom_messages` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT,
    `room_id` INT unsigned,
    `member_id` VARCHAR(20),
    `member_name` VARCHAR(50),
    `message` TEXT NOT NULL,
    `is_pinned` BOOLEAN DEFAULT FALSE,
    `created` DATETIME DEFAULT NOW(),
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `discord_accounts`;

CREATE TABLE `discord_accounts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(80) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `phone` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `username` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `password` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB AUTO_INCREMENT = 3;

DROP TABLE IF EXISTS `facetime_call_history`;

CREATE TABLE `facetime_call_history` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `caller` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `calledId` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    `time` TIMESTAMP NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `phone_favorite_contacts`;

CREATE TABLE `phone_favorite_contacts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `phone` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `crypto`;

CREATE TABLE `crypto` (
    `crypto` varchar(50) NOT NULL DEFAULT 'btc',
    `worth` int(11) NOT NULL DEFAULT 0,
    `history` text DEFAULT NULL,
    PRIMARY KEY (`crypto`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

INSERT INTO
    `crypto`
VALUES
    (
        'btc',
        1000,
        '[{"NewWorth":1000,"PreviousWorth":1000}]'
    );

DROP TABLE IF EXISTS `crypto_history`;

CREATE TABLE `crypto_history` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `worth` INT(11) NOT NULL DEFAULT '0',
    `name` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
    `date` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `lapraces`;

CREATE TABLE `lapraces` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) DEFAULT NULL,
    `checkpoints` text DEFAULT NULL,
    `records` text DEFAULT NULL,
    `creator` varchar(50) DEFAULT NULL,
    `distance` int(11) DEFAULT NULL,
    `raceid` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 35 DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `phone_blocked_phones`;

CREATE TABLE `phone_blocked_phones` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `uniqueId` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB;

DROP TABLE IF EXISTS `phone_backups`;

CREATE TABLE `phone_backups` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_unicode_ci',
    `data` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
    `owner` VARCHAR(120) NOT NULL DEFAULT '' COLLATE 'utf8mb4_unicode_ci',
    PRIMARY KEY (`id`) USING BTREE
) COLLATE = 'utf8mb4_unicode_ci' ENGINE = InnoDB AUTO_INCREMENT = 17;