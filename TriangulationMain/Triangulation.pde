
 ArrayList<Triangle> getDiagonalBasedTriangulation(Polygon poly){
   // TODO: Triangulate the polygon using a method of your choice
   ArrayList<Triangle> ret = new ArrayList<Triangle>();
   
    // copy of polygon to remove triangulated vertices
    ArrayList<Point> vertCopy = new ArrayList<Point >(poly.p);

    // EASY WAY
    // int i=0;
    // int triangulate = 0;
    // while(triangulate <= poly.p.size()-3){ // do this till n-3 diagonals draw leaving n-2 triangles
    //   i = (i)%vertCopy.size();
    //   int vIdx = i;
    //   int midIdx = (i+1)%vertCopy.size();
    //   int diagOtherIdx = (i+2)%vertCopy.size();
    //   // check with valid diagonal ahead, IF valid THEN draw it and process
    //   Edge diagonal = new Edge(vertCopy.get(vIdx), vertCopy.get(diagOtherIdx));
    //   if(checkValidDiagonalInPoly(diagonal, vertCopy)){
    //     ret.add(new Triangle(vertCopy.get(vIdx), vertCopy.get(midIdx), vertCopy.get(diagOtherIdx)));
    //     vertCopy.remove(midIdx);
    //     triangulate++;
    //   }
    //   i++;
    // }

    // COMPLICATED
    if(poly.p.size() >= 3){
        doRandomDiagonalBasedTriangulation(vertCopy, ret);
    }

    return ret;
 }


 void doRandomDiagonalBasedTriangulation(ArrayList<Point > vertices, ArrayList<Triangle> retTri){

  if(vertices.size() == 3){
    retTri.add(new Triangle(vertices.get(0), vertices.get(1), vertices.get(2)));
    return;
  }
  else if(vertices.size()>3){

    int min = 2; // canot take diagonal v0 to v0
    int max = vertices.size()-2;
    int randomDiagIdx = 0;
    int vIdx = 0;
    boolean found = false;
    boolean flaggedCase = false;
    int count = 0;
    // if(vertices.size() == 0){
    //   System.out.println("here it is zero");
    // }
    while(!found){

      if(count<100){// cannot find valid diagonal in count iterations then 
        randomDiagIdx = (int)Math.floor(Math.random() * (max - min + 1) + min); //citation : https://www.educative.io/answers/how-to-generate-random-numbers-in-java
        // System.out.println("IF vIdx " + vIdx + " & random number generated " + randomDiagIdx + " \n");
        Edge diagonal = new Edge(vertices.get(vIdx), vertices.get(randomDiagIdx));
        found = checkValidDiagonalInPoly(diagonal, vertices);
        // found = true;
        count++;
      }
      else{
        vIdx = (vIdx + 1)%vertices.size();
        randomDiagIdx = (min + 1)%vertices.size(); 
        min = (min + 1)%vertices.size();
        // System.out.println("ELSE vIdx " + vIdx + " & random number generated " + randomDiagIdx + " \n");
        Edge diagonal = new Edge(vertices.get(vIdx), vertices.get(randomDiagIdx));
        found = checkValidDiagonalInPoly(diagonal, vertices);
        flaggedCase = true;
        // System.out.println("flagging here " + vIdx + ", " + randomDiagIdx +"\n");
        // vIdx = (vIdx + 1)%vertices.size();// edge case thingy
        
        count = 0;
        // break;
      }
    } 
    if(!found){
      System.out.println("have not found valid diagonal \n");
    }

    int idx1 = 0;
    int idx2 = (randomDiagIdx+1)%vertices.size(); //including condition for subList, hence +1

    if(!flaggedCase){
      // call left
      ArrayList<Point> leftCopy = new ArrayList<Point >(vertices.subList(idx1, idx2));
      // System.out.println("left size " + leftCopy.size() + " \n");
      doRandomDiagonalBasedTriangulation(leftCopy, retTri);

      // call right
      ArrayList<Point> rightCopy = new ArrayList<Point >(vertices.subList(idx2-1, vertices.size()-1));  
      rightCopy.add(vertices.get(vertices.size()-1)); // add last
      rightCopy.add(vertices.get(0)); // add first 
      // System.out.println("right size " + rightCopy.size() + " \n");
      doRandomDiagonalBasedTriangulation(rightCopy, retTri);
    }
    else{ // when flaggedCase

      // call left
      ArrayList<Point> leftCopy = new ArrayList<Point >(vertices.subList(vIdx, randomDiagIdx));
      leftCopy.add(vertices.get(randomDiagIdx)); // add last
      // System.out.println("left size " + leftCopy.size() + " \n");
      doRandomDiagonalBasedTriangulation(leftCopy, retTri);

      // call right
      ArrayList<Point> rightCopy = new ArrayList<Point >(vertices.subList(randomDiagIdx, vertices.size()-1)); 
      rightCopy.add(vertices.get(vertices.size()-1)); 
      rightCopy.add(vertices.get(0)); // add last  
      rightCopy.add(vertices.get(1));
      // System.out.println("right size " + rightCopy.size() + " \n"); 
      doRandomDiagonalBasedTriangulation(rightCopy, retTri); 
      return; 
    }
    

    // return;
  }
  return;
 }




 ArrayList<Triangle> getEarBasedTriangulation(Polygon ply){
   // TODO: Triangulate the polygon using a method of your choice
   ArrayList<Triangle> ret = new ArrayList<Triangle>();

  ArrayList<Point> vertCopy = new ArrayList<Point >(ply.p);
  ArrayList<Point> queueVertices = new ArrayList<Point>();
   // check for all vertices if valid ear or not 

   // checking V0
    Edge diagonal = new Edge(new Point(0,0), new Point(0,1));

    // Initial ear tip list 
    // triangulation needed only when size is greater then 3
    if(vertCopy.size() > 2){

      // checking first vertex IF ear 
      diagonal = new Edge(vertCopy.get(vertCopy.size()-1), vertCopy.get(1));      
      if(checkValidDiagonalInPoly(diagonal, ply.p)){
        queueVertices.add(ply.p.get(0));
      }
      // checking other vertices IF ear 
      for(int i=1; i<vertCopy.size(); i++){
        boolean valid = true;
        diagonal = new Edge(vertCopy.get(i-1), vertCopy.get((i+1)%vertCopy.size()));
        if(checkValidDiagonalInPoly(diagonal, ply.p)){
          queueVertices.add(ply.p.get(i));
          // System.out.println("adding " + i + " \n");
        }
      }

    }

    // System.out.println("queue size " + queueVertices.size() + " & vertcopy size " + vertCopy.size() + " \n");
    // start processing ear tip queue
    int i=0;
    while(vertCopy.size()>2){
      
        // System.out.println("vertCopy.size() " + vertCopy.size() + " \n");

        Point earTip = queueVertices.get(i);
        // make the triangle
        for(int j=0; j<vertCopy.size(); j++){
          if(earTip == vertCopy.get(j)){

            Point prevNeighbour = new Point(0,0);
            Point nextNeighbour = new Point(0,0);
            if(j==0){
              prevNeighbour = vertCopy.get(vertCopy.size()-1);
              nextNeighbour = vertCopy.get(j+1);
              ret.add(new Triangle(vertCopy.get(vertCopy.size()-1), vertCopy.get(j), vertCopy.get(j+1)));
            }
            else{
              prevNeighbour = vertCopy.get(j-1);
              nextNeighbour = vertCopy.get((j+1)%vertCopy.size());
              ret.add(new Triangle(vertCopy.get(j-1), vertCopy.get(j), vertCopy.get((j+1)%vertCopy.size())));
            }
            ret.add(new Triangle(prevNeighbour, vertCopy.get(j), nextNeighbour));

            // update new polygon and queue 
            vertCopy.remove(j); // remove after cutting the ear 
            queueVertices.remove(i); // remove from queue
            i--;

            // NEW POLYGON FORMED AFTER REMOVING
            // check neighbours if they are still ear 

            // first neighbour - vertCopy j-1
            int prevIdx = ((j-2) + vertCopy.size())%vertCopy.size();
            int nextIdx = ((j) + vertCopy.size())%vertCopy.size();
            int vIdx = ((j-1) + vertCopy.size())%vertCopy.size();
            diagonal = new Edge(vertCopy.get(prevIdx), vertCopy.get(nextIdx));
            if(checkValidDiagonalInPoly(diagonal, vertCopy)){
              int idx = queueVertices.indexOf(vertCopy.get(vIdx));
              if(idx == -1){// means not present 
                queueVertices.add(vertCopy.get(vIdx));
              }
            }
            else{
              queueVertices.remove(vertCopy.get(vIdx));
            }

            // second neighbour - vertCopy j
            prevIdx = ((j-1) + vertCopy.size())%vertCopy.size();
            nextIdx = ((j+1) + vertCopy.size())%vertCopy.size();
            vIdx = ((j) + vertCopy.size())%vertCopy.size();
            diagonal = new Edge(vertCopy.get(prevIdx), vertCopy.get(nextIdx));
            if(checkValidDiagonalInPoly(diagonal, vertCopy)){
              int idx = queueVertices.indexOf(vertCopy.get(vIdx));
              if(idx == -1){// means not present 
                queueVertices.add(vertCopy.get(vIdx));
              }
            }
            else{
              queueVertices.remove(vertCopy.get(vIdx));
            }

            continue;
          }
        }
        i++;
    }
   
  //  System.out.println("here " + queueVertices.size() + " \n");

   return ret;
 }


 boolean checkValidDiagonalInPoly(Edge diag, ArrayList<Point> newPolyVert ){
  // System.out.println("coming here \n");
  boolean invalid = false;

  for(int i = 0; i<newPolyVert.size(); i++){ // compare with each boundary 
    // check if intersects with boundary edges
    if(diag.intersectionTest(new Edge(newPolyVert.get(i), newPolyVert.get((i+1)%newPolyVert.size())))){
      invalid = true;
    }
  }

  if(!invalid){
    // check if diagonal is inside or outside the polygon
    Point midPoint = new Point((diag.p0.getX() + diag.p1.getX())/2, (diag.p0.getY() + diag.p1.getY())/2);
    // check if diagonal's midpoint is inside or outside the polygon 
    if(pointInDifferentPolygon(midPoint, newPolyVert)){
      return true;
    }
  }

  return false;
 }
 

  boolean pointInDifferentPolygon( Point p , ArrayList<Point> newPolyVert ){
    // TODO: Check if the point p is inside of the 
    
    float m = 1;
    float c = p.y() - m * p.x();
    int k = 0;
    // ArrayList<Edge> bdry = ply.getBoundary();
    for(int i =0; i<newPolyVert.size(); i++){
      // edge going outside the window 
      Edge newSide = new Edge(newPolyVert.get(i), newPolyVert.get((i+1)%newPolyVert.size()));
      if(newSide.intersectionTest(new Edge(p, new Point(p.p.x+800, p.p.y+800)) )){
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
