void cloud( PGraphics pg , float x , float y ){
  float hAxis = width *0.033 ;
  float vAxis = hAxis * 2 ;
  float ballR = width * 0.02 ;
  for( float agl = 0 ; agl <= TAU ; agl += 0.0065*TAU ){
    pg.noStroke() ;
    pg.fill( #D1FAF7 , 50 ) ;
    float t = random(1) ;
    pg.ellipse( x +t*vAxis*cos(agl), y +t*hAxis*sin(agl) , 2*ballR , 2*ballR ) ;
  }
}

PShape cloud( float vAxis , float hAxis , float dAgl ){
  PShape s = createShape( GROUP ) ;
  float ballR = width * 0.02 ;
  for( float agl = 0 ; agl <= TAU ; agl += dAgl ){
    float t = random(1) ;
    PShape ell = createShape( ELLIPSE , t*vAxis*cos(agl) , t*hAxis*sin(agl) , 2*ballR , 2*ballR ) ;
    ell.setStroke(false) ;
    ell.setFill( #D1FAF7 ) ;
    s.addChild( ell ) ;
  }
  return s ;
}

PShape cloud( float vAxis , float hAxis ){
  return cloud( vAxis , hAxis , 0.0065*TAU ) ;
}
