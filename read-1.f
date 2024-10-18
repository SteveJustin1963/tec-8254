:A
  0x34 0x43 /O ;       // Set control word for Counter 0 in Mode 1 (one-shot mode), binary format

:B
  % 0x40 /O            // Write the lower byte of the count value to Counter 0
  % 8 / 0x40 /O ;      // Write the upper byte of the count value to Counter 0

:C
  A                    // Call function A to initialize Counter 0
  65535 B ;            // Set the counter value (65535) using function B

:D
  0x40 /I              // Read the lower byte of Counter 0
  0x40 /I 8 * + ;      // Read the upper byte, shift it left by 8 bits, and combine with the lower byte

:E
  0x36 0x43 /O ;       // Set control word for Counter 0 in Mode 2 (Rate Generator), binary format

:F
  % 0x40 /O            // Write the lower byte of the frequency count to Counter 0
  % 8 / 0x40 /O ;      // Write the upper byte of the frequency count to Counter 0

:G
  E                    // Call function E to initialize Counter 0 for rate generation
  65535 F ;            // Set the frequency count (65535) using function F

:H
  0x40 /I ;            // Read the status of Counter 0

:I
  0x38 0x43 /O ;       // Set control word for Counter 2 in Mode 5 (Hardware Triggered Strobe), binary format

:J
  0xFF 0x42 /O         // Write the maximum count value (lower byte) to Counter 2
  0xFF 0x42 /O ;       // Write the maximum count value (upper byte) to Counter 2

:K
  I                    // Call function I to initialize Counter 2 for duration measurement
  J ;                  // Set the maximum count value using function J

:L
  0x42 /I              // Read the lower byte of Counter 2
  0x42 /I 8 * + ;      // Read the upper byte, shift it left by 8 bits, and combine with the lower byte
