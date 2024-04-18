// ArrayList to hold effects
ArrayList<Effect> effects = new ArrayList<Effect>();

// Abstract class to represent an effect
abstract class Effect implements Display 
{
  float x, y;
  int start_time;
  int duration;
  
  Effect(float x, float y, int duration) 
  {
    this.x = x;
    this.y = y;
    this.duration = duration;
    this.start_time = millis();
  }
  
  boolean is_active() 
  {
    return millis() - start_time < duration;
  }
}

void update_effects() 
{
  for (int i = effects.size() - 1; i >= 0; i--) 
  {
    Effect effect = effects.get(i);
    
    // Draw the effect at the given position for each instance
    if (effect instanceof Death_Effect) 
    {
      Death_Effect death_effect = (Death_Effect) effect;
      death_effect.display();
    }
    else if (effect instanceof Hit_Effect)
    {
      Hit_Effect hit_effect = (Hit_Effect) effect;
      hit_effect.display();
    }
    
    // Check if the effect duration has passed
    if (!effect.is_active()) 
    {
      effects.remove(i);
    }
  }
}
