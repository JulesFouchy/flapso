PShape createLillyFlower( float r ){
  int nbPetals = 24 ;
  float power = 4.5 ;
  PShape lilly = createShape( GROUP ) ;
  for( int k = 0 ; k < nbPetals/2 ; ++k ){
    PShape petal = gaussianPetal( r*2 , power , #D355AE ) ;
    petal.rotate( k*2*TAU/nbPetals ) ;
    lilly.addChild( petal ) ;
  }
  for( int k = 0 ; k < nbPetals/2 ; ++k ){
    PShape petal = gaussianPetal( r*1.3 , power , #FCBAE9 ) ;
    petal.rotate( (k*2+1  )*TAU/nbPetals ) ;
    lilly.addChild( petal ) ;
  }
  return lilly ;
}

  
PShape gaussianPetal( float flowerLength , float flowerPower , color colour ) {
    float windowSize = 3 ; // the window from which the flower function will be ploted
    float maximum = flowerPower * exp( - pow( flowerPower , flowerPower/(1-flowerPower) ) ) ;
    float dx = 5 ;
    PShape s ;
    s = createShape() ;
    s.beginShape() ;
    s.noStroke() ;
    s.fill( colour ) ;
  //Actual shape building
    for( float x = 0 ; x < flowerLength ; x += dx ){
      float xInWindow = map( x , 0 , flowerLength , 0 , windowSize ) ;
      float yInWindow = gaussianBump( xInWindow , flowerPower ) ;
      float y = map( yInWindow , 0 , maximum , 0 , maximum/windowSize*flowerLength ) ;
      s.vertex( x , y ) ;
    }
    for( float x = flowerLength ; x >= 0 ; x -= dx ){
      float xInWindow = map( x , 0 , flowerLength , 0 , windowSize ) ;
      float yInWindow = gaussianBump( xInWindow , flowerPower ) ;
      float y = yInWindow * flowerLength/windowSize ;
      s.vertex( x , -y ) ;
    }
  //End of shape
    s.endShape() ;
    return s ;
}

float gaussianBump( float x , float flowerPower ){ 
  return x * exp( - pow( x , flowerPower ) ) ;
}
