############################
### VARNISH.SETTINGS.PHP ###
############################

/**
 * Add Varnish Caching.
 */
$conf['cache_backends'][] = 'profiles/secondlevel/modules/contrib/varnish/varnish.cache.inc';

// Drupal 7 does not cache pages when we invoke hooks during bootstrap. This needs
// to be disabled.
$conf['page_cache_invoke_hooks'] = FALSE;

// Array of Drupal cache bins to cache with Varnish
$drupal_cache_bins_varnish = array(
  'cache_page',
);

foreach ($drupal_cache_bins_varnish as $cache_bin) {
  // Assign each Drupal cache bin to Varnish caching
  $conf['cache_class_' . $cache_bin] = 'VarnishCache';
}
