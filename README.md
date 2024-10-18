
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

## 


### References for Further Reading
- [OSDev Wiki - Programmable Interval Timer](https://wiki.osdev.org/Programmable_Interval_Timer)
- [GeeksforGeeks - 8254 Control Word & Operating Modes](https://www.geeksforgeeks.org/8254-control-word-operating-modes/)
- [GeeksforGeeks - Microprocessor 8254 Programmable Interval Timer](https://www.geeksforgeeks.org/microprocessor-8254-programmable-interval-timer/)

