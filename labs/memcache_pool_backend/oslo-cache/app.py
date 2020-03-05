import os
from oslo_cache import core as cache
from oslo_config import cfg

_CONFIG_FILES = [
    os.path.join(os.path.dirname(os.path.abspath(__file__)), "app.conf"),
]

CONF = cfg.CONF

cfg.CONF(default_config_files=_CONFIG_FILES)
caching = cfg.BoolOpt('caching', default=True)
cache_time = cfg.IntOpt('cache_time', default=3600)
cfg.CONF.register_opts([caching, cache_time], "feature-name")
cache.configure(CONF)

example_cache_region = cache.create_region()
MEMOIZE = cache.get_memoization_decorator(
    CONF, example_cache_region, "feature-name")

backend = cfg.CONF.cache.backend
print("------------------------------------------------------")
print("Used backend: {}".format(backend))
print("------------------------------------------------------")

# Load config file here

cache.configure_cache_region(CONF, example_cache_region)


@MEMOIZE
def f(x):
    print(x)
    return x
