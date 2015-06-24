from math import *


def toBinary(num):
    integerPart = '%i000000%i' % ((0 if (num >= 0.0) else 1),int(abs(num)))
    decimalPArt = ''

    number = abs(num - int(num))
    for i in xrange(0,8):
        if number*2 > 1:
            decimalPArt = decimalPArt + '1'
        else:
            decimalPArt = decimalPArt + '0'
        number = abs(number*2 - int(number*2))

    return integerPart + decimalPArt
def main():
    fsin = open('sin.v', 'w')
    fcos = open('cos.v', 'w')    
    for n in xrange(0,360):
        nsin = sin(radians(n)) 
        ncos = cos(radians(n))
        fsin.write('9\'b%s : out = %s;' % ('{:09b}'.format(n), toBinary(nsin)))
        fsin.write('\n')
        fcos.write('9\'b%s : out = %s;' % ('{:09b}'.format(n), toBinary(ncos)))
        fcos.write('\n')

if __name__ == '__main__':
    main()