
import java.util.*;

ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Edge>  edges  = new ArrayList<Edge>();

ArrayList<Point> intersectionsNaive = new ArrayList<Point>();
ArrayList<Point> intersectionsOpt   = new ArrayList<Point>();
ArrayList<Point> intersectionsAABB  = new ArrayList<Point>();
ArrayList<Point> intersectionsShamos  = new ArrayList<Point>();

boolean saveImage = false;

int edgeCount = 10;

void setup(){
  //randomSeed(1);//keeps the output const to help debug 
  size(800,800,P3D);
  frameRate(30);
  makeRandomSegmentsVersion1( edgeCount, 250 );
  //makeRandomSegmentsVersion2(edgeCount);
  makeIntersections( );
}


void makeIntersections( ){
  //LineSegmentSetIntersectionBruteForce( edges, intersectionsNaive );
  //LineSegmentSetIntersectionBruteForceOptimized( edges, intersectionsOpt );
  //LineSegmentSetIntersectionAABB( edges, intersectionsAABB ); // input, output 
  LineSegmentSetIntersectionShamos( edges, intersectionsShamos );
}


void draw(){
  background(255);
  
  translate( 0, height, 0);
  scale( 1, -1, 1 );
  
  strokeWeight(3);
  
  fill(0);
  noStroke();
  for( Point p : points ){
    p.draw();
  }
  
  noFill();
  stroke(100);
  for( Edge e : edges ){
    e.draw();
  }
  
  fill(0,255,0);
  stroke(0,255,0);
  for( Point p : intersectionsNaive ){
    p.draw();
  }  

  fill(0,0,255);
  stroke(0,0,255);
  for( Point p : intersectionsOpt ){
    p.draw();
  }  
  
  fill(0,255,255);
  stroke(0,255,255);
  for( Point p : intersectionsAABB ){
    p.draw();
  }  
  
  fill(255,0,255);
  stroke(255,0,255);
  for( Point p : intersectionsShamos ){
    p.draw();
  }    
  
  fill(0);
  stroke(0);
  textSize(18);
  for( int i = 0; i < points.size(); i++ ){
    textRHC( i+1, points.get(i).p.x+5, points.get(i).p.y+15 );
  }
  
  if( edges.get(0).intersectionTest( edges.get(1) ) ){
    fill(0);
    textRHC( "Edges 0 and 1 Intersect", width-300, height-20 );
  }
  else {
    fill(255,0,0);
    textRHC( "Edges 0 and 1 Do Not Intersect", width-300, height-20 );
  }
  
  if( saveImage ) saveFrame( ); 
  saveImage = false;
  
}


void keyPressed(){
  if( key == 's' ) saveImage = true;
  if( key == '+' ){ edgeCount++; makeRandomSegmentsVersion1(edgeCount, 250); makeIntersections( ); }
  if( key == '-' ){ edgeCount = max(2,edgeCount-1); makeRandomSegmentsVersion1(edgeCount, 250); makeIntersections( ); }
  if( key == 'p' ){ performanceTest1(); }
}


void textRHC( int s, float x, float y ){
  textRHC( Integer.toString(s), x, y );
}


void textRHC( String s, float x, float y ){
  pushMatrix();
  translate(x,y);
  scale(1,-1,1);
  text( s, 0, 0 );
  popMatrix();
}

void mousePressed(){
  makeRandomSegmentsVersion1(edgeCount, 250);
  //makeRandomSegmentsVersion2(edgeCount);
  makeIntersections( );
}

  
