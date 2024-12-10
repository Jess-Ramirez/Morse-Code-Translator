MORSE CODE TRANSLATOR
Jessica Ramirez, Lola Shadare, Jacob Perry
-------------------------------------------
Link to video: https://drive.google.com/file/d/1hxbJpg75ievgFomxVZAwcbuQU6udUSEt/view?usp=sharing

-----------------------------------------------------------------------------------------------------------------------------------

Overview: User presses buttons on FPGA and translates them from Morse code to text which is displayed on the monitor

----------------------------------------------------------------------------------------------------------------------------------

How to run: 

Press and hold the M17 button for one second to input a dot or for three seconds to input a dash (an LED will flash to indicate the clock cycle). To enter a Morse code sequence, repeatedly press M17 to create a series of dots "." and dashes "-" corresponding to your desired character. Your input will be displayed in real-time on the rightmost 10 LEDs, with two LEDs representing each input: the rightmost LED for a dot and both LEDs for a dash.

When your Morse code message is complete, press the P17 button for one second to send it to the VGA. An LED will light up to confirm the signal has been sent, and the corresponding character will be displayed on the monitor. To clear the screen, press P18. If the input message is not empty, first press P17 to clear it before pressing P18. To reset the VGA controller, press the M18 button.

----------------------------------------------------------------------------------------------------------------------------------

Overview of code structure:

The vga_TOP module is the top-level module that is pushed to the FPGA. Below is a brief description of the inputs and outputs and their functionality in the project.

Inputs:

  clk: The internal system clock. 

  conReset: A reset button for the VGA controller.
  
  reset: A reset button for the display monitor.
  
  send: A button that sends the input message to the VGA. When pressed, it displays the corresponding letter on the monitor; if no input message is provided, a space character is shown instead.
  
  button: A button input for the users Morse code message. For a dot input, press for one second and for a dash input, press for three seconds.
 
Outputs:
  
  letter: The current 10-bit representation of the input character displayed via the 10 rightmost LEDs. Each pair of LEDs represent one input (ex. a single dash input would be displayed by the two rightmost LEDs lighting up)
  
  hsync, vsync: Horizontal and vertical synchronization signals for the VGA display.
  
  vga_r: VGA signal representing the color intensity for the pixedl output. Determines whether a character is displayed.
  
  sendoff: Debounced version of the send signal. Displayed through an LED to indicate to the user that their input message has been registered.
  
  clkLed: A divided clock signal displayed through the leftmost LED. Provided to help the user count accurately in order to have the correct input.

Description of the modules and their functionalities:
  
  vga: Handles synchronization and timing for the VGA display.
  
  clk_divider: Divides the system clock to approximately a 1 second clock cycle.
  
  debouncer: Cleans up the noisy send button signal for reliable processing. 
  
  button_encoder: Encodes user inputs (from button) into a 10-bit representation stored in letter.
  
  decoder: Decodes the input letterBits into a numeric representation for ASCII text processing at the posedge of send button. (1-26 for A-Z, 27-36 for 1-9,0).
  
  ascii_test: Generates bits text to display based on input , synchronized with the video signals. This module receives data from vga_controller and sends and receives data from ascii_rom.
  
  ascii_rom: ROM module with bitmap data for A-Z, 0-9 and space characters.
  
  The always block updates the vga_reg register at every clock pulse. This ensures that the output to the VGA is synchronized with the pixel clock.

