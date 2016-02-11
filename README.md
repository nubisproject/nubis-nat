# nubis-nat
This repository consist of 2 parts, a NAT instance as well as a squid proxy. This repository doesn't have any cloudformation information all we do here is build AMI's.

# Proxy related information
This project is currently based around [Squid3](http://www.squid-cache.org/). As configured we are only taking advantage of the forward proxy abilities and none of the caching abilities. The default configuration is a logging only forward proxy, in other words there are no blocklists or allow lists deployed. There is a list of "safe ports" which are allowed, all others are blocked.

## Integrating
In order to make use of the proxies, your application must be proxy aware. Many applications make use of environment variables to route outbound through a proxy. here is a simple example script for setting the environment variables:
```bash
export http_proxy="http://proxy.service.consul:3128/"
export https_proxy="http://proxy.service.consul:3128/"
export no_proxy="localhost,127.0.0.1,.localdomain,10.0.0.0/8,169.254.169.254"
export HTTP_PROXY="$http_proxy"
export HTTPS_PROXY="$https_proxy"
export NO_PROXY="$no_proxy"
```

This file is installed by default in [nubis-base](https://github.com/Nubisproject/nubis-base) as */etc/profile.d/proxy.sh*.

## Custom configuration
To add custom rules to the proxy you need to place some information in consul. The following examples demonstrate how to accomplish this. Note that setting any of these values in consul overwrites the default. Therefore if you wish to include the default you must do so explicatly.

To start with, set up the environment from user data. We actually only need ```$NUBIS_STACK``` and ```$NUBIS_ENVIRONMENT``` which you could set manually.
```bash
eval $(curl -fs http://169.254.169.254/latest/user-data)
```

The defalut allowed domains is *all*. To set a custom list set *AllowDomains* with a value of a JSON array of domains to allow connections to:
```bash
curl -X PUT -d '[ ".mozilla.org", ".mozilla.com", ".mozilla.net", ".redhat.com", ".ubuntu.com", ".debian.org", ".github.com", ".java.com", "cdp1.public-trust.com", "ocsp.omniroot.com", "ocsp.msocsp.com", "www.msftncsi.com", "msftncsi.com", "ipv6.msftncsi.com", "ocsp.geotrust.com", "crl.geotrust.com", "gtssl-ocsp.geotrust.com", "gtssl-crl.geotrust.com", "ocsp.digicert.com", "collector.newrelic.com", "platform-api.newrelic.com" ]' http://localhost:8500/v1/kv/$NUBIS_STACK/$NUBIS_ENVIRONMENT/config/AllowDomains
```

By default there are no regex domains. Set *AllowRegexDomains* to a JSON array for regex style whitelisting:
```bash
curl -X PUT -d '[ "^collector-[0-9]+.newrelic.com$" ]' http://localhost:8500/v1/kv/$NUBIS_STACK/$NUBIS_ENVIRONMENT/config/AllowRegexDomains
```

The default for allowed subnets is *all*. For a custom list set *AllowSubnets* to a JSON array of subnets:
```bash
curl -X PUT -d '[ "2620:101:8000::/40 # Mozilla public IPv6", "63.245.208.0/20 # Mozilla public IPv4" ]' http://localhost:8500/v1/kv/$NUBIS_STACK/$NUBIS_ENVIRONMENT/config/AllowSubnets
```

The default denied domains is 'localhost' and '.localdomain'. You can set *DenyDomains* to a JSON array to modify this list:

```bash
curl -X PUT -d '[ "localhost", ".localdomain", "some.domain.dom" ]' http://localhost:8500/v1/kv/$NUBIS_STACK/$NUBIS_ENVIRONMENT/config/DenyDomains
```

The default deny subnet list is:
 * 127.0.0.0/8
 * ::1/128
 * 10.0.0.0/8
 * 192.168.0.0/16
 * 172.16.0.0/12
To modify this list set *DenySubnets* to a JSON array:
```bash
curl -X PUT -d '[ "127.0.0.0/8", "::1/128", "10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12" ]' http://localhost:8500/v1/kv/$NUBIS_STACK/$NUBIS_ENVIRONMENT/config/DenySubnets
```

To see what is currently set for any particular key you can query consul like so:
```bash
curl -X GET http://localhost:8500/v1/kv/$NUBIS_STACK/$NUBIS_ENVIRONMENT/config/AllowRegexDomains?raw=1
```

To remove all custom configuration and reset to the defaults:
```bash
curl -X DELETE http://localhost:8500/v1/kv/$NUBIS_STACK?recurse
```

## Testing
After building a new proxy image you should start it using the template in the *nubis/cloudformation* folder, ssh in and test some basic functionality.

To ensure there are no errors when generating the configuration files from consul you should set some consul keys as demonstrated above and then manually execute a confd run:
```bash
confd -onetime -backend consul -node 127.0.0.1:8500
```

To check that the squid configuration is syntactically correct:
```bash
squid3 -k check
```
To test the the proxy is working at the most basic level check http and https outbound connectivity through the proxy. This tests the CONNECT method only:
```bash
curl -s -o /dev/null -x localhost:3128 http://www.google.com; echo $?
curl -s -o /dev/null -x localhost:3128 https://www.google.com; echo $?
```

It is possible to test the CONNECT method with telnet directly, however as it is quite difficult to speak encrypted protocols over telnet you can only see that the connection is made to the remote service. This is of limited benefit and the above curl method is a more complete test:
```bash
telnet localhost 3128
CONNECT www.google.com
```
```bash
telnet localhost 3128
CONNECT github.com:9418
```

To test the GET method (asking the proxy to establish the ssl connection, whilst spying on you):
```bash
telnet localhost 3128
GET http://www.google.com/404 HTTP/1.0
HOST: proxytest
```
```bash
telnet localhost 3128
GET https://www.google.com/404 HTTP/1.0
HOST: proxytest
```

To ensure consul service regesteration is working correctly run this command and check that the IP of the proxy you are testing is in the returned list:
```bash
host proxy.service.consul
```

To test the proxy and service discovery you can run this command. Keep in mind however that this does not guarantee you will be testing this proxy, only that you will be testing the first proxy returned with the consul dns service lookup. You are better off testing by replacing the *proxy.service.consul* portion of this command with the actual IP address of the proxy you wish to test:
```bash
curl -s -o /dev/null -x proxy.service.consul:3128 http://www.google.com; echo $?
```

And of course you can always check the log files:
```bash
tail /var/log/squid3/*.log
```
