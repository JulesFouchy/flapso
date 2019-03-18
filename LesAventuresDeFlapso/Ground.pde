class Ground extends Entity{
  Ground( float x , float y , float w , float h ){
    super( x , y , w , h ) ;
    isMoveable = false ;
    isGround = true ;
  }
  
  Ground( float x , float y , float w , float h , color colour ){
    super( x , y , w , h , colour ) ;
    isMoveable = false ;
    isGround = true ;
  }
  
  void show(){
    rectMode( CENTER ) ;
    noStroke() ;
    fill( colour ) ;
    rect( width/2 , pos.y , width , h ) ; 
  }
}
