class Text{
  float x , y ;
  color colour ;
  String text ;
  float age = 0 ;
  float duration ;
  PShape bulle ;
  PFont font ;
  boolean isFixed = false ;
  
  float transparency(){
    if( age < 1 ){
      return map( age , 0 , 1 , 0 , 255 ) ;
    }
    else if( age < duration - 1 ){
      return 255 ;
    }
    else{
      return map( age , duration-1 , duration , 255 , 0 ) ;
    }
  }
  
  Text( float x , float y , float duration , String text , PShape bulle , PFont font , color colour ){
    this.x = x ;
    this.y = y ;
    this.colour = colour ;
    this.duration = duration ;
    this.text = text ;
    this.bulle = bulle; 
    this.font = font ;
  }
  
  Text( float x , float y , float duration , PShape bulle , PFont font , String text ){
    this.x = x ;
    this.y = y ;
    this.colour = color(0) ;
    this.duration = duration ;
    this.text = text ;
    this.bulle = bulle; 
    this.font = font ;
  }
  
    Text( float x , float y , float duration , String text , PShape bulle , PFont font , color colour , boolean isFixed ){
    this.x = x ;
    this.y = y ;
    this.colour = colour ;
    this.duration = duration ;
    this.text = text ;
    this.bulle = bulle; 
    this.font = font ;
    this.isFixed = isFixed ;
  }
  
  Text( float x , float y , float duration , PShape bulle , PFont font , String text , boolean isFixed ){
    this.x = x ;
    this.y = y ;
    this.colour = color(0) ;
    this.duration = duration ;
    this.text = text ;
    this.bulle = bulle; 
    this.font = font ;
    this.isFixed = isFixed ;
  }
  
  void show(){
    if( isFixed ){
      shape( bulle , x - flapso.pos.x , y ) ;
      textAlign( CENTER , CENTER ) ;
      textSize( width * 0.05 ) ;
      textFont( font , 80 ); 
      fill( colour , transparency() ) ;
      text( text , x - flapso.pos.x, y ) ;
    }
    else{
      shape( bulle , x , y ) ;
      textAlign( CENTER , CENTER ) ;
      textSize( width * 0.05 ) ;
      textFont( font , 80 ); 
      fill( colour , transparency() ) ;
      text( text , x , y ) ;
    }
  }
  
  void update(){
    show() ;
    age += 1./framesPerSecond ;
  }
}

class Texts{
  ArrayList<Text> texts ;
  
  Texts(){
    texts = new ArrayList<Text>() ;
  }
  
  void add( Text text ){
    texts.add( text ) ;
  }
  
  void update(){
    int k = texts.size()-1 ;
    if( k >= 0 ){
      Text text = texts.get(k) ;
      text.update() ;
      if( text.age > text.duration ){
        texts.remove(k) ;
      }
    }
  }
}
