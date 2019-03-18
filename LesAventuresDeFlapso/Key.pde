PShape createKey(){
  color col = color(#FFCD03) ; 
  PShape key = createShape( GROUP ) ;
  //Hole
  PShape hole = createShape() ;
  float outerR = width*0.009 ;
  float innerR = outerR*0.6 ;
  hole.beginShape() ;
  hole.noStroke() ;
  hole.fill(col) ;
    //Outer circle
  for( float agl = 0 ; agl <= TAU ; agl += 0.02*TAU ){
    hole.vertex( outerR*cos(agl) , outerR*sin(agl) ) ;
  }
  hole.vertex( outerR*cos(TAU) , outerR*sin(TAU) ) ;
    //Inner circle
  hole.beginContour() ;
  for( float agl = TAU ; agl >= 0 ; agl -= 0.02*TAU ){
    hole.vertex( innerR*cos(agl) , innerR*sin(agl) ) ;
  }
  hole.vertex( innerR*cos(0) , innerR*sin(0) ) ;
  hole.endContour() ;
  hole.endShape() ;
  key.addChild( hole ) ;
  //Long rect
  float longRectLength = outerR*2.3 ;
  float longRectWidth = longRectLength*0.25 ;
  PShape longRect = createShape( RECT , -longRectWidth/2 , outerR , longRectWidth , longRectLength ) ;
  longRect.setStroke(false) ;
  longRect.setFill( col ) ;
  key.addChild( longRect ) ;
  //Teeth
  PShape teeth = createShape() ;
  float teethStart = longRectLength*0.25 ;
  float teethEnd = longRectLength*0.85 ;
  float minToothLength = longRectWidth*0.5  ;
  float maxToothLength = longRectWidth*1.2 ;
  float toothRange = maxToothLength - minToothLength ;
  teeth.beginShape() ;
  teeth.noStroke() ;
  teeth.fill( col ) ;
  teeth.vertex( longRectWidth/2 , outerR + teethEnd ) ;
  teeth.vertex( longRectWidth/2 , outerR + teethStart ) ;
  float y = outerR + teethStart ;
  float x = minToothLength + toothRange*random(0.05,0.1) ;
  int sgn = 1 ;
  while( y < outerR + teethEnd ){
    teeth.vertex( longRectWidth/2 + x  , y ) ;
    x = (minToothLength+maxToothLength)/2 + sgn*random( 0.35*toothRange , 0.4*toothRange ) ;
    sgn *= -1 ;
    teeth.vertex( longRectWidth/2 + x  , y ) ;
    y+= (teethEnd-teethStart)*random(0.25,0.3) ;
  }
  teeth.vertex( longRectWidth/2 + x  , outerR + teethEnd ) ;
  teeth.endShape() ;
  key.addChild( teeth ) ;
  
  return key ;
}
