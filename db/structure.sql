CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `glasses_id` int(11) DEFAULT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

CREATE TABLE `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

CREATE TABLE `glasses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `glasses_name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `manufacturer_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_glasses_manufacturers` (`manufacturer_id`),
  CONSTRAINT `fk_glasses_manufacturers` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

CREATE TABLE `manufacturers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `glasses_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `ship_to_first_name` varchar(255) DEFAULT NULL,
  `ship_to_last_name` varchar(255) DEFAULT NULL,
  `ship_to_address` varchar(255) DEFAULT NULL,
  `ship_to_city` varchar(255) DEFAULT NULL,
  `ship_to_postal_code` varchar(255) DEFAULT NULL,
  `ship_to_country_code` varchar(255) DEFAULT NULL,
  `customer_ip` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `error_message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `crypted_password` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  `persistence_token` varchar(255) NOT NULL,
  `perishable_token` varchar(255) NOT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `failed_login_count` int(11) NOT NULL DEFAULT '0',
  `last_request_at` datetime DEFAULT NULL,
  `current_login_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `current_login_ip` varchar(255) DEFAULT NULL,
  `last_login_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20130703084901');

INSERT INTO schema_migrations (version) VALUES ('20130703084948');

INSERT INTO schema_migrations (version) VALUES ('20130705111222');

INSERT INTO schema_migrations (version) VALUES ('20140324142550');

INSERT INTO schema_migrations (version) VALUES ('20140401101327');

INSERT INTO schema_migrations (version) VALUES ('20140415235812');

INSERT INTO schema_migrations (version) VALUES ('20140420131844');

INSERT INTO schema_migrations (version) VALUES ('20140422083605');

INSERT INTO schema_migrations (version) VALUES ('20140422083618');