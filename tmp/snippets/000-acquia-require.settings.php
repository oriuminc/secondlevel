/**
 * Include a local settings file if it exists.
 */
$local_settings = dirname(__FILE__) . '/settings.local.php';
if (file_exists($local_settings)) {
  include $local_settings;
}

/**
 * If on Acquia environment, include file with DB credentials.
 * (Replace SUBSCRIPTION_NAME with actual Acquia subscription name.)
 */

$subscription = 'SUBSCRIPTION_NAME';

if (file_exists('/var/www/site-php')) {
  require("/var/www/site-php/${subscription}/${subscription}-settings.inc");
}
