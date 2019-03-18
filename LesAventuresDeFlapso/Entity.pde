class Entity{
  PVector pos ;
  PVector prevPos ;
  PVector speed ;
  float speedMax = 200./framesPerSecond ;
  float w ;
  float h ;
  boolean isJumping ;
  float gravity ;
  float xBouncingCoef = 0 ;
  float yBouncingCoef = -0.3 ;
  boolean isFlapso = false ;
  boolean isAGhost = false ;
  boolean isGround = false ;
  boolean isMoveable = true ;
  color colour = color(255) ;
  
  Entity( float x , float y , float w , float h ){
    this.gravity = 0 ;
    pos = new PVector( x , y ) ;
    prevPos = new PVector( x , y ) ; 
    speed = new PVector(0,0) ;
    this.w = w ;
    this.h = h ;
  }
  
  Entity( float x , float y , float w , float h , color colour ){
    this.gravity = 0 ;
    pos = new PVector( x , y ) ;
    prevPos = new PVector( x , y ) ; 
    speed = new PVector(0,0) ;
    this.w = w ;
    this.h = h ;
    this.colour = colour ;
  }
  
  void applyGravity(){
    speed.y += gravity ;
  }
  
  void move(){
    prevPos.set( pos ) ;
    pos.add( speed ) ;
    if( isJumping ){
      //applyGravity() ;
    }
  }
  
  void jump(){
    if( !isJumping ){
      speed.y = -250./framesPerSecond ;
      isJumping = true ;
    }
  }
  
  void show(){
  }
  
  boolean collidesXwith( Entity truc ){
    return ( abs( pos.x - truc.pos.x ) < w/2 + truc.w/2 ) || truc.isGround;
  }
  
  boolean collidesYwith( Entity truc ){
    return abs( pos.y - truc.pos.y ) < h/2 + truc.h/2 ;
  }
  
  boolean collidedXwith( Entity truc ){
    return ( abs( prevPos.x - truc.prevPos.x ) < w/2 + truc.w/2 ) || truc.isGround ;
  }
  
  boolean collidedYwith( Entity truc ){
    return abs( prevPos.y - truc.prevPos.y ) < h/2 + truc.h/2 ;
  }
  
  boolean collidesWith( Entity truc ){
    return collidesXwith( truc ) && collidesYwith( truc ) ;
  }
  
  void resolveCollision( Entity thatGuyWhoBumpedIntoMe ){
    if( !thatGuyWhoBumpedIntoMe.isAGhost ){
      //pos.set( prevPos ) ;
        if( !collidedXwith( thatGuyWhoBumpedIntoMe ) ){
          speed.x = xBouncingCoef ;
          if( prevPos.x < thatGuyWhoBumpedIntoMe.prevPos.x ){
              pos.x = thatGuyWhoBumpedIntoMe.pos.x - thatGuyWhoBumpedIntoMe.w/2 - w/2 ;
          }
          else{
            pos.x = thatGuyWhoBumpedIntoMe.pos.x + thatGuyWhoBumpedIntoMe.w/2 + w/2 ;
          }
        }
        if( !collidedYwith( thatGuyWhoBumpedIntoMe ) ){
          speed.y *= yBouncingCoef ;
          if( prevPos.y < thatGuyWhoBumpedIntoMe.prevPos.y ){
              pos.y = thatGuyWhoBumpedIntoMe.pos.y - thatGuyWhoBumpedIntoMe.h/2 - h/2 ;
          }
          else{
            pos.y = thatGuyWhoBumpedIntoMe.pos.y + thatGuyWhoBumpedIntoMe.h/2 + h/2 ;
          }
        }
        else{
          while( collidesWith( thatGuyWhoBumpedIntoMe ) ){
            move() ;
          }
        }
    }
  }
  
  void checkAndResolveCollision( Entity thatGuyWhoBumpedIntoMe ){
    if( collidesWith( thatGuyWhoBumpedIntoMe ) ){
      resolveCollision( thatGuyWhoBumpedIntoMe ) ;
    }
  }
}
