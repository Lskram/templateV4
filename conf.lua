function love.conf(t)
    t.window.width = 1280       -- กำหนดความกว้างของหน้าต่างแสดงผล

    t.window.height = 720       -- กำหนดความสูงของหน้าต่างแสดงผล

    t.window.resizable = true   -- อนุญาตให้ปรับขนาดหน้าต่างได้

    t.window.fullscreen = false -- ไม่เปิดใช้งานโหมดเต็มหน้าจอ

    t.window.vsync = 1          -- เปิดใช้งาน VSync (ลดการฉีกขาดของภาพ)

    t.window.title = "My Game"  -- ชื่อของหน้าต่าง
end
