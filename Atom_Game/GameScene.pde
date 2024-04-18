// This class holds the particles in the scene and keeps track of score
int size = 50, customFilterStartTime = -1000;
int totalScore = 0;

String[][] elementsArray = ElementsData.elementsArray;

class GameScene
{
  int score;
  ArrayList<Particle> inSceneParticles;
  ArrayList<Particle> inArenaParticles;
  Particle currentParticle;
  
  GameScene(int score)
  {
    this.score = score;
    inSceneParticles = new ArrayList<Particle>();
    inArenaParticles = new ArrayList<Particle>();
  }
  
  // Add particle to the scene
  void addParticle(Particle particle)
  {
    inSceneParticles.add(particle);
  }
  
  // Display all particles in the scene
  void update()
  {
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text(score, width / 2, 100);
  
    currentParticle.display();
  
    for (Particle particle : inSceneParticles)
    {
      particle.display();
  
      // Check if the particle is an instance of Element
      if (particle instanceof Element)
      {
        ((Element) particle).isMouseOver();
      }
    }
  
    if (isCustomFilterActive()) 
    {
      customFilter();
    }
  }

  
  void generateRandomParticle(GameScene scene)
  {
    float randomIndex = random(1, 100);
    
    if (randomIndex <= 70)
    {
      generateRandomElement(scene);
    }   
    
    else
    {
      generateRadomChargedParticle(scene);
    }    
  }
  
  void generateRandomElement(GameScene scene)
  {
    int randomIndex = 0;
    
    if (score < 2000) 
    {
      randomIndex = int(random(0, (elementsArray.length) - 80));
    } 
    
    else if (score < 10000) 
    {
      randomIndex = int(random(20, (elementsArray.length) - 60));
    } 
    
    else if (score < 25000) 
    {
      randomIndex = int(random(40, (elementsArray.length) - 40));
    } 
    
    else if (score < 40000) 
    {
      randomIndex = int(random(60, (elementsArray.length) - 20));
    } 
    
    else 
    {
      randomIndex = int(random(80, elementsArray.length));
    }
      
    String symbol = elementsArray[randomIndex][0];
    int atomicNumber = Integer.parseInt(elementsArray[randomIndex][1]);
    color particleColor = color(random(245), random(245), random(245));
    String name = elementsArray[randomIndex][2];
    
    Element element = new Element(size, width / 2, 400, atomicNumber, symbol, name, particleColor);
    scene.addParticle(element);
    currentParticle = element;
    
  }
  
  void generateRadomChargedParticle(GameScene scene)
  {
    float randomIndex = random(1, 100);
    
    if (randomIndex <= 80)
    {
      PositiveParticle positive = new PositiveParticle(size, width / 2, 400);
      scene.addParticle(positive);
      currentParticle = positive;
    }   
    
    else
    {
      NegativeParticle negative = new NegativeParticle(size, width / 2, 400);
      scene.addParticle(negative);
      currentParticle = negative;
    }    
  }
  
  void generateAllElements(GameScene scene) 
  {
    int x = 25;  
    int y = 25;  
  
    for (int i = 0; i < elementsArray.length; i++) 
    {
      String symbol = elementsArray[i][0];
      int atomicNumber = Integer.parseInt(elementsArray[i][1]);
      color particleColor = color(random(245), random(245), random(245));
      String name = elementsArray[i][2];
  
      Element element = new Element(size, x, y, atomicNumber, symbol, name, particleColor);
      
      scene.addParticle(element);
      x = x + 50;
  
      if ((i + 1) % 10 == 0) 
      {
        x = 25;
        y = y + 50;
      }
    }
  }
  
  void overrideCurrent()
  {
    if (!inSceneParticles.isEmpty()) 
    {
        inSceneParticles.remove(inSceneParticles.size() - 1);
    }

    NegativeParticle negative = new NegativeParticle(size, width / 2, 400);
    inSceneParticles.add(negative);
    currentParticle = negative;
    customFilterStartTime = millis();
  }
  
  void clearInScene(GameScene scene) 
  {
    scene.inArenaParticles.clear();
    scene.inSceneParticles.clear();
    scene.generateRandomParticle(scene);
  }

  
  void addToArena(Particle currentParticle, float mouseX) 
  {
    // Set the y-coordinate to the bottom of the screen
    float target_Y = height / 1.25;
    
    // If the mouseX is within the existing particles in the arena, insert the new particle there
    for (int i = 0; i < inArenaParticles.size(); i++) 
    {
      Particle existingParticle = inArenaParticles.get(i);
      float particleX = existingParticle.x;
      
      if (mouseX < particleX) 
      {
        inArenaParticles.add(i, currentParticle);
        currentParticle.shift(mouseX, target_Y);
        arrangeParticles();
        return;
      }
    }

    // If mouseX is beyond existing particles, add the new particle at the end
    inArenaParticles.add(currentParticle);
    currentParticle.shift(mouseX, target_Y);
    arrangeParticles();
  }
  
  void shiftToArena(Particle particle, float target_X) 
  {
    float target_Y = height / 1.25;
    particle.shift(target_X, target_Y);
  }
  
  void arrangeParticles() 
  {
    if (inArenaParticles.isEmpty()) 
    {
      return;
    }
  
    // Calculate the spacing between particles
    float particleSpacing = width / (float) inArenaParticles.size();
  
    float x = particleSpacing / 2;
  
    for (Particle particle : inArenaParticles) 
    {
      particle.shift(x, height / 1.25);
      x += particleSpacing;
    }
  }
  
  void score(GameScene scene) 
  {  
    for (Particle particle : scene.inArenaParticles) 
    {
      if (particle instanceof Element) 
      {
        totalScore = totalScore + ((Element) particle).atomicNum;
      }
    }
    scene.score = totalScore;
  }

  void printParticles()
  {
    for (Particle particle : inSceneParticles)
    {
      System.out.println("in Scene " + particle.symbol);
    }
        for (Particle particle : inArenaParticles)
    {
      System.out.println("in Arena " + particle.symbol);
    }
    System.out.println("Current " + currentParticle.symbol);
  }
  
  void customFilter() 
  {
    float r = 0;
    float g = 0;
    float b = 0;
    
    loadPixels();
    for (int x = 0; x < width; x++) 
    { 
      for (int y = 0; y < height; y++) 
      { 
        int index = x + y * width;
        color c = pixels[index];
        
          r = red(c) / 2;
          g = green(c) / 2;
          b = blue(c) / 2;    
          
        pixels[index] = color(r, g, b);
      }
    }
    updatePixels();
  }
  
  boolean isCustomFilterActive() 
  {
    return millis() - customFilterStartTime < 1000;
  }
}
