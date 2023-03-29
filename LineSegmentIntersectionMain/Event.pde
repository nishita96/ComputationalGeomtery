
// Class to hold an Axis Aligned Bounding Box
class Event {

  Point p;
  Edge edge1;
  Edge edge2;
  //int edgeIndex;
  
  Event(Point _p, Edge _edge1, Edge _edge2){
    p = _p;
    edge1 = _edge1;
    edge2 = _edge2;
    //edgeIndex = _edgeIndex;
  }
  
  
  boolean intersectionTest( AABB other ){
    return false;
  }
  
}
