# tec-8254
8254 Programmable Interval Timer PIT

The 8254 Programmable Interval Timer (PIT) is a widely used integrated circuit in the field of computer hardware and embedded systems. It was originally manufactured by Intel and has been a key component in many computer systems for decades. The 8254 PIT is primarily used for generating accurate time delays, generating periodic interrupts, and performing various timing and counting functions.

Here's a detailed overview of the 8254 PIT and its functionalities:

**1. Three Independent Counters:** The 8254 PIT features three independent 16-bit counters, known as Counter 0, Counter 1, and Counter 2. These counters can operate in a variety of modes to suit different timing requirements.

**2. Clock Inputs:** The 8254 PIT typically receives a clock signal (usually from the system clock) and divides it down to produce precise timing intervals.

**3. Operating Modes:** The PIT can operate in several modes, including:

   - **Mode 0 (Interrupt on Terminal Count):** This mode generates an interrupt when the counter reaches its terminal count.
   - **Mode 1 (Hardware Retriggerable One-Shot):** This mode generates a pulse on the output pin when triggered.
   - **Mode 2 (Rate Generator):** In this mode, the PIT generates square waveforms at a specified frequency.
   - **Mode 3 (Square Wave Generator):** Similar to Mode 2, but the duty cycle of the square wave can be changed.
   - **Mode 4 (Software Triggered Strobe):** This mode is used for generating a single pulse on the output pin when triggered by software.
   - **Mode 5 (Hardware Triggered Strobe):** Similar to Mode 4, but the trigger is hardware-based.

**4. Output Pins:** The 8254 has three output pins, one for each counter. These pins can be connected to external devices for various applications, such as generating sound or controlling external hardware.

**5. Control Register:** The control register is used to configure the operating mode and other parameters of each counter.

**6. Counting:** Each counter can be programmed to count up or count down. Counting can be binary or BCD (Binary Coded Decimal).

**7. Interrupts:** The PIT can be configured to generate interrupts when counters reach their terminal counts. This feature is commonly used in operating systems for timekeeping and multitasking.

**8. Timekeeping:** The 8254 PIT is often used to implement system timers and real-time clocks in older computer systems.

**9. Applications:** The 8254 PIT has been used in a wide range of applications, including generating precise time delays, controlling the refresh rate of CRT displays, generating audio tones, and more.

It's worth noting that while the 8254 PIT has been a staple in older computer systems, modern systems often use newer timer mechanisms, such as the High Precision Event Timer (HPET) or platform-specific timers. However, understanding the 8254 PIT remains valuable for anyone working with legacy hardware or embedded systems.

## generate an interrupt. 
It is commonly used in PCs for various timing-related tasks, such as generating the system clock or providing a time delay. One of its channels (commonly Channel 0) can be set up to generate an interrupt signal, which then triggers the CPU's interrupt handling mechanism.

To set up the 8254 PIT for generating interrupts, you'd typically go through these steps:

1. Choose a channel (usually Channel 0 for system clock)
2. Set the operating mode for that channel
3. Load the initial count value to set the frequency
4. Connect the output to the interrupt controller (like the 8259 PIC) if it is not directly connected.

Here's a Forth-83 code snippet to set up the 8254 PIT to generate an interrupt. This example assumes that you're setting up Channel 0, the count value is loaded with 65535 (0xFFFF), and the operating mode is 2 (Rate Generator).

Note: This is assuming that I/O operations can be done using `!` for output and `@` for input, and that these operations are byte-sized. A hypothetical `outb` and `inb` are used for byte-sized I/O to ports.

### int-1.f

After initializing the 8254 using `init-8254`, you'll also need to set up your interrupt service routine (ISR) and configure the interrupt controller (like the 8259 PIC) to accept the interrupt from the PIT. These parts are dependent on your CPU and system architecture, and thus are not covered in this example.

## measure the duration of an I/O pin's state 
(e.g., high or low) involves using one of its channels in "gate" mode. The gate input can start and stop the count based on an external signal. If you use the PIT's counter to count upward while the I/O pin is in a specific state, you can then read the counter value to determine the duration the pin remained in that state.

Here's a general approach:

1. **Configure the PIT**: Set up one of the PIT's channels (e.g., Channel 2) in a suitable mode that uses the gate input. Mode 5 (Hardware Triggered Strobe) can be suitable for this. The count will start when the gate input goes high.

2. **Connect the I/O pin to the PIT's gate**: Ensure the I/O pin you want to measure is connected to the gate input of the channel you're using on the PIT.

3. **Start the Measurement**: When you're ready to measure, initialize the PIT counter to its maximum value. Monitor the I/O pin, and when it goes high (or low, depending on your requirements), the PIT will start counting down.

4. **Read the Value**: Once the I/O pin changes state again, read the value from the PIT counter. This value will give you a measure of the time duration the I/O pin remained in the initial state.

Here's an illustrative Forth-83 code snippet for the 8254 setup:

### dur-1.f

Keep in mind:

- Ensure the I/O pin you want to measure is connected to the gate input of the PIT channel you're using.
- The example assumes Channel 2, but other channels can be used in a similar manner.
- The exact method of waiting for the I/O pin to change state is not provided, as it's system-specific.
- The PIT counts down, so the longer the duration, the smaller the value you read back. To find the elapsed counts, you can subtract the read-back value from the starting value.

This method provides a way to measure durations longer than one PIT tick but shorter than the max count value. If the I/O duration might exceed the max count value, you'll need to handle wrap-around or choose a different measurement method.


## Ref
- https://wiki.osdev.org/Programmable_Interval_Timer
- https://en.wikipedia.org/wiki/Programmable_interval_timer
- https://www.geeksforgeeks.org/8254-control-word-operating-modes/
- https://www.geeksforgeeks.org/microprocessor-8254-programmable-interval-timer/
- 
