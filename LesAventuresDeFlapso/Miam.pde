class Miam extends Entity{
  boolean wasEaten = false ;
  PShape s ;
  
  Miam(float x , float y , float r){
    super( x , y , 2*r , 2*r ) ;
    isAGhost = true ;
    s = createLillyFlower( r ) ;
  }
  
  void resolveCollision( Entity thatGuyWhoBumpedIntoMe ){
    if( thatGuyWhoBumpedIntoMe.isFlapso && !wasEaten ){
      wasEaten = true ;
      if( !miamSound.isPlaying() ){
        miamSound.play() ;
      }
    }
    if( !thatGuyWhoBumpedIntoMe.isMoveable ){
      speed.y = -15 ;
      while( collidesWith( thatGuyWhoBumpedIntoMe ) ){
         move() ;
      }
      speed.y = 0 ;
    }
  }
  
  void show(){
    if( !wasEaten ){
      noStroke() ;
      fill( #FAA7FF ) ;
      ellipse( pos.x , pos.y , w , h ) ;
      //shape( s , pos.x , pos.y ) ;
    }
  }
}
