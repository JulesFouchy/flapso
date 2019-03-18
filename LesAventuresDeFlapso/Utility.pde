float time(){
  return (float) frameCount/framesPerSecond ;
}

void imageBlend( PGraphics pg , float x_ , float y_ , float w_ , float h_ , float alpha ){
  int x = int(x_ ) ; int y = int(y_ ) ; int w = int(w_ ) ; int h = int(h_ ) ;
  loadPixels() ;
  pg.loadPixels() ;
  for( int j = x ; j < x+w ; ++j ){
    for( int i = y ; i < y+h ; ++ i ){
      if( i >= 0 && i < height && j >= 0 && j < width ){
        int jPg = int( map( j , x , x+w , 0 , pg.width ) ) ;
        int iPg = int( map( i , y , y+h , 0 , pg.height ) ) ;
        color col = pixels[ i*width+j ] ;
        color pgCol = pg.pixels[ iPg*width+jPg ] ;
        float a = map( alpha * alpha( pgCol ) , 0 , 255*255 , 0 , 255 ) ;
        pixels[ i*width+j ] = color( lerp(red(col),red(pgCol),a) , lerp(green(col),green(pgCol),a) , lerp(blue(col),blue(pgCol),a) ) ;
      }
    }
  }
  updatePixels() ;
}
