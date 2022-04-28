local imgTiles = playdate.graphics.imagetable.new("tiles") -- load tileset image from files
local tilemap = playdate.graphics.tilemap.new() -- create a tilemap
tilemap:setImageTable(imgTiles) -- set the tilemap's tiles to the tileset 

playdate.display.setScale(4) -- zoom in 🔭 this isn't necessary for the tilemap

local width, height = 0, 0 -- create width and height variables, we will use this to only make the tilemap big enough to fit all the tiles but no bigger

local world = json.decodeFile("level.json") -- load the json file

-- loop through tiles and set the width and height to the farthest points
for i = 1, #world.tiles, 1 do
    local tile = world.tiles[i] -- get the tile from the table

    if tile.x > width then width = tile.x end -- if a tile goes out further than the width, make the width how far out the tile is
    if tile.y > height then height = tile.x end -- same but vertical
end

tilemap:setSize(width, height) -- set size to width and height

-- add tiles in all tile positions
for i = 1, #world.tiles, 1 do
    local tile = world.tiles[i] -- get the tile from the table
    tilemap:setTileAtPosition(tile.x, tile.y, tile.tile) -- place the tile in the tile's position
    -- the tile number is the position of the tile on the tileset image. left to right, top to bottom is the order
end

-- I originally had those as 1 loop but it didn't wanna work like that

-- run every frame
function playdate.update()
    playdate.graphics.clear() -- clear screen
    tilemap:draw(0,0) -- draw tile at x = 0, y = 0
end