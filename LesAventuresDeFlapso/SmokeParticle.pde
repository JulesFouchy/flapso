class SmokeParticle{
  PVector pos ;
  float r = 20 ;
  float age = 0 ;
  float lifeSpan = 8 ;
  float x0 ;
  float xOffset ;
  
  SmokeParticle( float x , float xOffset , float y ){
    pos = new PVector( x ,y ) ;
    x0 = x ;
    this.xOffset = xOffset ;
  }
  
  float transparency(){
    if( age < 1 ){
      return map( age , 0 , 1 , 0 , 225 ) ;
    }
    else if( age < lifeSpan-1 ){
      return 225 ;
    }
    else{
      return map( age , lifeSpan-1 , lifeSpan , 225 , 0 ) ;
    }
  }
  
  void move(){
    pos.add( 0.1*(noise(time()*0.03)-0.5) , -1 ) ;
  }
  
  void show(float x){
    noStroke() ;
    fill( #E3E3E3 , transparency() ) ;
    ellipse( x-x0 + pos.x + xOffset , pos.y , 2*r , 2*r ) ;
  }
  
  void update(float x){
    move() ;
    age += 1./framesPerSecond ;
    show(x) ;
  }
}
