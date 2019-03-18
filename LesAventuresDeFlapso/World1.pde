class World1 extends World{
  //House
  House house ;
  //Background
  MovingBackground bg ;
  //Drawing for the fairies
  PGraphics drawingForTheFairies ;
  float drawingScaleFactor = 0.3 ;
  //Physics
  float groundHeight = 150 ;
  float gravity = 20./framesPerSecond ;
  //Key
  PShape theKey ;
  //Walls
  Ground ground ;
  //Colours
  color skyColour = color( #12D1FF ) ;
  //Fade
  Fade fade = new Fade( color(255) , 1.5 , false ) ;
  //Events
  boolean hasNotBeenThanked = true ;
  
  //Constructor
  World1( Hero flapso ){
    super( flapso ) ;
    hasVisitedTheFairies = false ;
    hasTheKey = false ;
    //Sign
    signPosition = 3*width ;
    //House
    house = new House( width/2 , height - groundHeight ) ;
    //Ground
    ground = new Ground( width/2 , height , width , groundHeight*2 , color(#4DE02D) ) ;
    //Key
    theKey = createKey() ;
    //Background
    bg = new MovingBackground() ;
    bg.pg.beginDraw() ;
      //Sky
    bg.pg.background( skyColour ) ;
      //Trees
    for( int k = 0 ; k < 35 ; k++){
      int randomSeed = int(random(10000)) ;
      float xTreePos = random(bg.pg.width) ;
      drawTree( bg.pg , xTreePos , height-groundHeight , randomSeed) ;
      drawTree( bg.pg , xTreePos +bg.pg.width , height-groundHeight , randomSeed) ;
      drawTree( bg.pg , xTreePos -bg.pg.width, height-groundHeight , randomSeed) ;
    }
      //
    bg.pg.endDraw() ;
  }
  
  void setup(Hero flapso , float x , float y , PGraphics drawing ){
    drawingForTheFairies = drawing ;
    this.flapso = flapso ;
    flapso.gravity = gravity ;
    //Physics
    flapso.xBouncingCoef = 0 ;
    flapso.yBouncingCoef = 0 ;
    flapso.pos.set( x , y ) ;
    flapso.maxYspeed = 300./framesPerSecond ;
  }
  
  void setup(Hero flapso){
    setup(flapso , width*0.75 , height-groundHeight-flapso.h/2-1 , createGraphics(1,1) ) ;
  }
  
  void draw(){
    //Background
    bg.show(width/2-flapso.pos.x);
    //Drawing for the fairies
    if( hasVisitedTheFairies ){
        //Draw
      image( drawingForTheFairies , -flapso.pos.x+width/2 + (1-drawingScaleFactor)*width/2, 0 , drawingScaleFactor*width , drawingScaleFactor*height ) ;
      //imageBlend( drawingForTheFairies , -flapso.pos.x+width/2 + (1-drawingScaleFactor)*width/2, 0 , drawingScaleFactor*width , drawingScaleFactor*height , 200 ) ;
        //Alpha blending
      rectMode(CORNER) ;
      noStroke() ;
      fill( skyColour , 200) ;
      rect( -flapso.pos.x+width/2 + (1-drawingScaleFactor)*width/2, 0 , drawingScaleFactor*width , drawingScaleFactor*height ) ;
    }
    //House
    house.show(-flapso.pos.x+width) ;
    //Key sign
    if( !hasTheKey ){
      sign( -flapso.pos.x + signPosition , height - groundHeight , theKey) ;
    }
    else{
      sign( -flapso.pos.x + signPosition , height - groundHeight , createShape()) ;
    }
    //Perso principal
      //Move
    flapso.move() ;
      //Check collisions
    flapso.checkAndResolveCollision( ground ) ;
      //Show
    flapso.update(width/2) ;
      //Has the key
    if( hasTheKey && !house.doorIsOpen ){
      shape( theKey , width/2 , flapso.pos.y -flapso.h*1.1 ) ;
    }
    
    //Ground
    ground.show() ;
    
    //Fade
    if( hasVisitedTheFairies && fade.age < fade.duration ){
      fade.update() ;
    }
    
    //Events
      //Warp to cloud land
    if( abs(flapso.pos.x - signPosition + width/2) < width*0.1 && flapso.pos.y < 0 && !hasVisitedTheFairies){
      currentWorld = 2 ;
      worlds[currentWorld].setup( flapso ) ;
    }
      //Thank you Flapso
    if( hasVisitedTheFairies && abs(flapso.pos.x) < width*1.1 && hasNotBeenThanked ){
      PShape bulle = cloud( width * 0.09 , width*0.09/2, TAU*0.002 ) ;
      texts.add( new Text( width , height*0.2 , 3 , bulle , fontHandwritten , "Merci Flapso" , true ) ) ;
      hasNotBeenThanked = false ;
    }
      //Open the door
    if( abs(flapso.pos.x - house.doorX) < flapso.w/2 + house.doorW/2 && hasTheKey ){
      house.doorIsOpen = true ;
    }
    
    //Arrêter de bouger
    if( !keyPressed ){
      flapso.speed.x = 0 ;
    }
  }
}
