ALTER TABLE
    `players`
ADD
    IF NOT EXISTS `cryptocurrency` LONGTEXT NOT NULL DEFAULT '',
ADD
    IF NOT EXISTS `crypto_wallet_id` TEXT NULL DEFAULT NULL,
ADD
    IF NOT EXISTS `cryptocurrencytransfers` TEXT NULL DEFAULT NULL;