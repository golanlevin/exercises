criterion = hue
# criterion = saturation
# criterion = brightness

def setup():
    size(800,800);
    img = loadImage("j.jpg");
    img.pixels=sorted(img.pixels,key=criterion);
    img.updatePixels();
    image(img,0,0);
