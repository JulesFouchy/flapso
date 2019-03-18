class World{
  float signPosition ;
  boolean hasVisitedTheFairies ;
  boolean hasTheKey ;
  //Hero
  Hero flapso ;
  
  World( Hero flapso ){
    //Hero
    this.flapso = flapso ;
  }
  
  void setup( Hero flapso ){
  }
  void setup( Hero flapso , float x , float y , PGraphics pg ){
  }
  void draw(){
  }
  void keyPressed(){
    //Move left
    if( key == 'q' ){
      flapso.speed.x = -flapso.speedMax ;
    }
    //Move right
    if( key == 'd' ){
      flapso.speed.x = flapso.speedMax ;
    }
    if( key ==' ' ){
      flapso.h -= flapso.jumpLoadingYshift ;
      flapso.pos.y += flapso.jumpLoadingYshift ;
    }
  }
  void keyReleased(){
    //Jump
    if( key ==' ' ){
      flapso.jump() ;
      key = '!' ;
      flapso.h += flapso.jumpLoadingYshift ;
      flapso.pos.y -= flapso.jumpLoadingYshift ;
      flapso.jumpLoadingSpeedAccumulation = 0 ;
    }
  }
  void mousePressed(){
  }
  void mouseWheel(MouseEvent event){
  }
  void mouseDragged(){
  }
}

class World0 extends World{
  //Physics
  float gravity = 25./framesPerSecond ;
  //Walls
  Wall ground ;
  Wall ceiling ;
  ArrayList<Wall> obstacles ;
  //Miams
  int nbMiams = 30 ;
  ArrayList<Miam> miams ;
  //Final animation
  boolean hasFinishedTheLevel(){
    return miams.size() == 0 ;
  }
  PGraphics animationBg ;
  
  //Constructor
  World0( Hero flapso ){
    super( flapso ) ;
    //Ground
    ground = new Wall( width/2 , height , width , 100 , color(#FF69B4) ) ;
    flapso.pos.y = height-150 ;
    ceiling = new Wall( width/2 , -50 , width , 100 ) ; 
    //Obstacles
    obstacles = new ArrayList<Wall>() ;
    for( int k = 0 ; k < 3 ; ++k ){
      obstacles.add( new Wall( random(width) , random(height*0.3,height*0.7) , random(100,300) , 50 , color(#FF69B4) ) ) ;
    }
    //Miams
    miams = new ArrayList<Miam>() ;
    for( int k = 0 ; k < nbMiams ; ++k ){
      Miam miam = new Miam( random(width) , random(50,height-50) , 7.5 )  ;
      for( Wall obstacle : obstacles ){
        miam.checkAndResolveCollision( obstacle ) ;
      }
      miams.add( miam ) ;
    }
    //Animation
    animationBg = createGraphics( width , height ) ;
  }
  
  void setup( Hero flapso ){
    this.flapso = flapso ;
    flapso.gravity = gravity ;
    //Physics
    flapso.pos.set( width/2 , height-50-flapso.h/2 - 1 ) ;
    flapso.xBouncingCoef = 0 ;
    flapso.yBouncingCoef = -0.95 ;
    flapso.maxYspeed = 500./framesPerSecond ;
  }
  
  void draw(){
    background(0);
    //Animation
    if( hasFinishedTheLevel() ){
      animationBg.beginDraw() ;
      animationBg.noStroke();
      animationBg.fill(0,45) ;
      animationBg.rect(0,0,width,height) ;
      for( int k = 0 ; k <10 ; k++ ){
        animationBg.fill(#FFE308) ;
        drawStar( animationBg , random(width) , random(height) , 5 , 20 , 50 ) ;
        //animationBg.ellipse( random(width) , random(height) , 20 , 20 ) ;
      }
      animationBg.endDraw() ;
    }
    image( animationBg , 0, 0 ) ;
    
    //Miam counter
    textSize(width*0.02) ;
    text( nbMiams-miams.size() + " sur " + nbMiams , width*0.8 , height*0.1 ) ;
    //Perso principal
      //Move
    flapso.move() ;
      //Check collisions
    flapso.checkAndResolveCollision( ground ) ;
    flapso.checkAndResolveCollision( ceiling ) ;
    for( Wall obstacle : obstacles ){
      flapso.checkAndResolveCollision( obstacle ) ;
    }
      //Show
    flapso.update() ;
    
    //Ground
    ground.show() ;
    ceiling.show() ;
    
    //Obstacles
    for( Wall obstacle : obstacles ){
      obstacle.show() ;
    }
    
    //Miams
    for ( int k = miams.size()-1 ; k>=0 ; --k){
      Miam miam = miams.get(k) ;
      miam.checkAndResolveCollision( flapso ) ;
      if( miam.wasEaten ){
        miams.remove(k) ;
      }
      miam.show() ;
    }
    
    //Arrêter de bouger
    if( !keyPressed ){
      flapso.speed.x = 0 ;
    }
  }
 
}
