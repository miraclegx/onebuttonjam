--started 25th nov 2024 for the one button game jam
-- hmmmmm maybe the whole game should be in a single file main.lua :) lol
-- basicaly flappy bird but its a plane
-- so you basically collect stuffs okay, so im gone for now

lume = require('lume')

function love.load()
  math.randomseed(os.time())
  plane = {x = 100, y = 100,img = love.graphics.newImage('assets/plane.png'),dy = 0,climbPower = -200,angle = 0,isClimbing = false} -- fuck this randians stuff very confusing :)
  plane.angle = math.deg(plane.angle)
  gravity = 400
  
  collectables = {}
  score = 0
  backgroundImg = love.graphics.newImage('assets/background.png')
  coinImg = love.graphics.newImage('assets/coin.png')
end

function love.update(dt)
  fps = love.timer.getFPS()
  plane.angle = lume.clamp(plane.angle,-1,1)
  -- gravity stuff
  plane.dy = plane.dy + gravity * dt
  plane.y = plane.y + plane.dy * dt
  
  if plane.isClimbing == true then
    plane.angle = plane.angle - .0150
  else 
    plane.angle = plane.angle + .006
  end
  
  if love.keyboard.isDown('space') then
    plane.isClimbing = true
    plane.dy = plane.climbPower
  else 
    plane.isClimbing = false
  end
  
  for i,v in ipairs(collectables) do
    v.x = v.x - 60 * dt
  end
end

function love.draw()
  love.graphics.draw(backgroundImg)-- draw the backgroud
  love.graphics.draw(plane.img,plane.x,plane.y,plane.angle)
  --love.graphics.draw(coinImg,500,60)
  for i,v in ipairs(collectables) do
    love.graphics.draw(v.img,v.x,v.y)
  end
  -- good old debug value print
  love.graphics.print(plane.angle)
  love.graphics.print('fps'..fps,900,0,0,2,2)
end

function love.keypressed(key)
  if key == 'space' then
    --plane.dy = plane.climbPower
  elseif key == 'a' then
    addCollectable()
  end
end

function addCollectable()
  collectable  = {x = 1010,y = math.random(0,470),img = coinImg}
  table.insert(collectables,collectable)
end