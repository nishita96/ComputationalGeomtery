

class Polygon {
  
   ArrayList<Point> p     = new ArrayList<Point>(); // ASK/CHECK are these vertices?
   ArrayList<Edge>  bdry = new ArrayList<Edge>();
     
   Polygon( ){  }
   
   
   boolean isClosed(){ return p.size()>=3; }
   
   
   boolean isSimple(){
     // TODO: Check the boundary to see if it is simple or not.
     ArrayList<Edge> bdry = getBoundary(); 
     for(int i = 0; i<bdry.size()-1; i++){
       for(int j = i+1; j<bdry.size(); j++){
          if(bdry.get(i).intersectionTest(bdry.get(j))){
            // System.out.println("simple false");
            return false; 
          }
        }
      }
     return true;
   }
   

   boolean pointInPolygon( Point p ){
     // TODO: Check if the point p is inside of the 
     
     float m = 1;
     float c = p.y() - m * p.x();
     int k = 0;
     ArrayList<Edge> bdry = getBoundary();
     for(int i =0; i<bdry.size(); i++){
      // edge going outside the window 
      if(bdry.get(i).intersectionTest(new Edge(p, new Point(p.p.x+800, p.p.y+800)) )){
         k++;
       }
     }
     if(k%2 == 0){
       return false;
     }
     else{
       return true;
     }
   }
   
   
   ArrayList<Edge> getDiagonals(){
     // TODO: Determine which of the potential diagonals are actually diagonals
     ArrayList<Edge> bdry = getBoundary();
     ArrayList<Edge> diag = getPotentialDiagonals();
     ArrayList<Edge> ret  = new ArrayList<Edge>();
     
     for(int i = 0; i<diag.size(); i++){ // check each diagonals 
      boolean invalid = false;
      Edge diagonal = diag.get(i);
      if(checkValidDiagonal(diagonal)){
        ret.add(diagonal);
      }

    }
     return ret;
   }

   boolean checkValidDiagonal(Edge diag){

      boolean invalid = false;
      for(int j = 0; j<bdry.size(); j++){ // compare with each boundary 
        // check if intersects with boundary edges
        if(diag.intersectionTest(bdry.get(j))){
          invalid = true;
        }
      }

      if(!invalid){
        // check if diagonal is inside or outside the polygon
        Point midPoint = new Point((diag.p0.getX() + diag.p1.getX())/2, (diag.p0.getY() + diag.p1.getY())/2);
        // check if diagonal's midpoint is inside or outside the polygon 
        if(pointInPolygon(midPoint)){
          return true;
        }
      }

      return false;
   }
  

   ArrayList<Edge> getDiagonalsOptimized(){
     // TODO: Determine which of the potential diagonals are actually diagonals
     ArrayList<Edge> ret  = new ArrayList<Edge>();

     ArrayList<Edge> bdry = getBoundary();
    //  

    // do anything ONLY if polygon size >3
    if(p.size() > 3 && ccw()){
     // visibility map 
    //  System.out.println("\n p.size() = " + p.size());

      // got through each vertex till last vertex
      for(int i=0; i<p.size()-2; i++){//leaving last 2 as the posible diagonals will already be checked 

        Point vert = p.get(i); // V in consideration
        Point prevV = p.get(p.size()-1); // prev V
        if(i != 0)
          prevV = p.get(i-1);
        Point nextV = p.get(i+1); // next V
        
        int start = i+2;
        int end = p.size()-1;
        // if(i==0)
        //   end = p.size()-2;

        ArrayList<Point> sortedPointList = new ArrayList<Point>(p.subList(start,end)); // sorted list to iterate through 
        if(i != 0){
          sortedPointList.add(p.get(p.size()-1));
        }
        
        // System.out.println("\n\n VERTEX i = " + i + " size now = " + sortedPointList.size() );
        // System.out.println("\n start = " + start + ", end = " + start);
        // System.out.println("\n seeeee = " + p.indexOf(sortedPointList.get(0)));

        Collections.sort( sortedPointList, new Comparator<Point>(){ // sort 
          public int compare( Point p0, Point p1 ){
            float dist0 = sqrt(pow((p0.p.x-vert.p.x),2) + pow((p0.p.y-vert.p.y),2));
            float dist1 = sqrt(pow((p1.p.x-vert.p.x),2) + pow((p1.p.y-vert.p.y),2));

            if( dist0 < dist1 ) return -1;
            if( dist0 > dist1 ) return  1;
            return 0;
          }
        });

        float retAngleRange = angleInBetween(vert, nextV, vert, prevV); // initial x final side 
        // System.out.println(" \n theta values " + retAngleRange  + " angle between " );
          


        // MAKE FINAL GRAPH EDGE LIST 
        ArrayList<Edge> graphEdgeList = new ArrayList<Edge>(); // has values theta, distance (the x and y values)

        for(int j=0; j<sortedPointList.size(); j++){
          Point pointV = sortedPointList.get(j); // = p1
          int idxP1 = p.indexOf(pointV);
          // System.out.println("\n value " + idxP1);
          Point p0 = p.get(idxP1-1);
          Point p2 = p.get((idxP1+1)%p.size());

          float angle0 = angleInBetween(vert, nextV, vert, p.get(idxP1-1));
          float angle1 = angleInBetween(vert, nextV, vert, pointV);
          float angle2 = angleInBetween(vert, nextV, vert, p.get((idxP1+1)%p.size()));

          // System.out.println("\n all angles " + angle0 + " " + angle1 + " " + angle2);

          float distPrev = 0.0;
          float distNext = 0.0;

          // Edge p0,p1
          distPrev = sqrt(pow((p0.p.x-vert.p.x),2) + pow((p0.p.y-vert.p.y),2));
          distNext = sqrt(pow((pointV.p.x-vert.p.x),2) + pow((pointV.p.y-vert.p.y),2));
          graphEdgeList.add(new Edge(new Point(angle0, distPrev), new Point(angle1, distNext)));

          // Edge p2,p1
          distPrev = distNext;
          distNext = sqrt(pow((p2.p.x-vert.p.x),2) + pow((p2.p.y-vert.p.y),2));
          graphEdgeList.add(new Edge(new Point(angle1, distPrev), new Point(angle2, distNext)));

        }

        // System.out.println("\n graph size = " + graphEdgeList.size());// + " sortedPointList.size() " + sortedPointList.size()); // getting duplicates 

        // CHECK IN GRAPH FOR EACH V
        for(int k=0; k<sortedPointList.size(); k++){// point will have to be in the sorted point list only 

          Point checkV = sortedPointList.get(k);
          float angle = angleInBetween(vert, nextV, vert, checkV);
          boolean addDiag = true;
          // System.out.println("\n here angle " + angle);
          if(angle > 0 && angle < retAngleRange){ // only if in range then check further
            System.out.println("\n in angle");
            for(int s=0; s<graphEdgeList.size(); s++){
              boolean pIntersect = graphEdgeList.get(s).intersectionTest(new Edge(new Point(angle,0), new Point(angle,800))); //verticle line checking the min Y
              float xmin = min(graphEdgeList.get(s).p0.p.x, graphEdgeList.get(s).p1.p.x);
              float xmax = max(graphEdgeList.get(s).p0.p.x, graphEdgeList.get(s).p1.p.x);
              System.out.println("\n here " + xmin + " " + angle + " " + xmax);
              if(angle > xmin && angle < xmax){//intersects
                addDiag = false;
              }
              // pIntersect = new Edge(new Point(0,0), new Point(angle,800)).intersectionPoint(new Edge(new Point(angle,0), new Point(angle,800)));
              // if(pIntersect){ // process ONLY if does not intersect
              //   // System.out.println("\n it intersects");
              //   addDiag = false;
              // }
            }
            if(addDiag){
              ret.add(new Edge(checkV, vert));
            }
          }
        }


      } // going through each vertex 
    }
    else
    {
      checkDiag(ret);
    }
     

     return ret;
   }  

   float angleInBetween(Point p0, Point p1, Point q0, Point q1){

      float ix = p1.p.x-p0.p.x;
      float iy = p1.p.y-p0.p.y;

      // do with points other 2 points 
      float fx = q1.p.x-q0.p.x;
      float fy = q1.p.y-q0.p.y;

      float crossProduct = ix * fy - iy * fx;
      float dotProduct = ix * fx + iy * fy;

      float angle = (degrees(atan2(crossProduct, dotProduct)) + 360)%360;
      return angle;
   }
   
   
   boolean ccw(){
     // TODO: Determine if the polygon is oriented in a counterclockwise fashion
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;

     int leftTurn = 0;
     int rightTurn = 0;

      for(int i=0; i<bdry.size(); i++){
        Edge firstEdge = bdry.get(i);
        Edge secondEdge = bdry.get((i+1)%p.size());

        float ax = firstEdge.p1.p.x - firstEdge.p0.p.x;
        float ay = firstEdge.p1.p.y - firstEdge.p0.p.y;
        float bx = secondEdge.p1.p.x - secondEdge.p0.p.x;
        float by = secondEdge.p1.p.y - secondEdge.p0.p.y;
        float crossProduct = ax * by - ay * bx;

        if(crossProduct > 0){
          leftTurn++;
        }
        if(crossProduct < 0){
          rightTurn++;
        }
      }

      if(leftTurn > rightTurn){
        return true;
      }
     return false;
   }
   
   
   boolean cw(){
     // TODO: Determine if the polygon is oriented in a clockwise fashion
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
     
      return !ccw();
   }
   

   float area(){
     // TODO: Calculate and return the area of the polygon

      // System.out.println("area ");
      float area = 0.0;
      for(int i = 0; i < p.size() ; i++){
        area = area + p.get(i).getX()*p.get((i+1)%p.size()).getY() 
          - p.get(i).getY()*p.get((i+1)%p.size()).getX() ;
      }

      return abs(area)/2;  
   }
      

   ArrayList<Edge> getBoundary(){
     return bdry;
   }


   ArrayList<Edge> getPotentialDiagonals(){
     ArrayList<Edge> ret = new ArrayList<Edge>();
     int N = p.size();
     for(int i = 0; i < N; i++ ){
       int M = (i==0)?(N-1):(N);
       for(int j = i+2; j < M; j++ ){
         ret.add( new Edge( p.get(i), p.get(j) ) );
       }
     }
     return ret;
   }
   

   void draw(){
     //println( bdry.size() );
     for( Edge e : bdry ){
       e.draw();
     }
   }
   
   
   void addPoint( Point _p ){ 
     p.add( _p );
     if( p.size() == 2 ){
       bdry.add( new Edge( p.get(0), p.get(1) ) );
       bdry.add( new Edge( p.get(1), p.get(0) ) );
     }
     if( p.size() > 2 ){
       bdry.set( bdry.size()-1, new Edge( p.get(p.size()-2), p.get(p.size()-1) ) );
       bdry.add( new Edge( p.get(p.size()-1), p.get(0) ) );
     }
   }

   void checkDiag(ArrayList<Edge> ret){
    ArrayList<Edge> diag = getPotentialDiagonals();
     for(int i = 0; i<diag.size(); i++){ // check each diagonals 
      boolean invalid = false;
      Edge diagonal = diag.get(i);
      if(checkValidDiagonal(diagonal)){
        ret.add(diagonal);
      }
     }
     return;
   }

}
