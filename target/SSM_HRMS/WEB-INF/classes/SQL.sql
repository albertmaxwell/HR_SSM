
CREATE TABLE `tbl_emp` (
`emp_id` INT ( 11 ) UNSIGNED NOT NULL auto_increment,
`emp_name` VARCHAR ( 22 ) NOT NULL DEFAULT '',
`emp_email` VARCHAR ( 256 ) NOT NULL DEFAULT '',
`gender` CHAR ( 2 ) NOT NULL DEFAULT '',
`department_id` INT ( 11 ) NOT NULL DEFAULT 0,
PRIMARY KEY ( `emp_id` )
) ENGINE = INNODB DEFAULT CHARSET = UTF8;



DROP TABLE
IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept` (
`dept_id` INT ( 11 ) UNSIGNED NOT NULL auto_increment,
`dept_name` VARCHAR ( 255 ) NOT NULL DEFAULT '',
`dept_leader` VARCHAR ( 255 ) NOT NULL DEFAULT '',
PRIMARY KEY ( `dept_id` )
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


DROP TABLE
IF EXISTS `tbl_contracts`;
CREATE TABLE `tbl_contracts` (
`contracts_id` INT ( 11 ) UNSIGNED NOT NULL auto_increment,
`contracts_code` VARCHAR ( 255 ) NOT NULL DEFAULT '',
`contracts_title` VARCHAR ( 255 ) NOT NULL DEFAULT '',
PRIMARY KEY ( `contracts_id` )
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
