abstract class Boss extends Enemy 
{
  float max_health;
  String name;
  int lastSpawnTime;

  // Boss constructor 
  Boss(float x, float y, float hitbox_length, float hitbox_width, float health, float damage, float speed, float experience_drop, float score_increase, String name) 
  {
      super(x, y, hitbox_length, hitbox_width, health, damage, speed, experience_drop, score_increase);
      this.max_health = health;
      this.name = name;
      lastSpawnTime = millis();
  }

  // Boss constructor with default values
  Boss() 
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed, experience_drop, score_increase)
    super(random(width), random(height), 50, 50, 100, 100, 0.4, 50, 500);
    name = "BOSS";
    lastSpawnTime = millis();
  }

  void boss_spawn_enemy() 
  {
    // Check if specified time have passed since the last spawn
    if (millis() - lastSpawnTime >= 2500) 
    {
      // Spawn a new enemy
      arena_enemies.add(new Speeder(x, y));
      // Update lastSpawnTime
      lastSpawnTime = millis();
    }
  }

  void boss_health() 
  {
    // Display boss health bar
    float boss_health = 450 * (health / max_health);

    pushMatrix();
    rectMode(CORNER);
    fill(0);
    rect(width / 2 - 225, height - 30, 450, 20);
    fill(250, 120, 10);
    rect(width / 2 - 225, height - 30, boss_health, 20);
    popMatrix();
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text((int)health, width / 2 - 200, height - 20);
    text(name, width / 2, height - 20);
    text((int)max_health, width / 2 + 200, height - 20); 
  }

  void display() 
  {
    boss_health();
    
    // Call boss_spawn_enemy method
    boss_spawn_enemy();
  }
}
