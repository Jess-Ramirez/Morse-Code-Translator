MORSE CODE TRANSLATOR

Jessica Ramirez, Lola Shadare, Jacob Perry

Link to video:

Overview: User presses buttons on FPGA and translates them from Morse code to text which is displayed on the monitor

How to run: 

Press the M17 button for one second to input a dot, three seconds for a dash. Once you have inputted the series of . and - for your desired character. If you make a mistake you can press P18 to reset the registers that store your inputs so you can try again. When the message is correct, press the P17 button for one second to send to the VGA (an LED will turn on when the P17 signal is being sent). The letter you inputted will now appear on screen. If you wish to clear the screen press M18.

Overview of code structure:

