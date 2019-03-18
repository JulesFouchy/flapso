class Menu{
  boolean isOpen = false ;
  ArrayList<Button> buttons ;
  
  Menu(){
    buttons = new ArrayList<Button>() ;
    buttons.add( new Button( width/2 , height*0.2*3 , "RECT" , "Le monde des nuages" , 25 , standardFont  ) ) ;
    buttons.add( new Button( width/2 , height*0.2*2 , "RECT" , "Le jardin de Flapso" , 25 , standardFont  ) ) ;
    buttons.add( new Button( width/2 , height*0.2*1 , "RECT" , "Monde 0" , 25 , standardFont ) ) ;
  }
  
  void show(){
    if( isOpen ){
      rectMode(CORNER) ;
      noStroke() ;
      fill( 150 , 150 ) ;
      rect( 0 , 0 , width , height ) ;
      for( int k = 0 ; k <  buttons.size() ; ++k ){
        Button button = buttons.get(k) ;
        button.show() ;
      }
    }
  }
  
  void checkClick(){
    if( isOpen ){
      for( int k = 0 ; k <  buttons.size() ; ++k ){
        Button button = buttons.get(k) ;
        if( button.mouseIsHovering() ){
          currentWorld = nbWorlds - k - 1 ;
          switch( currentWorld ){
            case 0 :
              worlds[0] = new World0( flapso ) ;
              break ;
            case 1 :
              worlds[1] = new World1( flapso ) ;
              break ;
            case 2 : 
              worlds[2] = new World2( flapso ) ;
              break ;
          }
          
          worlds[currentWorld].setup( flapso ) ;
          isOpen = false ;
        }
      }
    }
  }
}
