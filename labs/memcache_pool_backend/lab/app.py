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
cfg.CONF.register_opts([caching, cache_time], "group1")
cache.configure(CONF)

def my_key_generator(namespace, fn, **kw):
    fname = fn.__name__
    def generate_key(*arg):
        key = fname + "_".join(str(s) for s in arg)
        print(key)
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


@MEMOIZE
def boom(x):
    print(x)
    return x


boom.set(14)
print(boom.get())
print(dir(boom))
