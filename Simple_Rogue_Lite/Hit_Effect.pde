class Hit_Effect extends Effect
{
  // Initialize variables
  float speed;
  float angle;
  float rotation;

  Hit_Effect(float x, float y, int duration, float speed) 
  {
    super(x, y, duration);
    this.speed = speed;
    this.angle = random(TWO_PI);
    this.rotation = random(TWO_PI); 
  }

  // Display method for Hit Effect
  void display() 
  {
    fill(255, 255, 0);
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    // Update position based on angle and speed
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    draw_star(0, 0, 8, 4, 5);
    popMatrix();
  }
}

// Method to draw star
 void draw_star(float x, float y, float radius_1, float radius_2, int n_points) 
 {
  float angle = TWO_PI / n_points;
  float half_angle = angle / 2.0;
  beginShape();
  for (float i = 0; i < TWO_PI; i += angle) 
  {
    float s_x = x + cos(i) * radius_2;
    float s_y = y + sin(i) * radius_2;
    vertex(s_x, s_y);
    s_x = x + cos(i + half_angle) * radius_1;
    s_y = y + sin(i +half_angle) * radius_1;
    vertex(s_x, s_y);
  }
  endShape(CLOSE);
}

// Method to start a new hit effect, spawn number of effects based on argument
void start_hit_effect(float x, float y, int num_effects) 
{
  for (int i = 0; i < num_effects; i++) 
  {
    effects.add(new Hit_Effect(x, y, 250, 3));
  }
}
