# Hardware
  - Connect Zodiac FX port 4 to non openflow network
  - Connect Zodiac FX port 1-3 to openflow network

# Version
  - openflow v1.3
  - raspberrypi ?


# Bootstrap

- Zodiac FX
  - openflow port: `6633`
  - view settings `show config`
  - save configuration `save`
  - set IP `set ip-address xxx.xxx.xxx.xxx`
  - set gateway `set gateway xxx.xxx.xxx.xxx`
  - set controller `set of-controller xxx.xxx.xxx.xxx`
    - default: `10.0.1.8`
  - after save, need to reboot
- Controller

# Reference
- Zodiac FX
  - [Zodiac FX - Getting Started](https://www.youtube.com/watch?v=B9HBbG2VaWc&t=2s)
  - [Zodiac FX - Connecting to an SDN Controller](https://www.youtube.com/watch?v=x-6jFiUdJdQ)
  - [Latest versions of source code, firmware, user guides and drivers.](http://forums.northboundnetworks.com/index.php?topic=52.0)
  - [RAUCET - Raspberry Pi + FAUCET, controlling Zodiac FX](https://faucet-sdn.blogspot.com.au/2016/06/raucet-raspberry-pi-faucet-controlling.html)

## Hardware
- Switch
  - [ZODIAC FX](https://northboundnetworks.com/products/zodiac-fx) $109
  - [NETGEAR 16-Port (FS116NA)](https://www.amazon.com/NETGEAR-ProSAFE-FS105NA-5-Port-Ethernet/dp/B000063UZW/ref=sr_1_7?s=electronics&ie=UTF8&qid=1501271893&sr=1-7&keywords=ethernet%2Bswitch&th=1) $50
- Host
  - [RASPBERRY PI 3 MODEL B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b) $35
- USB to Ethernet adapter
  - [AmazonBasics USB 3.0 to 10/100/1000 Gigabit Ethernet Adapter](https://www.amazon.com/dp/B00M77HMU0/ref=asc_df_B00M77HMU05096840/?tag=hyprod-20&creative=394997&creativeASIN=B00M77HMU0&linkCode=df0&hvadid=167140037427&hvpos=1o1&hvnetw=g&hvrand=9113586287609328199&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9028744&hvtargid=pla-195027879195) $12
