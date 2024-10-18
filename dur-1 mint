:M                     // Set control word for Counter 2 in Mode 5 (Hardware Triggered Strobe)
  0x38 0x43 /O ;       

:N                     // Set maximum count value for Counter 2
  0xFF 0x42 /O         // Write the lower byte of the maximum count value to Counter 2
  0xFF 0x42 /O ;       // Write the upper byte of the maximum count value to Counter 2

:O                     // Initialize Counter 2 for duration measurement
  M                    // Call function M to set up Counter 2
  N ;                  // Call function N to set the maximum count value

:P                     // Read the count value after the measurement is complete
  0x42 /I              // Read the lower byte of Counter 2
  0x42 /I 8 * + ;      // Read the upper byte, shift it left by 8 bits, and combine with the lower byte
