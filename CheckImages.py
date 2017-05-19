import os, glob
from PIL import Image

def checkImages(dir):
    print("Checking for black/white images")
    os.chdir(dir)
    for file in glob.glob("*.tif"):
        im = Image.open(file)
        extrema = im.convert("L").getextrema()
        if (extrema == (0, 0)) or (extrema == (1, 1)): #image is all black or all white
            os.remove(file)
            print(file + " was deleted as it was all black or white")
    return 0
