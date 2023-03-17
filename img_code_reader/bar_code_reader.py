# Importing library
import sys

import cv2
import os
from pyzbar.pyzbar import decode

path_img = os.getenv("HOME")
path_img = f"{path_img}/Downloads/laetus-bar-code/laetus-324.jpg"

lines = []


def get_value(width, position):
    small = position + 1
    if width == "small":
        return small
    return small * 2


def get_sum():
    total = 0
    for idx, line in enumerate(lines):
        width = lines[idx]
        total += get_value(width, idx)
    return total


# Make one method to decode the barcode
def BarcodeReader(image):
    # read the image in numpy array using cv2

    imgs = cv2.imread(image)
    for ar1 in imgs:
        for ar2 in ar1:
            print(ar2[0])
    # print(imgs)
    sys.exit()
    # Decode the barcode image
    detectedBarcodes = decode(img)

    # If not detected then print the message
    if not detectedBarcodes:
        print("Barcode Not Detected or your barcode is blank/corrupted!")
    else:

        # Traverse through all the detected barcodes in image
        for barcode in detectedBarcodes:

            # Locate the barcode position in image
            (x, y, w, h) = barcode.rect

            # Put the rectangle in image using
            # cv2 to highlight the barcode
            cv2.rectangle(img, (x - 10, y - 10),
                          (x + w + 10, y + h + 10),
                          (255, 0, 0), 2)

            if barcode.data != "":
                # Print the barcode data
                print(barcode.data)
                print(barcode.type)

    # Display the image
    cv2.imshow("Image", img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


if __name__ == "__main__":
    # Take the image from user
    image = path_img
    BarcodeReader(image)
