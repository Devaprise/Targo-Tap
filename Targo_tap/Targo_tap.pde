// This sketch builds on a prior work, "Targo Tap", created by Virus & Micah Canfield & Wes
// http://studio.sketchpad.cc/sp/pad/view/ro.98$Fad5UME48E/rev.1511
// Most of it was edited by Snakebyte now, though.

/**
  Hello application uncompiler, source code searcher or someone else!
**/
 
//resources
float scal;
boolean onButton = false;
color backgroundColor = color(216, 222, 191);
 
int FPS = 120;

//rotation amount
int theta = 0;


float elapsedSecs = 0;

//this is changed to true when the game begins
boolean timerStarted = true;

//level variables
//game variables
boolean[] bArray = {false, false, false, false};
int cx = displayWidth/4;
int cy = displayHeight/3;
int goalNum = ceil(random(0, 4));
int score;
int gameState = 1;
int cycleState = 0;
//Button Class
class Button{
    int id;
    int x;
    int y;
    int w;
    float h;
    color clr;
    color fntClr;
 
    Button(color fntClr, color clr, int tx, int ty, int tw, float th, int tid){
        this.x = tx;
        this.y = ty;
        this.w = tw;
        this.h = th;
        this.id = tid;
        this.clr = clr;
        this.fntClr = fntClr;
    }
    
    void draw(){
        pushStyle();
        noStroke();
        if(mousePressed&&mouseX>x&&mouseY>y&&mouseX<x+w&&mouseY<y+h){
            fill(fntClr);
        } else {
            fill(clr);
        }
        rect(x,y,w,h);
        fill(0);
        textSize(80*scal);
        textAlign(CENTER,CENTER);
        if(mousePressed&&mouseX>x&&mouseY>y&&mouseX<x+w&&mouseY<y+h){
            fill(clr);
        } else {
            fill(fntClr);
        }
        text(str(id+1),x, y, w, h);
        popStyle();
    }
    
    boolean checkPressed(){
        if(mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h){
             if(this.id+1 == goalNum){
               int oldGN = int(goalNum);
               goalNum = ceil(random(0,4));
               while(goalNum == oldGN){
                 goalNum = ceil(random(0,4));
               }
               score++;
               cycleState++;
               return true;
             }
        }
        return false;
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
    boolean isOn = false;
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
        if(mouseX>x && mouseY>y&&mouseX<x+w&&mouseY<y+h){
            if(true){
                return true;
            } else {
                
                return false;
            }
        }
        return false;
    }
    void draw(){
        if(mouseX>x&&mouseY>y&&mouseX<x+w&&mouseY<y+h&&mousePressed){
            this.isOn = true;
        }else{
            this.isOn = false;
        }
        pushStyle();
        stroke(0);
        if(this.isOn){
          fill(this.fntClr);
        }else{
          fill(this.clr);
        }
        noStroke();
        rect(x,y,w,h);
        fill(0);
        textSize(64*scal);
        textAlign(CENTER,CENTER);
        if(this.isOn){
          fill(this.clr);
        }else{
          fill(this.fntClr);
        }
        text(this.txt,x, y,w,h);
        popStyle();
    }
}

class lostPoint {
  int lifeStart = millis();
  int lifetime = 0;
  int lifespan = 2;//in seconds
  int x;
  int y;
  float acc = 0.5;
  float vel = 0;
  boolean shouldRemove = false;
  lostPoint(int x, int y){
    this.x = x;
    this.y = y;
  }
  void draw() {
    this.vel += this.acc;
    if(round(((float(lifetime - lifeStart)/1000)/2)*255) >= 256){
      this.shouldRemove = true;
    }
    lifetime = millis();
    textAlign(CENTER,CENTER);
    textSize(60*scal);
    fill(255,0,0,255 - round(((float(lifetime - lifeStart)/1000)/2)*255));
    text("-1",x,y);
    this.y += (height/720)*int(vel);
    lifetime = millis() - lifeStart;
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
menuButton menu_button;
menuButton play;
menuButton[] buttonArray;
menuButton menu_options;
menuButton menu_credits;
 

 
void setup() {  // this is run once.   
    
    // set the background color
    background(backgroundColor);
    
    // canvas size (Variable aren't evaluated. Integers only, please.)
    //boolean device = true;
    //if(device){
<<<<<<< HEAD
      //size(int(displayWidth), int(displayWidth)); 
      //scal = round(width/720);
=======
      size(720, 1080); 
      scal = round(width/720);
>>>>>>> origin/master
    //}else{
      size(360,540);
      scal = 0.5;
    //  scal=0.5;
    //}
    //size(720, 1080);
    
    // limit the number of frames per second
    frameRate(60);
    
    // set the displayWidth of the line. 
    strokeWeight(1);
    
    PImage menu;
    //menu = loadImage("/static/uploaded_resources/p.17470/TargoTap_Menu.jpg");
    
    // button definition
    button0 = new Button(color(8, 19, 166),color(149, 148, 209),0, height/5, width/2, height/3.33,0);
    button1 = new Button(color(166, 8, 8),color(207, 147, 147),width/2, height/5, width/2, height/3.33,1);
    button2 = new Button(color(166, 8, 8),color(207, 147, 147),0, height/2, width/2, height/3.33,2);
    button3 = new Button(color(8, 19, 166),color(149, 148, 209),width/2, height/2, width/2, height/3.33,3);
    
    //button4 = new Button(width/1.5, height/2,width/2,height/3.33,3);
    
    options = new menuButton("Options",color(149,211,206),color(7,166,153),0, height - round(height/3.33)-1, width/2, round(height/3.33));
    credits = new menuButton("Credits",color(252,179,126),color(239,113,24),width/2, height - round(height/3.33)-1, width/2, round(height/3.33));
    actionMode = new menuButton("Action Mode",color(239,113,24),color(252,179,126),0, height - (round(height/3.33)*2), width/2, round(height/3.33));
    zenMode = new menuButton("Zen Mode",color(149,211,206),color(7,166,153),width/2, height - (round(height/3.33)*2), width/2, round(height/3.33));
    restart = new menuButton("Restart",color(149,211,206),color(7,166,153),0,round(height/1.5),width/2,height/6);
    menu_button = new menuButton("Menu",color(207,206,147),color(166,163,8),round(width/2),round(height/1.5),width/2,height/6);
    play = new menuButton("Play Targo Tap",color(157, 209, 148),color(8, 166, 24),0, height - (round(height/3.33)*2), width, round(height/3.33));
    menu_options = new menuButton("Menu",color(207,206,147),color(166,163,8),0,height - (height/6),width,height/6);
    menu_credits = new menuButton("Menu",color(207,206,147),color(166,163,8),0,height - (height/6),width,height/6);
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
ArrayList<lostPoint> lostPoints = new ArrayList<lostPoint>();
void drawGame(){
    background(backgroundColor);
    fill(0);
    title();
    switch(gameState){
        case 0:
            int time = (round(startTime/1000)+30) - round(millis()/1000);
            if(time <= 0){
               gameState = 2;
               return;
            }
            background(backgroundColor);
            /*
              button0 = new Button(0, height/5, width/2, height/3.33,0);
              button1 = new Button(width/2, height/5, width/2, height/3.33,1);
              button2 = new Button(0, height/2, width/2, height/3.33,2);
              button3 = new Button(width/2, height/2, width/2, height/3.33,3);
            */
            if(rotateMode){
            switch(cycleState%4){
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
            //lastTime = round(frameCount/10)%4;
            button0.draw();
            button1.draw();
            button2.draw();
            button3.draw();
            fill(255);
            rectMode(CENTER);
            noStroke();
            rect(width/2, height/2, 150*scal, 150*scal,100*scal);
            rectMode(CORNER);
            fill(0);
            textSize(48*scal);
            textAlign(CENTER,CENTER);
            text(goalNum, width/2, height/2);
            textAlign(CENTER,TOP);
            textSize(50*scal);
            text("Time: " + round(time) + "\n\nScore: "+score,width/2,20*(height/1080));
            for(lostPoint lp : lostPoints){
              if(lp.shouldRemove == false){
                lp.draw();
              }
            }
            for (int i = lostPoints.size() - 1; i >= 0; i--) {
              lostPoint lp = lostPoints.get(i);
              if(lp.shouldRemove == true){
                lostPoints.remove(i);  
              }
            }
            break;
        case 1:
            break;
        case 2:
            noFill();
            textSize(80*scal);
            background(backgroundColor);
            textAlign(CENTER,CENTER);
            text("Score: "+score,width/2,height/2.55);
            text("Game Over",width/2,height/3.25);
            restart.draw();
            menu_button.draw();
            break;
        case 3:
          background(backgroundColor);
          textAlign(CENTER,TOP);
          fill(0);
          textSize(80*scal);
          text("Options",width/2,scal*10);
          menu_options.draw();
        break;
        case 4:
          background(backgroundColor);
          textAlign(CENTER,TOP);
          fill(0);
          textSize(80*scal);
          text("Options",width/2,scal*10);
          menu_credits.draw();
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
            /*button0.checkPressed();
            button1.checkPressed();
            button2.checkPressed();
            button3.checkPressed();
            if(bArray[goalNum-1]==true){
                score++;
                int newNum=goalNum;
                while(newNum==goalNum){
                    newNum=ceil(random(0,4));
                }
                bArray[goalNum-1] = false;
                goalNum=newNum;
                cycleState++;
                return;
            } else if(mousePressed){
                score--;
                if (score < 0) {
                    score = 0;
                }
                cycleState++;
                return;
            } */
            boolean a = button0.checkPressed();
            if(a){return;}
            boolean b = button1.checkPressed();
            if(b){return;}
            boolean c = button2.checkPressed();
            if(c){return;}
            boolean d = button3.checkPressed();
            if(d){return;}
            if(!a&&!b&&!c&&!d){
              if(score>0){
                score--;
              }
              lostPoints.add(new lostPoint(mouseX,mouseY));
            }
        break;
        case 1:
            credits.checkPressed();
            if(options.checkPressed()){
                gameState = 3;
                startTime = -1;
                score = 0;
                return;
            }
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
               return;
            }
         break;
         case 2:
           if(restart.checkPressed()){
             gameState = 0;
             startTime = millis();
             score = 0;
             return;
           }
           if(menu_button.checkPressed()){
              gameState = 1;
              startTime = -1;
              score = 0;
              return;
            }
         break;
         case 3:
           if(menu_options.checkPressed()){
              gameState = 1;
              startTime = -1;
              score = 0;
              return;
            }
         break;
    }
}
 
void draw() {  // this is run repeatedly.  
    drawGame();
    textAlign(CENTER, CENTER);
    theta+=0.01;
}
void mouseReleased() {
  updateGame();
}
