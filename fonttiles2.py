from PIL import Image

horizontalTiles = 8
verticalTiles = 192

tileWidth = 16
tileHeight = 16

tileset = Image.open("E:\\NDS\\AA\\coolfont.png")

outputTileset = Image.new("RGBA", (horizontalTiles*tileWidth, verticalTiles*tileHeight), (0,0,0,0))

def getTile(x,y):
    posX = x*tileWidth
    posY = y*tileHeight
    box = (posX, posY, posX + tileWidth, posY + tileHeight)
    return tileset.crop(box)

tileNumber = 0

for y in range(0,verticalTiles):
    for x in range(0,horizontalTiles):    
        destbox = (x * tileWidth, y * tileHeight, x * tileWidth+tileWidth, y * tileHeight + tileHeight)
        outputTileset.paste(getTile(0,tileNumber), destbox)
        tileNumber += 1


outputTileset.save("E:\\NDS\\AA\\awesomefont.png")
