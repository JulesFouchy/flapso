void sign( float x , float y , PShape theKey){
  float baseWeight = width*0.03 ;
  float baseHeight = baseWeight*1.5 ; 
  float arrowOffsetX = baseWeight*0.5 ;
  float arrowOffsetY = baseHeight *0.15 ;
  float arrowHeight = baseHeight ;
  beginShape() ;
  stroke(0) ;
  fill( #935D31 ) ;
  vertex( x- baseWeight/2 , y ) ;
  vertex( x+ baseWeight/2 , y ) ;
  vertex( x+ baseWeight/2 , y -baseHeight ) ;
  vertex( x+ baseWeight/2 +arrowOffsetX , y -baseHeight +arrowOffsetY ) ;
  vertex( x , y - baseHeight - arrowHeight ) ;
  vertex( x- baseWeight/2 -arrowOffsetX , y -baseHeight +arrowOffsetY ) ;
  vertex( x- baseWeight/2 , y -baseHeight ) ;
  endShape(CLOSE) ;
  shape( theKey , x , y - baseHeight ) ;
}
