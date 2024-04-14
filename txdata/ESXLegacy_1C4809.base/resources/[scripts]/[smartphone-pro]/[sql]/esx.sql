ALTER TABLE
    `users`
ADD
    IF NOT EXISTS `cryptocurrency` LONGTEXT NOT NULL DEFAULT '',
ADD
    IF NOT EXISTS `crypto_wallet` INT(11) NULL DEFAULT '0',
ADD
    IF NOT EXISTS `phone_number` INT(11) NULL;