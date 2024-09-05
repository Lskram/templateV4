local map = require("map")
local anim = require("animModule")
local animP = require("animModule")

-- เพลย์เยอร์
local player = { x = 100, y = 100, width = 32, height = 32, speed = 100, image = nil }


-- ศัตรูเปลี่ยนท่าทางได้
local t = {}
table.insert(t,
    { x = 100, y = 100, width = 32, height = 32, speed = 100, image = love.graphics.newImage("assets/images/zombie.png") })
table.insert(t,
    { x = 200, y = 250, width = 32, height = 32, speed = 100, image = love.graphics.newImage("assets/images/zombie.png") })

local world

function love.load()
    -- โหลดmap
    map.load("maps/map.lua", {})

    --รับโลกมา
    local world = map.getWorld()

    --เพิ่มเพลย์เยอร์เข้าไปในโลก
    world:add(player, player.x, player.y, player.width, player.height)


    --เพิ่มศัตรูเข้าไปในโลก
    for _, t1 in ipairs(t) do
        world:add(t1, t1.x, t1.y, t1.width, t1.height)
    end
    -- โหลดเพลย์เยอร์เข้ามาแสดง
    player.image = love.graphics.newImage("assets/images/sprite.png")


    -- โหลดศัตรูเข้ามาแสดง
    anim.loadAnimation("assets/images/sword.png", 64, 64, {

        idle = {
            frames = { '1-4', 1 }, -- ใช้เฟรมที่ 1 ถึง 4 จากแถวที่ 1
            duration = 0.1
        },
        run = {
            frames = { '1-4', 2 }, -- ใช้เฟรมที่ 1 ถึง 4 จากแถวที่ 2
            duration = 0.1
        }
    })


    -- โหลดอนิเมชันเพลย์เยอร์ผ่าน animP
    animP.loadAnimation("assets/images/sword.png", 64, 64, {
        idle = {
            frames = { '1-4', 1 }, -- เฟรมที่ 1 ถึง 4 จากแถวที่ 1
            duration = 0.1
        },
        run = {
            frames = { '1-4', 2 }, -- เฟรมที่ 1 ถึง 4 จากแถวที่ 2
            duration = 0.1
        }
    })
end

function love.update(dt)
    -- ตำแหน่งเพลย์เยอร์
    local dx, dy = 0, 0

    -- การควบคุมของเพลย์เยอร์
    if love.keyboard.isDown("up") then
        dy = -player.speed * dt
        animP.setState("run")
    elseif love.keyboard.isDown("down") then
        dy = player.speed * dt
        animP.setState("run")
    elseif love.keyboard.isDown("left") then
        dx = -player.speed * dt
        animP.setState("run")
    elseif love.keyboard.isDown("right") then
        dx = player.speed * dt
        animP.setState("run")
    else
        animP.setState("idle")
    end


    -- อัปเดตตำแหน่งของเพลเยอร์
    player.x = player.x + dx
    player.y = player.y + dy


    -- อัปเดตตำแหน่งในโลก
    world:update(player, player.x, player.y)


    -- อัปเดตท่าทางเพลเยอร์
    animP.update(dt)


    -- อัปเดตท่าทางศัตรู
    anim.update(dt)

    -- อัปเดตเมป
    map.update(dt)
end

function love.draw()
    --โหลดเมปขึ้นมาแสดง
    map.draw()


    --โหลดศัตรูขึ้นมาแสดงแบบ อาร์เลย์
    for _, t1 in ipairs(t) do
        love.graphics.draw(t1.image, t1.x, t1.y)
        anim.draw(t1.image, t1.x, t1.y)
    end


    -- โหลดภาพเพลย์เยอร์ขึ้นมาแสดงพร้อมอนิเมชัน
    animP.draw(player.image, player.x, player.y)


end
