from PIL import Image

horizontalTiles = 8
verticalTiles = 456

tileWidth = 16
tileHeight = 8

tileset = Image.open("E:\\NDS\\nds.png")

outputTileset = Image.new("RGBA", (tileWidth, horizontalTiles*verticalTiles*tileHeight), (0,0,0,0))

def getTile(x,y):
    posX = x*tileWidth
    posY = y*tileHeight
    box = (posX, posY, posX + tileWidth, posY + tileHeight)
    return tileset.crop(box)

tileNumber = 0

for y in range(0,verticalTiles):
    for x in range(0,horizontalTiles):    
        destbox = (0, tileNumber * tileHeight, tileWidth, tileNumber * tileHeight + tileHeight)
        outputTileset.paste(getTile(x,y), destbox)
        tileNumber += 1


outputTileset.save("E:\\NDS\\nds2.png")
