class Player_Projectile extends Projectile
{
  PVector direction;
  
  // Basic_Projectile constructor
  Player_Projectile(float x, float y, float hitbox_length, float hitbox_width, float health ,float damage, float speed)
  {
    super(x, y, hitbox_length, hitbox_width, health, damage, speed);
    
    // Calculate direction vector from player to initial mouse click
    float dir_x = mouseX - x;
    float dir_y = mouseY - y;
    float magnitude = sqrt(dir_x * dir_x + dir_y * dir_y);
    direction = new PVector(dir_x / magnitude, dir_y / magnitude);
  }
  
  // Basic_Projectile constructor with default values
  Player_Projectile()
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed)
    this(player.x, player.y, 15, 15, 1, player.damage, player.proj_speed);
  }
  
  void display()
  {
    super.display();
    fill(125);
    //circle(x, y, 10);
    image(player_projectile_image, x, y, 15, 15);
  }
  
  void update() 
  {
    if(!is_paused)
    {
      float add_x = direction.x * speed;
      float add_y = direction.y * speed;
      
      move(add_x, add_y);
    }
  }
}
