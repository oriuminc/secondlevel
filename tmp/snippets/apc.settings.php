########################
### APC.SETTINGS.PHP ###
########################

/**
 * Add APC Caching.
 */
$conf['cache_backends'][] = 'profiles/secondlevel/modules/contrib/apc/drupal_apc_cache.inc';

// Remove slashes to use debug mode.
// $conf['apc_show_debug'] = TRUE;

// Array of Drupal cache bins to cache with APC
$drupal_cache_bins_apc = array(
  'cache',
  'cache_bootstrap',
);

foreach ($drupal_cache_bins_apc as $cache_bin) {
  // Assign each Drupal cache bin to Memcache caching (Memcache bin has same name)
  $conf['cache_class_' . $cache_bin] = 'DrupalAPCCache';
}
