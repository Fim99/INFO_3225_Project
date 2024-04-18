Player player;
Button start_button, main_button, leaderboard_button, quit_button, select_button_1, select_button_2, select_button_3;
int score = 0, wave = 0;
float total_defeated, total_experience, difficulty = 1;
boolean display_hitbox = false, is_paused = false, is_dead = false, is_selecting = false, is_reset = false, is_invincible = false;
String current_screen;
String[] random_stat;
ArrayList<Enemy> arena_enemies = new ArrayList<Enemy>();
ArrayList<Player_Projectile> player_projectiles = new ArrayList<Player_Projectile>();
PFont font;
PImage background, death_effect_image;
Table table;

PImage player_image, player_projectile_image, 
basic_left_image, basic_right_image, 
advanced_left_image, advanced_right_image, 
speeder_left_image, speeder_right_image, 
giant_left_image, giant_right_image;


// Explain the point of the game
// Explain the scribble theme
// Explain HUD
// Show random level up, and how stats work
// Show all enemies such as boss and effects
// Show maxed out player and how difficulty works
// Show command keys 
// Show leaderboard
// Explain leaderboard sort
// Explain code

void setup()
{
  // Initial Setup
  frameRate(60);
  size(800, 800);
  background(125);
  noStroke();

  // Load font and background, set current screen to "MAIN SCREEN"
  font = createFont("PipersPlayroom.ttf", 128);
  textFont(font);
  background = loadImage("paper.jpg");
  
  // Load Effects
  death_effect_image = loadImage("Death_Effect.png");
  
  // Load Sprites
  player_image = loadImage("Player.png");
  player_projectile_image = loadImage("Player-Projectile.png");
  basic_left_image = loadImage("Basic-Left.png");
  basic_right_image = loadImage("Basic-Right.png");
  advanced_left_image = loadImage("Advanced-Left.png");
  advanced_right_image = loadImage("Advanced-Right.png"); 
  speeder_left_image = loadImage("Speeder-Left.png");
  speeder_right_image = loadImage("Speeder-Right.png");
  giant_left_image = loadImage("Giant-Left.png");
  giant_right_image = loadImage("Giant-Right.png");
  
  // set current screen to "MAIN SCREEN"
  current_screen = "MAIN SCREEN";
  
  // load leaderboard table
  table = loadTable("data/leaderboard.csv", "header");

  // Create new player
  player = new Player();

  // Create Buttons
  start_button = new Button();
  leaderboard_button = new Button();
  main_button = new Button();
  quit_button = new Button();
}

// draw screen based of current_screen 
void draw()
{
  switch(current_screen)
  {
  case "MAIN SCREEN":
    if (!is_reset)
    {
      reset_game();
      reset_buttons();
    }
    draw_main_screen();
    break;

  case "GAME SCREEN":
    if (!is_reset)
    {
      reset_game();
      reset_buttons();
    }
    draw_game_screen();
    break;

  case "LEADERBOARD SCREEN":
    if (!is_reset)
    {
      reset_game();
      reset_buttons();
      sort_leaderboard();
    }
    draw_leaderboard_screen();
    break;

  case "DEATH SCREEN":
    if (is_dead)
    {
      draw_death_screen();
    }
    break;
  }
}

void draw_game_screen()
{
  background(background);

  difficulty_logic();
  enemy_updates();
  projectile_updates();
  player_updates();
  player.display_stats();

  // If player is selecting, draw selection buttons and pause
  if (is_selecting && !is_dead)
  {
    is_paused = true;

    // Info text
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(20);
    text("CHOOSE A STAT TO INCREASE", width / 2, height / 2 - 125);
    textSize(60);
    text("LEVEL UP", width / 2, height / 2 - 200);

    // Buttons for selections and display()
    select_button_1 = new Button(width / 2 - 150, height / 2 - 75, 300, 50, color(0, 0, 0, 150), color(255), random_stat[0]);
    select_button_2 = new Button(width / 2 - 150, height / 2, 300, 50, color(0, 0, 0, 150), color(255), random_stat[1]);
    select_button_3 = new Button(width / 2  -150, height / 2 + 75, 300, 50, color(0, 0, 0, 150), color(255), random_stat[2]);

    select_button_1.display();
    select_button_2.display();
    select_button_3.display();
  }

  // --- Display score and dead / paused ---
  if (is_dead)
  {
    player.health = 0;
    is_paused = true;
    current_screen = "DEATH SCREEN";
  }

  if (is_paused && !is_dead && !is_selecting)
  {
    textSize(70);
    textAlign(CENTER, CENTER);
    fill(0);
    text("PAUSED", width / 2, height / 2);
  }

  textSize(25);
  textAlign(CENTER, CENTER);
  fill(0);
  text("SCORE: " + score, width / 2, 50);
}

// Draw main screen
void draw_main_screen()
{
  textSize(70);
  textAlign(CENTER, CENTER);
  background(background);
  fill(0);
  text("SCRIBBLE SURVIVAL", width / 2, height / 2 - 150);

  // Create Button's
  // Button(x, y, button_width, button_height, background_color, text_color, label)
  start_button = new Button(width / 2 - 100, height / 2 - 75, 200, 50, color(0, 0, 0, 150), color(255), "START GAME");
  leaderboard_button = new Button(width / 2 - 100, height / 2, 200, 50, color(0, 0, 0, 150), color(255), "LEADERBOARD");
  quit_button = new Button(width / 2 - 100, height / 2 + 75, 200, 50, color(0, 0, 0, 150), color(255), "QUIT");

  start_button.display();
  leaderboard_button.display();
  quit_button.display();
}

// Draw death screen
void draw_death_screen()
{
  textSize(70);
  textAlign(CENTER, CENTER);
  fill(125, 0, 0);
  text("DEAD", width / 2, height / 2 - 150);

  // Create Button's
  // Button(x, y, button_width, button_height, background_color, text_color, label)
  start_button = new Button(width / 2 - 100, height / 2 - 75, 200, 50, color(120, 0, 0, 255), color(255), "PLAY AGAIN");
  main_button = new Button(width / 2 - 100, height / 2, 200, 50, color(120, 0, 0, 255), color(255), "MAIN MENU");
  leaderboard_button = new Button(width / 2 - 100, height / 2 + 75, 200, 50, color(120, 0, 0, 255), color(255), "LEADERBOARD");

  start_button.display();
  main_button.display();
  leaderboard_button.display();
}

void draw_leaderboard_screen()
{
  textSize(70);
  textAlign(CENTER, CENTER);
  background(background);
  fill(0);
  text("LEADERBOARD", width / 2, height / 2 - 360);
  
  // Load leaderboard.csv table
  table = loadTable("data/leaderboard.csv", "header");
  
  float start_y = 100; 
  float row_height = 50;
  int count = 1;
  
  //println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) 
  {
    float leaderboard_score = row.getFloat("Score");
    float leaderboard_defeated = row.getFloat("Defeated");
    float leaderboard_experience = row.getFloat("Experience");
    
    // Display top 3 as gold, silver, bronze
    if (count == 1)
    {
      fill(200, 200, 0, 200);
    }
    else if (count == 2)
    {
      fill(150, 150, 130, 200);
    }
    else if (count == 3)
    {
      fill(160, 80, 0, 200);
    }
    else
    {
      fill(0, 0, 0, 150);
    }
    
    // Display row on screen
    rectMode(CENTER);
    rect(width / 2, start_y, 400, row_height - 15);
    
    fill(255);
    textSize(24);
    textAlign(CENTER, CENTER);
    text(count + ". Score: " + (int) leaderboard_score + ", Defeated: " + (int) leaderboard_defeated + ", Experience: " + (int) leaderboard_experience, width / 2, start_y);
    
    // Increment start_y for next row and count
    start_y += row_height;
    count += 1;
  }
  
  // Call search leaderboard method
  search_leaderboard_by_defeated();

  // Create Button's
  // Button(x, y, button_width, button_height, background_color, text_color, label)
  start_button = new Button(width / 2 - 100, height / 2 + 250, 200, 50, color(0, 0, 0, 150), color(255), "START GAME");
  main_button = new Button(width / 2 - 100, height / 2 + 325, 200, 50, color(0, 0, 0, 150), color(255), "MAIN MENU");

  start_button.display();
  main_button.display();
}

// --- Logic for difficulty increase ---
void difficulty_logic() 
{
  // Increase difficulty based on level
  difficulty = player.level / 1.5;
    
  // Check if the arena is empty
  if (arena_enemies.isEmpty()) 
  {
    wave += 1;
    // Add Basic enemies based on difficulty
    for (int i = 0; i < 2 * difficulty; i++) 
    {
      arena_enemies.add(new Basic());
    }
    
    // Add Advanced enemies based on difficulty
    for (int i = 0; i < 1 * difficulty; i++) 
    {
      arena_enemies.add(new Advanced());
    }
    
    // Add Advanced enemies based on difficulty
    for (int i = 0; i < 1 * difficulty; i++) 
    {
      arena_enemies.add(new Speeder());
    }
    
    if (wave % 10 == 0)
    {
      arena_enemies.add(new Giant());
    }
    
  }
}

// --- Do updates for each enemy ---
void enemy_updates()
{
  ArrayList<Enemy> enemies_to_remove = new ArrayList<>();
  for (int i = arena_enemies.size() - 1; i >= 0; i--)
  {
    Enemy enemy = arena_enemies.get(i);
    enemy.display();
    if (display_hitbox)
    {
      enemy.display_hitbox();
    }
    enemy.update(player);

    // Check player projectile collision with enemies
    for (int j = player_projectiles.size() - 1; j >= 0; j--)
    {
      Player_Projectile projectile = player_projectiles.get(j);
      if (projectile.collision(enemy))
      {
        // Take damage and remove projectile and enemy if collision detected
        player_projectiles.remove(j);
        enemy.take_damage(projectile);
        start_hit_effect(enemy.x, enemy.y, 5);
        if (enemy.health <= 0)
        {
          // Add enemy to array if health is depleted
          enemies_to_remove.add(enemy);
        }
        break;
      }
    }

    // Add the enemy to ArrayList collided with
    if (player.collision(enemy))
    {
      // Take damage and remove enemy if collision is detected
      if(!is_invincible)
      {
        player.take_damage(enemy);
      }
      start_hit_effect(enemy.x, enemy.y, 5);
      enemies_to_remove.add(enemy);
    }
  }
  // Loop through ArrayList to remove enemy and call required methods 
  for (Enemy enemy : enemies_to_remove) 
  {
    total_defeated += 1;
    start_death_effect(enemy.x, enemy.y);
    enemy.give_experience(player);
    enemy.give_score_increase();
    arena_enemies.remove(enemy);
  }
}

// --- Do updates for each player projectile and check for click using player.shoot() ---
void projectile_updates()
{
  player.shoot();
  for (int i = player_projectiles.size() - 1; i >= 0; i--)
  {
    Player_Projectile projectile = player_projectiles.get(i);
    projectile.display();
    if (display_hitbox)
    {
      projectile.display_hitbox();
    }
    projectile.update();

    // Check if the player projectile hits the screen edges
    if (projectile.x < 0 ||projectile.x > width || projectile.y < 0 || projectile.y > height)
    {
      player_projectiles.remove(i);
    }
  }
}

// --- Do updates for player ---
void player_updates()
{
  player.display();
  if (display_hitbox)
  {
    player.display_hitbox();
  }
  player.update();
  player.check_regen();
  update_effects();

  if (player.check_level_up() && !is_dead)
  {
    is_selecting =  true;
    random_stat = player.random_stat();
  }

  if (player.health <= 0)
  {
    save_score(score);
    is_dead = true;
  }
}

// Reset game
void reset_game()
{
  score = 0;
  wave = 0;
  total_defeated = 0;
  total_experience = 0;
  difficulty = 0;
  display_hitbox = false;
  is_paused = false;
  is_dead = false;
  is_selecting = false;
  is_invincible = false;
  arena_enemies.clear();
  player_projectiles.clear();
  player.reset_player();
  effects.clear();
  is_reset = true;
}

// Save current runs score into leaderboard.cvs 
void save_score(int score)
{
  TableRow new_row = table.addRow();
  new_row.setFloat("Score", score);
  new_row.setFloat("Defeated", total_defeated);
  new_row.setFloat("Experience", total_experience);
  saveTable(table, "data/leaderboard.csv");
  
  // Call sort_scoreboard() method
  sort_leaderboard();
}

// Method to sort and cull leaderboard
void sort_leaderboard() 
{
  int row_count = table.getRowCount();

  // Bubble sort algorithm to sort the leaderboard by score in descending order
  for (int i = 0; i < row_count - 1; i++) 
  {
    for (int j = 0; j < row_count - i - 1; j++) 
    {
      TableRow row_1 = table.getRow(j);
      TableRow row_2 = table.getRow(j + 1);

      float score_1 = row_1.getFloat("Score");
      float score_2 = row_2.getFloat("Score");

      if (score_1 < score_2) 
      {
        // Swap row data
        float temp_score = row_1.getFloat("Score");
        float temp_defeated = row_1.getFloat("Defeated");
        float temp_experience = row_1.getFloat("Experience");

        row_1.setFloat("Score", row_2.getFloat("Score"));
        row_1.setFloat("Defeated", row_2.getFloat("Defeated"));
        row_1.setFloat("Experience", row_2.getFloat("Experience"));

        row_2.setFloat("Score", temp_score);
        row_2.setFloat("Defeated", temp_defeated);
        row_2.setFloat("Experience", temp_experience);
      }
    }
  }
  
  // Remove excess rows if there are more than 10 rows, keep leaderboard as top 10 scores
  while (table.getRowCount() > 10) 
  {
    table.removeRow(table.getRowCount() - 1);
  }
  
  // Save the sorted table back to the csv file
  saveTable(table, "data/leaderboard.csv");
}

// Method to search and display the leaderboard row with the most Experience
void search_leaderboard_by_defeated() 
{
  // Initialize the index of the row with the highest Defeated value
  int highest_defeated_index = 0; 
  float highest_defeated = 0; 
  
  // Iterate through each row in the leaderboard table
  for (int i = 0; i < table.getRowCount(); i++) 
  {
    TableRow row = table.getRow(i);
    
    // Get the Defeated value from the current row
    float defeated = row.getFloat("Defeated");
    
    // Check if the Defeated value of the current row is higher than the current highest Defeated
    if (defeated > highest_defeated) 
    {
      highest_defeated = defeated;
      highest_defeated_index = i;
    }
  }
  
  // Display row on screen
  fill(150, 0, 0, 150);   
  rectMode(CENTER);
  rect(width / 2, height / 2 + 210, 450, 30);
  
  fill(255);
  textSize(24);
  textAlign(CENTER, CENTER);
  
  // Display the row with the highest Defeated
  if (highest_defeated_index != -1) 
  {
    TableRow highest_defeated_row = table.getRow(highest_defeated_index);
    float score = highest_defeated_row.getFloat("Score");
    float defeated = highest_defeated_row.getFloat("Defeated");
    float experience = highest_defeated_row.getFloat("Experience");
    
    text("Most defeated enemies in a run is: " + (int) defeated, width / 2, height / 2 + 210);
  } 
  else 
  {
    text("None Defeated", width / 2, height / 2 + 210);
  }
}

// Reset Buttons
void reset_buttons()
{
  start_button = null;
  leaderboard_button = null;
  main_button = null;
  quit_button = null;

  start_button = new Button();
  main_button = new Button();
  leaderboard_button = new Button();
  quit_button = new Button();
}

// Check for if button is pressed
void mousePressed()
{
  if (current_screen != "GAME SCREEN")
  {
    if (start_button.is_clicked())
    {
      //println("Start Screen Clicked");
      current_screen = "GAME SCREEN";
      is_reset = false;
    }
    if (main_button.is_clicked())
    {
      //println("Main Screen Clicked");
      current_screen = "MAIN SCREEN";
      is_reset = false;
    }
    if (leaderboard_button.is_clicked())
    {
      //println("Leaderboard Screen Clicked");
      current_screen = "LEADERBOARD SCREEN";
      is_reset = false;
    }
    if (quit_button.is_clicked())
    {
      exit();
    }
  }

  if (!is_dead && current_screen == "GAME SCREEN" && is_selecting)
  {
    if (select_button_1.is_clicked())
    {
      player.increase_stat(random_stat[0]);
      is_selecting = false;
      is_paused = false;
    }
    if (select_button_2.is_clicked())
    {
      player.increase_stat(random_stat[1]);
      is_selecting = false;
      is_paused = false;
    }
    if (select_button_3.is_clicked())
    {
      player.increase_stat(random_stat[2]);
      is_selecting = false;
      is_paused = false;
    }
  }
}

// check for key presses
void keyPressed()
{
  player.keyPressed();

  switch(key)
  {
    // Clear Enemy array
  case 'c':
    arena_enemies.clear();
    break;

    // Disable player death check
  case 'i':
    is_invincible = !is_invincible;
    break;

    // Display Hitboxes
  case 'h':
    display_hitbox = !display_hitbox;
    break;

    // Give player experience for current level
  case 'l':
    player.experience = player.max_experience;
    break;

    // Pause game
  case 'p':
    is_paused = !is_paused;
    break;

    // Reset game
  case 'r':
    reset_game();
    break;
   
    // Make max experience very high
  case 'e':
    player.max_experience = 10000000;
    break;

    // Kill Player
  case 'k':
    player.health = -100;
    is_dead = true;
    break;
    
    // Max player stats (give 100)
  case 'm':
    for (int i = 0; i < 100; i++)
    {
      player.increase_stat("MAX HEALTH");
      player.increase_stat("REGEN");
      player.increase_stat("DAMAGE");
      player.increase_stat("SPEED");
      player.increase_stat("PROJECTILE SPEED");
      player.increase_stat("FIRERATE");
      player.level += 1;
    }
    break;
  }
}

void keyReleased()
{
  player.keyReleased();
}
