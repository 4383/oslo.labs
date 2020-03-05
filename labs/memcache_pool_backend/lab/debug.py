import pprint
from pymemcache.client.base import Client

pp = pprint.PrettyPrinter(indent=4)

client1 = Client(('memcached1', 11211))
client2 = Client(('memcached2', 11211))

pp.pprint(client1.get('group1_boom12'))
pp.pprint(client1.get('group1_boom'))
pp.pprint(client2.get('boom12'))
pp.pprint(client1.stats())
pp.pprint(client2.stats())
