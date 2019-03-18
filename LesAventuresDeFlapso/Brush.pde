class Brush{
  color colour ;
  float radius ;
  
  Brush( color col , float r ){
    colour = col ;
    radius = r ;
  }
  
  void paint( PGraphics pg , float x , float y){
    pg.noStroke() ;
    pg.fill( colour ) ;
    pg.ellipse( x , y , 2*radius , 2*radius ) ;
  }
  
  void show(){
    stroke(0) ;
    fill(colour) ;
    ellipse( mouseX , mouseY , radius*2 , radius*2 ) ;
  }
}
