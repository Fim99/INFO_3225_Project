class Giant extends Boss
{
  // Giant constructor 
  Giant(float x, float y, float hitbox_length, float hitbox_width, float health ,float damage, float speed, float experience_drop, float score_increase, String name)
  {
    super(x, y, hitbox_length, hitbox_width, health, damage, speed, experience_drop, score_increase, name);
  }
  
  // Giant constructor with default values
  Giant()
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed, experience_drop, score_increase)
    super(random(width), random(height), 75, 75, 100, 100, 0.4, 50, 300, "GIANT");
  }
  
  void display()
  {
    super.display();
    fill(50, 200, 0);
    //circle(x, y, 75);
    
    imageMode(CENTER);
    if(facing_left)
    {
      image(giant_left_image, x, y, 75, 75);
    }
    else if(facing_right)
    {
      image(giant_right_image, x, y, 75, 75); 
    }
  }    
}
