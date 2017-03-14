// --------------------
// Guess The Country Game Version 1.2
// --------------------
// Laboratório de Programação
// 10 a 13 de Abril 2016
// Autor: Ricardo Daniel Tavares Reais
// ID Mooshak: Ricardo_Reais_52333
// --------------------
// Window Resolution
final int myWidth = 1200;
final int myHeight = 700;
// Image Resolution
int imageWidth = 1200;
int imageHeight = 700;
// Colors
color windowColor;
color borderColor;
// Randomly Generated Lists
ArrayList<Integer> rCountries = new ArrayList<Integer>(); //list with random countries (i.e. country index)
ArrayList<Integer> rPositions = new ArrayList<Integer>(); //list with random positions (position A, position B, position C & position D)
ArrayList<Integer> rLandscapes = new ArrayList<Integer>(); //list with random landscapes (i.e. landscape index)
// Timer
int ellapsedTime;
int clickTime;
int secs;
int finalTime;
float averageTime;
// Mouse click
int clicker=0; //one mouse click gets the next picture
int points=0; //each correct answers gains one point
int rounds=0; //round counter
// Files
String[] filenames = {"globe.png", "frame.png", "title.png", "flag_mode.png", "name_mode.png", "star.png", "replay.png"};
String[] landscapes = {"alemanha_p1.jpg", "argentina_p1.jpg", "austria_p1.jpg", "belgica_p1.jpg", "brasil_p1.jpg", "canada_p1.jpg", "chile_p1.jpg", "croacia_p1.jpg", "cuba_p1.jpg", "espanha_p1.jpg", "estados unidos_p1.jpg", "finlandia_p1.jpg", "franca_p1.jpg", "holanda_p1.jpg", "ilhas faroe_p1.jpg", "irlanda_p1.jpg", "jamaica_p1.jpg", "malta_p1.jpg", "mexico_p1.jpg", "peru_p1.jpg", "portugal_p1.jpg", "reino unido_p1.jpg", "suecia_p1.jpg"};
String[] flags = {"alemanha.png", "argentina.png", "austria.png", "belgica.png", "brasil.png", "canada.png", "chile.png", "croacia.png", "cuba.png", "espanha.png", "estados_unidos.png", "finlandia.png", "franca.png", "holanda.png", "ilhas_faroe.png", "irlanda.png", "jamaica.png", "malta.png", "mexico.png", "peru.png", "portugal.png", "reino_unido.png", "suecia.png"};
String[] countries = {"Alemanha", "Argentina", "Austria", "Belgica", "Brasil", "Canada", "Chile", "Croacia", "Cuba", "Espanha", "Estados Unidos", "Finlandia", "Franca", "Holanda", "Ilhas Faroe", "Irlanda", "Jamaica", "Malta", "Mexico", "Peru", "Portugal", "Reino Unido", "Suecia"};
// Answers
String[] answers = new String [4]; //array with 4 answers (position A, position B, position C & position D)
int[] flagAnswers = new int [4]; //array with 4 answers (position A, position B, position C & position D)
// User Interface  & Images
PImage[] UI = new PImage[filenames.length];
PImage[] landscapesImages = new PImage[landscapes.length];
PImage[] flagsImages = new PImage[flags.length];
// Trackers
String currentCountry; //Country of the first image loaded
int currentCountryPosition; //Country position in the array of the first image loaded
int rightPosition; //Position of the correct answer (A,B,C or D)
int finalPoints; //Total Points
// Game Flags
boolean flagLoader;
boolean flagLoaded;
boolean flagStart; //Game started
boolean flagEnd; //Game ended
boolean flagModeSelection; //Game mode selection menu
boolean flagMode1; //Game mode 1 gameplay
boolean flagMode2; //Game mode 2 gameplay
// Mouse Coordinates
float x, y;
// Hit Box Dimensions
float xLeftLimit = 0;
float xRightLimit = 0; 
float yLeftLimit = 0;
float yRightLimit = 0;
// Loading screen values
int loadingX = 20; //loading bar starting size
float loadingPercentage = 0.0;
// -----------------
void settings()
{
  size(myWidth, myHeight); //Window resolution
  //fullScreen(); //Fullscreen mode
}
// -----------------
void setup()
{  
  windowColor = aliceblue;
  imageMode(CENTER);
  rectMode(CENTER);
  randomLandscapes(); //Generates a random order of landscapes
}
// -----------------
void draw()
{
  background(windowColor); 
  update(); //Timer
  //--------------------------------------------------// CRIAR UM SOUND CONTROL COM DOIS IF'S
  if(!flagLoader && !flagLoaded) //Start the setup
  {
    thread("loader");
    flagLoader=true;
  }
  else if(flagLoader && !flagLoaded) //During the setup
    drawLoading();
  else if(!flagStart && !flagModeSelection && !flagEnd && !flagLoader) //Game has not started yet
    drawStart();
  else if (flagModeSelection) //Mode selection menu
    drawModes();
  else if(flagMode1) //Gameplay in mode 1
    drawGameMode1();
  else if(flagMode2) //Gameplay in mode 2
    drawGameMode2();
  else if(flagEnd) //Game End screen
    drawEnd();    
}
// -----------------
// Loaders
void loadUI() //Load User Interface
{
  for (int i = 0; i < filenames.length; i++)
    UI[i]=loadImage(filenames[i]);
}

void loadAllImages()
{
  for (int i = 0; i < landscapes.length; i++)
    landscapesImages[i]=loadImage(landscapes[i]);
  for (int i = 0; i < flags.length; i++)
    flagsImages[i]=loadImage(flags[i]);
}

void loader() //Loads the images while the loading screen displays
{
  loadUI();
  loadAllImages();
  delay(600); // Lengthly initialization here: load stuff, compute things, etc.
  flagLoader=false; //Loader ended
  flagLoaded=true; //Loader ended
}
// -----------------
// Interface Settings
void boxSettings(boolean fill, color boxColor, boolean stroke, color strokeColor, int strokeSize, int opacity)
{
  rectMode(CENTER);
  noFill();
  noStroke();
  if(fill)
    fill(boxColor, opacity);
  if(stroke)
    stroke(strokeColor);
  strokeWeight(strokeSize);
}

void textSettings(color textColor, int size)
{
  PFont mono;
  mono = createFont("04B_30__.TTF", size);
  textFont(mono);
  fill(textColor); //Text Color
  textAlign(CENTER, CENTER); //When creating a new font from the data folder, textAlign is used instead of textMode
}
// -----------------
// Draws
void drawLoading()
{
  loadingPercentage+=0.35;
  if(loadingPercentage >= 100.0)
    loadingPercentage = 100.0;
  textSettings(black, 32);
  text("Please wait, loading...\n" + nf(loadingPercentage, 1,1) + "%", myWidth/2, myHeight/2); // nf(number, leftDigits, rightDigits) Changes number format
  boxSettings(true, cyan, false, black, 0, 255);
  rect(myWidth/2, 2 * myHeight / 3, loadingX, 20, 20);
  loadingX += 4;
  if (loadingX > myWidth)
    loadingX = myWidth;
}

void drawStart()
{
  image(UI[0], myWidth/2, myHeight/2, imageWidth, imageHeight); //Background image
  boxSettings(true, orange, true, cyan, 3, 255); 
  rect(myWidth/2-5, (myHeight/2)+250, 300, 75, 200); //Play Button
  image(UI[2], myWidth/2, myHeight/2, imageWidth, imageHeight); //Game Title & Play
}

void drawModes()
{
  image(UI[0], myWidth/2, myHeight/2, imageWidth, imageHeight); //Background image
  image(UI[2], myWidth/2, myHeight/2, imageWidth, imageHeight); // Game Title & Play
  // Flags Button
  textSettings(red, 32);
  text("HARD", myWidth/2 - 400, myHeight/2 - 100);
  image(UI[3],myWidth/2-400, myHeight/2, 300, 150); 
  textSettings(orange, 32);
  text("Country Flag\nMode", myWidth/2 - 400, myHeight/2 + 120);
  // Countries Button
  textSettings(green, 32);
  text("EASY", myWidth/2 + 400, myHeight/2 - 100);
  image(UI[4],myWidth/2 + 400, myHeight/2, 300, 150);
  textSettings(orange, 32);
  text("Country Name\nMode", myWidth/2 + 400, myHeight/2 + 120);
}

void drawGameMode1() //Country Flags
{
  drawPic(); //Main image
  drawFlags(); //Flags
  drawBoard(); //Points & Timer
}

void drawGameMode2() //Country Names
{
  drawPic(); //Main image
  drawAnswers(); //Answers
  drawBoard(); //Points & Timer
}

void drawCorrectName(int i)
{
  boxSettings(true, green, true, green, 10, 126); 
  rect((i*300)+150, (myHeight/2)+300, 300, 75, 200);     
}

void drawCorrectFlag(int i)
{
  boxSettings(true, green, true, green, 10, 126);
  rect((i*300)+150, (myHeight/2)+300, 200, 100, 3);  
}

void drawWrongName(int i)
{
  boxSettings(true, red, true, red, 10, 126);
  rect((i*300)+150, (myHeight/2)+300, 300, 75, 200);
}

void drawWrongFlag(int i)
{
  boxSettings(true, red, true, red, 10, 126);
  rect((i*300)+150, (myHeight/2)+300, 200, 100, 3);  
}

void drawBorder() //Game Frame
{
  image(UI[1], myWidth/2, myHeight/2, imageWidth, imageHeight);
}

void drawPic() //Game Image
{
  image(landscapesImages[rLandscapes.get(clicker)], (myWidth/2)-100, myHeight/2, imageWidth-200, imageHeight-80);
  drawBorder();
}

void drawBoxes() //Answers borders
{
  boxSettings(true, windowColor, true, color(#86A5FF), 3, 255);
  for(int i = 0; i<4; i++ )
    rect((i*300)+150, (myHeight/2)+300, 300, 75, 200);
}

void drawAnswers()
{
  drawBoxes(); //Answers borders
  for(int i = 0; i<4; i++ )
  {  
    textSettings(black, 32); //Text Font
    if(answers[i].length()>10) //when the string is too big to fit inside the box, lower the size
        textSize(20);
    text(answers[i], (i*300)+150, (myHeight/2)+300);
  }
}

void drawFlags()
{
  boxSettings(false, black, true, color(#86A5FF), 8, 255);
  for(int i = 0; i<4; i++ )
  {
    image(flagsImages[flagAnswers[i]], i*300 + 150, myHeight/2 + 300, 200, 100);
    rect(i*300 + 150, myHeight/2 + 300, 196, 97, 10);
  }
}

void drawBoard()
{
  boxSettings(true, windowColor, true, color(#86A5FF), 3, 255);
  rect(myWidth-130, (2*myHeight/3)-125, 250, 300, 3); //Frame
  textSettings(black, 25); //Font Settings
  
  text("Total Time:\n"+finalTime, myWidth-130, (2*myHeight)/3 - 225); //Total Timer
  text("Guess Time:\n"+secs, myWidth-130, (2*myHeight)/3 - 125); //Timer
  text("Points:\n"+points, myWidth-130, (2*myHeight)/3 - 25); //Point counter
}

void drawStars(int n, int opacity)
{
  tint(255, opacity);
  for(int i = 0; i<n; i++ )
    image(UI[5], (myWidth/2 - 100) + i*50, (2*myHeight)/3 - 325, 50, 50);
}

void drawReplay()
{
  image(UI[6], (myWidth*5)/6, (2*myHeight)/3 - 125, 100, 100);
  textSettings(black, 32); //Font Settings
  text("Replay", (myWidth*5)/6, (2*myHeight)/3 - 50); //Total Time
}

void drawEnd()
{
  boxSettings(true, windowColor, true, color(#86A5FF), 6, 255); 
  rect(myWidth/2, (2*myHeight)/3 - 125, 400, 600, 3); //Frame
  drawReplay(); //Replay button
  textSettings(black, 25); //Font Settings
  text("Average Time:\n" + nf(averageTime,1,2) + " Seconds", myWidth/2, (2*myHeight)/3 -200); //Average Time with custom number format
  text("Points:\n" + finalPoints, myWidth/2, (2*myHeight)/3 - 100); //Total Points
  text("Your Rating:\n" + getRating(finalPoints) , myWidth/2, (2*myHeight)/3); //Rating
  text("Correct Answers:\n" + nf(getPercentage(finalPoints),1,2) + "%" , myWidth/2, (2*myHeight)/3 + 100); //Rating with custom number format
  drawStars(5, 30); //Empty stars effect
  drawStars(getRating(finalPoints), 255); //100% Opacity is 255
}
// -----------------
// Random Generators
void randomCountries()
{
  while (rCountries.size()<3)
  {
    int rNumber = int(random(countries.length));
    if(!rCountries.contains(rNumber) && rNumber!=currentCountryPosition)
      rCountries.add(rNumber);
  }
}

void randomPositions()
{
  while (rPositions.size()<4)
  {
    int rNumber = int(random(4));
    if(!rPositions.contains(rNumber))
      rPositions.add(rNumber);
  }
}

void randomLandscapes()
{
  while (rLandscapes.size()!=landscapes.length)
  {
    int rNumber = int(random(landscapes.length));
    if(!rLandscapes.contains(rNumber))
      rLandscapes.add(rNumber);
  }
}

void generateAnswers()
{
  //Correct Answer//
  rightPosition = rPositions.get(0); //The first random position is the correct answer position (it still is a random position)
  answers[rightPosition]=currentCountry; //Because the current country is the randomly generated
  //Wrong Answers//
  for(int i = 1; i<4; i++)
    answers[rPositions.get(i)]=countries[rCountries.get(i-1)]; //Get one random position & get one random country (we use i-1 because we only need 3 countries, the 4th country is the correct one), finally place those two 
}

void generateFlags()
{
  //Correct Answer//
  rightPosition = rPositions.get(0); //The first random position is the correct answer position (it still is a random position)
  flagAnswers[rightPosition]=currentCountryPosition; //Because the current country is the randomly generated
  //Wrong Answers//
  for(int i = 1; i<4; i++)
    flagAnswers[rPositions.get(i)]=rCountries.get(i-1); //Get one random position & get one random country (we use i-1 because we only need 3 countries, the 4th country is the correct one), finally place those two 
}

void generator() // Generates a completly new set of answers
{
  currentCountry = countries[rLandscapes.get(clicker)]; // New country
  currentCountryPosition = rLandscapes.get(clicker); //New country position
  rCountries.clear(); //Erases random array of numbers
  rPositions.clear(); //Erases random array of positions
  randomCountries(); //List with random countries (i.e. country index)
  randomPositions(); //List with random positions (position A, position B, position C & position D)
  if(flagMode1)  
    generateFlags(); //Generate new flags
  else if(flagMode2)
    generateAnswers(); //Generate new answers
}
// -----------------
// Timer
void update()
{
  ellapsedTime = millis();
  if(ellapsedTime == millis()-clickTime)
    secs = 0;
  else
    secs = (millis()-clickTime) / 1000; //the division converts from milliseconds to seconds
}
// -----------------
// Math
int getRating(int points)
{
  if(points<23)
    return points/5;
  else
    return 5;
}

float getPercentage(int points)
{
  float result = points*100.0/23.0;
  return result;
}
// -----------------
// Game engine
void startGameMode1()
{
  flagStart = true; //Game has started
  flagModeSelection=false; //Mode selection is over
  flagMode1 = true;
  clickTime = ellapsedTime; //Guess Time   
  generator();
  rounds++; //Next Round
}

void startGameMode2()
{
  flagStart = true; //Game has started
  flagModeSelection=false; //Mode selection is over
  flagMode2 = true;
  clickTime = ellapsedTime; //Guess Time   
  generator();
  rounds++; //Next Round
}

void endGame()
{
  flagStart = false; //Game has started
  flagModeSelection=false; //Mode selection is over
  flagMode1 = false;
  flagMode2 = false;
  flagEnd = true;
  averageTime=finalTime/23.0;
  clicker = 0;
}

void correctOption(int i) //Does something when the answer is correct
{
  if(flagMode1)
    drawCorrectFlag(i); // Highlight Box
  else if (flagMode2)
    drawCorrectName(i); // Highlight Box
  clicker++;
  points++;
  finalPoints=points;
  rounds++; //Next Round
  clickTime = ellapsedTime; //Guess Time  
  if(rounds>=24) //Ends game when pictures end
    endGame();
  generator();
  finalTime += secs;
}

void wrongOption(int i) //Does something when the answer is incorrect
{
  if(flagMode1)
    drawWrongFlag(i); // Highlight Box
  else if (flagMode2)
    drawWrongName(i); // Highlight Box
  clicker++;
  rounds++; //Next Round
  clickTime = ellapsedTime; //Guess Time   
  if(rounds>=24) //Ends game when pictures end
    endGame();          
  generator();
  finalTime += secs;
}

void hitBox(int i)
{
  if(flagMode1) //Click boxes for the mode1
  {
    xLeftLimit = i*300 + 50;
    xRightLimit = (i+1)*300 - 50; 
    yLeftLimit = myHeight/2 + 250;
    yRightLimit = myHeight/2 + 350;
  }
  if(flagMode2) //Click boxes for the mode2
  {
    xLeftLimit = i*300 ;
    xRightLimit = (i+1)*300; 
    yLeftLimit = myHeight/2 + 262.5;
    yRightLimit = myHeight/2 + 337.5;    
  }
}

void optionChecker(int i) //Option checker rececieves hit box dimensions and says if the answer is correct or wrong according to those dimensions
{
  hitBox(i); //Changes hit box according to the game mode being played
  if(x > xLeftLimit && x < xRightLimit && y > yLeftLimit && y < yRightLimit && i==rightPosition) //Checks if we are clicking the right position
    correctOption(i);
  else if(x > xLeftLimit && x < xRightLimit && y > yLeftLimit && y < yRightLimit && i!=rightPosition) //Checks if we are clicking one of the 3 wrong positions
    wrongOption(i);
}

void reset()
{
  flagEnd=false;
  rounds = 0;
  averageTime = 0;
  finalTime = 0;
  points = 0;
  finalPoints = 0;
}
// -----------------
// Mouse
void mousePressed()
{
  x = mouseX;
  y = mouseY;

  if(x > myWidth/2 - 150 && x < myWidth/2 + 150 && y > myHeight/2 + 212.5 && y < myHeight/2 + 287.5 && rounds==0) //Checks if the mouse clicked the play button
    flagModeSelection = true;
  if(x > myWidth/2 - 550 && x < myWidth/2 - 250 && y > myHeight/2 - 75 && y < myHeight/2 + 75 && rounds==0 && flagModeSelection) //Checks if the mouse clicked the Country Name Mode button 
    startGameMode1();
  if(x > myWidth/2 + 250 && x < myWidth/2 + 550 && y > myHeight/2 - 75 && y < myHeight/2 + 75 && rounds==0 && flagModeSelection) //Checks if the mouse clicked the Country Flag Mode button 
    startGameMode2();
  if(flagStart && !flagEnd) //Checks if mouse clicked the options
    for(int i = 0; i<4; i++ )
      optionChecker(i);
  if(x > (myWidth*5)/6 - 50 && x < (myWidth*5)/6 + 50 && y > myHeight/2 - 75 && y < myHeight/2 + 75 && flagEnd) //Checks if the mouse clicked the replay button
    reset(); 
}