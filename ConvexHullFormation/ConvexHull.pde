
Polygon ConvexHullQuickHull( ArrayList<Point> points ){ // TODO: collinear points arent removed 
  Polygon cHull = new Polygon();
  // System.out.println("\n points " + points.size());  

  if(points.size() < 3){ // if points is empty 
    return cHull;
  }

  int leftIdx = 0;
  int rightIdx = 0;

  for(int i = 0; i < points.size(); i++){
    if(points.get(i).p.x <= points.get(leftIdx).p.x){
      leftIdx = i;
      if(points.get(i).p.x == points.get(leftIdx).p.x){
        if(points.get(i).p.y > points.get(leftIdx).p.y){ // leftmost highest 
          leftIdx = i;
        }
      }
    }
    if(points.get(i).p.x >= points.get(rightIdx).p.x){
      rightIdx = i;
      if(points.get(i).p.x == points.get(rightIdx).p.x){
        if(points.get(i).p.y < points.get(rightIdx).p.y){ // rightmost lowest
          rightIdx = i;
        }
      }
    }
  }
  // System.out.println("\n left and right idx " + leftIdx + " " + rightIdx);  

  // save lines always counterclockwise 
  Edge halfLineUpper = new Edge(points.get(rightIdx), points.get(leftIdx));
  Edge halfLineLower = new Edge(points.get(leftIdx), points.get(rightIdx));

  // processing uppar and lower halves 
  quickHullDivide(cHull, halfLineUpper);
  quickHullDivide(cHull, halfLineLower);

  // System.out.println("\n after cHull size " + cHull.p.size()); 
  return cHull;// cHullReturn;
}

Polygon quickHullDivide(Polygon cHull, Edge edgeLine){ // recursion - make the new left and right edge 
  float maxDist = 0.0;
  int pointIdx = -1;

  for(int i = 0; i < points.size(); i++){
    if(checkIfPointOnRight(edgeLine, points.get(i))){// check if point on the right
      float dist = distLinePoint(edgeLine, points.get(i));
      if(dist > maxDist){
        pointIdx = i;
        maxDist = dist;
      }
    }
  }

  if(pointIdx != -1){ // go ahead only if points exist on the right side 
    quickHullDivide(cHull, new Edge(edgeLine.p0, points.get(pointIdx)));
    quickHullDivide(cHull, new Edge(points.get(pointIdx), edgeLine.p1));
  }
  else{ // when its the end edge - terminating case 
    // cHull.addPoint(edgeLine.p0);
    cHull.addPoint(edgeLine.p1);
    if(cHull.p.size() >= 3) checkIfPrevPointCollinear(cHull);
  }

  return cHull;
}

boolean checkIfPointOnRight(Edge e, Point p){ // cross product less that zero 
  float ax = e.p1.p.x - e.p0.p.x;
  float ay = e.p1.p.y - e.p0.p.y;
  float bx = p.p.x - e.p0.p.x;
  float by = p.p.y - e.p0.p.y;
  if((ax * by - bx * ay) < 0){
    // System.out.println("\n on the right " );  
    return true;
  }
  return false;
}

float distLinePoint(Edge e, Point p){
  float m = (e.p1.p.y - e.p0.p.y)/(e.p1.p.x - e.p0.p.x);
  float a = m;
  float b = -1;
  float y2 = e.p1.p.y;
  float x2 = e.p1.p.x;
  float c = y2 - m * x2;
  float d = abs(a * p.p.x + b * p.p.y + c) / sqrt(a*a + b*b);
  // System.out.println("\n d = " + d );  
  return d;
}










Polygon ConvexHullGraham( ArrayList<Point> points ){
  Polygon cHull = new Polygon();

  if(points.size() < 3){
    return cHull;
  }

  // finding the leftmost point
  int leftmostIdx = 0;
  for(int i = 0; i < points.size(); i++){
    if(points.get(i).p.x <= points.get(leftmostIdx).p.x){
      leftmostIdx = i;
      if(points.get(i).p.x == points.get(leftmostIdx).p.x){
        if(points.get(i).p.y > points.get(leftmostIdx).p.y){ // top of the leftest points
          leftmostIdx = i;
        }
      }
    }
  }
  // println("\n leftmostIdx=" + leftmostIdx);

  // sort based on calculated angles
  ArrayList<Integer> sortedPointsIdx = new ArrayList<Integer>();
  for(int i = 0; i < points.size(); i++){
    sortedPointsIdx.add(i);
  }
  // System.out.println("\n before sortedPointsIdx: " + sortedPointsIdx);

  PVector v1 = new PVector(0, -10);
  final Integer xx = new Integer(leftmostIdx);
  Collections.sort( sortedPointsIdx, new Comparator<Integer>(){
    public int compare(Integer int0, Integer int1 ){
      PVector v2_0 = PVector.sub(points.get(int0).p, points.get(xx).p);
      float a0 = PVector.angleBetween(v1, v2_0); // gives only 0 to 180
      PVector v2_1 = PVector.sub(points.get(int1).p, points.get(xx).p);
      float a1 = PVector.angleBetween(v1, v2_1); // gives only 0 to 180
      if(a0 < a1){
        return -1;
      }
      if(a0 > a1){
        return 1;
      }
      return 0;
    }
  });
  // System.out.println("\n after sorting sortedPointsIdx: " + sortedPointsIdx);

  Stack<Integer> stack = new Stack<Integer>();
  // push 3
  stack.push(sortedPointsIdx.get(0));
  stack.push(sortedPointsIdx.get(1));
  stack.push(sortedPointsIdx.get(2));
  int i = 3;

  while(stack.peek() != sortedPointsIdx.get(0)){
    // println("\n initially stack" + stack.size());
    if(stack.size() < 3){
      // println("here........");
      stack.push(sortedPointsIdx.get(i));
      i++;
    }

    int r = stack.pop();
    int q = stack.pop();
    int p = stack.pop();
    // check if counter clockwise 
    if(checkIfCounterClockwise(points.get(p), points.get(q), points.get(r))){
      stack.push(p);
      stack.push(q);
      stack.push(r); 

      // push next if prev is counter clockwise
      stack.push(sortedPointsIdx.get(i%points.size()));
      i++;
    }
    else{ // if clock wise then dont push q
      stack.push(p);
      stack.push(r);
    }
    // println("\n end stack" + stack);
  }

  // removing the repeated first point
  stack.pop();

  // reversing the order because need to pop 
  // println("\n final stack" + stack);
  Stack<Integer> revStack = new Stack<Integer>();
  while(!stack.isEmpty()){
    revStack.push(stack.pop());
  }
  // println("\n reverse revStack" + revStack);
  while(!revStack.isEmpty()){
    cHull.addPoint(points.get(revStack.pop()));
    if(cHull.p.size() >= 3) checkIfPrevPointCollinear(cHull);
  }

  return cHull;
}

boolean checkIfCounterClockwise(Point p0, Point p1, Point p2){
  float ax = p1.p.x - p0.p.x;
  float ay = p1.p.y - p0.p.y;
  float bx = p2.p.x - p1.p.x;
  float by = p2.p.y - p1.p.y;
  if((ax * by - bx * ay) > 0){
    // System.out.println("\n counter clockwise " );  
    return true;
  }
  return false;
}










Polygon ConvexHullGiftWrap( ArrayList<Point> points ){
  Polygon cHull = new Polygon();

  if(points.size() < 3){
    return cHull;
  }

  int lowestPointIdx = 0; // lowest left
  int highestPointIdx = 0; // highest right

  for(int i = 0; i < points.size(); i++){
    if(points.get(i).p.y <= points.get(lowestPointIdx).p.y){
      lowestPointIdx = i;
      if(points.get(i).p.y == points.get(lowestPointIdx).p.y){
        if(points.get(i).p.x > points.get(lowestPointIdx).p.x){ // leftmost of the highest points 
          lowestPointIdx = i;
        }
      }
    }
    if(points.get(i).p.y >= points.get(highestPointIdx).p.y){
      highestPointIdx = i;
      if(points.get(i).p.y == points.get(highestPointIdx).p.y){
        if(points.get(i).p.x < points.get(highestPointIdx).p.x){ // rightmost of the lowest points
          highestPointIdx = i;
        }
      }
    }
  }

  // System.out.println("\n indexes lowestPointIdx=" + lowestPointIdx + " highestPointIdx=" + highestPointIdx);

  // cHull.p.add(points.get(lowestPointIdx));
  iterateTillEnd(true, points, cHull, lowestPointIdx, highestPointIdx);
  iterateTillEnd(false, points, cHull, lowestPointIdx, highestPointIdx);

  // System.out.println("\n after cHull size " + cHull.p.size()); 
  return cHull;
}

void iterateTillEnd(boolean bottomToTop, ArrayList<Point> points, Polygon cHull, int lowestPointIdx, int highestPointIdx){

  int iteratingPointIdx = lowestPointIdx;
  int finalIdx = highestPointIdx;
  float directionXY = 1.0;
  if(bottomToTop){
    directionXY = 1.0;
    iteratingPointIdx = lowestPointIdx;
    finalIdx = highestPointIdx;
  }
  else{
    directionXY = -1.0;
    iteratingPointIdx = highestPointIdx;
    finalIdx = lowestPointIdx;
  }
  // println(" inside function - " + iteratingPointIdx + ", " + finalIdx + ", " + directionXY);
  Edge dividingLine = new Edge(points.get(iteratingPointIdx), points.get(finalIdx));

  // int cnt = 0; // to exit infinite loop 
  while(iteratingPointIdx != finalIdx){ // from bottom start point to top
    // check if point is on the right side 
    int minAngleIdx = -1;//0;
    float minAngle = PI;

    PVector v1 = new PVector(100*directionXY, 0);
    PVector v2 = new PVector(100*directionXY, 0);
    for(int i = 0; i<points.size(); i++){ // TODO: MAKE 2 POINTS LIST, LEFT AND RIGHT 
      if(i != iteratingPointIdx){
        if(checkIfPointOnRight(dividingLine, points.get(i)) && points.get(i).p.y*directionXY >= points.get(iteratingPointIdx).p.y*directionXY ){ // checking if point is on the right 
          v2 = PVector.sub(points.get(i).p, points.get(iteratingPointIdx).p);
          float a = PVector.angleBetween(v1, v2); // gives only 0 to 180
          // println("\n i=" + i + " a=" + a + " degrees=" + degrees(a));  
          if(a < minAngle){ // finding the min angle 
            minAngleIdx = i;
            minAngle = a;
          }
        }
      }
    }

    // check angle with the highest point too COZ it is missed when checking for points on the right, that one is not on the right side hence not checked
    v2 = PVector.sub(points.get(finalIdx).p, points.get(iteratingPointIdx).p);
    float a = PVector.angleBetween(v1, v2); // gives only 0 to 180
    // println("\n i=" + i + " a=" + a + " degrees=" + degrees(a));  
    if(a < minAngle){ // finding the min angle 
      minAngleIdx = finalIdx;
      minAngle = a;
    }

    // println("\n minAngleIdx " + minAngleIdx);
    if(minAngleIdx != -1){
      cHull.p.add(points.get(minAngleIdx));
      // checking collinearity 
      if(cHull.p.size() >= 3){
        checkIfPrevPointCollinear(cHull);
      }
      
      iteratingPointIdx = minAngleIdx;
    }
    else{ // when no points on that side
      iteratingPointIdx = finalIdx;
    }

    // exit infinite 
    // if(cnt > points.size()){
    //   break;
    // }
    // cnt++;
  }
}

void checkIfPrevPointCollinear(Polygon cHull){
  int cSize = cHull.p.size();
  PVector v1 = PVector.sub(cHull.p.get(cSize-1).p, cHull.p.get(cSize-2).p);
  PVector v2 = PVector.sub(cHull.p.get(cSize-3).p, cHull.p.get(cSize-2).p);
  float a = PVector.angleBetween(v1, v2);
  // println(" a is " + degrees(a));
  if(a == PI){
    cHull.p.remove(cSize-2);
    // println("removing collinear");
  }
}
