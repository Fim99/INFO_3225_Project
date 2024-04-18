abstract class Projectile extends Entity 
{
  // Projectile constructor
  Projectile(float x, float y, float hitbox_length, float hitbox_width, float health, float damage, float speed) 
  {
    super(x, y, hitbox_length, hitbox_width, health, damage, speed);
  }

  // Projectile constructor with default values
  Projectile() 
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed)
    this(width / 2, height / 2, 5, 5, 1, 1, 1);
  }
}
