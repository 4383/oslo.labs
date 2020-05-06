import os
import threading
from oslo_cache import core as cache
from oslo_config import cfg
import time

PAYLOAD_BASE_PATH = os.path.dirname(os.path.abspath(__file__))
_CONFIG_FILES = [
    # Use the existing memcache_pool as the default backend
    # Users could tests the new feature by consuming the related
    # config to load the new pymemcache_pool backend.
    # python payload/run.py --config-file payload/pymemcache_pool.conf
    os.path.join(PAYLOAD_BASE_PATH, "memcache_pool-backend.conf"),
]

test = 1

CONF = cfg.CONF

cfg.CONF(default_config_files=_CONFIG_FILES)
caching = cfg.BoolOpt('caching', default=True)
cache_time = cfg.IntOpt('cache_time', default=3600)
cfg.CONF.register_opts([caching, cache_time], "group1")
cache.configure(CONF)

def my_key_generator(namespace, fn, **kw):
    fname = fn.__name__
    def generate_key(*arg):
        key = fname + "_".join(str(s) for s in arg)
        #print(key)
        return key
    return generate_key

example_cache_region = cache.create_region(function=my_key_generator)
MEMOIZE = cache.get_memoization_decorator(
    CONF, example_cache_region, "group1")

backend = cfg.CONF.cache.backend
print("------------------------------------------------------")
print("Used backend: {}".format(backend))
print("------------------------------------------------------")

# Load config file here
cache.configure_cache_region(CONF, example_cache_region)

print("Cache configuration done")

#region = cache.make_region()
#region.set("herve", "boom")
#print(region.get("herve"))

@MEMOIZE
def foo(x):
    print(x)
    return x

@MEMOIZE
def bar(x):
    print(x)
    return x



for el in range(300):
    print("~~~~~~~~~~~~~~~~~~")
    print(f"round {el}")
    print("~~~~~~~~~~~~~~~~~~")
    foo.set(int(el))
    bar.set('bar{}'.format(el))
    print("Stored value for foo: {}".format(foo.get()))
    print("Stored value for bar: {}".format(bar.get()))
    time.sleep(2)
