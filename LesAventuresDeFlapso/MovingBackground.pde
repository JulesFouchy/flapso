class MovingBackground{
  PGraphics pg ;
  
  MovingBackground(){
    pg = createGraphics(2*width,height) ;
  }
  
  void show(float x){
    x = x%pg.width ;
    image( pg , x + width/2 - pg.width/2 , 0 ) ;
    image( pg , x + width/2 - pg.width/2 - pg.width , 0 ) ;
    image( pg , x + width/2 - pg.width/2 + pg.width , 0 ) ;
    //Borders
    //stroke(0) ;
    //noFill() ;
    //rectMode(CORNER) ;
    //rect(x + width/2 - pg.width/2 , 0 , pg.width , pg.height ) ;
  }
}
