function update_game(var)
-- moving
    ship.sx = (ship.x > -4 and love.keyboard.isDown("a")) and -300 or 
              (ship.x < 740 and love.keyboard.isDown("d")) and 300 or 0
    ship.sy = (ship.y > 7 and love.keyboard.isDown("w")) and -300 or 
              (ship.y < 530 and love.keyboard.isDown("s")) and 300 or 0
    ship.flip = (love.keyboard.isDown("d")) and -1 or 1
    ship.xAxisInc = (love.keyboard.isDown("d")) and 64 or 0
    ship.spr = (love.keyboard.isDown("a") or love.keyboard.isDown("d")) and 2 or 1
-- moving apllying
    ship.x = ship.x + ship.sx * var
    ship.y = ship.y + ship.sy * var
-- life
    if ship.contentLife > ship.maxLife then
        ship.contentLife = ship.maxLife
    end
-- ship exhaust
    ship.exhaust_x = ship.x + 16
    ship.exhaust_y = ship.y + 64
-- cadence
    ship.cadence = (ship.cadence > 0) and ship.cadence - 1 or ship.cadence - 0
-- bullets
    --shot
    if ship.cadence == 0 and love.keyboard.isDown(" ") then
        ship.cadence = 25
        local newBullet = {
            x = ship.x + 24,
            y = ship.y - 15,
            damage = 1,
            speed = 450,
            spr = love.graphics.newImage("sprites/bullet.png")
        }

        local shotSound = love.audio.newSource("sounds/ship_shoot.wav", "static")
        shotSound:play()
        table.insert(ship.bullets, newBullet)
    end
    --move bullets
    for b = #ship.bullets, 1, -1 do
        local myBullet = ship.bullets[b]
        myBullet.y = myBullet.y - myBullet.speed * var
        
        if myBullet.y <= -15 then
            table.remove(ship.bullets, b)
        end
    end
-- enemies
    -- spawn enemy
    if #enemies == 0 then
        tools.spawn_enemy()
    end
    -- move enemies
    for e = #enemies, 1, -1 do
        local myEnemy = enemies[e]
        myEnemy.y = myEnemy.y + myEnemy.speed * var

        if myEnemy.y >= 600 then
            table.remove(enemies, e)
        end
    end
    -- ship, enemies and bullets interactions
    for e = #enemies, 1, -1 do
        local myEnemy = enemies[e]

        -- enemy and ship collision
        if tools.s_collision(myEnemy, ship) == true then
            table.remove(enemies, e)
            ship.contentLife = ship.contentLife - 1
        end

        for b = #ship.bullets, 1, -1 do
            local myBullet = ship.bullets[b]
            -- bullet hit enemy
            if tools.b_collision(myEnemy, myBullet) == true then
                table.remove(ship.bullets, b)
                myEnemy.life = myEnemy.life - myBullet.damage
            end

            if myEnemy.life <= 0 then
                table.remove(enemies, e)
            end
        end
    end

-- move stars
    tools.move_stars(var)
end

return{
    update_game = update_game
}