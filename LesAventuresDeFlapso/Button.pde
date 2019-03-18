class Button{
  float x , y ;
  float w , h ;
  String text ;
  float txtSize ;
  PShape box ;
  PFont font ;
  
  Button( float x , float y , String boxType , String text , float txtSize , PFont font ){
    this.x = x ;
    this.y = y ;
    this.text = text ;
    this.txtSize = txtSize ;
    this.font = font ;
    textFont(font) ;
    textSize(txtSize) ;
    h = txtSize/2 ;
    w = textWidth(text)/2 ;
    switch( boxType ){
      case "CLOUD" :
        box = cloud( w/2 , h/2 ) ;
        break ;
      case "RECT" :
        box = createShape( RECT , -w , -h ,  2*w , 2*h ) ;
        box.setStroke(false) ;
        box.setFill(255) ;
        break ;
    }
  }
  
  void show(){
      //Box
    shape(box , x , y ) ;
      //Text
    textFont( font ) ;
    textSize(txtSize) ;
    textAlign(CENTER,CENTER) ;
    fill( 0 ) ;
    text( text , x , y ) ;
  }
  
  boolean mouseIsHovering(){
    return abs( mouseX - x ) < w && abs( mouseY - y ) < h ;
  }
}
