class Hero extends Entity{
  //States
  boolean hasDoubleJumped = false ;
  //Collision and position
  PVector bodyCenter ;
  //Head
  PShape head ;
  float headRadius ;
  float headProportion = 0.7 ;
  float eyeXpos ;
  float eyeYpos ;
  float pupilRadius ;
  float pupilsPuls = TAU/0.5 ;
  float pupilsTrajRadius ;
  //Legs
  PShape leg ;
  float legPuls ;
  float legWeight ;
  float legLength ;
    //Jump loading
  PShape jumpLoadingPosition = createShape( GROUP ) ;
  float jumpLegAngleTop = TAU*0.15 ;
  float jumpLegAngleBot = TAU*0.1 ;
  float jumpLoadingYshift ;
  float jumpLoadingSpeedAccumulation = 0 ;
  //Jump
  float maxYspeed = 300./framesPerSecond ;
  
  Hero( float x , float y ){
    super( x ,y , width * 0.08 , width * 0.08 *0.9) ;
    //Leg
    legPuls = 5 ;
    legLength = h*(1-headProportion) ;
    legWeight = legLength*0.3 ;
    leg = createShape( RECT , -legWeight/2 , 0 , legWeight , legLength ) ;
    leg.setStroke(false); 
    leg.setFill( #258342 ) ;
      //Jump loading
    jumpLoadingYshift = 0 ;//( cos( jumpLegAngleTop ) + sin( jumpLegAngleBot) ) * legLength/2 ;
    PShape legPartTL = createShape( RECT , -legWeight/2 , 0 , legWeight , legLength/2 ) ;
    PShape legPartTR = createShape( RECT , -legWeight/2 , 0 , legWeight , legLength/2 ) ;
    PShape legPartBL = createShape( RECT , -legWeight/2 , 0 , legWeight , legLength/2 ) ;
    PShape legPartBR = createShape( RECT , -legWeight/2 , 0 , legWeight , legLength/2 ) ;
    legPartTL.setStroke( false ) ; legPartTL.setFill( #258342 ) ; legPartTR.setStroke( false ) ; legPartTR.setFill( #258342 ) ; legPartBL.setStroke( false ) ; legPartBL.setFill( #258342 ) ; legPartBR.setStroke( false ) ; legPartBR.setFill( #258342 ) ;
    //TL
    legPartTL.rotate(jumpLegAngleTop ) ;
    //TR
    legPartTR.rotate(-jumpLegAngleTop ) ;
    //BL
    legPartBL.rotate( jumpLegAngleTop ) ;
    legPartBL.translate( 0 ,legLength/2 ) ;
    legPartBL.rotate( -jumpLegAngleTop - jumpLegAngleBot  ) ;
    //BR
    legPartBR.rotate( -jumpLegAngleTop ) ;
    legPartBR.translate( 0 ,legLength/2 ) ;
    legPartBR.rotate( jumpLegAngleTop + jumpLegAngleBot  ) ;
      //Add child
    jumpLoadingPosition.addChild( legPartTL ) ;
    jumpLoadingPosition.addChild( legPartTR ) ;
    jumpLoadingPosition.addChild( legPartBL ) ;
    jumpLoadingPosition.addChild( legPartBR ) ;
    //Head
    head = createShape( GROUP ) ;
      //Back
    headRadius = h*headProportion /2 ;
    PShape back = createShape( ELLIPSE , 0 , 0 , 2*headRadius , 2*headRadius ) ;
    back.setStroke(false) ;
    back.setFill( #03c11b ) ;
    head.addChild( back ) ;
      //Eyes
    float eyeRadius = headRadius *0.5 /2 ;
    pupilsTrajRadius = eyeRadius * 0.4 ;
    pupilRadius = eyeRadius * 0.2 ;
    eyeYpos = -headRadius * 0.3 ;
    eyeXpos = headRadius * 0.2 ;
    PShape leftEyeBack = createShape( ELLIPSE , -eyeXpos , eyeYpos , 2*eyeRadius , 2*eyeRadius ) ;
    PShape rightEyeBack = createShape( ELLIPSE , eyeXpos , eyeYpos , 2*eyeRadius , 2*eyeRadius ) ;
    leftEyeBack.setStroke(false) ;
    leftEyeBack.setFill( #F2FA14) ;
    rightEyeBack.setStroke(false) ;
    rightEyeBack.setFill( #F2FA14) ;
    head.addChild( leftEyeBack ) ;
    head.addChild( rightEyeBack ) ;
      //Ears
    float earAngle = TAU*0.1 ;
    float earRadius = headRadius * 0.4 ;
    PShape leftEar = createShape( ELLIPSE , headRadius*cos(-earAngle -TAU/4 ) , headRadius*sin(-earAngle -TAU/4 ) , 2*earRadius , 2*earRadius ) ;
    PShape rightEar = createShape( ELLIPSE , headRadius*cos(earAngle -TAU/4 ) , headRadius*sin(earAngle -TAU/4 ) , 2*earRadius , 2*earRadius ) ;
    leftEar.setStroke( false ) ;
    leftEar.setFill( #1B6421 ) ;
    rightEar.setStroke( false ) ;
    rightEar.setFill( #1B6421 ) ;
    head.addChild( leftEar ,0 ) ;
    head.addChild( rightEar ,0 ) ;
      //Mouth
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
    head.addChild( mouth ) ;
    //Hitbox
    w = 2*headRadius ;
    //h = 2*headRadius + legLength ;
    //bodyCenter = newPVector
  }
  
  void show(float x){
    //Legs
      //Jump loading
    if( keyPressed && key == ' ' ){
      shape( jumpLoadingPosition , x , pos.y-h/2+2*headRadius ) ;
    }
      //Walking
    else{
      float legAgl = TAU*0.2* speed.x/speedMax * sin( time()*legPuls ) ;
      leg.resetMatrix() ;
      leg.rotate(legAgl ) ;
      shape(leg , x , pos.y-h/2+2*headRadius) ;
      leg.resetMatrix() ;
      leg.rotate(-legAgl ) ;
      shape(leg , x , pos.y-h/2+2*headRadius) ;
    }
    //Head
    shape( head , x , pos.y - h/2 +headRadius ) ;
      //Pupils
    noStroke() ;
    fill( 0 ) ;
    pushMatrix() ;
      translate( x , pos.y-h/2+headRadius ) ;
      ellipse( -eyeXpos + pupilsTrajRadius*cos( -time()*pupilsPuls +TAU/2 ) , eyeYpos + pupilsTrajRadius*sin( -time()*pupilsPuls +TAU/2 ) , 2*pupilRadius , 2*pupilRadius ) ;
      ellipse( eyeXpos + pupilsTrajRadius*cos( time()*pupilsPuls ) , eyeYpos + pupilsTrajRadius*sin( time()*pupilsPuls ) , 2*pupilRadius , 2*pupilRadius ) ;
    popMatrix() ;
    //Hitbox
    //rectMode(CENTER) ;
    //stroke(0) ;
    //noFill() ;
    //rect( pos.x , pos.y , w , h ) ;
  }
  
  void show(){
    show( pos.x ) ;
  }
  
  void update(float x){
    show(x) ;
    //if( isJumping || abs(speed.y)>EPSILON ){
      applyGravity() ;
    //}
    if( keyPressed && key == ' ' && currentWorld != 2 ){
      jumpLoadingSpeedAccumulation += 5./framesPerSecond ;
    }
  }
  
  void update(){
    update( pos.x ) ;
  }
  
  void jump(){
    if( !hasDoubleJumped ){
      //speed.y -= maxYspeed + jumpLoadingSpeedAccumulation ;
      speed.y = -maxYspeed - jumpLoadingSpeedAccumulation ;
      if( isJumping ){
        hasDoubleJumped = true ;
      }
      else{
        isJumping = true ;
      }
    }
  }
  
  void resolveCollision( Entity thatGuyWhoBumpedIntoMe ){
    if( !thatGuyWhoBumpedIntoMe.isAGhost ){
        //pos.set( prevPos ) ;
        //X collision
        if( !collidedXwith( thatGuyWhoBumpedIntoMe ) ){
          //Speed
          speed.x = xBouncingCoef ;
          //Position
          if( prevPos.x < thatGuyWhoBumpedIntoMe.prevPos.x ){
              pos.x = thatGuyWhoBumpedIntoMe.pos.x - thatGuyWhoBumpedIntoMe.w/2 - w/2 -1 ;
          }
          else{
            pos.x = thatGuyWhoBumpedIntoMe.pos.x + thatGuyWhoBumpedIntoMe.w/2 + w/2 +1 ;
          }
        }
        //Y collision
        if( !collidedYwith( thatGuyWhoBumpedIntoMe ) ){
          //Landing on something
          if( pos.y < thatGuyWhoBumpedIntoMe.pos.y ){
            isJumping = false ;
            hasDoubleJumped = false ;
            if( keyCode == SHIFT ){
              speed.y *= 0 ;
            }
          }
          //Position
          if( prevPos.y < thatGuyWhoBumpedIntoMe.prevPos.y ){
              pos.y = thatGuyWhoBumpedIntoMe.pos.y - thatGuyWhoBumpedIntoMe.h/2 - h/2 -0.1  ;
          }
          else{
            pos.y = thatGuyWhoBumpedIntoMe.pos.y + thatGuyWhoBumpedIntoMe.h/2 + h/2 +0.1 ;
          }
          //Speed
          speed.y *= yBouncingCoef ;
        }
        //Spawn into one another
        else{
          while( collidesWith( thatGuyWhoBumpedIntoMe ) ){
            move() ;
          }
        }
    }
  }
}
