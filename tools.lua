

function set_values()
    ship = {
        x = 400,
        y = 200,
        x_spd = 0,
        y_spd = 0,
        contentLife = 3,
        maxLife = 5,
        sprs = {love.graphics.newImage("sprites/stopped_ship.png"), 
                love.graphics.newImage("sprites/turning_ship.png")},
        spr = 1,
        flip = 1,
        xAxisInc= 0,
        pixel_turn_inc = 0,

        exhaust_x = nil,
        exhaust_y = nil,
        exhaust_sprs = {love.graphics.newImage("sprites/exhaust1.png"), 
                        love.graphics.newImage("sprites/exhaust2.png"), 
                        love.graphics.newImage("sprites/exhaust3.png"), 
                        love.graphics.newImage("sprites/exhaust4.png"), 
                        love.graphics.newImage("sprites/exhaust5.png"), 
                        love.graphics.newImage("sprites/exhaust6.png"), 
                        love.graphics.newImage("sprites/exhaust7.png"), 
                        love.graphics.newImage("sprites/exhaust8.png")},

        exhaust_spr = 1,
                   
        bullets = {},
        bullet_spr = love.graphics.newImage("sprites/bullet.png"),
        cadence = 0,
        shot_wav = love.audio.newSource("sounds/ship_shoot.wav", "static")
    }

    enemies = {}

    stars = {}
    for i = 1, 100 do
        tools.starfield("start")
    end
end
function spawn_enemy()
    local newEnemy = {
        x = math.random(0, 760),
        y = math.random(0, 200),
        speed = 130,
        life = 3,
        sprs = {love.graphics.newImage("sprites/alien1.png"), 
               love.graphics.newImage("sprites/alien2.png"), 
               love.graphics.newImage("sprites/alien3.png"), 
               love.graphics.newImage("sprites/alien4.png"), 
               love.graphics.newImage("sprites/alien5.png"), 
               love.graphics.newImage("sprites/alien6.png"), 
               love.graphics.newImage("sprites/alien7.png"), 
               love.graphics.newImage("sprites/alien8.png")},
        spr = 1
    }

    table.insert(enemies, newEnemy)
end

function b_collision(enemy, bullet)
    local e_top = enemy.y
    local e_bottom = enemy.y + 51
    local e_left = enemy.x + 11
    local e_right = enemy.x + 51

    local b_top = bullet.y
    local b_bottom = bullet.y + 15
    local b_left = bullet.x + 4
    local b_right = bullet.x + 11

    if b_top > e_bottom then return false end
    if e_top > b_bottom then return false end
    if b_left > e_right then return false end 
    if e_left > b_right then return false end

    return true
end

function s_collision(enemy, player)
    local e_top = enemy.y
    local e_bottom = enemy.y + 51
    local e_left = enemy.x + 11
    local e_right = enemy.x + 51

    local s_top = player.y + 7
    local s_bottom = player.y + 55
    local s_left = player.x + 11
    local s_right = player.x + 55

    if e_top > s_bottom then return false end
    if s_top > e_bottom then return false end
    if e_left > s_right then return false end
    if s_left > e_right then return false end

    return true
end

function animate(sprites, sprite, inc) 
    if sprite < (#sprites + 1) then
        sprite = sprite + inc
    end

    if sprite >= (#sprites + 1) then
        sprite = 1
    end

    return sprite
end

function starfield(var)
    local newStars = {}
        newStars.x = math.random(-6, 801)

        if var == "start" then
            newStars.y = math.random(4, 590)
        elseif var == "new" then
            newStars.y = 0
        end

        newStars.speed = math.random(90, 140)
        
        newStars.p_speed = (newStars.speed <= 106) and "slow" or 
                           (newStars.speed > 106 and newStars.speed <= 123) and "medium" or 
                           (newStars.speed > 123 and newStars.speed <= 140) and "fast" or "slow"

        newStars.r = (newStars.p_speed == "slow") and 29 or 
                     (newStars.p_speed == "medium") and 95 or 
                     (newStars.p_speed == "fast") and 255 or 255

        newStars.g = (newStars.p_speed == "slow") and 43 or 
                     (newStars.p_speed == "medium") and 87 or 
                     (newStars.p_speed == "fast") and 255 or 255

        newStars.b = (newStars.p_speed == "slow") and 83 or 
                     (newStars.p_speed == "medium") and 79 or 
                     (newStars.p_speed == "fast") and 255 or 255
    
    table.insert(stars, newStars)
end

function move_stars(var)
    for s = 1, #stars do
        local myStar = stars[s]

        if myStar.y >= 600 then
            table.remove(stars, s)
            starfield("new")
        end

        myStar.y = myStar.y + myStar.speed * var

        --myStar.y = (myStar.y < 600) and myStar.y + myStar.speed * var or (myStar.y >= 600) and 0 or 0 
        --myStar.x = (myStar.y >= 600) and math.random(-6, 801) or myStar.x
    end
end

function draw_stars()
    for s = 1, #stars do
        local myStar = stars[s]

        love.graphics.setColor(myStar.r, myStar.g, myStar.b)
        love.graphics.rectangle("fill", myStar.x, myStar.y, 3, 3)
        love.graphics.setColor(255, 255, 255)
    end
end

return{
    set_values = set_values,
    spawn_enemy = spawn_enemy,
    b_collision = b_collision,
    animate = animate,
    starfield = starfield,
    move_stars = move_stars,
    draw_stars = draw_stars,
    s_collision = s_collision
}