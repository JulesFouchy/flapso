void drawStar( PGraphics pg , float x , float y , int nbBranches , float innerR , float outerR ){
  pg.beginShape() ;
  for( int k = 0 ; k < nbBranches ; ++k ){
    pg.vertex( x+ outerR*cos( 2*k*TAU/nbBranches/2 -TAU/4 ) , y+ outerR*sin( 2*k*TAU/nbBranches/2 -TAU/4) ) ;
    pg.vertex( x+ innerR*cos( (2*k+1)*TAU/nbBranches/2 -TAU/4) , y+ innerR*sin( (2*k+1)*TAU/nbBranches/2 -TAU/4)) ;
  }
  pg.endShape() ;
}
