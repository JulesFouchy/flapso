import processing.sound.* ;
SoundFile miamSound ;
boolean isFilming = false ;

//Game settings
int framesPerSecond = 25 ;
//Hero
Hero flapso ;
//Worlds
int currentWorld = 1 ;
int nbWorlds = 3 ;
World[] worlds ;
//Texts
Texts texts ;
//Fonts
PFont standardFont ;
PFont fontHandwritten ;
//Menu
Menu menu ;

void setup(){
  fullScreen() ;
  frameRate(framesPerSecond) ;
  //Variables creation
    //Hero
  flapso = new Hero( width/2 , height*0.7 ) ;
  flapso.isFlapso = true ;
  flapso.isJumping = true ;
  
    //Texts
  texts = new Texts() ;
    //Fonts
  standardFont = loadFont( "rockwellNova60.vlw" ) ;
  fontHandwritten = loadFont("rainbowDreams80.vlw");
    //Worlds creation
  worlds = new World[nbWorlds] ;
  worlds[0] = new World0( flapso ) ;
  worlds[1] = new World1( flapso ) ;
  worlds[2] = new World2( flapso ) ;
    //World loading
  worlds[currentWorld].setup( flapso ) ;
  //Sounds loading
  miamSound = new SoundFile(this, "miam.mp3");
  miamSound.amp(0.3) ;
  //Menu
  menu = new Menu() ;
}

void draw(){
  worlds[currentWorld].draw() ;
  texts.update() ;
  if( isFilming ){
    saveFrame("film/#####.tiff") ;
  }
  menu.show() ;
}

void keyPressed(){
  if( key =='s' ){
    //isFilming = true ;
  }
  //Screenshots
  if( key == 'e' ){
    save( "screenshots/"+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png") ;
  }
  //Open or close menu
  if( key =='m' ){
    menu.isOpen = !menu.isOpen ;
  }
  worlds[currentWorld].keyPressed() ;
}

void keyReleased(){
  worlds[currentWorld].keyReleased() ;
}

void mousePressed(){
  menu.checkClick() ;
  worlds[currentWorld].mousePressed() ;
}

void mouseDragged(){
  worlds[currentWorld].mouseDragged() ;
}

void mouseWheel(MouseEvent event) {
  worlds[currentWorld].mouseWheel(event) ;
}
