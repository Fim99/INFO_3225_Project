class Death_Effect extends Effect 
{
  // Initialize variables
  float rotation;

  Death_Effect(float x, float y, int duration) 
  {
    super(x, y, duration);
    this.rotation = random(TWO_PI);
  }

  // Display method for Death Effect
  void display() 
  {
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    image(death_effect_image, 0, 0, 50, 50); 
    popMatrix();
  }
}

// Method to start a new death effect
void start_death_effect(float x, float y) 
{
  effects.add(new Death_Effect(x, y, 150));
}
