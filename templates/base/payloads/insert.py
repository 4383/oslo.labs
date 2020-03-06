from pymemcache.client.hash import HashClient

client = HashClient([
    ('memcached1', 11211),
    ('memcached2', 11212)
])

client.set('boom', 'foo')
