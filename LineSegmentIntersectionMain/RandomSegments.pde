
// Function to make a set of random edges
void makeRandomSegmentsVersion1( int numOfEdges, float max_length ){
  points.clear();
  edges.clear();
  
  for( int i = 0; i < numOfEdges; i++ ){
    Point p0 = new Point( random(150,650), random(150,650) );
    Point p1 = new Point( PVector.fromAngle( random(0,2*PI) )
                                 .mult( random(10,max_length) )
                                 .add(p0.p) );
    points.add( p0 );
    points.add( p1 );
    edges.add( new Edge( points.get(i*2), points.get(i*2+1) ) );
  }
}


// Function to make a set of random edges
void makeRandomSegmentsVersion2( int numOfEdges ){ // very small lines hence very less intersections hence more improvement // 90% improvement 
  points.clear();
  edges.clear();

  // TODO: Complete this function
  float max_length = 20;
  for( int i = 0; i < numOfEdges; i++ ){
    Point p0 = new Point( random(150,650), random(150,650) );
    Point p1 = new Point( PVector.fromAngle( random(0,2*PI) )
                                 .mult( random(10,max_length) )
                                 .add(p0.p) );
    points.add( p0 );
    points.add( p1 );
    edges.add( new Edge( points.get(i*2), points.get(i*2+1) ) );
  }
}


// Function to make a set of random edges
void makeRandomSegmentsVersion3( int numOfEdges ){
  points.clear();
  edges.clear();
  
  // TODO: Complete this function
  float max_length = 200;
  for( int i = 0; i < numOfEdges; i++ ){
    
    //float rnd = i%2 == 0? random((1.3)*PI,(1.5)*PI) : random(0,(1/20)*PI);
    float rnd = random((1.3)*PI,(1.5)*PI); // 60% improvement 
    
    Point p0 = new Point( random(150,650), random(150,650) );
    Point p1 = new Point( PVector.fromAngle( rnd ) //random((1.3)*PI,(1.5)*PI) )
                                 .mult( random(30,max_length) )
                                 .add(p0.p) );
    points.add( p0 );
    points.add( p1 );
    edges.add( new Edge( points.get(i*2), points.get(i*2+1) ) );
  }
  
  //for( int i = 0; i < numOfEdges/2; i++ ){
  //  Point p0 = new Point( random(150,650), random(150,650) );
  //  Point p1 = new Point( PVector.fromAngle( random(0,(1/20)*PI) )
  //                               .mult( random(30,max_length) )
  //                               .add(p0.p) );
  //  points.add( p0 );
  //  points.add( p1 );
  //  edges.add( new Edge( points.get(i*2), points.get(i*2+1) ) );
  //}
}
