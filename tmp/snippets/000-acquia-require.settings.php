/**
 * If on Acquia environment, include file with DB credentials.
 */

$subscription = $_ENV['AH_SITE_GROUP'];

if (file_exists('/var/www/site-php')) {
  require("/var/www/site-php/${subscription}/${subscription}-settings.inc");
}
