<?php
$path = dirname(__FILE__);

$host = (strstr($path,'htdocs')) ? 'ninjacad.local' : 'ninjacad.com';
$dbhost = (strstr($path,'htdocs')) ? 'localhost' : 'ninjacad.db.8089870.hostedresource.com';

// HTTP
define('HTTP_SERVER', 'http://'.$host.'/');

// HTTPS
define('HTTPS_SERVER', 'http://'.$host.'/');

// DIR
define('DIR_APPLICATION', $path.'/catalog/');
define('DIR_SYSTEM', $path.'/system/');
define('DIR_DATABASE',$path.'/system/database/');
define('DIR_LANGUAGE',$path.'/catalog/language/');
define('DIR_TEMPLATE',$path.'/catalog/view/theme/');
define('DIR_CONFIG', $path.'/system/config/');
define('DIR_IMAGE', $path.'/image/');
define('DIR_CACHE', $path.'/system/cache/');
define('DIR_DOWNLOAD', $path.'/download/');
define('DIR_LOGS', $path.'/system/logs/');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', $dbhost);
define('DB_USERNAME', 'ninjacad');
define('DB_PASSWORD', 'NinjaCadDB!1');
define('DB_DATABASE', 'ninjacad');
define('DB_PREFIX', 'oc_');
?>