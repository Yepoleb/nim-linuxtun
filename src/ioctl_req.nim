const
  iocNrBits*: culong = 8
  iocTypeBits*: culong = 8
  iocSizeBits*: culong = 14
  iocDirBits*: culong = 2

  iocNrMask*: culong = ((1 shl iocNrBits) - 1)
  iocTypeMask*: culong = ((1 shl iocTypeBits) - 1)
  iocSizeMask*: culong = ((1 shl iocSizeBits) - 1)
  iocDirMask*: culong = ((1 shl iocDirBits) - 1)

  iocNrShift*: culong = 0
  iocTypeShift*: culong = iocNrShift + iocNrBits
  iocSizeShift*: culong = iocTypeShift + iocTypeBits
  iocDirShift*: culong = iocSizeShift + iocSizeBits

  iocNone*: culong = 0
  iocWrite*: culong = 1
  iocRead*: culong = 2

  iocIn*: culong = iocWrite shl iocDirShift
  iocOut*: culong = iocRead

proc iocEncode*(direction: culong, kind: culong, nr: culong, size: culong): culong =
  (direction shl iocDirshift) or
  (kind shl iocTypeshift) or
  (nr shl iocNrshift) or
  (size shl iocSizeshift)

template iocCommand*(direction: culong, kind: char, nr: culong, sizeType: type): culong =
  ## Encodes a generic ioctl command
  iocEncode(direction, kind.culong, nr, sizeof(sizeType).culong)

template ioc*(kind: char, nr: culong): culong =
  ## Encodes an ioctl command with the direction `iocNone`
  iocEncode(iocNone, kind.culong, nr, 0)

template iocR*(kind: char, nr: culong, sizeType: type): culong =
  ## Encodes an ioctl command with the direction `iocRead`
  iocCommand(iocRead, kind, nr, sizeType)

template iocW*(kind: char, nr: culong, sizeType: type): culong =
  ## Encodes an ioctl command with the direction `iocWrite`
  iocCommand(iocWrite, kind, nr, sizeType)

template iocWR*(kind: char, nr: culong, sizeType: type): culong =
  ## Encodes an ioctl command with the direction `iocRead or iocWrite`
  iocCommand(iocRead or iocWrite, kind, nr, sizeType)

proc iocDir*(request: culong): culong =
  (request shr iocDirShift) and iocDirMask

proc iocType*(request: culong): culong =
  (request shr iocTypeShift) and iocTypeMask

proc iocNr*(request: culong): culong =
  (request shr iocNrShift) and iocNrMask

proc iocSize*(request: culong): culong =
  (request shr iocSizeShift) and iocSizeMask
