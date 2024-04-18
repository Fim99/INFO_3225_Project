abstract class Enemy extends Entity
{
  float experience_drop, score_increase;
  
  Enemy(float x, float y, float hitbox_length, float hitbox_width, float health ,float damage, float speed, float experience_drop, float score_increase)
  {
    super(x, y,  hitbox_length, hitbox_width, health, damage, speed);
    this.experience_drop = experience_drop;
    this.score_increase = score_increase;
  }
  
  Enemy()
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed)
    super(random(width), random(height), 25, 25, 3, 1, 1);
    this.experience_drop = 1;
    this.score_increase = 1;
  }
  
  // give experience to player
  void give_experience(Player player)
  {
    player.experience += experience_drop;
    total_experience += experience_drop;
  }
  
  void give_score_increase()
  {
    score += score_increase;
  }

  // Method to move the enemy towards the player
  void update(Player player) 
  {
    if(!is_paused)
    {
      // Calculate direction vector from the enemy to the player
      PVector direction = new PVector(player.x - x, player.y - y).normalize();
      
      // Adjust enemy's position based on the direction vector and enemy's speed
      float add_x = direction.x * speed;
      float add_y = direction.y * speed;
      
      move(add_x, add_y);
    }
  }
}
