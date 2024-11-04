
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

## Duration dur-1.mint
- This setup is ideal for measuring the duration of events triggered by hardware signals, such as monitoring the state of an I/O pin.
- The code sets up Counter 2 in hardware-triggered strobe mode.
- It loads the maximum count value, preparing the counter to start counting when a hardware trigger is received.
- It reads the current state of the counter, providing a full 16-bit value by combining the upper and lower bytes.

 
## Interval int-1.mint
- This sequence of functions sets up Counter 0 for precise timing operations and allows for monitoring its countdown in real-time.
- **`:A`** configures Counter 0 in one-shot mode with binary counting.
- **`:B`** sets a 16-bit count value for Counter 0 by writing the lower and upper bytes separately.
- **`:C`** initializes Counter 0 and sets the count value, preparing it for countdown.
- **`:D`** reads and combines the lower and upper bytes of the current count value to provide the full 16-bit value.

 

## Read Write mint rw-1.mint
- **`:A` - `:D`** are functions that set up and read Counter 0, configuring it in one-shot and rate generator modes and reading its count value.
- **`:E` - `:H`** configure Counter 0 specifically for periodic interrupts and read its status.
- **`:I` - `:L`** focus on Counter 2, setting it up for hardware-triggered strobe mode and measuring duration based on an external event.


 


### Ref 
- [OSDev Wiki - Programmable Interval Timer](https://wiki.osdev.org/Programmable_Interval_Timer)
- [GeeksforGeeks - 8254 Control Word & Operating Modes](https://www.geeksforgeeks.org/8254-control-word-operating-modes/)
- [GeeksforGeeks - Microprocessor 8254 Programmable Interval Timer](https://www.geeksforgeeks.org/microprocessor-8254-programmable-interval-timer/)

