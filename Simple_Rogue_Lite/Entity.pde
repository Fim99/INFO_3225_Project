abstract class Entity implements Moveable, Display 
{
  // Initilaize variables for all objects of type Entity
  float x, y, add_x, add_y, prev_x, health, damage, speed, hitbox_length, hitbox_width;
  boolean facing_left = false, facing_right = true;
  
  // Entity Constructor
  Entity(float x, float y, float hitbox_length, float hitbox_width, float health ,float damage, float speed)
  {
    this.x = x;
    this.y = y;
    this.hitbox_length = hitbox_length;
    this.hitbox_width = hitbox_width;
    this.health = health;
    this.damage = damage;
    this.speed = speed;
  }
  
  // Entity Constructor with default values
  Entity()
  {
    // (x, y, hitbox_length, hitbox_width, health ,damage, speed)
    this(width / 2, height / 2, 25, 25, 25, 1, 1);
  }
  
  // move method for all entities, add_x and add_y are added to the entity's current coords
 void move(float add_x, float add_y)
  {
    this.add_x = add_x;
    this.add_y = add_y;
    
    // Store the previous x position
    prev_x = x;
    
    this.x = x + add_x;
    this.y = y + add_y;
    
    // Update facing direction based on movement
    if (x < prev_x) 
    {
      facing_left = true;
      facing_right = false;
    } 
    else if (x > prev_x) 
    {
      facing_left = false;
      facing_right = true;
    }
  }
  
  // collision detection method used to determine if two entities have collided
  boolean collision(Entity other) 
  {
    // Calculate bounding box coordinates for both entities
    float left1 = x - hitbox_length / 2;
    float right1 = x + hitbox_length / 2;
    float top1 = y - hitbox_width / 2;
    float bottom1 = y + hitbox_width / 2;
  
    float left2 = other.x - other.hitbox_length / 2;
    float right2 = other.x + other.hitbox_length / 2;
    float top2 = other.y - other.hitbox_width / 2;
    float bottom2 = other.y + other.hitbox_width / 2;
   
    // Check for collision using AABB collision detection
    if (left1 < right2 && right1 > left2 && top1 < bottom2 && bottom1 > top2) 
    {
        return true;
    } 
    else 
    {
        return false;
    }
  }
  
  void take_damage(Entity other)
  {
    health = health - other.damage;
  }
  
  // display hitbox for entity
  void display_hitbox() 
  {
    // Calculate bounding box coordinates for the entity
    float left = x - hitbox_length / 2;
    float right = x + hitbox_length / 2;
    float top = y - hitbox_width / 2;
    float bottom = y + hitbox_width / 2;
  
    // Draw lines for the hitbox
    stroke(0);
    line(left, top, right, top);      
    line(right, top, right, bottom);  
    line(right, bottom, left, bottom);
    line(left, bottom, left, top);
    noStroke();
  }
  
  // basic display for all entities
  void display()
  {
    noStroke();
    rectMode(CENTER);
  }
}

// Interfaces Moveable and Display that all entities must implement
interface Moveable
{
  void move(float add_x, float add_y);
}

interface Display
{
  void display();
}
