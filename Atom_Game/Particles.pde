// Abstract class that all particles inherit
abstract class Particle implements Moveable, Display
{
  int size; 
  float x, y, add_X, add_Y;
  String symbol;

  Particle(int size, float x, float y, String symbol) 
  {
    this.size = size;
    this.x = x;
    this.y = y;
    this.symbol = symbol;
  }

  void move(float x, float y) 
  {
    this.x = x;
    this.y = y;
  }
   
  void shift(float target_X, float target_Y) 
  {
    // Adjust the easing value to change animation speed
    float easing = 0.05;
    this.add_X = (target_X - this.x) * easing;
    this.add_Y = (target_Y - this.y) * easing;
    
    pushMatrix();
    translate(this.x, this.y);
    this.x += this.add_X;
    this.y += this.add_Y;
    popMatrix();
  }
  
  String getSymbol() 
  {
    return symbol;
  }

  void display() 
  {
    noStroke();
    ellipse(x, y, size, size);
  }
}

// class to define elements
class Element extends Particle 
{
  int atomicNum;
  String name;
  color c;
  boolean isHovered;

  // pass size, x, y, atomicNum, symbol, color
  Element(int size, float x, float y, int atomicNum, String symbol, String name, color c)
  {
    super(size, x, y, symbol);
    this.atomicNum = atomicNum;
    this.name = name;
    this.c = c;
    this.isHovered = false;
  }

  // display element with symbol and atomic number
  void display() 
  { 
    if (isMouseOver()) 
    {
      isHovered = true;
    } 
    
    else 
    {
      isHovered = false;
    }
    
    float brightness;
    
    if (isHovered) 
    {
      brightness = 10;
    } 
    
    else 
    {
      brightness = 255;
    }
    
    fill(c, brightness);
    super.display();
    fill(255);
    textAlign(CENTER);
    textSize(15);
    text(symbol, x, y + 2);
    textSize(10);
    text(atomicNum, x, y + 14);
  }
  
  boolean isMouseOver() 
  {
    float distance = dist(mouseX, mouseY, x, y);
    if (distance < size / 2) 
    {
      displayElementData();
      return true;
    } 
    else 
    {
      return false;
    }
  }
  
  void displayElementData() 
  {
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text("Element Name: " + name, width - 300, height - height + 30);
    text("Symbol: " + symbol, width - 300, height - height + 50);
    text("Atomic Number: " + atomicNum, width - 300, height - height + 70);
    textAlign(CENTER);
  }
}

// abstract class for all charged particles
abstract class ChargedParticle extends Particle 
{
  ChargedParticle(int size, float x, float y, String symbol) 
  {
    super(size, x, y, symbol);
  }

  void display()
  {
    textSize(20);
    pushMatrix();
    translate(x, y);
    beginShape();
    float angleOff = TWO_PI / 6.0;
    for (int i = 0; i < 6; i++)
    {
      float angle = i * angleOff;
      float px = cos(angle) * size / 2;
      float py = sin(angle) * size / 2;
      vertex(px, py);
    }
    endShape(CLOSE);
    popMatrix();
  }
}

class PositiveParticle extends ChargedParticle 
{
  PositiveParticle(int size, float x, float y) 
  {
    super(size, x, y, "+");
  }

  void display() 
  {
    fill(255, 0, 0);
    super.display();
    fill(255);
    text("+", x, y + 8);
  }
}

class NegativeParticle extends ChargedParticle 
{
  NegativeParticle(int size, float x, float y)
  {
    super(size, x, y, "-");
  }

  void display() 
  {
    fill(0, 0, 255);
    super.display();
    fill(255);
    text("-", x, y + 7);
  }
}

class BackgroundParticle extends Particle
{
  float rotationAngle;
  int blueness;
  boolean isPressed;

  BackgroundParticle(int size, float x, float y)
  {
    super(size, x, y, "■");
    rotationAngle = 0;
    isPressed = false;
    // Set a random direction once during initialization
    float angle = random(TWO_PI);
    float speed = 2;
    add_X = cos(angle) * speed;
    add_Y = sin(angle) * speed;
  }

  void moveRandomDirection()
  {
    move(x + add_X, y + add_Y);
    rotationAngle += 0.1;
  }

  void display()
  {
    fill(255 - blueness, 255 - blueness, 255);
    pushMatrix();
    translate(x, y);
    rotate(rotationAngle);
    rectMode(CENTER);
    rect(0, 0, size, size);       
    
    rotate(-rotationAngle * 2);
    triangle(0, 0, size, 0, size , size); 
    
    rotate(PI / 2); 
    triangle(0, 0, size, 0, size , size);
    
    rotate(PI / 2);
    triangle(0, 0, size, 0, size , size); 
    
    rotate(PI / 2);
    triangle(0, 0, size, 0, size  , size);
    
    popMatrix();
  }

  void changeMotion(float newSpeed)
  {
    // Change the motion of the particle
    if (!isPressed) 
    {
      float angle = random(TWO_PI);
      add_X = cos(angle) * newSpeed;
      add_Y = sin(angle) * newSpeed;
      blueness = 255;
      isPressed = true;
    }
  }
}

class BackgroundParticles
{
  int pressCount = 0, pressAmount;
  ArrayList<BackgroundParticle> bgparticles;
  

  BackgroundParticles()
  {
    bgparticles = new ArrayList<BackgroundParticle>();
  }

  void addParticle(BackgroundParticle particle)
  {
    bgparticles.add(particle);
  }

  void update()
  {
    for (BackgroundParticle particle : bgparticles)
    {
      particle.display();
      particle.moveRandomDirection();
    }
  }

  void resetParticles(int numParticles)
  {
    bgparticles.clear();
    for (int i = 0; i < numParticles; i++) 
    {
      addParticle(new BackgroundParticle(20, random(width), random(height)));
      pressCount = 0;
    }
  }

  void bgParticlePressed(GameScene scene)
  {
    boolean anyParticlePressed = false;
    
    // Check if any particle is pressed
    for (BackgroundParticle particle : bgparticles)
    {
      float distance = dist(mouseX, mouseY, particle.x, particle.y);
      if (distance < particle.size && !particle.isPressed)
      {
        anyParticlePressed = true;
        float newSpeed = random(1, 3);
        particle.changeMotion(newSpeed);
        particle.isPressed = true;
        pressCount++;
      }
    }
  
    if (anyParticlePressed && pressCount > 2)
    {
      scene.overrideCurrent();
      pressCount = 0;
    }
  }
}

interface Moveable 
{
  void move(float deltaX, float deltaY);
  void shift(float deltaX, float deltaY);
}

interface Display
{
  void display(); 
}
