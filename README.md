
### Overview of the 8254 PIT
The 8254 PIT has three independent 16-bit counters, each capable of handling clock inputs up to 10 MHz. It operates with a +5V power supply and can be configured via software to operate in different modes. Each counter has:
- A **Clock input**: Receives the clock signal for the counter.
- A **Gate input**: Controls whether the counter is enabled.
- An **Output**: Outputs a signal based on the counter's configuration.

### Modes of Operation
The 8254 PIT can be programmed to operate in various modes:
1. **Mode 0 (Interrupt on Terminal Count)**: Generates an interrupt when the counter reaches zero.
2. **Mode 1 (Hardware Retriggerable One-Shot)**: Generates a pulse when triggered.
3. **Mode 2 (Rate Generator)**: Produces a periodic square wave.
4. **Mode 3 (Square Wave Generator)**: Similar to Mode 2, but with adjustable duty cycle.
5. **Mode 4 (Software Triggered Strobe)**: Produces a single pulse when triggered by software.
6. **Mode 5 (Hardware Triggered Strobe)**: Similar to Mode 4 but triggered by hardware.

### Applications
- Generating accurate time delays
- Event counting
- Generating square waves
- Producing periodic interrupts
- Measuring the duration of an I/O pin’s state

## Duration dur-1 mint
- This setup is ideal for measuring the duration of events triggered by hardware signals, such as monitoring the state of an I/O pin.
- The code sets up Counter 2 in hardware-triggered strobe mode.
- It loads the maximum count value, preparing the counter to start counting when a hardware trigger is received.
- It reads the current state of the counter, providing a full 16-bit value by combining the upper and lower bytes.

#### Function `:M`
- configures Counter 2 of the 8254 PIT to operate in Mode 5,
- which is the hardware-triggered strobe mode.
- In this mode, the counter begins counting down when a hardware signal (the gate input) is received,
- and when it reaches zero, it generates a pulse on the output.
- The control word specific to Mode 5 is sent to the PIT’s control register to configure this behavior for Counter 2.

#### Function `:N`
- sets the initial maximum count value for Counter 2.
- The count value is split into two bytes:
1. The lower byte is written to Counter 2’s data register first.
2. The upper byte is then written to the same register after shifting it appropriately.
- ensures that the full 16-bit count value is loaded correctly into Counter 2,
- which determines the duration before the counter reaches zero and triggers the strobe.

#### Function `:O`
- initializes Counter 2 for the duration measurement process.
- It does so by calling `:M` to set up Counter 2 with the hardware-triggered strobe configuration.
- Afterward, it calls `:N` to set the counter’s maximum count value.
- This setup prepares Counter 2 to begin counting down when it receives a signal.

#### Function `:P`
- reads the current count value from Counter 2.
- It first retrieves the lower byte from the counter’s data register.
- It then reads the upper byte, shifts it left by 8 bits to position it correctly,
- and combines it with the lower byte.
- This operation reconstructs the full 16-bit count value,
- allowing you to know how much time remains until the counter reaches zero.

## Interval int-1 mint
- This sequence of functions sets up Counter 0 for precise timing operations and allows for monitoring its countdown in real-time.
- **`:A`** configures Counter 0 in one-shot mode with binary counting.
- **`:B`** sets a 16-bit count value for Counter 0 by writing the lower and upper bytes separately.
- **`:C`** initializes Counter 0 and sets the count value, preparing it for countdown.
- **`:D`** reads and combines the lower and upper bytes of the current count value to provide the full 16-bit value.

#### Function `:A`
- sets the control word for Counter 0 in Mode 1 (one-shot mode) with binary counting. 
- The control word is sent to the control register of the 8254 PIT using the command `" 52 67 /O`. 
- Mode 1 (one-shot mode) means that once the counter is started, it counts down to zero, and when it reaches zero, it triggers an output pulse.

#### Function `:B`
- sets the count value for Counter 0.
- The count value is divided into two parts:
1. The lower byte of the count value is written first to Counter 0’s data register (`" 64 /O`).
2. The upper byte of the count value is then written after shifting it appropriately (`" 8 / 64 /O`).
- This ensures the 16-bit value is properly loaded into Counter 0,
- allowing it to count down accurately from the set value.

#### Function `:C`
- initializes and starts Counter 0 for its measurement task:
- It calls `:A` to configure Counter 0 with the appropriate mode and settings.
- It sets a specific count value (65535) by calling `:B`,
- loading the count value into the counter.
- This count value determines how long Counter 0 will count before it reaches zero and generates an output.

#### Function `:D`
- reads the current count value from Counter 0:
- It reads the lower byte of the count value from Counter 0’s data register.
- It then reads the upper byte, shifts it left by 8 bits to align it correctly,
- and combines it with the lower byte to form the full 16-bit count value.
- This combined value represents the remaining count until the counter reaches zero.

## Read Write mint rw mint
- **`:A` - `:D`** are functions that set up and read Counter 0, configuring it in one-shot and rate generator modes and reading its count value.
- **`:E` - `:H`** configure Counter 0 specifically for periodic interrupts and read its status.
- **`:I` - `:L`** focus on Counter 2, setting it up for hardware-triggered strobe mode and measuring duration based on an external event.


#### Function `:A`
- sets up Counter 0 to operate in Mode 1 (one-shot mode) using binary counting.
- The control word `0x34` is sent to the control register `0x43` to configure Counter 0. 
- Mode 1 means that the counter will count down to zero once, and upon reaching zero, it generates a pulse.

#### Function `:B`
- writes a 16-bit count value into Counter 0.
- The function first writes the lower byte of the count value to Counter 0’s data port `0x40`.
- Then it writes the upper byte of the count value (shifted by 8 bits) to the same port.
- This ensures the full count value is properly loaded into Counter 0.

#### Function `:C`
- initializes Counter 0 and sets a specific count value.
- It calls `:A` to configure Counter 0 in one-shot mode.
- It then sets the count value to `65535` by calling `:B`, initializing Counter 0 to start counting down from this value when triggered.

#### Function `:D`
- reads the current value of Counter 0.
- It reads the lower byte of the counter value from the data port `0x40`.
- Then it reads the upper byte, shifts it left by 8 bits, and combines it with the lower byte to reconstruct the full 16-bit count value.

#### Function `:E`
- sets up Counter 0 to operate in Mode 2 (rate generator mode) using binary counting.
- The control word `0x36` is sent to the control register `0x43` to configure Counter 0 for generating a periodic square wave.

#### Function `:F`
- sets a frequency count value for Counter 0 in rate generator mode.
- It writes the lower byte of the frequency count value to the data port `0x40`.
- Then it writes the upper byte of the frequency count value (shifted by 8 bits) to the same port.

#### Function `:G`
- initializes Counter 0 for rate generation.
- It calls `:E` to set up Counter 0 in rate generator mode.
- It then sets the frequency count value to `65535` by calling `:F`, configuring Counter 0 to generate periodic interrupts at this frequency.

#### Function `:H`
- reads the status of Counter 0.
- It reads the current state of Counter 0 from the data port `0x40`. This allows monitoring of the counter’s state, useful for checking if it is functioning as expected.

#### Function `:I`
- sets up Counter 2 to operate in Mode 5 (hardware-triggered strobe) using binary counting.
- The control word `0x38` is sent to the control register `0x43` to configure Counter 2.
- Mode 5 uses a hardware trigger to start the countdown, and when it reaches zero, it generates a pulse.

#### Function `:J`
- sets a maximum count value for Counter 2.
- It writes the lower byte of the maximum count value (`0xFF`) to Counter 2’s data port `0x42`.
- Then it writes the upper byte of the maximum count value (`0xFF`) to the same port, ensuring that the full count value is loaded.

#### Function `:K`
- initializes Counter 2 for duration measurement.
- It calls `:I` to set up Counter 2 in hardware-triggered strobe mode.
- It then sets the maximum count value using function `:J`, preparing Counter 2 for measurement.

#### Function `:L`
- reads the current value of Counter 2.
- It reads the lower byte of Counter 2’s value from the data port `0x42`.
- Then it reads the upper byte, shifts it left by 8 bits, and combines it with the lower byte to form the full 16-bit count value, allowing the duration measurement to be observed.



### References for Further Reading
- [OSDev Wiki - Programmable Interval Timer](https://wiki.osdev.org/Programmable_Interval_Timer)
- [GeeksforGeeks - 8254 Control Word & Operating Modes](https://www.geeksforgeeks.org/8254-control-word-operating-modes/)
- [GeeksforGeeks - Microprocessor 8254 Programmable Interval Timer](https://www.geeksforgeeks.org/microprocessor-8254-programmable-interval-timer/)

