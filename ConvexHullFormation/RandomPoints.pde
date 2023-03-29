


void makeRandomPointsVersion1(){
  points.clear();
  for( int i = 0; i < numOfPoints; i++){
    points.add( new Point( random(100,width-100), random(100,height-100) ) );
  }
}

void makeRandomPointsVersion2(){
  points.clear();
  
  // TODO
  for( int i = 0; i < numOfPoints-1; i++){
    points.add( new Point( random(200,width-200), random(200,height-200) ) );
  }
  // 4 corners forming the hull
  points.add( new Point( random(10,150), random(10,150) ) );
  points.add( new Point( random(10,150), random(height-150,height-10) ) );
  points.add( new Point( random(width-150,width-10), random(10,150) ) );
  points.add( new Point( random(width-150,width-10), random(height-150,height-10) ) );
}

void makeRandomPointsVersion3(){
  points.clear();
  
  // TODO
  // A360 or all points forming the hull 
  float angle = 2 * PI / (numOfPoints -1);
  float radius = random(50,100);
  for( int i = 0; i < numOfPoints; i++){
    Point p0 = new Point( 250,250);
    Point p1 = new Point( PVector.fromAngle( angle * i )
                              .mult( radius ) //.mult( random(50,100) )
                              .add(p0.p) );
    points.add( p1 );
  }
}

