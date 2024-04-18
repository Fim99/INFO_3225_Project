class Advanced extends Enemy
{
  // Basic constructor 
  Advanced(float x, float y, float hitbox_length, float hitbox_width, float health ,float damage, float speed, float experience_drop, float score_increase)
  {
    super(x, y, hitbox_length, hitbox_width, health, damage, speed, experience_drop, score_increase);
  }
  
  // Basic constructor with default values
  Advanced()
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed, experience_drop, score_increase)
    super(random(width), random(height), 50, 50, 3, 2, 0.75, 5, 20);
  }
   
  void display() 
  {
    super.display();
    fill(50, 200, 0);
    //circle(x, y, 25);
    
    imageMode(CENTER);
    if(facing_left)
    {
      image(advanced_left_image, x, y, 50, 50);
    }
    else if(facing_right)
    {
      image(advanced_right_image, x, y, 50, 50); 
    }
  }
}
