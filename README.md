docker-rotating-proxy
=====================

Built upon the interesting work of https://github.com/mattes/rotating-proxy
This is a port for RPi (based on Raspbian Jessie)

```
               Docker Container
               -------------------------------------
                        <-> Polipo 1 <-> Tor Proxy 1
Client <---->  HAproxy  <-> Polipo 2 <-> Tor Proxy 2
                        <-> Polipo n <-> Tor Proxy n
```

__Why:__ Lots of IP addresses. One single endpoint for your client.
Load-balancing by HAproxy.

Usage
-----

```bash
# build docker container
docker build -t prafiles/rotating-proxy:latest .

# ... or pull docker container
docker pull prafiles/rotating-proxy:latest

# start docker container
docker run -d -p 5566:5566 -p 1936:1936 --env tors=25 prafiles/rotating-proxy

# test with ...
curl --proxy 127.0.0.1:5566 http://echoip.com
curl --proxy 127.0.0.1:5566 http://header.jsontest.com

# monitor
http://127.0.0.1:1936/haproxy?stats
```


Further Readings
----------------

 * [Tor Manual](https://www.torproject.org/docs/tor-manual.html.en)
 * [Tor Control](https://www.thesprawl.org/research/tor-control-protocol/)
 * [HAProxy Manual](http://cbonte.github.io/haproxy-dconv/configuration-1.5.html)
 * [Polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/)

--------------

Please note: Tor offers a SOCKS Proxy only. In order to allow communication
from HAproxy to Tor, Polipo is used to translate from HTTP proxy to SOCKS proxy.
HAproxy is able to talk to HTTP proxies only.

