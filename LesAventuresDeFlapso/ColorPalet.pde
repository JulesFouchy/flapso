color randomColour(){
  return color( random(255) , random(255) , random(255) ) ;
}

class ColorChoice{
  float x , y ;
  float r ;
  color colour = randomColour() ;
  
  ColorChoice( float x , float y , float r ){
    this.x = x ;
    this.y = y ;
    this.r = r ;
  }
  
  void show(){
    noStroke() ;
    fill( colour ) ;
    ellipse( x , y ,2*r , 2*r ) ;
  }
}

class ColorPalet{
  int nbColours ;
  float colourChoiceR ;
  ColorChoice[] colours ;
  
  ColorPalet( int nbColours , float x , float y ){
    colourChoiceR = width*0.018 ;
    this.nbColours = nbColours ;
    colours = new ColorChoice[nbColours] ;
    for( int k = 0 ; k < nbColours ; ++k ){
      colours[k] = new ColorChoice( x+colourChoiceR + (k%2)*3*colourChoiceR , y+colourChoiceR + k/2*3*colourChoiceR , colourChoiceR ) ;
    }
  }
  
  float h(){
    return nbColours/2 * colourChoiceR*3 ;
  }
  
  void show(){
    for( int k = 0 ; k < nbColours ; ++k ){
      colours[k].show() ;
    }
  }
  
  int clickingOn(){
    for( int k = 0 ; k < nbColours ; ++k ){
      if( sqrt( sq(mouseX-colours[k].x) + sq(mouseY-colours[k].y) ) < colours[k].r ){
        return k ;
      }
    }
    return -1 ;
  }
}
