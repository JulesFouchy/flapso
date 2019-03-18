void drawTree( PGraphics pg , float x , float y , int randomSeed ){
  randomSeed(randomSeed) ;
  //Trunk
  float h = random( width*0.1 , width*0.2 ) ;
  float w = width*random( 0.03,0.04) ; 
  //Leaves
  color leafColour1 = color(#44FF12) ;
  color leafColour2 = color(#0F6410) ;
  float leafRadius = width *0.013 ;
  float diskRadius = w*random(1.8,2.1) ;
  
  pg.noStroke() ;
  //Trunk
  pg.fill( #4D1B0E ) ;
  pg.rect( x-w/2 , y-h , w , h ) ;
  //Leaves
  for( int k = 0 ; k < 120 ; ++k ){
    pg.fill( lerpColor( leafColour1 , leafColour2 , random(1) ) ) ;
    float r = random(diskRadius );
    float agl = random(TAU) ;
    pg.ellipse( x +r*cos(agl) , y-h +r*sin(agl) , leafRadius*2 , leafRadius*2 ) ;
  }
}
