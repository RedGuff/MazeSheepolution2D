function love.load()
  margeV = 60
   mode = "intro"
   sfx = love.audio.newSource("sfx.ogg", "static")
   image = love.graphics.newImage("tileset.png")
 image2 = love.graphics.newImage("SpreadSheet0.png")
    local image_width = image:getWidth()
    local image_height = image:getHeight()
    width = (image_width / 3) - 2
    height = (image_height / 2) - 2

    quads = {}

    for i=0,1 do
        for j=0,2 do
            table.insert(quads,
                love.graphics.newQuad(
                    1 + j * (width + 2),
                    1 + i * (height + 2),
                    width, height,
                    image_width, image_height))
        end
    end

    tilemap = {
        {1, 6, 6, 2, 1, 6, 6, 2},
        {3, 0, 0, 4, 5, 0, 0, 3},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {4, 2, 0, 0, 0, 0, 1, 5},
        {1, 5, 0, 0, 0, 0, 4, 2},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {3, 0, 0, 1, 2, 0, 0, 3},
        {4, 6, 6, 5, 4, 6, 6, 5}
    }

    --Create our player
    player = {
        image = love.graphics.newImage("player.png"),
        tile_x = 2,
        tile_y = 2
    }
    exit = {
        image = love.graphics.newImage("exit.png"),
        tile_x = 6,
        tile_y = 6
    }
end

function love.keypressed(key)
    local x = player.tile_x
    local y = player.tile_y

    if key == "left" then
        x = x - 1
    elseif key == "right" then
        x = x + 1
    elseif key == "up" then
        y = y - 1
    elseif key == "down" then
        y = y + 1
    end

    if isEmpty(x, y) then
        player.tile_x = x
        player.tile_y = y
    end
    if (exit.tile_x == x) and (exit.tile_y == y) then
        player.tile_x = y
        player.tile_y = y
         sfx:play()
        mode = "win"
    end
    
    
end



function isEmpty(x, y)
    return tilemap[y][x] == 0
end

function love.draw()
     love.graphics.print("2D maze from SheePolution!", 110, 20)
  
  
    for i,row in ipairs(tilemap) do
        for j,tile in ipairs(row) do
            if tile ~= 0 then
                --Draw the image with the correct quad
                love.graphics.draw(image, quads[tile], j * width, margeV + (i * height))
            end 
        end
    end

    --Draw the player and multiple its tile position with the tile width and height
    love.graphics.draw(exit.image, exit.tile_x * width, margeV + (exit.tile_y * height))
    love.graphics.draw(player.image, player.tile_x * width, margeV + (player.tile_y * height))
    
  
    if mode == "win" then
     love.graphics.print("You win!", 40, 40)
    end
end