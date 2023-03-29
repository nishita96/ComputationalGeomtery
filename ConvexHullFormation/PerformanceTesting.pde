

// Module for testing performance of implementations
// works by testing may random sets of points
void performanceTest( ){

  int maxNumOfPoints = 1000;
  int maxIterations = 500; 
  
  
  println("\n Running Performance Test");

//----TODO GIFTWRAPPING HANGS-------------------------------------------------------------------------------------------  
  println( "\n  Testing with version 1 random segments:--------------------------------");

  for( int nP = 10; nP <= maxNumOfPoints; nP*=10){//, maxIterations/=5 ){
    
    println( "    " + nP + " vertices per test & " + maxIterations + " iterations" );
    numOfPoints = nP;

    // QUICKHULL
    int start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion1();
      ConvexHullQuickHull( points );
    }
    int tQH = (millis()-start);
    println( "      QuickHull Implementation:     " + tQH + " ms" );


    // GRAHAM
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion1();
      ConvexHullGraham( points );
    }
    int tG = (millis()-start);
    println( "      Graham Implementation:        " + tG + " ms" );


    // GIFT WRAPPING
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion1();
      ConvexHullGiftWrap( points );
    }
    int tGW = (millis()-start);
    println( "      Gift Wrapping Implementation: " + tGW + " ms" );
    
  }


//----TODO GIFTWRAPPING HANGS-------------------------------------------------------------------------------------------  
  
  println( "\n  Testing with version 2 random segments:--------------------------------");

  for( int nP = 10; nP <= maxNumOfPoints; nP*=10){//, maxIterations/=5 ){
    
    println( "    " + nP + " vertices per test & " + maxIterations + " iterations" );
    numOfPoints = nP;

    // QUICKHULL
    int start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion2();
      ConvexHullQuickHull( points );
    }
    int tQH = (millis()-start);
    println( "      QuickHull Implementation:     " + tQH + " ms" );


    // GRAHAM
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion2();
      ConvexHullGraham( points );
    }
    int tG = (millis()-start);
    println( "      Graham Implementation:        " + tG + " ms" );


    // GIFT WRAPPING
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion2();
      ConvexHullGiftWrap( points );
    }
    int tGW = (millis()-start);
    println( "      Gift Wrapping Implementation: " + tGW + " ms" );
    
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------  
  
  println( "\n  Testing with version 3 random segments:--------------------------------");

  for( int nP = 10; nP <= maxNumOfPoints; nP*=10){//, maxIterations/=5 ){
    
    println( "    " + nP + " vertices per test & " + maxIterations + " iterations" );
    numOfPoints = nP;

    // QUICKHULL
    int start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion3();
      ConvexHullQuickHull( points );
    }
    int tQH = (millis()-start);
    println( "      QuickHull Implementation:     " + tQH + " ms" );


    // GRAHAM
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion3();
      ConvexHullGraham( points );
    }
    int tG = (millis()-start);
    println( "      Graham Implementation:        " + tG + " ms" );


    // GIFT WRAPPING
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion3();
      ConvexHullGiftWrap( points );
    }
    int tGW = (millis()-start);
    println( "      Gift Wrapping Implementation: " + tGW + " ms" );
    
  }


//----------------------------------------------------------------------------------------------------------------------------------------------------------  
//----------------------------------------------------------------------------------------------------------------------------------------------------------  
  
  println( "\n\n  Testing different versions for QuickHull:--------------------------------");
  
  for( int nP = 10; nP <= maxNumOfPoints; nP*=10){//, maxIterations/=5 ){
    
    println( "    " + nP + " vertices per test & " + maxIterations + " iterations" );
    numOfPoints = nP;

    // version 1
    int start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion1();
      ConvexHullQuickHull( points );
    }
    int tQH = (millis()-start);
    println( "      Version 1:     " + tQH + " ms" );


    // version 1
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion2();
      ConvexHullQuickHull( points );
    }
    tQH = (millis()-start);
    println( "      Version 2:     " + tQH + " ms" );


    // version 1
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion3();
      ConvexHullQuickHull( points );
    }
    tQH = (millis()-start);
    println( "      Version 3:     " + tQH + " ms" );
    
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------  
  
  println( "\n\n  Testing different version for Graham:--------------------------------");

  for( int nP = 10; nP <= maxNumOfPoints; nP*=10){//, maxIterations/=5 ){
    
    println( "    " + nP + " vertices per test & " + maxIterations + " iterations" );
    numOfPoints = nP;

    // version 1
    int start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion1();
      ConvexHullGraham( points );
    }
    int tG = (millis()-start);
    println( "      Version 1:     " + tG + " ms" );


    // version 1
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion2();
      ConvexHullGraham( points );
    }
    tG = (millis()-start);
    println( "      Version 2:     " + tG + " ms" );


    // version 1
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion3();
      ConvexHullGraham( points );
    }
    tG = (millis()-start);
    println( "      Version 3:     " + tG + " ms" );
    
  }

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
  
  println( "\n\n  Testing different version for GiftWrapping:---------------------------");

  for( int nP = 10; nP <= maxNumOfPoints; nP*=10){//, maxIterations/=5 ){
    
    println( "    " + nP + " vertices per test & " + maxIterations + " iterations" );
    numOfPoints = nP;

    // version 1
    int start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion1();
      ConvexHullGiftWrap( points );
    }
    int tGW = (millis()-start);
    println( "      Version 1:     " + tGW + " ms" );


    // version 2
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion2();
      ConvexHullGiftWrap( points );
    }
    tGW = (millis()-start);
    println( "      Version 2:     " + tGW + " ms" );


    // version 3
    start = millis();
    for(int i = 0; i < maxIterations; i++ ){
      makeRandomPointsVersion3();
      ConvexHullGiftWrap( points );
    }
    tGW = (millis()-start);
    println( "      Version 3:     " + tGW + " ms" );

  }
      println(" THE END ");



  
  
}
