```forth
: outb ( byte port -- )  \ Output byte to port
  swap out ;

: inb ( port -- byte )  \ Input byte from port
  in ;

: setup-8254
  \ Set up Channel 2 in Mode 5 (Hardware Triggered Strobe), 16-bit binary
  \ Control Word format for this: 10110110b = 0xB6
  0xB6 0x43 outb ;

: start-measurement
  \ Load Channel 2 with max value 0xFFFF
  0xFFFF 0x42 outb 0x42 outb ;

: read-count ( -- count )
  \ Read current count from Channel 2
  0x42 inb 0x42 inb ;

: measure-io-pin ( -- duration )
  setup-8254
  start-measurement
  \ Now wait for the I/O pin to change state (this will be platform-specific)
  read-count ;
```
