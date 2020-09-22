import serial
import csv

ser = serial.Serial('COM4', 9600, serial.EIGHTBITS, serial.PARITY_NONE, serial.STOPBITS_ONE)
# Enter the port and baudrate correctly

b_array = []

for i in range(128):
   b_array.append(i)

# b_array = [170, 186, 139, 136, 200, 220, 173, 170, 42, 50, 131, 136, 72, 84, 165, 170, 171, 171, 155, 136, 201, 205, 189, 
#         170, 43, 35, 147, 136, 73, 69, 181, 170, 168, 152, 171, 136, 202, 254, 141, 170, 40, 16, 163, 136, 74, 118, 133, 
#         170, 169, 137, 187, 136, 203, 239, 157, 170, 41, 1, 179, 136, 75, 103, 149, 170, 174, 254, 203, 136, 204, 152, 
#         237, 170, 46, 118, 195, 136, 76, 16, 229, 170, 175, 239, 219, 136, 205, 137, 253, 170, 47, 103, 211, 136, 77, 1, 
#         245, 170, 172, 220, 235, 136, 206, 186, 205, 170, 44, 84, 227, 136, 78, 50, 197, 170, 173, 205, 251, 136, 207, 171, 
#         221, 170, 45, 69, 243, 136, 79, 35, 213, 0]
#print (type(b_array))

values = bytearray(b_array)
#print (values)
ser.write(values)

carray =[]
oarray = []

for i in range(128):
    cur_byte=ser.read()
    carray.append(hex(ord(cur_byte)))
    oarray.append(ord(cur_byte))
    #print (ord(cur_byte),)

print (carray)

print (oarray)

with open("byte_array.csv", 'w') as myfile:
    wr = csv.writer(myfile, quoting=csv.QUOTE_ALL)
    wr.writerow(carray)

