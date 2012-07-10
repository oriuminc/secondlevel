#########################
### GELF.SETTINGS.PHP ###
#########################

/**
 * Hardcode GELF module settings for Graylog2 logging.
 */
switch ($_ENV['AH_SITE_ENVIRONMENT']) {
  default:
    # Non-Acquia environment (local development)
    $conf['gelf_host'] = '33.33.33.1';
    $conf['gelf_port'] = '12201';
    break;

  case 'dev':
  case 'test':
    # Acquia Development & Staging environments
    break;

  case 'prod':
    # Acquia Production environment
    break;
}
