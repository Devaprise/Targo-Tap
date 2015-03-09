// This sketch builds on a prior work, "Targo Tap", created by Virus & Micah Canfield & Wes
// http://studio.sketchpad.cc/sp/pad/view/ro.98$Fad5UME48E/rev.1511
 
//resources
float scal;
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
        strokeWeight(10*scal);
        fill(255);
        if(mousePressed&&mouseX>x&&mouseY>y&&mouseX<x+w&&mouseY<y+h){
            fill(0,200,250);
        } else {
            fill(150,100,255);
        }
        rect(x,y,w,h);
        fill(0);
        textSize(80*scal);
        textAlign(CENTER,CENTER);
        text(str(id+1),x, y, w, h);
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
 
class menuButton{
    int x;
    int y;
    int w;
    int h;
    color clr;
    color fntClr;
    String txt;
    menuButton(String txt, color clr, color fntClr, int x, int y, int w, int h){
        /*if(x=="mid"){
            x=width/2-w/2;
        }
        if(y=="mid"){
            y=displayHeight/2-h/2;
        }*/
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.txt = txt;
        this.clr = clr;
        this.fntClr = fntClr;
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
    void draw(){
        pushStyle();
        stroke(0);
        fill(this.clr);
        noStroke();
        rect(x,y,w,h);
        fill(0);
        textSize(64*scal);
        textAlign(CENTER,CENTER);
        fill(this.fntClr);
        text(this.txt,x, y,w,h);
        popStyle();
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
menuButton restart;
menuButton play;
menuButton[] buttonArray;
 
boolean onButton = false;
int buttonCenterX = width/2;
float buttonCenterY = displayHeight/3.33;
color backgroundColor = color(216, 222, 191);
 
int FPS = 60;
boolean mouseClicked = false;

//rotation amount
int theta = 0;

 
void mousePressed(){
    mouseClicked = true;
}

float elapsedSecs = 0;

//this is changed to true when the game begins
boolean timerStarted = true;

//int timer(){
    //if(timerStarted){
    //    elapsedSecs++;
    //}
   // else{
    //    elapsedSecs=0;
//}
    
    //return elapsedSecs;
//}

//level variables
//game variables
boolean[] bArray = {false, false, false, false};
int cx = displayWidth/4;
int cy = displayHeight/3;
int goalNum = ceil(random(0, 4));
int score;
int gameState = 1;
 
void setup() {  // this is run once.   
    
    // set the background color
    background(backgroundColor);
    
    // canvas size (Variable aren't evaluated. Integers only, please.)
    boolean device = true;
    if(device){
      size(int(displayWidth), int(displayWidth)); 
      scal = round(displayWidth/720);
    }else{
      size(360,540);
      scal=0.5;
    }
    //size(720, 1080);
    
    // limit the number of frames per second
    frameRate(60);
    
    // set the displayWidth of the line. 
    strokeWeight(1);
    
    PImage menu;
    //menu = loadImage("/static/uploaded_resources/p.17470/TargoTap_Menu.jpg");
    
    // button definition
    button0 = new Button(0, height/5, width/2, height/3.33,0);
    button1 = new Button(width/2, height/5, width/2, height/3.33,1);
    button2 = new Button(0, height/2, width/2, height/3.33,2);
    button3 = new Button(width/2, height/2, width/2, height/3.33,3);
    
    //button4 = new Button(width/1.5, height/2,width/2,height/3.33,3);
    
    options = new menuButton("Options",color(149,211,206),color(7,166,153),0, height - round(height/3.33)-1, width/2, round(height/3.33));
    credits = new menuButton("Credits",color(239,113,24),color(252,179,126),width/2, height - round(height/3.33)-1, width/2, round(height/3.33));
    actionMode = new menuButton("Action Mode",color(239,113,24),color(252,179,126),0, height - (round(height/3.33)*2), width/2, round(height/3.33));
    zenMode = new menuButton("Zen Mode",color(149,211,206),color(7,166,153),width/2, height - (round(height/3.33)*2), width/2, round(height/3.33));
    restart = new menuButton("Restart",color(149,211,206),color(7,166,153),width/4,round(height/1.5),width/2,height/6);
    play = new menuButton("Play Targo Tap",color(157, 209, 148),color(8, 166, 24),0, height - (round(height/3.33)*2), width, round(height/3.33));
}

 
void title() {
    textSize(96*scal);
    fill(7,166,153);
    if(debugMode){
        text("Targo Tap  bArray:"+bArray, width/2, height/7, elapsedSecs);
    } else {
        text("Targo Tap", width/2, height/6);
    }
    textSize(70*scal);
    text("Alpha!",width/2,height/6 + ((96*scal)*1.25));
    options.draw();
    credits.draw();
    play.draw();
    
}

void buttonUpdate(Button button, int id){
  button.id = id;
}
int lastTime;
int startTime;
void drawGame(){
    background(backgroundColor);
    fill(0);
    title();
    switch(gameState){
        case 0:
            background(backgroundColor);
            /*
              button0 = new Button(0, height/5, width/2, height/3.33,0);
              button1 = new Button(width/2, height/5, width/2, height/3.33,1);
              button2 = new Button(0, height/2, width/2, height/3.33,2);
              button3 = new Button(width/2, height/2, width/2, height/3.33,3);
            */
            if(rotateMode && round(frameCount/10)%4 != lastTime){
            switch(round(millis()/500)%4){
              case 0:
                buttonUpdate(button0,0);
                buttonUpdate(button1,1);
                buttonUpdate(button2,2);
                buttonUpdate(button3,3);
               break;
               case 1:
                buttonUpdate(button0,3);
                buttonUpdate(button1,0);
                buttonUpdate(button2,1);
                buttonUpdate(button3,2);
               break;
               case 2:
                buttonUpdate(button0,2);
                buttonUpdate(button1,3);
                buttonUpdate(button2,0);
                buttonUpdate(button3,1);
               break;
               case 3:
                buttonUpdate(button0,1);
                buttonUpdate(button1,2);
                buttonUpdate(button2,3);
                buttonUpdate(button3,0);
               break;
            }
            }
            lastTime = round(frameCount/10)%4;
            button0.draw();
            button1.draw();
            button2.draw();
            button3.draw();
            fill(255);
            rectMode(CENTER);
            strokeWeight(10*scal);
            rect(width/2, height/2, 150*scal, 150*scal);
            rectMode(CORNER);
            fill(0);
            textSize(48*scal);
            textAlign(CENTER,CENTER);
            text(goalNum, width/2, height/2);
            noFill();
            textSize(30*scal);
            text("Score: "+score,width/2,height-height/8);
            int time = (round(startTime/1000)+25) - round(millis()/1000);
            if(time <= 0){
              gameState = 2;
              return;
            }
            text("Time: " + round(time), width/2, 20);
            break;
        case 1:
            //image(loadImage("/static/uploaded_resources/p.17470/TargoTap_Menu.jpg"), 0, 0);
            break;
        case 2:
            noFill();
            textSize(50);
            background(backgroundColor);
            textAlign(CENTER,CENTER);
            text("Score: "+score,width/2,height/2);
            text("Game Over",width/2,height/2.5);
            restart.draw();
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
    switch(gameState){
        case 0:
            if (25-elapsedSecs <= 0){
                    gameState=2;
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
            /*if(actionMode.checkPressed()){
                gameState = 0;
                startTime = millis();
            }
            if(zenMode.checkPressed()){
                gameState = 0;
                startTime = millis();
            }*/
            if(play.checkPressed()){
               gameState = 0;
               startTime = millis();
               score = 0;
            }
         break;
         case 2:
           if(restart.checkPressed()){
             gameState = 0;
             startTime = millis();
             score = 0;
           }
         break;
    }
}
 
void draw() {  // this is run repeatedly.  
    updateGame();
    drawGame();
    textAlign(CENTER, CENTER);
    mouseClicked=false; //needed to reset the variable
    theta+=0.01;
}
