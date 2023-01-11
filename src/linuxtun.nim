import linuxtun/ioctl_req
import linuxtun/linux_if
export linux_if


type
  sock_filter* = object
    ## From `linux/filter.h`
    code*: uint16  ## Actual filter code
    jt*: uint8  ## Jump true
    jf*: uint8  ## Jump false
    k*: uint32  ## Generic multiuse field

  sock_fprog* = object
    ## From `linux/filter.h`
    len*: cushort  ## Number of filter blocks
    filter*: ptr sock_filter  ## Pointer to array of filter blocks

  tun_pi* = object
    ## Protocol info prepended to the packets (when IFF_NO_PI is not set).
    ## From `linux/if_tun.h`
    flags*: uint16  ## TUN_PKT_STRIP or zero
    proto*: int16  ## Linux Ethertype from `linux/if_ether.h`


const
  TUN_READQ_SIZE* = 500

  TUNSETNOCSUM*: culong = iocW('T', 200, cint)
  TUNSETDEBUG*: culong = iocW('T', 201, cint)
  TUNSETIFF*: culong = iocW('T', 202, cint)
  TUNSETPERSIST*: culong = iocW('T', 203, cint)
  TUNSETOWNER*: culong = iocW('T', 204, cint)
  TUNSETLINK*: culong = iocW('T', 205, cint)
  TUNSETGROUP*: culong = iocW('T', 206, cint)
  TUNGETFEATURES*: culong = iocR('T', 207, cuint)
  TUNSETOFFLOAD*: culong = iocW('T', 208, cuint)
  TUNSETTXFILTER*: culong = iocW('T', 209, cuint)
  TUNGETIFF*: culong = iocR('T', 210, cuint)
  TUNGETSNDBUF*: culong = iocR('T', 211, cint)
  TUNSETSNDBUF*: culong = iocW('T', 212, cint)
  TUNATTACHFILTER*: culong = iocW('T', 213, sock_fprog)
  TUNDETACHFILTER*: culong = iocW('T', 214, sock_fprog)
  TUNGETVNETHDRSZ*: culong = iocR('T', 215, cint)
  TUNSETVNETHDRSZ*: culong = iocW('T', 216, cint)
  TUNSETQUEUE*: culong = iocW('T', 217, cint)
  TUNSETIFINDEX*: culong = iocW('T', 218, cuint)
  TUNGETFILTER*: culong = iocR('T', 219, sock_fprog)
  TUNSETVNETLE*: culong = iocW('T', 220, cint)
  TUNGETVNETLE*: culong = iocR('T', 221, cint)
  TUNSETVNETBE*: culong = iocW('T', 222, cint)
  TUNGETVNETBE*: culong = iocR('T', 223, cint)
  TUNSETSTEERINGEBPF*: culong = iocR('T', 224, cint)
  TUNSETFILTEREBPF*: culong = iocR('T', 225, cint)
  TUNSETCARRIER*: culong = iocW('T', 226, cint)
  TUNGETDEVNETNS*: culong = ioc('T', 227)

  # TUNSETIFF ifr flags
  IFF_TUN*: cushort = 0x0001
  IFF_TAP*: cushort = 0x0002
  IFF_NAPI*: cushort = 0x0010
  IFF_NAPI_FRAGS*: cushort = 0x0020
  IFF_NO_CARRIER*: cushort = 0x0040  ## Used in TUNSETIFF to bring up tun/tap without carrier
  IFF_NO_PI*: cushort = 0x1000
  IFF_ONE_QUEUE*: cushort = 0x2000  ## This flag has no real effect
  IFF_VNET_HDR*: cushort = 0x4000
  IFF_TUN_EXCL*: cushort = 0x8000
  IFF_MULTI_QUEUE*: cushort = 0x0100
  IFF_ATTACH_QUEUE*: cushort = 0x0200
  IFF_DETACH_QUEUE*: cushort = 0x0400
  IFF_PERSIST*: cushort = 0x0800  ## read-only flag
  IFF_NOFILTER*: cushort = 0x1000

  # Socket options
  TUN_TX_TIMESTAMP* = 1

  # Features for GSO (TUNSETOFFLOAD).
  TUN_F_CSUM* = 0x01  ## You can hand me unchecksummed packets.
  TUN_F_TSO4* = 0x02  ## I can handle TSO for IPv4 packets.
  TUN_F_TSO6* = 0x04  ## I can handle TSO for IPv6 packets.
  TUN_F_TSO_ECN* = 0x08  ## I can handle TSO with ECN bits.
  TUN_F_UFO* = 0x10  ## I can handle UFO packets.

  TUN_PKT_STRIP*: uint16 = 0x0001  # Packet was truncated because of small buffer

  TUN_FLT_ALLMULTI*: cshort = 0x0001  ## Accept all multicast packets
