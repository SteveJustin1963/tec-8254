```forth
: outb ( byte port -- )  \ Output byte to port
  swap out ;

: inb ( port -- byte )  \ Input byte from port
  in ;

: set-8254 ( count -- )
  \ Set mode for Channel 0, Mode 2 (Rate Generator), 16-bit binary
  \ Control Word format: 00110110b = 0x36
  0x36 0x43 outb
  
  \ Set count value for Channel 0
  \ Low byte
  dup 0xFF and 0x40 outb
  \ High byte
  8 rshift 0x40 outb ;

: init-8254
  \ Set 8254 with a count value of 65535
  \ This is just an example; typically you would set it to a value that
  \ corresponds to the desired interrupt frequency
  65535 set-8254 ;
```
