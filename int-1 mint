:A
  " 52 67 /O ;        // Set control word for Counter 0 in Mode 1 (one-shot), binary mode

:B
  " 64 /O             // Write the lower byte to Counter 0
  " 8 / 64 /O ;       // Write the upper byte to Counter 0

:C
  A                   // Call function A to initialize Counter 0
  65535 B ;           // Set the counter value to start the measurement using function B

:D
  64 /I               // Read the lower byte of Counter 0
  64 /I 8 * + ;       // Read the upper byte, shift left by 8 bits, and combine with the lower byte
