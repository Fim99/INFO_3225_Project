class Speeder extends Enemy
{
  // Speeder constructor 
  Speeder(float x, float y, float hitbox_length, float hitbox_width, float health ,float damage, float speed, float experience_drop, float score_increase)
  {
    super(x, y, hitbox_length, hitbox_width, health, damage, speed, experience_drop, score_increase);
  }
  
  // Speeder constructor with default values
  Speeder()
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed, experience_drop, score_increase)
    super(random(width), random(height), 30, 50, 1, 2, 1.5, 7, 25);
  }
  
  // Speeder constructor for boss_spawn_enemy();
    Speeder(float x, float y)
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed, experience_drop, score_increase)
    super(x, y, 30, 50, 1, 2, 1.5, 0, 0);
  }
   
  void display() 
  {
    super.display();
    fill(0, 100, 200);
    //circle(x, y, 25);
    
    imageMode(CENTER);
    if(facing_left)
    {
      image(speeder_left_image, x, y, 30, 50);
    }
    else if(facing_right)
    {
      image(speeder_right_image, x, y, 30, 50); 
    }
  }
}
