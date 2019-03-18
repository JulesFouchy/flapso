class Fairy {  
  int noiseSeed = int(random(1000)) ;
  PVector pos ;
  PShape s ;
  //Body
  float bodyHeight = width *0.03 ;
  float bodyWeight = bodyHeight*0.618 ;
  //Head
    //Back
  float headRadius = bodyHeight*0.6 /2;
    //Eyes
  float eyeX = headRadius *0.33 ;
  float eyeY = -headRadius *0.21 ;
  float eyeRadius = headRadius *0.28 ;
    //Pupils
  float pupilX = eyeX ;
  float pupilY = eyeY ;
  float pupilRadius = eyeRadius*0.28 ;
  //Wing
  PShape wing ;
  float wingLength = bodyHeight*1 ;
  float wingWeight = bodyWeight * 0.75 ;
  float wingMinAngle = TAU *0.055 ;
  float wingMaxAngle = TAU * 0.075 ;
  float wingYoffset = bodyHeight*0.32 ;
  float wingPuls = 13 ;
  
  Fairy(float x , float y ){
    pos = new PVector( x , y ) ;
    //Show
    s = createShape( GROUP ) ;
      //Body
    PShape body = createShape( TRIANGLE , 0 , 0 , -bodyWeight/2 , bodyHeight , bodyWeight/2 , bodyHeight ) ;
    body.setStroke(false) ;
    body.setFill( #FAC5DF ) ;
    s.addChild( body ) ;
      //Head
    PShape head = createShape( ELLIPSE , 0 , 0 , 2*headRadius , 2*headRadius ) ;
    head.setStroke(false) ;
    head.setFill( #FFE44B ) ;//#FFE134) ;//#FFF979 ) ;
    s.addChild( head ) ;
      //Eyes
    PShape leftEye = createShape( ELLIPSE , -eyeX , eyeY , 2*eyeRadius , 2*eyeRadius ) ;
    leftEye.setStroke(false);
    leftEye.setFill( 255 ) ;
    s.addChild( leftEye ) ;
    PShape rightEye = createShape( ELLIPSE , +eyeX , eyeY , 2*eyeRadius , 2*eyeRadius ) ;
    rightEye.setStroke(false);
    rightEye.setFill( 255 ) ;
    s.addChild( rightEye ) ;
      //Pupils
    PShape leftPupil = createShape( ELLIPSE , -pupilX , pupilY , 2*pupilRadius , 2*pupilRadius ) ;
    leftPupil.setStroke(false);
    leftPupil.setFill( 0 ) ;
    s.addChild( leftPupil ) ;
    PShape rightPupil = createShape( ELLIPSE , pupilX , pupilY , 2*pupilRadius , 2*pupilRadius ) ;
    rightPupil.setStroke(false);
    rightPupil.setFill( 0 ) ;
    s.addChild( rightPupil ) ;
      //Smile
    PShape mouth = createShape() ;
    mouth.beginShape() ;
    mouth.noStroke() ;
    mouth.fill( 255 ) ;
    float mouthUpRadius = headRadius * 0.9 ;
    float mouthBotRadius = headRadius * 0.6 ;
    float mouthY = headRadius* 0.13 ;
    float mouthUpAngle = asin( mouthBotRadius / mouthUpRadius ) ;
    for( float angle = -mouthUpAngle ; angle <= mouthUpAngle ; angle += 0.01*TAU ){
      mouth.vertex( mouthUpRadius*cos(angle +TAU/4) ,  mouthY-sqrt(sq(mouthUpRadius)-sq(mouthBotRadius) ) + mouthUpRadius*sin(angle+TAU/4) ) ;
    }
    for( float angle = TAU/4 ; angle >= -TAU/4 ; angle -= 0.01*TAU ){
      mouth.vertex( mouthBotRadius*cos(angle +TAU/4) , mouthY+ mouthBotRadius*sin(angle +TAU/4) ) ;
    }
    mouth.endShape() ;
    s.addChild( mouth ) ;
  }
  
  void wing(){
    beginShape() ;
    noStroke() ;
    fill( #ABF4FC , 200 ) ;
    curveVertex( 0 , 0 ) ;
    curveVertex( 0 , 0 ) ;
    curveVertex( 0 + wingLength , 0 + wingWeight/2 ) ;
    curveVertex( 0 + wingLength*1.3 , 0 ) ;
    curveVertex( 0 + wingLength , 0 -wingWeight/2 ) ;
    curveVertex( 0 + 0 , 0 ) ;
    curveVertex( 0 + 0 , 0 ) ;
    endShape() ;
  }
  
  void showRandomly(){
    float x = pos.x + 40*(noise( time()*0.3 +noiseSeed ) -0.5) ;
    float y = pos.y + 100*(noise( time()*0.4 +100 +noiseSeed ) -0.5) ;
    float angle = map( sin(time()*wingPuls)  , -1 , 1 , wingMinAngle , wingMaxAngle ) ;
      //Wing
    pushMatrix() ;
    translate( x , y + wingYoffset ) ;
    pushMatrix() ;
      rotate( angle ) ;
      wing() ;
    popMatrix() ;
    pushMatrix() ;
      rotate( -angle ) ;
      wing() ;
    popMatrix() ;
    pushMatrix() ;
      rotate( PI + angle ) ;
      wing() ;
    popMatrix() ;
    pushMatrix() ;
      rotate( PI - angle ) ;
      wing() ;
    popMatrix() ;
    popMatrix() ;
      //Body
    shape( s , x , y ) ;
  }
}
