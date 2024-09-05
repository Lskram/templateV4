local map = require("map")

local anim = require("animModule")

local state = nil

local player = {

    x = 100,

    y = 100,

    width = 32,

    height = 32,

    speed = 100

}

function love.load()
    map.load("maps/map.lua", {})
    local world = map.getWorld()
    world:add(player, player.x, player.y, player.width, player.height)
    player.image = love.graphics.newImage("assets/images/sprite.png")
end

function love.update(dt)
    local dx, dy = 0, 0
    map.update(dt)
    dx=player.speed*dt
    map.movePlayer(player,dx,dy)

end

function love.draw()
    map.draw()
    love.graphics.draw(player.image, player.x, player.y)
end
