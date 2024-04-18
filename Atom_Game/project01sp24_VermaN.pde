GameScene scene;
BackgroundParticles backgroundParticles;

int particleResetInterval = 6000;
int lastResetTime = 0;
boolean allDisplayed = false;
PImage bg;

PFont font;

void setup()
{
  frameRate(60);
  size(1000, 800);
   bg = loadImage("bg.png");
  background(bg);

  font = createFont("Arial Bold", 14);
  textFont(font);
  
  scene = new GameScene(0);
  backgroundParticles = new BackgroundParticles();
   
  scene.generateRandomElement(scene);
  backgroundParticles.resetParticles(10);
  
  //scene.generateAllElements(scene);
  
  // Create Element pass size, x, y, atomicNum, symbol, color
}

void draw()
{
  background(bg);
  textSize(14);
  text("press 'space' over 3 background particles before they reset\n to get a guaranteed negative particle!", width / 2, height - height + 200);
  text("hover over elements to see thier data", width / 2, height - height + 690);
  text("press 'space' to interact with background particles", width / 2, height - height + 710);
  text("press 'c' to clear scene and or elements GUI", width / 2, height - height + 730);
  text("press 'g' to show all elements GUI", width / 2, height - height + 750);
  text("press 'r' to reset the game", width / 2, height - height + 770);
  stroke(255);
  line(50, height / 1.25, 950, height / 1.25);
  noStroke();
  backgroundParticles.update();
  scene.update();
  scene.arrangeParticles();
  
  if (millis() - lastResetTime > particleResetInterval) 
  {
    backgroundParticles.resetParticles(10);
    lastResetTime = millis();
  } 
}

void mousePressed() 
{ 
  if (scene.inArenaParticles.size() < 20) 
  {
    scene.addToArena(scene.currentParticle, mouseX);
    scene.shiftToArena(scene.currentParticle, mouseX);
    scene.generateRandomParticle(scene);
    scene.score(scene);
  }
  else
  {
    scene.clearInScene(scene);
  }
}

void keyPressed() 
{
  if (key == ' ')
  {
    backgroundParticles.bgParticlePressed(scene);
  }
  if (key == 'c')
  {
    scene.clearInScene(scene);
  }
  if (key == 'p')
  {
    scene.printParticles();
  }
  if (key == 'g')
  {
    if(!allDisplayed)
    {
      scene.generateAllElements(scene);
      allDisplayed = true;
    }
    else
    {
      scene.clearInScene(scene);
      allDisplayed = false;
    }
  }
  if (key == 'r')
  {
    totalScore = 0;
    scene.clearInScene(scene);
    scene.score(scene);
  }
}
