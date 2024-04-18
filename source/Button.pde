class Button 
{
  // Initialize Variables
  float x, y, button_width, button_height; 
  String label;
  color default_background_color, hover_background_color, text_color;
  boolean clicked;

  // Button Constructor
  Button(float x, float y, float button_width, float button_height, color default_background_color, color text_color, String label) 
  {
    this.x = x;
    this.y = y;
    this.button_width = button_width;
    this.button_height = button_height;
    this.default_background_color = default_background_color;
    this.hover_background_color = darker_color(default_background_color);
    this.text_color = text_color;
    this.label = label;
    this.clicked = false;
  }
  
  Button() 
  {
    this(0, 0, 0, 0, color(0, 0, 0, 150), color(255), "BUTTON");
  }
  
  // Check if the button is clicked
  boolean is_clicked() 
  {
    return mouseX > x && mouseX < x + button_width && mouseY > y && mouseY < y + button_height;
  }
  
  // Check if the mouse is hovering over the button
  boolean is_hovering() 
  {
    return mouseX > x && mouseX < x + button_width && mouseY > y && mouseY < y + button_height;
  }

  // Method to calculate a darker version of a color
  color darker_color(color c) 
  {
    float factor = 50;
    float r = red(c) + factor;
    float g = green(c) + factor;
    float b = blue(c) + factor;
    return color(r, g, b);
  }

  // Display Button
  void display() 
  { 
    textSize(25);
    textAlign(CENTER, CENTER);
    
    if (is_hovering()) 
    {
      fill(hover_background_color);
    } 
    else 
    {
      fill(default_background_color);
    }
    
    rectMode(CORNER);
    rect(x, y, button_width, button_height);
    fill(text_color);
    text(label, x + button_width / 2, y + button_height / 2);
  }
}
