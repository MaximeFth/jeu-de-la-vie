int tailleCase=8;
float cellSize=8;
final int gridSize=800;
HScrollbar hs;
boolean shiftMode=false;
float frame=1;
int[][] currentGrid=new int[gridSize/tailleCase][gridSize/tailleCase]; 
int[][] nextGrid=new int[gridSize/tailleCase][gridSize/tailleCase]; 

void setup() {  
  hs=new HScrollbar(0, 0, 300, 8);
  size(800, 800);  
  for (int i = 0; i < gridSize/cellSize; i++) {  // two lines to begin life :)
    for (int j = 0; j < gridSize/cellSize; j++) {  
      currentGrid[i][j]=0;
      nextGrid[i][j]=0;
      if (i==53 || i==55) {
        currentGrid[i][j]=1;
        nextGrid[i][j]=1;
      }
    }
  }
}  


void draw() {  

  frameRate(frame);
  background(0); 

  for (int i = 0; i < gridSize/cellSize; i++) {  
    for (int j = 0; j < gridSize/cellSize; j++) {  
      int val = currentGrid[i][j];   

      switch(val) {  
      case 0:   
        fill(255, 255, 255);   
        break;  
      case 1:   
        fill(0, 0, 0);   
        break;
      }  
      noStroke();  
      rect(cellSize + (j * tailleCase), cellSize + (i * tailleCase), tailleCase, tailleCase);
    }
  }
  liveOrDie(); // living/death algorithm
  copie(nextGrid, currentGrid); // 
  hs.update();
  hs.display();
  if (!shiftMode) {
    frame=0.7+20*hs.getPos();
  }

  String s = "Generation: "+frameCount;
  fill(50);
  text(s, 10, 10, 70, 80);
}


void liveOrDie() {
  for (int i = 1; i < gridSize/cellSize-1; i++) {  
    for (int j = 1; j < gridSize/cellSize-1; j++) {
      int score=0;
      if (currentGrid[i][j]==1) {
        score--;
      }

      for (int l = 0; l < 3; ++l) {  
        for (int m = 0; m < 3; ++m) {
          if (currentGrid[i+l-1][j+m-1]==1 ) {
            score++;
          }
        }
      }


      if (nextGrid[i][j]==0&&score==3) {
        nextGrid[i][j]=1;
      } else if (nextGrid[i][j]==1 &&( score==2||score==3)) {
        nextGrid[i][j]=1;
      } else {
        nextGrid[i][j]=0;
      }
    }
  }
}
// TODO ; shiftmode = mode to stop the "game" and add possibility to add manually living cells
void keyReleased() {
  if (shiftMode==true) {
    shiftMode=false;
    frame=10;
  }
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==SHIFT) {
      shiftMode = true;
      if (shiftMode) { 
        frame=0.2;
      }
    }
  }
}

void mouseClicked() {

  int x=(int) Math.floor(mouseX/8);
  int y=(int) Math.floor(mouseY/8);
  currentGrid[y][x]=1;
}
void copie(int tableauOriginal[][], int tableauCopie[][])
{

  for (int i = 0; i < gridSize/tailleCase; i++) {
    for (int j = 0; j < gridSize/tailleCase; j++) {
      tableauCopie[i][j] = tableauOriginal[i][j] ;
    }
  }
}