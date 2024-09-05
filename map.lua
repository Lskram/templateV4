local sti = require("libs.sti")
local bump = require("libs.bump")

local mapModule = {}

-- ประกาศตัวแปรภายในโมดูลเพื่อเก็บแผนที่และโลก Bump
local map
local world

-- ฟังก์ชันโหลดแผนที่และเลเยอร์ที่ไม่ให้ผ่าน
function mapModule.load(mapPath, layerNames)
    -- สร้างโลก Bump
    world = bump.newWorld(32)

    -- โหลดแผนที่จากไฟล์ที่สร้างจาก Tiled
    map = sti(mapPath)

    -- เพิ่มไทล์ในเลเยอร์ที่กำหนดลงใน Bump World
    for _, layerName in ipairs(layerNames) do
        local layer = map.layers[layerName]
        if layer then
            for y, tiles in ipairs(layer.data) do
                for x, tile in pairs(tiles) do
                    if tile then
                        -- เพิ่มไทล์ลงใน Bump World
                        local tileX, tileY = (x - 1) * map.tilewidth, (y - 1) * map.tileheight
                        world:add({name = layerName}, tileX, tileY, map.tilewidth, map.tileheight)
                    end
                end
            end
        end
    end
end

-- ฟังก์ชันอัปเดตแผนที่
function mapModule.update(dt)
    if map then
        map:update(dt)
    end
end

-- ฟังก์ชันวาดแผนที่
function mapModule.draw()
    if map then
        map:draw(0, 0)
    end
end

-- ฟังก์ชันตรวจสอบการชนกันและย้ายผู้เล่น
function mapModule.movePlayer(player, dx, dy)
    local actualX, actualY, cols, len = world:move(player, player.x + dx, player.y + dy)
    player.x, player.y = actualX, actualY

    -- ตรวจสอบการชนกับเลเยอร์ที่ไม่ให้ผ่าน
    for i = 1, len do
        local col = cols[i]
        if col.other.name then
            -- คืนค่าตำแหน่งเดิมของผู้เล่นถ้าชนกับเลเยอร์ที่ไม่ให้ผ่าน
            player.x, player.y = player.x - dx, player.y - dy
            break
        end
    end
end

-- ฟังก์ชันสำหรับเข้าถึง Bump World ภายนอกโมดูล
function mapModule.getWorld()
    return world
end

return mapModule

    
