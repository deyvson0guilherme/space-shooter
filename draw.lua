function draw_game()
    --local enm = enemies[1]
-- infos    
    love.graphics.print("x: "..math.floor(ship.x).."\ny: "..math.floor(ship.y)..
                        "\n#bullets: "..#ship.bullets..
                        "\ncadence: "..ship.cadence..
                        "\n#enemies: "..#enemies..
                        "\nlife: "..ship.contentLife..
                        "\nflip: "..ship.flip..
                        "\n#stars: "..#stars, 0, 0)
-- ship                
    love.graphics.draw(ship.sprs[ship.spr], ship.x, ship.y, 0, ship.flip, 1, ship.xAxisInc, 0)
    --ship.ex = tools.animate(ship.exhaust, ship.ex, 0.2)
-- exhaust
    ship.exhaust_spr = tools.animate(ship.exhaust_sprs, ship.exhaust_spr, 0.45)
    love.graphics.draw(ship.exhaust_sprs[math.floor(ship.exhaust_spr)], ship.exhaust_x, ship.exhaust_y)
-- bullets
    for b = #ship.bullets, 1, -1 do
        local myBullet = ship.bullets[b]

        love.graphics.draw(myBullet.spr, myBullet.x, myBullet.y)
    end
-- stars
    tools.draw_stars()
-- enemies
    for e = #enemies, 1, -1 do
        local myEnemy = enemies[e]

        myEnemy.spr = tools.animate(myEnemy.sprs, myEnemy.spr, 0.2)
        love.graphics.draw(myEnemy.sprs[math.floor(myEnemy.spr)], myEnemy.x, myEnemy.y)
    end
-- life
    for i = 1, ship.maxLife do

    -- case corners
        if i <= ship.contentLife then
        -- text
            love.graphics.print("life: full --- i: "..i, 0, 110 + (i * 15))
        -- life bar
            love.graphics.setColor(255, 0, 0)
            love.graphics.rectangle("fill", 340 + (i * 22), 580, 17, 10)
            love.graphics.setColor(255, 255, 255)
        elseif i > ship.contentLife then
        -- text
            love.graphics.print("life: empty -- i: "..i, 0, 110 + (i * 15))
        -- life bar 340
            love.graphics.setColor(126, 37, 83)
            love.graphics.rectangle("fill", 340 + (i * 22), 580, 17, 10)
        end
        
        --case
            love.graphics.setColor(29, 43, 83)
            love.graphics.rectangle("line", 361, 579, 105, 12)
            love.graphics.rectangle("line", 360, 578, 107, 14)
            love.graphics.rectangle("line", 359, 577, 109, 16)
            love.graphics.setColor(255, 255, 255)
        -- bar line broker
            love.graphics.setColor(29, 43, 83)
            love.graphics.rectangle("fill", 357 + (i * 22), 580, 5, 10)
        -- corners
            love.graphics.rectangle("fill", 355, 580, 5, 10)
            --love.graphics.rectangle("fill", 480, 570, 5, 10)
            love.graphics.setColor(255, 255, 255)
    end
end

return{
    draw_game = draw_game
}