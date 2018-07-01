int tailleCase=8;
float x_start = 8;  
float y_start = 8;  
final int sizet=800;
HScrollbar hs;
boolean shiftMode=false;
float frame=1;
final int hsHeight = 20;
final int hsWidth = 500;
int[][] casesA=new int[sizet/tailleCase][sizet/tailleCase]; 
int[][] casesB=new int[sizet/tailleCase][sizet/tailleCase]; 

void setup() {  
  hs=new HScrollbar(0, 0, 300, 8);

  size(800, 800);  
  rectMode(CORNER);
  for (int i = 0; i < sizet/x_start; i++) {  
    for (int j = 0; j < sizet/y_start; j++) {  
      casesA[i][j]=0;
      casesB[i][j]=0;
      if (i==53 || i==55) {
        casesA[i][j]=1;
        casesB[i][j]=1;
      }
    }
  }
}  


void draw() {  

  frameRate(frame);
  background(0); 

  for (int i = 0; i < sizet/x_start; i++) {  
    for (int j = 0; j < sizet/y_start; j++) {  
      int val = casesA[i][j];   //affiche casesA

      switch(val) {  
      case 0:   
        fill(255, 255, 255);   
        break;  
      case 1:   
        fill(0, 0, 0);   
        break;
      }  
      noStroke();  
      rect(x_start + (j * tailleCase), y_start + (i * tailleCase), tailleCase, tailleCase);
    }
  }
  liveOrDie(); // algorithme de survie/naissance/kill sur caseB a partir de caseA
  copie(casesB, casesA); // cases A=cases B

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
  for (int i = 1; i < sizet/x_start-1; i++) {  
    for (int j = 1; j < sizet/y_start-1; j++) {
      int score=0;
      if (casesA[i][j]==1) {
        score--;
      }
      int a=0;
      for (int l = 0; l < 3; ++l) {  
        for (int m = 0; m < 3; ++m) {
          if (i==5&&j==6) {
            a++;
          }
          if (casesA[i+l-1][j+m-1]==1 ) {

            score++;
          }
        }
      }


      if (casesB[i][j]==0&&score==3) {
        casesB[i][j]=1;
      } else if (casesB[i][j]==1 &&( score==2||score==3)) {
        casesB[i][j]=1;
      } else {
        casesB[i][j]=0;
      }
    }
  }
}
void keyReleased() {
  if (shiftMode==true) {
    shiftMode=false;
    System.out.println("cacacacapipi");
    frame=10;
  }
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==SHIFT) {
      shiftMode = true;
      if (shiftMode) { 
        frame=0.2;
        System.out.println("caca");
      }
    }
  }
}
void mouseClicked() {

  int x=(int) Math.floor(mouseX/8);
  int y=(int) Math.floor(mouseY/8);
  casesA[y][x]=1;
}
void copie(int tableauOriginal[][], int tableauCopie[][])
{


  for (int i = 0; i < sizet/tailleCase; i++) {
    for (int j = 0; j < sizet/tailleCase; j++) {
      tableauCopie[i][j] = tableauOriginal[i][j] ;
    }
  }
}