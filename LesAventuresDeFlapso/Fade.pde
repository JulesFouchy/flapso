class Fade{
  color colour ;
  float age = 0 ;
  float duration ; 
  boolean fadeIn ;
  
  Fade( color colour , float duration , boolean fadeIn ){
    this.colour = colour ;
    this.duration = duration ;
    this.fadeIn = fadeIn ;
  }
  
  void update(){
      //Draw
    rectMode(CORNER) ;
    noStroke() ;
    if( fadeIn ){
      fill( colour , map( age , 0 , duration , 0 , 255 ) );
      rect(0,0,width,height) ;
    }
    else{
      fill( colour , map( age , 0 , duration , 255 , 0 ) );
      rect(0,0,width,height) ;
    }
      //Age
    age += 1./framesPerSecond ;
  }
}
