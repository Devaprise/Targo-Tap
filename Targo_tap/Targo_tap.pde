
/**
  sound will be implemented at a later date for mobile devices.
  minim refused to work on android ;(
**/
//:) leaderboard
//import android.*;
import apwidgets.*;
APMediaPlayer player;
JSONObject leaderboard;

// This sketch builds on a prior work, "Targo Tap", created by Virus & Micah Canfield & Wes
// http://studio.sketchpad.cc/sp/pad/view/ro.98$Fad5UME48E/rev.1511
// Most of it was edited by Snakebyte now, though.

/**
  Hello application uncompiler, source code searcher or someone else!
**/

//import ddf.minim.*;

//AudioPlayer player;
//Minim minim;//audio context
/* Last Minute Popup */
int scalX;
int scalY;
class Prompt {
  String title;
  String message;
  boolean disabled = true;
  Prompt(String title, String message) {
    this.title = title;
    this.message = message;
  }
  void draw() {
    if(disabled){
      return;  
    }
    textAlign(LEFT,CORNER);
    noStroke();
    fill(0,0,0,100);
    rect(0,0,width,height);
    fill(0);
    rect(round(width*0.1)-(2*scalX),round(height/2) - round(round(height*0.3)/2)-(2*scalY),round(width*0.8)+(2*scalX),round(height*0.3)+(2*scalY));
    fill(100);
    rect(round(width*0.1)-(2*scalX),round(height/2) - round(round(height*0.3)/2)-(2*scalY),round(width*0.8)+(2*scalX),scalX*45);
    fill(255);
    textSize(scalX*40);
    text(this.title,round(width*0.1),round(height/2) - round(round(height*0.3)/2) + (scalY*3),round(width*0.8),round(height*0.3));
    textSize(scalX * 30);
    text(this.message,round(width*0.1),round(height/2) - round(round(height*0.3)/2) + (scalX*47),round(width*0.8),round(height*0.3));
    
  }
  void disable() {
    disabled = true;
    
  }
}

Prompt prompt1;
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
           return true;
        }
        return false;
    }
    void draw(){
        if(mouseX>x&&mouseY>y&&mouseX<x+w&&mouseY<y+h&&mousePressed&&prompt1.disabled==true){
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
menuButton option_music;
menuButton menu;
 
String music = "enabled"; //Enable or disable music
 
void setup() {  // this is run once.   
    // set the background color
    background(backgroundColor);
    orientation(PORTRAIT);
      //minim = new Minim(this);
    
    // canvas size (Variable aren't evaluated. Integers only, please.)
    boolean device = true;
    if(device){
      size(displayWidth, displayWidth); 
      scal = round(displayWidth/720);
      size(720, 1080); 
      scal = round(displayWidth/720);
    }else{
      size(360,540);
      scal = 0.5;
     scal=0.5;
    }
    size(displayWidth, displayHeight);
    
    // limit the number of frames per second
    frameRate(60);
    
    // set the displayWidth of the line. 
    strokeWeight(1);
    
    //PImage ;
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
    option_music = new menuButton("Music is " + music,color(157, 209, 148),color(8, 166, 24),round(width*0.1),round(height/2) - round(round(height/6)/2),round(width*0.8),height/6);
    //red = color(207, 149, 149),color(166, 8, 8)
    //green = color(157, 209, 148),color(8, 166, 24)
      prompt1 = new Prompt("Upcoming features...","- Music\n- More Modes!\n- Much, much more!");
  scalX = width/720;
  scalY = height/1080;
  player = new APMediaPlayer(this);
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
    text("Fresh!",width/2,height/6 + ((96*scal)*1.25));
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
            noStroke();
            ellipse(width/2, height/2, 150*scal, 150*scal);
            fill(100);
            textSize(130*scal);
            textAlign(CENTER,CENTER);
            text(goalNum, width/2, height/2);
            fill(0);
            textAlign(CENTER,TOP);
            textSize(60*scal);
            fill(7,166,153);
            text("Time: " + round(time),width/2,20*(height/1080));
            text("Score: "+score,width/2,20*(height/1080) + (60*scal));
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
            fill(7,166,153);
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
          fill(7,166,153);
          textSize(80*scal);
          text("Options",width/2,scal*10);
          menu_options.draw();
          option_music.draw();
        break;
        case 4:
          background(backgroundColor);
          textAlign(CENTER,TOP);
          fill(7,166,153);
          textSize(80*scal);
          text("Credits",width/2,scal*10);
          textSize(40*scal);
          textAlign(CENTER,CENTER);
          fill(0,abs(sin(frameCount/50)*255),0);
          text("Micah - Original Idea\nVirus - Original Code\nLoki - Programming, code adaption\nWilliam - Design and Graphics\nGrandzam - Music\n\nPlease note that Grandzam's music is currently not available in game due to some incompatibilities.",0,scal*90,width,height-(height/6));
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
            if(credits.checkPressed()){
                gameState = 4;
                startTime = -1;
                score = 0;
                return;
            }
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
               play_action();
               return;
            }
         break;
         case 2:
           if(restart.checkPressed()){
             gameState = 0;
             startTime = millis();
             score = 0;
             stop();
             play_action();
             return;
           }
           if(menu_button.checkPressed()){
              gameState = 1;
              startTime = -1;
              score = 0;
              stop();
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
            if(option_music.checkPressed()){
              //red = color(207, 149, 149),color(166, 8, 8)
              //green = color(157, 209, 148),color(8, 166, 24)
              //color fntClr, color clr
              if(music == "enabled"){
                music = "disabled";
                option_music.txt = "Music is " + music;
                option_music.fntClr = color(207, 149, 149);
                option_music.clr = color(166, 8, 8);
              }else if(music == "disabled"){
                music = "enabled";
                option_music.txt = "Music is " + music;
                option_music.fntClr = color(157, 209, 148);
                option_music.clr = color(8, 166, 24);
              }
              return;
            }
         break;
         case 4:
           if(menu_credits.checkPressed()){
              gameState = 1;
              startTime = -1;
              score = 0;
              return;
            }
         break;
    }
}
 
void draw() {  // this is run repeatedly. 
    textAlign(CENTER, CENTER);
    drawGame();
    //theta+=0.01;
    prompt1.draw();
}
void mouseReleased() {
  if(prompt1.disabled == false){
    prompt1.disable();
    return;
  }
  updateGame();
}
void stop() {
  if(music == "disabled"){
    return;  
  }
  player.seekTo(0);
  player.pause();
}
void play_action() {
  if(music == "disabled"){
    return;  
  }
  player.setMediaFile("zenmode.mp3");
  player.start();
  player.setLooping(true);
  player.setVolume(1.0,1.0);
}
