# FPGA-based-CBC-encryptor-and-decryptor

## Project description
In this project, we build a Cypher Block Chaining (CBC) based encryption and decryption module using FPGA. We send a raw data byte array to the FPGA from the computer through UART and then encrypt or decrypt byte stream using a provided specific secret key into the FPGA and return output to the computer again through UART. We use a switch to select between encryption and decryption operation.

### Cypher Block Chaining
#### Encryption

![alt text](https://github.com/durashi/FPGA-based-CBC-encryptor-and-decryptor/blob/master/Images/cbc_encryption.png)

In encryption mode, we xor the first byte with the one-byte long secret key. Then the result byte will be fed to the encryption function. In our project, we simply swap the 2 nibbles of the byte and return the result. Then the result will be saved and will be sent as the secret key for the next byte of the data. 

#### Decryption

![alt text](https://github.com/durashi/FPGA-based-CBC-encryptor-and-decryptor/blob/master/Images/cbc_decryption.png)

In decryption mode, we need to do the reverse of the functionality of encryption. So first we need to swap the two nibbles of the first byte of the encrypted data. Then the result will be xor with the secret key. Then the result will be output as the original data that we have encrypted. In here, the cyphered byte will be the secret key for the next decryption.

### UART communication

UART stands for Universal Asynchronous Receiver-Transmitter. It is a physical circuit in a microcontroller or a stand-alone IC that can receive and transmit serial data asynchronously. UART takes the bytes of data and converts them into a bitstream which can be sent using 1 wire instead of several wires. And another UART can re-assemble this bitstream into bytes. The following figure depicts the high-level understanding of the connectivity between the FPGA board and Laptop through UART.

![alt text](https://github.com/durashi/FPGA-based-CBC-encryptor-and-decryptor/blob/master/Images/uart_arc.png)

In UART communication, the data bits are sent in a frame including start bit and stop bit as shown below.

![alt text](https://github.com/durashi/FPGA-based-CBC-encryptor-and-decryptor/blob/master/Images/uart_trans.png))

  Since UART is asynchronous there is no clock involved. Therefore we need to sample data using the baud rate. This project works with 115200 Baud rate and 40ns (25 MHz) clock. That makes one bit = 25000000 / 115200 = 217 clock cycles. UART receiver and transmitter is built based on these data.

## Architecture diagram

![alt text](https://github.com/durashi/FPGA-based-CBC-encryptor-and-decryptor/blob/master/Images/block_diagram.png)

The computer sends data that needs to be encrypted or decrypted as a serial bitstream. The UART receiver reads this bitstream, assembles it to bytes and writes these bytes in the dual-port block RAM. Half the memory of the block RAM is allocated to write the received bytes from the UART receiver. 
After that, the saved data will be encrypted or decrypted upon a user's command. Users should select the mode encryption or decryption to start the process. Then the encrypted or decrypted data will be saved in the other half of the dual-port block RAM.  
Finally, the UART transmitter reads the encrypted or decrypted bytes one by one and reassembles them into a serial bit stream and sends it back to the computer.

## Main module - Cypher system

![alt text](https://github.com/durashi/FPGA-based-CBC-encryptor-and-decryptor/blob/master/Images/cypherSystem.png)

As the top module, the overall system including UART receiver, dual block ram, encryptor/decryptor and UART transmitter has been assembled under the Cypher system module. In this module, UART receiver writes the received bytes from the computer in the dual block ram from the addresses 0 to 127. Then the encryptor/decryptor module reads these 128 bytes from the block ram and writes the encrypted/decrypted 128 bytes to the block ram addresses 255 to 128 in reverse order. Then the UART transmitter reads these encrypted/decrypted 128 bytes from the block ram accordingly and sends the reassembled bitstream to the computer.

## Utilization results

![alt text](https://github.com/durashi/FPGA-based-CBC-encryptor-and-decryptor/blob/master/Images/Utilization.png)