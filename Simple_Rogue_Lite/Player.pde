class Player extends Entity 
{
  // Initialize variables for Player class
  float max_health, proj_speed, firerate, regen, experience, max_experience, level, last_shot_time = 0, last_regen_time = 0;
  float speed_cap = 30, proj_speed_cap = 30, firerate_cap = 30;
  boolean moving_up, moving_down, moving_left, moving_right;

  // Player constructor 
  Player(float x, float y, float hitbox_length, float hitbox_width, float health, float max_health ,float damage, float speed, float proj_speed, float firerate, float regen, float experience, float max_experience, float level)
  {
    super(x, y, hitbox_length, hitbox_width, health, damage, speed);
    this.max_health = max_health;
    this.proj_speed = proj_speed;
    this.firerate = firerate;
    this.experience = experience;
    this.regen = regen;
    this.max_experience = max_experience;
    this.level = level;
  }

  // Player constructor with default values
  Player() 
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed)
    super(/*x*/ width / 2, /*y*/ height / 2, /*hitbox length*/ 20, /*hitbox width*/ 20, /*health*/ 10, /*damage*/ 1, /*speed*/ 1.5);
    
    this.moving_up = false;
    this.moving_down = false;
    this.moving_left = false;
    this.moving_right = false;
    
    this.max_health = 10;
    this.proj_speed = 1;
    this.firerate = 1;
    this.regen = 0.25;
    this.experience = 0;
    this.max_experience = 15;
    this.level = 1;
  }

  // keyPressed() method to determine if user is holding a movment keys 
  void keyPressed() 
  {
    switch(key) 
    {
      case 'w':
        moving_up = true;
        break;
        
      case 'a':
        moving_left = true;
        break;
        
      case 's':
        moving_down = true;
        break;
        
      case 'd':
        moving_right = true;
        break;
    }
  }

  void keyReleased() 
  {
    switch(key) 
    {
      case 'w':
        moving_up = false;
        break;
        
      case 'a':
        moving_left = false;
        break;
        
      case 's':
        moving_down = false;
        break;
        
      case 'd':
        moving_right = false;
        break;
    }
  }
  
  // spawn player projectile based on firerate 
  void shoot() 
  {
    if(!is_paused)
    {
      // Calculate the cooldown period based on fire rate
      int current_time = millis();
      
      // Convert firerate from shots per second to milliseconds
      int cooldown = (int) (1000 / firerate);
      
      if (mousePressed && current_time - last_shot_time >= cooldown) 
      {
        // (x, y, hitbox_length, hitbox_width, health ,damage, speed) 
        player_projectiles.add(new Player_Projectile());
        
        // Update the time of the last shot
        last_shot_time = current_time;
      }
    }
  } 

  // check if the player can regenerate health, if so regen health
  void check_regen() 
  {
    if (!is_paused && health < max_health) 
    {
      // Calculate the time elapsed since the last regen update
      int current_time = millis();
      float elapsed_time = current_time - last_regen_time;
      
      // Convert regen rate from health per second to milliseconds
      int regen_interval = (int) (1000 / regen);
  
      // If enough time has passed and not at max health for regen, update the health
      if (elapsed_time >= regen_interval) 
      {
        health += 1;
        last_regen_time = current_time;
      }
    } 
    else if (health >= max_health) 
    {
      // Reset the regen timer when health reaches max
      last_regen_time = millis();
    }
  }
  
  // check if players experience is equal or above max experience
  boolean check_level_up() 
  {
    if (experience >= max_experience) 
    {
      player.level += 1;
      experience = 0;
      max_experience += 15;
      return true;
    }
    return false;
  }
  
  String[] random_stat() 
  {
    String[] stats_array = {"MAX HEALTH", "DAMAGE", "SPEED", "PROJECTILE SPEED", "FIRERATE", "REGEN"};
    
    // Shuffle the array to ensure randomness
    for (int i = stats_array.length - 1; i > 0; i--) 
    {
      int index = (int) random(i + 1);
      // Swap elements at i and index
      String temp = stats_array[index];
      stats_array[index] = stats_array[i];
      stats_array[i] = temp;
    }
    
    // Create an array to store selected stats
    String[] selectedStats = new String[3]; 
    
    // Select the first three unique stats
    for (int i = 0; i < 3; i++) 
    {
      selectedStats[i] = stats_array[i];
    } 
    return selectedStats;
  }

  // level up stat
  void increase_stat(String stat)
  {
    switch(stat) 
    {
      case "MAX HEALTH":
        max_health += 5;
        break;
        
      case "DAMAGE":
        damage += 0.5;
        break;
        
      case "SPEED":
        if(speed < speed_cap)
        {
          speed += 0.5;
        }
        break;
        
      case "PROJECTILE SPEED":
        if(proj_speed < proj_speed_cap)
        {
          proj_speed += 0.5;
        }
        break;
        
       case "FIRERATE":
        if(firerate < firerate_cap)
        {
          firerate += 0.5;
        }
        break;
        
      case "REGEN":
        regen += 0.25;
        break;       
    }
  }
  
  void reset_player() 
  {
    player = new Player
    (
      /*x*/ width / 2, 
      /*y*/ height / 2, 
      /*hitbox length*/ 20, 
      /*hitbox width*/ 20, 
      /*health*/ 10, 
      /*max_health*/ 10, 
      /*damage*/ 1, 
      /*speed*/ 1.5, 
      /*proj_speed*/ 1, 
      /*firerate*/ 1, 
      /*regen*/ 0.5, 
      /*experience*/ 0, 
      /*max_experience*/ 15, 
      /*level*/1
    );
  }
  
  // update the users position by using the move() method
  void update() 
  {
    if(!is_paused)
    {
      float add_x = 0;
      float add_y = 0;
  
      if (moving_up && y - speed >= 0) 
      {
        add_y -= speed;
      }
      if (moving_down && y + speed <= height) 
      {
        add_y += speed;
      }
      if (moving_left && x - speed >= 0) 
      {
        add_x -= speed;
      }
      if (moving_right && x + speed <= width) 
      {
        add_x += speed;
      }
      
      // Normalize diagonal movement
      if (add_x != 0 && add_y != 0) 
      {
        float magnitude = sqrt(add_x * add_x + add_y * add_y);
        add_x = (add_x / magnitude) * speed;
        add_y = (add_y / magnitude) * speed;
      }
      move(add_x, add_y);
    }
  }
  
  // Display all stats of player
  void display_stats()
  {
    fill(0);
    textSize(16);
    textAlign(LEFT);
    text("HEALTH: " + health + " / " + max_health + " (MAX ∞)", 10, 20);
    text("DAMAGE: " + damage + " (MAX ∞)", 10, 35);
    text("SPEED: " + speed + " (MAX " + speed_cap + ")", 10, 50);
    text("PROJ SPEED: " + proj_speed + " (MAX " + proj_speed_cap + ")", 10, 65);
    text("FIRERATE: " + firerate + " (MAX " + firerate_cap + ")", 10, 80);
    text("REGEN: " + regen + " (MAX ∞)", 10, 95);
    text("EXPERIENCE: " + experience + " / " + max_experience + " (MAX ∞)", 10, 110);
    text("LEVEL: " + level + " (MAX ∞)", 10, 125);
    text("TOTAL DEFEATED: " + total_defeated + " (MAX ∞)", 10, 140);
    text("TOTAL EXPERIENCE: " + total_experience + " (MAX ∞)", 10, 155);
    text("DIFFICULTY: " + nf(difficulty, 0, 2) + " (MAX ∞)", 10, 170);
    text("WAVE: " + wave + " (MAX ∞)", 10, 185);
    
    text("P - PAUSE GAME", width - 115, 20);
    text("C - CLEAR SCENE", width - 115, 35);
    text("I - INVINCIBLE", width - 115, 50);
    text("H - TOGGLE HITBOXES", width - 115, 65);
    text("L - LEVEL UP", width - 115, 80);
    text("E - NO LEVELUP", width - 115, 95);
    text("M - MAX STATS", width - 115, 110);
    text("K - KILL PLAYER", width - 115, 125);
    text("R - RESET GAME", width - 115, 140);
    
    // Display health bar
    float health_percentage = 400 * (health / max_health);
    
    pushMatrix();
    rotate(PI);
    rectMode(CORNER);
    translate(-width + 10, -height + 10);
    fill(0);
    rect(0, 0, 20, 400);
    fill(255, 0, 0);
    rect(0, 0, 20, health_percentage);
    popMatrix();
    fill(255);
    textSize(25);
    textAlign(CENTER, CENTER);
    text((int)max_health, width - 20, height - 390);
    text("H\nE\nA\nL\nT\nH\n\n", width - 20, height - 200);
    text((int)health, width - 20, height - 30);
    
    // Display experience bar
    float experience_percentage = 450 * (experience / max_experience);
    
    pushMatrix();
    rectMode(CORNER);
    fill(0);
    rect(width / 2 - 225, 10, 450, 20);
    fill(128, 0, 128);
    rect(width / 2 - 225, 10, experience_percentage, 20);
    popMatrix();
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text((int)experience, width / 2 - 200, 20);
    text("LEVEL " + (int) level, width / 2, 20);
    text((int)max_experience, width / 2 + 200, 20);    
  }
  
  // display method to draw the players apperance
  void display() 
  {
    super.display();
    fill(255, 0, 0);
    
    // Calculate angle between player and mouse
    float angle = atan2(mouseY - y, mouseX - x);
    
    // Adjust angle to align with sprite    
    // Add 90 degrees (PI/2 radians) to make the sprite face upwards
    angle += HALF_PI; 
    
    pushMatrix();
    translate(x, y);
    rotate(angle);  
    // Draw player image
    image(player_image, 0, 0, 40, 40); 
    popMatrix();
  }
}
