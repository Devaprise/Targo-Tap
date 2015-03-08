// This sketch builds on a prior work, "Targo Tap", created by Virus & Micah Canfield & Wes
// http://studio.sketchpad.cc/sp/pad/view/ro.98$Fad5UME48E/rev.1511
 
//resources
//Button Class
class Button{
    int id;
    int x;
    int y;
    int w;
    float h;
 
    Button(int tx, int ty, int tw, float th, int tid){
        this.x = tx;
        this.y = ty;
        this.w = tw;
        this.h = th;
        this.id = tid;
    }
    
    void draw(){
        pushStyle();
        stroke(0);
        fill(255);
        if(bArray[id]==true){
            fill(0,200,250);
        } else {
            fill(150,100,255);
        }
        rect(x,y,w,h);
        fill(0);
        textSize(12);
        text(str(id+1),x+w/2, y+h/2, 20, 20);
        popStyle();
    }
    
    void checkPressed(){
        if(mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h){
            onButton = true;
            if(mouseClicked){
                bArray[this.id] = true;
                
            } else {
                bArray[this.id] = false;
            }
        }
    }
}
 
//debug mode
 
boolean debugMode=false;
 
 
// Pressing Control-R will render this sketch.
//constants

//change this to play around with rotation

//ROTATION
boolean rotateMode = true;




//game buttons
Button button0;
Button button1;
Button button2;
Button button3;

//Replay button
Button button4;

//menu buttons
menuButton options;
menuButton credits;
menuButton actionMode;
menuButton zenMode;
menuButton[] buttonArray;
 
boolean onButton = false;
int height = 1080;
int width = 720;
int buttonCenterX = width/2;
float buttonCenterY = height/3.33;
color backgroundColor = color(216, 222, 191);
 
int FPS = 30;

boolean mouseClicked = false;

//rotation amount
int theta = 0;

 
void mousePressed(){
    mouseClicked = true;
}

int elapsedSecs = 0;

//this is changed to true when the game begins
boolean timerStarted = true;

int timer(){
    if(timerStarted){
        elapsedSecs++;
    }
    else{
        elapsedSecs=0;
    }
    
    return elapsedSecs;
}
 
//level variables
//game variables
boolean[] bArray = {false, false, false, false};
int cx = width/4;
int cy = height/3;
int goalNum = ceil(random(0, 4));
int score;
int gamestate = 1;
 
void setup() {  // this is run once.   
    
    // set the background color
    background(backgroundColor);
    
    // canvas size (Variable aren't evaluated. Integers only, please.)
    size(720, 1080); 
    
    // limit the number of frames per second
    frameRate(FPS);
    
    // set the width of the line. 
    strokeWeight(1);
    
    PImage menu;
    //menu = loadImage("/static/uploaded_resources/p.17470/TargoTap_Menu.jpg");
    
    // button definition
    button0 = new Button(0, height/5, width/2, height/3.33,0);
    button1 = new Button(width/2, height/5, width/2, height/3.33,1);
    button2 = new Button(0, height/2, width/2, height/3.33,2);
    button3 = new Button(width/2, height/2, width/2, height/3.33,3);
    
    //button4 = new Button(width/1.5, height/2,width/2,height/3.33,3);
    
    options = new menuButton(0, (height/3)*2, width/2, height/3);
    credits = new menuButton(width/2, (height/3)*2, width/2, height/3);
    actionMode = new menuButton(0, height/3, width/2, height/3);
    zenMode = new menuButton(width/2, height/3, width/2, height/3);
    
}

 
void title() {
    textSize(25);
    if(debugMode){
        text("Targo Tap  bArray:"+bArray, width/2, height/7, elapsedSecs);
    } else {
        text("Targo Tap", width/2, height/7);
    }
    
}

void buttonUpdate(Button button, int x, int y){
  button.x = x;
  button.y = y;
}

 
void drawGame(){
    background(backgroundColor);
    fill(0);
    title();
    switch(gamestate){
        case 0:
            /*
              button0 = new Button(0, height/5, width/2, height/3.33,0);
              button1 = new Button(width/2, height/5, width/2, height/3.33,1);
              button2 = new Button(0, height/2, width/2, height/3.33,2);
              button3 = new Button(width/2, height/2, width/2, height/3.33,3);
            */
            if(rotateMode){
            switch(round(frameCount/10)%4){
              case 0:
                buttonUpdate(button0,0,height/5);
                buttonUpdate(button1,width/2,height/5);
                buttonUpdate(button2,0,height/2);
                buttonUpdate(button3,width/2,height/2);
               break;
               case 1:
                buttonUpdate(button0,width/2,height/2);
                buttonUpdate(button1,0,height/5);
                buttonUpdate(button2,width/2,height/5);
                buttonUpdate(button3,0,height/2);
               break;
               case 2:
                buttonUpdate(button0,0,height/2);
                buttonUpdate(button1,width/2,height/2);
                buttonUpdate(button2,0,height/5);
                buttonUpdate(button3,width/2,height/5);
               break;
               case 3:
                buttonUpdate(button0,width/2,height/5);
                buttonUpdate(button1,0,height/2);
                buttonUpdate(button2,width/2,height/2);
                buttonUpdate(button3,0,height/5);
               break;
            }
            }
            button0.draw();
            button1.draw();
            button2.draw();
            button3.draw();
            fill(255);
            rect(width/2-25, height/2-25, 50, 50);
            fill(0);
            textSize(12);
            text(goalNum, width/2, height/2);
            noFill();
            textSize(30);
            text("Score: "+score,width/2,height-height/8);
            int time = 25-elapsedSecs;
            text("Time: " + time, width/2, 20);
            break;
        case 1:
            //image(loadImage("/static/uploaded_resources/p.17470/TargoTap_Menu.jpg"), 0, 0);
            break;
        case 2:
            noFill();
            textSize(50);
            
            text("Score: "+score,width/2,height/2);
            text("Game Over",width/2,height/3);
            break;
        default:
          textSize(50);
          
          //text("Uh Oh!");
          textSize(30);
          
          //text("Page has not been found!");
         
    }
    //popStyle();
}
 
void updateGame() {
    switch(gamestate){
        case 0:
            if (25-elapsedSecs <= 0){
                    gamestate=2;
                    timerStarted=false;
            }
            button0.checkPressed();
            button1.checkPressed();
            button2.checkPressed();
            button3.checkPressed();
            if(bArray[goalNum-1]==true){
                score++;
                int newNum=goalNum;
                while(newNum==goalNum){
                    newNum=ceil(random(0,4));
                };
                goalNum=newNum;
            } else if(mouseClicked){
                score--;
                if (score < 0) {
                    score = 0;
                }
                
            } 
            break;
        case 1:
            credits.checkPressed();
            options.checkPressed();
            if(actionMode.checkPressed()){
                gamestate = 0;
            }
            if(zenMode.checkPressed()){
                gamestate = 0;
            }
    }
}
 
void draw() {  // this is run repeatedly.  
    updateGame();
    drawGame();
    textAlign(CENTER, CENTER);
    mouseClicked=false; //needed to reset the variable
    theta+=0.01;
}
 
class menuButton{
    int x;
    int y;
    int w;
    int h;
    menuButton(int x, int y, int w, int h){
        /*if(x=="mid"){
            x=width/2-w/2;
        }
        if(y=="mid"){
            y=height/2-h/2;
        }*/
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    boolean checkPressed(){
        if(mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h){
            if(mouseClicked){
                return true;
            } else {
                
                return false;
            }
        }
        return false;
    }
}
