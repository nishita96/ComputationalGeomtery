


// Module for testing performance of implementations
// works by testing may random sets of edges.

void performanceTest1( ){
  int numOfEdges = 1000;
  int iterations = 4000; 
  
  println("Running Performance Test");
  
  println( "\n  Testing with version 1 random segments:");
  for( int nE = 10; nE <= numOfEdges; nE*=10, iterations/=8 ){
    
    println( "  " + nE + " edges per test; " + iterations + " iterations" );
    
    // NAIVE
    int start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegments( nE, 150 );
      //NaiveLineSegmentSetIntersection( edges, intersectionsNaive );
      LineSegmentSetIntersectionBruteForce( edges, intersectionsNaive );
    }
    int tNaive = (millis()-start);
    println( "    Naive Implementation: " + tNaive + " ms" );
    
    
    // AABB
    start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegments( nE, 150 );
      //OptimizedLineSegmentSetIntersectionAABB( edges, intersectionsAABB );
      LineSegmentSetIntersectionAABB( edges, intersectionsAABB );
    }
    int tAABB  = (millis()-start);
    print( "    AABB Optimized Implementation: " + tAABB + " ms" );
    println( "     Improvement over naive: " + (int)( 100.0f *(tNaive-tAABB)/(tNaive) ) + "%" );
    
    
    // Shamos
    start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegments( nE, 150 );
      LineSegmentSetIntersectionShamos( edges, intersectionsShamos );
    }
    int tShamos  = (millis()-start);
    print( "    Shamos Optimized Implementation: " + tShamos + " ms" );
    println( "    Improvement over naive: " + (int)( 100.0f *(tNaive-tShamos)/(tNaive) ) + "%" );
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------  
  }
  
  iterations = 4000;
  println( "\n  Testing with version 2 random segments:");
  for( int nE = 10; nE <= numOfEdges; nE*=10, iterations/=8 ){
    
    println( "  " + nE + " edges per test; " + iterations + " iterations" );
    
    // NAIVE
    int start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegmentsVersion2(nE);
      //NaiveLineSegmentSetIntersection( edges, intersectionsNaive );
      LineSegmentSetIntersectionBruteForce( edges, intersectionsNaive );
    }
    int tNaive = (millis()-start);
    println( "    Naive Implementation: " + tNaive + " ms" );
    
    
    // AABB
    start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegmentsVersion2(nE);
      //OptimizedLineSegmentSetIntersectionAABB( edges, intersectionsAABB );
      LineSegmentSetIntersectionAABB( edges, intersectionsAABB );
    }
    int tAABB  = (millis()-start);
    print( "    AABB Optimized Implementation: " + tAABB + " ms" );
    println( "     Improvement over naive: " + (int)( 100.0f *(tNaive-tAABB)/(tNaive) ) + "%" );
    
    
    // Shamos
    start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegmentsVersion2( nE );
      LineSegmentSetIntersectionShamos( edges, intersectionsShamos );
    }
    int tShamos  = (millis()-start);
    print( "    Shamos Optimized Implementation: " + tShamos + " ms" );
    println( "    Improvement over naive: " + (int)( 100.0f *(tNaive-tShamos)/(tNaive) ) + "%" );
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------
  }
  
  iterations = 4000;
  println( "\n  Testing with version 3 random segments:");
  for( int nE = 10; nE <= numOfEdges; nE*=10, iterations/=8 ){

    
    println( "  " + nE + " edges per test; " + iterations + " iterations" );
    
    // NAIVE
    int start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegmentsVersion3(nE);
      //NaiveLineSegmentSetIntersection( edges, intersectionsNaive );
      LineSegmentSetIntersectionBruteForce( edges, intersectionsNaive );
    }
    int tNaive = (millis()-start);
    println( "    Naive Implementation: " + tNaive + " ms" );
    
    
    // AABB
    start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegmentsVersion3(nE);
      //OptimizedLineSegmentSetIntersectionAABB( edges, intersectionsAABB );
      LineSegmentSetIntersectionAABB( edges, intersectionsAABB );
    }
    int tAABB  = (millis()-start);
    print( "    AABB Optimized Implementation: " + tAABB + " ms" );
    println( "     Improvement over naive: " + (int)( 100.0f *(tNaive-tAABB)/(tNaive) ) + "%" );
    
    
    // Shamos
    start = millis();
    for(int i = 0; i < iterations; i++ ){
      makeRandomSegmentsVersion3( nE );
      LineSegmentSetIntersectionShamos( edges, intersectionsShamos );
    }
    int tShamos  = (millis()-start);
    print( "    Shamos Optimized Implementation: " + tShamos + " ms" );
    println( "    Improvement over naive: " + (int)( 100.0f *(tNaive-tShamos)/(tNaive) ) + "%" );
    
  }
  
}
