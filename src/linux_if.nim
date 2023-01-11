import posix

const IF_NAMESIZE* = 16

type
  ifmap* = object
    mem_start*: culong
    mem_end*: culong
    base_addr*: cushort
    irq*: uint8
    dma*: uint8
    port*: uint8

  ifr_ifru_union* {.union.} = object
    ifr_addr*: SockAddr
    ifr_dstaddr*: SockAddr
    ifr_broadaddr*: SockAddr
    ifr_netmask*: SockAddr
    ifr_hwaddr*: SockAddr
    ifr_flags*: cushort
    ifr_ifindex*: cint
    ifr_metric*: cint
    ifr_mtu*: cint
    ifr_map*: ifmap
    ifr_slave*: array[IF_NAMESIZE, char]
    ifr_newname*: array[IF_NAMESIZE, char]
    ifr_data*: cstring

  ifreq* = object
    ifr_name*: array[IF_NAMESIZE, char]
    ifr_ifru*: ifr_ifru_union
