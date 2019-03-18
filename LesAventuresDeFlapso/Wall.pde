class Wall extends Entity{
  Wall( float x , float y , float w , float h ){
    super( x , y , w , h ) ;
    isMoveable = false ;
  }
  
  Wall( float x , float y , float w , float h , color colour ){
    super( x , y , w , h , colour ) ;
    isMoveable = false ;
  }
  
  void show(){
    rectMode( CENTER ) ;
    noStroke() ;
    fill( colour ) ;
    rect( pos.x , pos.y ,w , h ) ; 
  }
}
