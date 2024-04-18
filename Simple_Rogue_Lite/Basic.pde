class Basic extends Enemy
{
  // Basic constructor 
  Basic(float x, float y, float hitbox_length, float hitbox_width, float health ,float damage, float speed, float experience_drop, float score_increase)
  {
    super(x, y, hitbox_length, hitbox_width, health, damage, speed, experience_drop, score_increase);
  }
  
  // Basic constructor with default values
  Basic()
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed, experience_drop, score_increase)
    super(random(width), random(height), 50, 50, 1, 1, 0.5, 2, 10);
  }
   
  void display() 
  {
    super.display();
    fill(0, 100, 200);
    //circle(x, y, 25);
    
    imageMode(CENTER);
    if(facing_left)
    {
      image(basic_left_image, x, y, 50, 50);
    }
    else if(facing_right)
    {
      image(basic_right_image, x, y, 50, 50); 
    }
  }
}
