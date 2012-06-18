#############################
### MEMCACHE.SETTINGS.PHP ###
#############################

/**
 * Some confusion around instructions. Using D6 instructions as purported D7
 * throw silent drush fails when memcache module isn't enabled
 * (which shouldn't be required).
 *
 * @See http://drupalcode.org/project/memcache.git/blob/7.x-1.0:/INSTALLATION.txt#l90
 * @See INSTALLATION.txt outdated and redundant: http://drupal.org/node/1452966
 */
$conf['cache_backends'][] = 'profiles/2ndlevel/modules/contrib/memcache/memcache.inc';

// Set default cache type for Drupal cache bins to be native database caching.
$conf['cache_default_class'] = 'DrupalDatabaseCache';

// Assign Memcache instance to a cluster named 'default'
$conf['memcache_servers'] = array(
  '127.0.0.1:11211' => 'default',
);

// Array of Drupal cache bins to cache with Memcache
$drupal_cache_bins_memcache = array(
  'cache_field',
  'cache_menu',
);

foreach ($drupal_cache_bins_memcache as $cache_bin) {
  // Assign each Drupal cache bin to Memcache caching (Memcache bin has same name)
  $conf['cache_class_' . $cache_bin] = 'MemCacheDrupal';

  // Assign Memcache bin to cluster 'default'
  $conf['memcache_bins'][$cache_bin] = 'default';
}
