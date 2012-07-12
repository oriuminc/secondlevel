/**
 * If on Acquia environment, include file with DB credentials.
 */
if (file_exists('/var/www/site-php')) {
  $subscription = $_ENV['AH_SITE_GROUP'];
  require("/var/www/site-php/${subscription}/${subscription}-settings.inc");
}
