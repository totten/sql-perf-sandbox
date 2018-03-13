CREATE TABLE `civicrm_contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique Contact ID',
  `contact_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Type of Contact.',
  `contact_sub_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'May be used to over-ride contact view and edit templates.',
  `do_not_email` tinyint(4) DEFAULT '0',
  `do_not_phone` tinyint(4) DEFAULT '0',
  `do_not_mail` tinyint(4) DEFAULT '0',
  `do_not_sms` tinyint(4) DEFAULT '0',
  `do_not_trade` tinyint(4) DEFAULT '0',
  `is_opt_out` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Has the contact opted out from receiving all bulk email from the organization or site domain?',
  `legal_identifier` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'May be used for SSN, EIN/TIN, Household ID (census) or other applicable unique legal/government ID.\n    ',
  `external_identifier` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Unique trusted external ID (generally from a legacy app/datasource). Particularly useful for deduping operations.',
  `sort_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Name used for sorting different contact types',
  `display_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Formatted name representing preferred format for display/print/other output.',
  `nick_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Nickname.',
  `legal_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Legal Name.',
  `image_URL` text COLLATE utf8_unicode_ci COMMENT 'optional URL for preferred image (photo, logo, etc.) to display for this contact.',
  `preferred_communication_method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'What is the preferred mode of communication.',
  `preferred_language` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Which language is preferred for communication. FK to languages in civicrm_option_value.',
  `preferred_mail_format` varchar(8) COLLATE utf8_unicode_ci DEFAULT 'Both' COMMENT 'What is the preferred mode of sending an email.',
  `hash` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Key for validating requests related to this contact.',
  `api_key` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'API Key for validating requests related to this contact.',
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'where contact come from, e.g. import, donate module insert...',
  `first_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'First Name.',
  `middle_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Middle Name.',
  `last_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Last Name.',
  `prefix_id` int(10) unsigned DEFAULT NULL COMMENT 'Prefix or Title for name (Ms, Mr...). FK to prefix ID',
  `suffix_id` int(10) unsigned DEFAULT NULL COMMENT 'Suffix for name (Jr, Sr...). FK to suffix ID',
  `formal_title` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Formal (academic or similar) title in front of name. (Prof., Dr. etc.)',
  `communication_style_id` int(10) unsigned DEFAULT NULL COMMENT 'Communication style (e.g. formal vs. familiar) to use with this contact. FK to communication styles in civicrm_option_value.',
  `email_greeting_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Email Greeting.',
  `email_greeting_custom` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Custom Email Greeting.',
  `email_greeting_display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Cache Email Greeting.',
  `postal_greeting_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Postal Greeting.',
  `postal_greeting_custom` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Custom Postal greeting.',
  `postal_greeting_display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Cache Postal greeting.',
  `addressee_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to civicrm_option_value.id, that has to be valid registered Addressee.',
  `addressee_custom` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Custom Addressee.',
  `addressee_display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Cache Addressee.',
  `job_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Job Title',
  `gender_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to gender ID',
  `birth_date` date DEFAULT NULL COMMENT 'Date of birth',
  `is_deceased` tinyint(4) DEFAULT '0',
  `deceased_date` date DEFAULT NULL COMMENT 'Date of deceased',
  `household_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Household Name.',
  `primary_contact_id` int(10) unsigned DEFAULT NULL COMMENT 'Optional FK to Primary Contact for this household.',
  `organization_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Organization Name.',
  `sic_code` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Standard Industry Classification Code.',
  `user_unique_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'the OpenID (or OpenID-style http://username.domain/) unique identifier for this contact mainly used for logging in to CiviCRM',
  `employer_id` int(10) unsigned DEFAULT NULL COMMENT 'OPTIONAL FK to civicrm_contact record.',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'When was the contact was created.',
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'When was the contact (or closely related entity) was created or modified or deleted.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UI_external_identifier` (`external_identifier`),
  KEY `index_sort_name` (`sort_name`),
  KEY `index_preferred_communication_method` (`preferred_communication_method`),
  KEY `index_hash` (`hash`),
  KEY `index_api_key` (`api_key`),
  KEY `index_first_name` (`first_name`),
  KEY `index_last_name` (`last_name`),
  KEY `index_communication_style_id` (`communication_style_id`),
  KEY `UI_gender` (`gender_id`),
  KEY `index_is_deceased` (`is_deceased`),
  KEY `index_household_name` (`household_name`),
  KEY `index_organization_name` (`organization_name`),
  KEY `index_is_deleted_sort_name` (`is_deleted`,`sort_name`,`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
-- AUTO_INCREMENT=204


--  KEY `index_contact_type` (`contact_type`),
--  KEY `index_contact_sub_type` (`contact_sub_type`),
--  KEY `UI_prefix` (`prefix_id`),
--  KEY `UI_suffix` (`suffix_id`),
--  KEY `FK_civicrm_contact_primary_contact_id` (`primary_contact_id`),
--  KEY `FK_civicrm_contact_employer_id` (`employer_id`),
--  CONSTRAINT `FK_civicrm_contact_employer_id` FOREIGN KEY (`employer_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL,
--  CONSTRAINT `FK_civicrm_contact_primary_contact_id` FOREIGN KEY (`primary_contact_id`) REFERENCES `civicrm_contact` (`id`) ON DELETE SET NULL


CREATE TABLE `civicrm_prevnext_cache` (


     `id` int unsigned NOT NULL AUTO_INCREMENT  ,
     `entity_table` varchar(64)    COMMENT 'physical tablename for entity being joined to discount, e.g. civicrm_event',
     `entity_id1` int unsigned NOT NULL   COMMENT 'FK to entity table specified in entity_table column.',
     `entity_id2` int unsigned NOT NULL   COMMENT 'FK to entity table specified in entity_table column.',
     `cacheKey` varchar(255)    COMMENT 'Unique path name for cache element of the searched item',
     `data` longtext    COMMENT 'cached snapshot of the serialized data',
     `is_selected` tinyint   DEFAULT 0  ,
        PRIMARY KEY (`id`)
 
    ,     INDEX `index_all`(
        cacheKey
      , entity_id1
      , entity_id2
      , entity_table
      , is_selected
  )
  
 
)  ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci  ;
