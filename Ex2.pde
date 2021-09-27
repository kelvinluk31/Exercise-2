////////////// RESOLUTION /////////////
int RESOLUTIONX = 1024;
int RESOLUTIONY = 768;

int globalVerticies = 128;
int NUMBEROFTREES = 8;
//////////////// Variables //////////////
PShape[] trees;
  int treeWidth = 128;
  int treeHeight = 137;
  int[] treeXPos;
  int[] treeYPos;

PShape car;

float speed = 0.05;

PImage backGround;
float xforf = 0; // used for drawing the "ground"
float[] globalWave;



void setup() {
  size(1024, 768, P2D);
   noStroke();
   backGround = loadImage("https://eskipaper.com/images/beautiful-sky-wallpaper-1.jpg");
   backGround.resize(1024, 768);
   trees = new PShape[NUMBEROFTREES];
   treeXPos = new int[NUMBEROFTREES];
   treeYPos = new int[NUMBEROFTREES];
   
   for(int i = 0; i < NUMBEROFTREES; i++){
     trees[i] = loadShape("https://upload.wikimedia.org/wikipedia/commons/7/7d/Greentree.svg");
     treeXPos[i] = (int)random(RESOLUTIONX);
     treeYPos[i] = (int)random((50 + RESOLUTIONY/2), height - 128);
     trees[i].setFill(color(random(255), random(255) , random(255)));
   }
   car = loadShape("https://svgsilh.com/svg/1918554.svg");
   car.setFill(color(random(255), random(255) , random(255)));
 
}

void draw() {
    globalWave = sinWaveGenerator(globalVerticies);
    background(backGround);
    fill(color(0, 128 ,0));
    landScape(globalVerticies, globalWave);
    placeTrees(trees);
    shape(car, 500, ((height/2) + 32*globalWave[64]), 160, 54);
    fill(255,255,0);
    ellipse(mouseX, mouseY, 100, 100);
    
    
  }
//allows for the trees to be randomly placed with random colours indefinately
void placeTrees(PShape[] trees){
   for(int i = 0; i < NUMBEROFTREES; i++){
     if(treeXPos[i] < -treeWidth){
       treeXPos[i] = width + treeWidth;
       treeYPos[i] = (int)random((50 + RESOLUTIONY/2), height - 128);
       trees[i].setFill(color(random(255), random(255) , random(255)));
     }
     treeXPos[i] = treeXPos[i] - (int)(width/((float)globalVerticies - 1));
     shape(trees[i], treeXPos[i], treeYPos[i], treeWidth, treeHeight);
   }
}

//generates the landsacpe thats moving like a sin wave  
void landScape(int verticies, float[] localWave){
  float xVals = width/((float)verticies - 1);
  beginShape();
  vertex(0,height);
  for(int i = 0; i < verticies; i++){
    vertex((i * xVals), ((height/2 + 50) + 32*localWave[i]));
  }
  vertex(width,height);
  endShape();
}

// returns an array for a sine wave of a given precision (numVtex)
float[] sinWaveGenerator(int numVtex){
  float[] returnVal = new float[numVtex];
  float increment = ((2 * 3.14)/((float)numVtex));
  for(int i = 0; i < numVtex; i++){
    returnVal[i] = sin((i * increment) + xforf);
  }
  if(xforf > 2*3.14){
    xforf = 0;
  }
  else {
    xforf = (xforf + speed) ;
  }
  return returnVal;
}
