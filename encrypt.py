def xor(x, y):
    ans = ""
    for i in range(len(x)):
        if x[i] == "0" and y[i] == "1" or x[i] == "1" and y[i] == "0":
            ans += "1"
        else:
            ans += "0"
    return ans

b_array = []
for i in range(128):
    b_array.append(str(hex(i)))    

c_array =[]
num_of_bits = 8

for i in b_array:
    c_array.append(bin(int(i, 16))[2:].zfill(num_of_bits))  

# print(c_array)

def encrypt(byte_stream, key):
    encrypted = []
    # print(byte_stream)
    for i in byte_stream:
        regA = xor(i,key)
        regB = regA[4:]+regA[:4]
        print(regA,key,regB)
        key = regB
        encrypted.append(hex(int(regB,2)))
    return(encrypted)    

print(encrypt(c_array,'10101010'))        