class Ship extends GameObject
{
  Ship()
  {
    // Starts middle left of screen
    pos = new PVector(width / 10, height / 2);
    forward = new PVector(1, 0); // Initial forward movement is to the right
    theta = 0.0f;
    speed = 4.0f;
    health = 10.0f;
    maxHealth = 10.0f;
    ammo = 10.0f;
    maxAmmo = 10.0f;
    w = 30.0f;
    halfW = w / 2.0f;
    c = color(255); // White
    elapsed = 0;
    second = 1000;
  }
  
  void update()
  {
    move();
    shoot();
  }
  
  void move()
  {
    /* 
      In order to move in the same direction as the angle(theta) the ship is rotated to,
      you must use the sin() and cos() functions in conjuction with theta.
      This gives you an (x, y) coordinate that when added to your position
      moves you in the direction of the angle you are rotated towards.
      
      Whether to assign the x or y value based on sin(theta) or cos(theta) depends 
      on the initial point of rotation of the ship, which affects the unit circle. 
      Since the initial point of rotation of the player ship is 0 (according to Processing),
      then:
      
      sin(theta) = opposite/hypotenuse = y/radius(1) = y
      cos(theta) = adjacent/hypotenuse = x/radius(1) = x
    */
    
    forward.x = cos(theta);
    forward.y = sin(theta);
    
    // forward coordinates are multiplied by speed to get ship velocity
    forward.mult(speed);
    
    if(keys[UP])
    {
      // forward vector is added to pos vector to get our updated position
      pos.add(forward);
      
      wrapAround();
    }
        
    if(keys[LEFT])
    {
      // Rotates ship to the left
      theta -= .1f;
    }
        
    if(keys[RIGHT])
    {
      // Rotates ship to the right
      theta += .1f;
    } 
  }
  
  void shoot()
  {
    if(keys[' '] && millis() - elapsed > (second / 5))
    {
      Bullet bullet = new Bullet();
      
      gameObjects.add(bullet);
      
      elapsed = millis();
      
      // health -= .1;
      // ammo -= .2;
      
      // enemy.health -= .1;
      // enemy.ammo -= .1;
    }
  }
  
  void render()
  {
    pushMatrix();
    stroke(c);
    translate(pos.x, pos.y);
    rotate(theta);
    line(-halfW, -halfW, halfW, 0); // Outside Left
    line(-halfW, halfW, halfW, 0); // Outside Right
    line(-halfW, -halfW, 0, 0); // Inside Left
    line(-halfW, halfW, 0, 0); // Inside Right
    popMatrix();
    
    healthBarWidth = map(health, 0, maxHealth, 0, width / 2);
    ammoBarWidth = map(ammo, 0, maxAmmo, 0, width / 3);
    
    // Health Bar
    fill(0);
    rect(0, 0, width / 2, height / 20);
    fill(0, 200, 0);
    rect(0, 0, healthBarWidth, height / 20);
    
    // Ammo Bar
    fill(0);
    rect(0, height / 20, width / 3, height / 20);
    fill(200, 0, 0);
    rect(0, height / 20, ammoBarWidth, height / 20);
  }
}

