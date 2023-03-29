
// Class to hold an Axis Aligned Bounding Box
class AABB {

  float minX, maxX;
  float minY, maxY;
  
  AABB( float _minX, float _maxX, float _minY, float _maxY ){
    minX = _minX;
    maxX = _maxX;
    minY = _minY;
    maxY = _maxY;
  }
  
  boolean intersectionTest( AABB other ){
    // TODO: Implement A Method To Find The Intersection Between 2 Axis Aligned Bounding Boxes
    //System.out.println("here");
     
     float maxOfMinValX = max(other.minX, minX) ;
     float minOfMaxValX = min(other.maxX, maxX) ;
     
     float maxOfMinValY = max(other.minY, minY) ;
     float minOfMaxValY = min(other.maxY, maxY) ;
     
     if(maxOfMinValX <= minOfMaxValX && maxOfMinValY <= minOfMaxValY){
       return true;
     }
    return false;
  }
  
}
