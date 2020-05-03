import binascii

message = input("enter message: ")
asciiMessage = bin(int(binascii.hexlify(message.encode("ascii")), 16))
print("input byte stream: ", asciiMessage)

def registerize(bitStream,regName,seqNumber):
    cleanStream = bitStream[2:]
    regName = cleanStream[seqNumber*8:(seqNumber+1)*8]
    return(regName)

def xor(x, y):
    ans = ""
    for i in range(len(x)):
        if x[i] == "0" and y[i] == "1" or x[i] == "1" and y[i] == "0":
            ans += "1"
        else:
            ans += "0"
    return ans

def encode(bitStream):
    buffer = []
    seqNumber = 0
    regA = '00000000'
    regC = '00000000'

    while (regA!=''):
        regA = registerize(bitStream,regA,seqNumber)
        regB = xor(regA,regC)
        regC = regB[3:]+regB[:3]
        buffer.append(regC)
        seqNumber +=1 
    return (buffer)


encodedMessage = encode(asciiMessage)
print("encoded byte stream: ",encodedMessage) 
