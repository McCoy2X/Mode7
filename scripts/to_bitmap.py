import cv2
import numpy as np
import argparse

def main():
    bitmap_file = open('img.bit', 'w')
    parser = argparse.ArgumentParser(description='TP2.')
    parser.add_argument('-i', '--img')
    args = parser.parse_args()
    img = cv2.imread(args.img)
    scaled_img = cv2.resize(img,(64, 64), interpolation = cv2.INTER_CUBIC)
    rows = scaled_img.shape[0]
    cols = scaled_img.shape[1]
    chn = scaled_img.shape[2]
    for row in xrange(0,rows):
        for col in xrange(0, cols):
            pixel = scaled_img[row,col]
            if chn == 1:
                r = np.binary_repr(pixel[0]/32, width=3)
                g = np.binary_repr(pixel[0]/32, width=3)
                b = np.binary_repr(pixel[0]/64, width=2)
                bitmap_file.write(b+g+r)
                bitmap_file.write('\n')
            else:
                r = np.binary_repr(pixel[2]/32, width=3)
                g = np.binary_repr(pixel[1]/32, width=3)
                b = np.binary_repr(pixel[0]/64, width=2)
                bitmap_file.write(b+g+r)
                bitmap_file.write('\n')
    
if __name__ == '__main__':
    main()