from math import *

def imprimir_pixel(bitmap_file,black):
    if black:
        bitmap_file.write('00000000')
        bitmap_file.write('\n')
    else:
        bitmap_file.write('11111111')
        bitmap_file.write('\n')

def main():
    bitmap_file = open('bitmap.txt', 'w')
    fila = 64
    columna = 64
    black = False


    for i in xrange(0,fila):
        if i % 8 == 0:
                black = not(black)
        for j in xrange(0,columna):
            if j % 8 == 0:
                black = not(black)
            imprimir_pixel(bitmap_file, black)
if __name__ == '__main__':
    main()