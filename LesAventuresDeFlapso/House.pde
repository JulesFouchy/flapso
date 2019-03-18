class House{
  //Event
  boolean doorIsOpen = false ;
  //Position
  float x ;
  float y ;
  //Base
  PShape base ;
  float w = 0.23*width ;
  float h = w*0.65 ;
  color baseColour = color( #FEBFFF) ;
  //Roof
  float roofHeight = h ;
  color roofColour = color( #B70909 ) ;
  //Window
  float windowXratio = 0.75 ;
  float windowYratio = 0.25 ;
  float windowRadius = 0.1*w ;
  //Silhouette
  float bodyRadius = windowRadius*0.9 ;
  float headRadius = windowRadius*0.45 ;
  float silhouetteX(){
    return x + (w/2-bodyRadius)*( (time()*0.1)%2 -1) ;
  }
  float silhouetteY ; 
  //Cheminée
  float chemineeHeight = roofHeight*0.8 ;
  float chemineeWeight = chemineeHeight*0.2 ;
  float xCheminee(float x){
    return x -w/2 + w*0.3 ;
  }
  float yCheminee ;
  //Smoke
  ArrayList<SmokeParticle> smokeParticles ;
  //Door
  float doorXratio = 0.3 ;
  float doorW = 0.2*w ;
  float doorH = doorW*1.8 ;
  float doorX = x - w/2 + doorXratio * w + width/2 ;
  
  House( float x , float y ){
    this.x = x ;
    this.y = y ;
    //Silhouette
    silhouetteY = y - h + windowYratio * h + windowRadius ;
    //Base
    base = createShape() ;
      //rect
    base.beginShape() ;
    base.noStroke() ;
    base.fill( baseColour ) ;
    base.vertex( - w/2 , - h ) ;
    base.vertex(   w/2 , - h ) ;
    base.vertex(   w/2 , 0 ) ;
    base.vertex( - w/2 , 0 ) ;
    base.vertex( - w/2 , - h ) ;
      //Window contour
    base.beginContour() ;
    for( float agl = TAU/2 ; agl >= -TAU/2-EPSILON ; agl -=0.01*TAU ){
      base.vertex( - w/2 + windowXratio * w + windowRadius*cos(agl), - h + windowYratio * h + windowRadius*sin(agl)) ;
    }
    base.endContour() ;
    base.endShape() ;
    //Cheminée
    yCheminee = y -h ;
    //Smoke
    smokeParticles = new ArrayList<SmokeParticle>() ;
  }
  
  void silhouette( float x , float y ){
    noStroke() ;
    fill(0) ;
    ellipse( x , y , 2*bodyRadius , 2*bodyRadius) ;
    ellipse( x , y-bodyRadius , 2*headRadius , 2*headRadius ) ;
  }
  
  void window(float x , float y){
    stroke( 0 ) ;
    strokeWeight( 0.007*w ) ;
    fill( #FFEA24 ) ;
    ellipse( x , y , windowRadius*2 , windowRadius*2 ) ;
    strokeWeight( 0.005*w ) ;
    line( x - windowRadius , y , x + windowRadius , y ) ;
    line( x , y - windowRadius , x , y + windowRadius ) ;
    strokeWeight(1) ;
  }
  
  void door( float x , float y ){
    if( !doorIsOpen ){
      //Base
      strokeWeight(2) ;
      stroke(0) ;
      fill( #5A2A0F ) ;
      rect( x , y -doorH/2 , doorW , doorH ) ;
      //Stripes
      for( int k = 0 ; k < 3 ; ++k ){
        stroke( #A79B93 ) ;
        strokeWeight(0.5) ;
        line( x -doorW/2 + (k+1) * doorW/4 , y -doorH ,x-doorW/2 + (k+1) * doorW/4 , y ) ;
        strokeWeight(1) ;
      }
      //Lock
      noStroke() ;
      fill(0) ;
      float xLock = x -doorW/2 +doorW*0.85 ;
      float yLock = y -doorH*0.5 ;
      float weigthLock =  doorW * 0.2 ;
      float lockHeight = doorH * 0.2 ;
      ellipse( xLock , yLock , weigthLock , weigthLock ) ;
      triangle( xLock , yLock-weigthLock/2 , xLock - weigthLock/2 , yLock + lockHeight ,  xLock + weigthLock/2 , yLock + lockHeight ) ;
    }
    else{
      //Base
      fill( 0 ) ;
      rect( x , y -doorH/2 , doorW , doorH ) ;
    }
  }
  
  void show( float x ){
    noStroke() ;
    //Window
    window( x - w/2 + windowXratio * w , y - h + windowYratio * h ) ;
    //Silhouette
    silhouette( silhouetteX() +x-width/2 , silhouetteY ) ;
    //Base
    shape( base , x , y ) ;
    //Cheminée
    fill( #AD2C0C ) ;
    rectMode( CENTER ) ;
    rect( xCheminee(x) - chemineeWeight/2 , yCheminee - chemineeHeight/2 , chemineeWeight , chemineeHeight ) ;
    //Smoke
      //Show
    for( int k = smokeParticles.size()-1 ; k >=0 ; --k ){
      SmokeParticle smoke = smokeParticles.get(k) ;
      smoke.update(x) ;
      if( smoke.age > smoke.lifeSpan ){
        smokeParticles.remove(k) ;
      }
    }
      //Add
    if( random(1) < 2./framesPerSecond ){
      smokeParticles.add( new SmokeParticle( x , -random(chemineeWeight)-w/2 + w*0.3  , yCheminee - chemineeHeight ) ) ;
    }
    //Roof
    fill( roofColour ) ;
    beginShape() ;
    vertex( x - w/2 , y - h ) ;
    vertex( x + w/2 , y - h ) ;
    vertex( x , y - h - roofHeight ) ;
    endShape() ;
    //Door
    door( x - w/2 + doorXratio * w , y  ) ;
  }
  
  void show(){
    show(x) ;
  }
}
