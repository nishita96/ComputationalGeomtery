

class Edge{
  
   Point p0,p1;
   AABB aabb;
   
   Edge(Point _p0, Point _p1 ){
     
     if(_p0.p.y > _p1.p.y){
       p0 = _p0;
       p1 = _p1;
     }
     else{
       p0 = _p1;
       p1 = _p0;
     }
     
     //p0 = _p0;
     //p1 = _p1;
     
     // TODO: Initialize AABB
     float minX = min(p0.p.x, p1.p.x);
     float maxX = max(p0.p.x, p1.p.x);
     float minY = min(p0.p.y, p1.p.y);
     float maxY = max(p0.p.y, p1.p.y);
     aabb = new AABB( minX, maxX, minY, maxY );
   }
   
   void draw(){
     line( p0.p.x, p0.p.y, 
           p1.p.x, p1.p.y );
   }
   
   AABB getAABB(){
     return aabb;
   }
   
   int signum(float f) {
      if (f > 0) return 1;
      if (f < 0) return -1;
      return 0;
    } 
   
   boolean intersectionTest( Edge other ){
     // TODO: Implement A Method To Find If Edges Intersect using the cross product approach.
     // Should return true if intersecting and false otherwise.
     
     // 4 points - other.p0, other.p1, p0, p1
     // 4 cross product checks needed
     
     //System.out.println("new set");
     
     int sign1 = 0;
     int sign2 = 0;
     
     // other edge 
     float o1o0x = other.p1.p.x - other.p0.p.x;
     float o1o0y = other.p1.p.y - other.p0.p.y;
     // do with points other 2 points 
     float p0o0x = p0.p.x - other.p0.p.x;
     float p0o0y = p0.p.y - other.p0.p.y;
     float crossProduct1 = o1o0x * p0o0y - o1o0y * p0o0x;
     float p1o0x = p1.p.x - other.p0.p.x;
     float p1o0y = p1.p.y - other.p0.p.y;
     float crossProduct2 = o1o0x * p1o0y - o1o0y * p1o0x;
     if(signum(crossProduct1) != signum(crossProduct2)){
       //System.out.println("1 " + signum(crossProduct1) + " " + signum(crossProduct2));
       sign1 = 1;
     }
     
     //do this only when upper one is true?
     float p2p3x = p1.p.x - p0.p.x;
     float p2p3y = p1.p.y - p0.p.y;
     // do with points other 2 points 
     float o0p2x = other.p0.p.x - p0.p.x;
     float o0p2y = other.p0.p.y - p0.p.y;
     crossProduct1 = p2p3x * o0p2y - p2p3y * o0p2x;
     float o1p2x = other.p1.p.x - p0.p.x;
     float o1p2y = other.p1.p.y - p0.p.y;
     crossProduct2 = p2p3x * o1p2y - p2p3y * o1p2x;
     if(signum(crossProduct1) != signum(crossProduct2)){
       //System.out.println("2 " + signum(crossProduct1) + " " + signum(crossProduct1));
       sign2 = 1;
     }
     
     if(sign1 == 1 && sign2 == 1){
       return true;
     }
     return false;    
   }
   
   Point intersectionPoint( Edge other ){
     // TODO: Implement A Fast Method To Find The Edge Intersection Point.
     // Should return the intersection point or null, if no intersection exists.
     //  Care should be taken to make the implementation CORRECT, but SPEED MATTERS.
     
     //do the p1 - p0 and use that so that number of multiplication is less 
     float p0x = other.p0.p.x;
     float p0y = other.p0.p.y;
     float p1x = other.p1.p.x;
     float p1y = other.p1.p.y;
     float p2x = p0.p.x;
     float p2y = p0.p.y;
     float p3x = p1.p.x;
     float p3y = p1.p.y;
     float s = (p2y*p1x - p0y*p1x - p2y*p0x + p0y*p0x - p2x*p1y + p0x*p1y + p2x*p0y - p0x*p0y)/(p3x*p1y - p2x*p1y - p3x*p0y + p2x*p0y - p3y*p1x + p2y*p1x + p3y*p0x - p2y*p0x);
     if(0 <= s && s <= 1){
       float t = (p2x + ((p3x - p2x) * s) - p0x)/(p1x - p0x);
       if(0 <= t && t <= 1){
         float pointX = p0x + ((p1x - p0x) * t);
         float pointY = p0y + ((p1y - p0y) * t);
         return new Point(pointX, pointY);
       }
     }
     return null;
   }
   
}
