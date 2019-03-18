class World2 extends World{
  //Events
  boolean hasFinished = false ;
  Fade fade = new Fade( color(255) , 1 , true ) ;
  //Hero
  Hero flapso ;
  //Physics
  float gravity = 3./framesPerSecond ;
  Ground ground ;
  float groundHeight ;
  //Key
  PShape theKey ;
  //Background
  PGraphics bg ;
  //Texts
  String[] drawMeA = { "un oiseau" , "une fleur" , "un arbre" , "une plume"  , "une oreille", " un cactus" ,  "un carnet", "une trousse", "un nénuphar" , "une couronne", "un renard", "un stylo", "un lapin" ,
                      "un magnifique","une guitare", "un papillon" , "une ****" , "une *****" , "la bataille de Waterloo"} ;
  float textX = width/2 ; 
  float textY = height/2 ;
  PShape bulle = cloud( width * 0.12 , width*0.12/2 ) ;
  //Fairies
  ArrayList<Fairy> fairies ;
  //Finish button
  Button finishButton ;
  //Color Palet
  ColorPalet colourPalet ;
  //Brush
  Brush brush ;
  //The drawing !
  PGraphics flapsoDrawing ;
  float drawingX ;
  float drawingY ;
  float drawingW ;
  float drawingH ;
  
  //Constructor
  World2( Hero flapso ){
    super( flapso ) ;
    //Ground
    groundHeight = height*0.9 ;
    ground = new Ground( -1 , groundHeight , -1 , 100 ) ;
    //Color palet
    float colourPaletX = width * 0.85 ;
    float colourPaletY = height*0.3 ;
    colourPalet = new ColorPalet( 6 , colourPaletX , colourPaletY ) ;
    //Finish button
    float buttonTextHeight = width*0.05*0.8 ;
    finishButton = new Button( width*0.9 , colourPaletY + colourPalet.h() + buttonTextHeight , "CLOUD" , "J'ai fini !" , buttonTextHeight , fontHandwritten ) ;
    //Fairies
    fairies = new ArrayList<Fairy>() ;
    for( int k = 0 ; k < 3 ; ++k ){
      fairies.add( new Fairy( colourPaletX - width*0.05 - randomGaussian()*width*0.035 , colourPaletY + randomGaussian()*height*0.080 ) ) ;
    }
    //Brush
    brush = new Brush( colourPalet.colours[0].colour , width*0.02 ) ;
    //The drawing
    drawingX = width*0.0 ;
    drawingY = height*0.0 ;
    drawingW = width*1 ;
    drawingH = height*1 ;
    flapsoDrawing = createGraphics( int(drawingW) , int(drawingH) ) ;
    //Key
    theKey = createKey() ;
    //Background
    bg = createGraphics(width , height) ;
      //Sky
    bg.beginDraw() ;
    bg.background( #12D1FF , 255 ) ;
      //Clouds
    for( int k = 0 ; k < 10 ; ++k){
      cloud( bg , random(width) , random(0,height*0.1 ) ) ;
      cloud( bg , random(width) , random(height*0.9,height ) ) ;
      cloud( bg , random(0,width*0.1) , random(height) ) ;
      //cloud( bg , random(width*0.9,width) , random(height) ) ;
    }
    bg.endDraw() ;
  }
  
  void setup( Hero flapso ){
    this.flapso = flapso ;
    flapso.gravity = gravity ;
    //Physics
    flapso.xBouncingCoef = 0 ;
    flapso.yBouncingCoef = -0.75 ;
    flapso.pos.set( width*0.1 , height/2 ) ;
    flapso.maxYspeed = 150./framesPerSecond ;
    //Texts
    bulle.setStroke(false) ;
    bulle.setFill( 255 ) ;
    texts.add( new Text( textX , textY , 3 , bulle , fontHandwritten , "Pourrais tu nous dessiner\n" + drawMeA[int(random(drawMeA.length))] + " s'il-te-plaît ?" ) ) ;
    texts.add( new Text( textX , textY , 2.5 , bulle , fontHandwritten , "Nous avons besoin de ton aide" ) ) ;
    texts.add( new Text( textX , textY , 5 , bulle , fontHandwritten ,"Nous ne voulions pas voler ta clé,\nmais c'était le seul moyen d'attirer ton attention" ) ) ;
    texts.add( new Text( textX , textY , 4   , bulle , fontHandwritten ,"Bienvenue Flapso :)\nNous sommes les fées des nuages" ) ) ;
  }
  
  void draw(){
    //Background
    image( bg , 0 , 0 ) ;
    image( flapsoDrawing , drawingX , drawingY ) ;
    //Finish button
    finishButton.show() ;
    //Color Palet
    colourPalet.show() ;
    //Brush 
    brush.show() ;
    //Fairies
    for( int k = fairies.size()-1 ; k >=0 ; --k ){
      Fairy fairy = fairies.get(k) ;
      fairy.showRandomly() ;
    //Perso principal
      //Move
    if( random(1) < 0.02/framesPerSecond ){
      flapso.jump() ;
    }
    flapso.move() ;
      //Check collisions
    flapso.checkAndResolveCollision( ground ) ;
      //Show
    flapso.update() ;
    }
    //Fade
    if( hasFinished && texts.texts.size() == 0 ){
      fade.update() ;
    }
    
    //Event
    if( hasFinished && texts.texts.size() == 0 && fade.age > fade.duration  ){
      currentWorld = 1 ;
      worlds[currentWorld].setup( flapso , worlds[1].signPosition-width/2 , -100 , flapsoDrawing ) ;
      worlds[currentWorld].hasVisitedTheFairies = true ;
      worlds[currentWorld].hasTheKey = true ;
    }
    
    if( mousePressed ){
      onClick() ;
    }
  }
  
  void onClick(){
      //Finish button
    if( finishButton.mouseIsHovering() && !hasFinished ){
      hasFinished = true ;
      flapsoDrawing.save( "screenshots/Merci Flapso "+year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".png") ;
      PShape bulle = cloud( width * 0.18 , width*0.18/2, TAU*0.002 ) ;
      texts.add( new Text( textX , textY , 2 , bulle , fontHandwritten , "Voilà, nous te rendons ta clé\net te seront éternellement reconnaissantes" ) ) ;
      texts.add( new Text( textX , textY , 2 , bulle , fontHandwritten , "Oh merci Flapso !" ) ) ;
    }
    else{
      int colourIndex = colourPalet.clickingOn() ;
        //Draw
      if( colourIndex == -1 ){
        flapsoDrawing.beginDraw() ;
        brush.paint( flapsoDrawing , mouseX - drawingX , mouseY -drawingY ) ;
        flapsoDrawing.endDraw() ;
      }
        //Change colour
      else{
        brush.colour = colourPalet.colours[colourIndex].colour ;
      }
    }
  }
  
  void mousePressed(){
    //onClick() ;
  }
  
  void mouseDragged(){
  }
  
  void mouseWheel(MouseEvent event){
    brush.radius += event.getCount() ;
  }
  
  void keyPressed(){
  }
  
  void keyReleased(){
  }
}
