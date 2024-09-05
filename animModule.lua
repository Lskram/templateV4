local anim8 = require("libs.anim8")

local animModule = {}

local animations = {}

function animModule.loadAnimation(imagePath, frameWidth, frameHeight, animDefs)
    -- โหลดภาพ
    local image = love.graphics.newImage(imagePath)
    
    -- สร้างกริดจากภาพ
    local grid = anim8.newGrid(frameWidth, frameHeight, image:getWidth(), image:getHeight())
    
    -- สร้างแอนิเมชันจาก animDefs
    for name, def in pairs(animDefs) do
        animations[name] = {
            animation = anim8.newAnimation(grid(unpack(def.frames)), def.duration),
            image = image
        }
    end
end

function animModule.getAnimation(name)
    return animations[name] and animations[name].animation
end

function animModule.update(dt)
    for _, animData in pairs(animations) do
        if animData.animation then
            animData.animation:update(dt)
        end
    end
end

function animModule.draw(name, x, y, r, sx, sy, ox, oy)
    local animData = animations[name]
    if animData and animData.animation then
        animData.animation:draw(animData.image, x, y, r or 0, sx or 1, sy or 1, ox or 0, oy or 0)
    end
end

return animModule
