import pprint
from pymemcache.client.base import Client

pp = pprint.PrettyPrinter(indent=4)

client1 = Client(('memcached1', 11211))
client2 = Client(('memcached2', 11211))

pp.pprint(client1.get('c53d2f1a9a8499bcb477be56c31caa5c76ae60f5'))
pp.pprint(client2.get('c53d2f1a9a8499bcb477be56c31caa5c76ae60f5'))
#pp.pprint(client1.stats())
#pp.pprint(client2.stats())
