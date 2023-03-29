
public void LineSegmentSetIntersectionAABB( ArrayList<Edge> input_edges, ArrayList<Point> output_intersections ){
  // TODO: Implement the optimized AABB method for calucating the intersections of a set of line segments.
  // The implemention does NOT need to use an interval tree (a list is sufficient). However, performance matters!
  output_intersections.clear();
  
  
  //int ymax = Integer.MIN_VALUE;
  //int ymin = Integer.MAX_VALUE;
  
  // make event queue, highest val Y - sort absed on this 
  // calc at after each event 
  
  // keep status list (ll), no swaps
  // status list - only edges 
  

  
  ArrayList<Event> eventQueueArr = new ArrayList<Event>();
  for(int i=0; i<input_edges.size(); i++){
    Edge currentEdge = input_edges.get(i);
    
    //if(currentEdge.p0.p.y > currentEdge.p1.p.y){
    //  eventQueueArr.add(new Event(currentEdge.p0, currentEdge, null));//top edge // switched p0 and p1 - works 
    //  eventQueueArr.add(new Event(currentEdge.p1, null, currentEdge));
    //}
    //else{
    //  eventQueueArr.add(new Event(currentEdge.p1, currentEdge, null));//top edge // switched p0 and p1 - works 
    //  eventQueueArr.add(new Event(currentEdge.p0, null, currentEdge));
    //}
    
    eventQueueArr.add(new Event(currentEdge.p1, currentEdge, null));//top edge // switched p0 and p1 - works 
    eventQueueArr.add(new Event(currentEdge.p0, null, currentEdge));
  }
    
  Collections.sort( eventQueueArr, new Comparator<Event>(){
    public int compare(Event e0, Event e1 ){
      if( e0.p.p.y < e1.p.p.y ) return -1;
      if( e0.p.p.y > e1.p.p.y ) return  1;
      return 0;
    }
  });
  
  //System.out.println(" after ");
  //for(int i=0; i<eventQueueArr.size(); i++){
  //  System.out.println(i + " " + eventQueueArr.get(i).p.p.y);
  //}
  
  
  
  
  //LinkedList<Event> eventQueue = new LinkedList<Event>();
  //for(int i=0; i<input_edges.size(); i++){
  //  Point biggerY = input_edges.get(i).p0.p.y > input_edges.get(i).p1.p.y ? input_edges.get(i).p0 : input_edges.get(i).p1 ;
  //  Point smallerY = input_edges.get(i).p0.p.y < input_edges.get(i).p1.p.y ? input_edges.get(i).p0 : input_edges.get(i).p1 ;
  //  Event eachBigEvent = new Event(biggerY, input_edges.get(i), null, i);
  //  Event eachSmallEvent = new Event(smallerY, null, input_edges.get(i), i);
    
  //  if(i==0){
  //    // initial
  //    eventQueue.add(eachBigEvent);
  //    eventQueue.add(eachSmallEvent);
  //  }
  //  else{
  //    boolean flag = false;
  //    for(int j=0; j<eventQueue.size(); j++){
  //      if(biggerY.p.y > eventQueue.get(j).p.p.y ){
  //        eventQueue.add(j, eachBigEvent);
  //        flag = true;
  //        break;
  //      }
  //    }
  //    if(!flag){
  //      eventQueue.add(eachBigEvent);
  //    }
      
  //    flag = false;
      
  //    for(int j=0; j<eventQueue.size(); j++){
  //      if(smallerY.p.y > eventQueue.get(j).p.p.y ){
  //        eventQueue.add(j, eachSmallEvent);
  //        flag = true;
  //        break;
  //      }
  //    }
  //    if(!flag){
  //      eventQueue.add(eachSmallEvent);
  //    }
  //  }
  //}
  //System.out.println(" input_edges.size() " + input_edges.size());
  
  
  
  
  
  
  
  
  
  
  
  // active status list 
  ArrayList<Edge> activeListEdges = new ArrayList<Edge>();
  
  for(int j=0; j<eventQueueArr.size(); j++){
    Event currentEvent = eventQueueArr.get(j);
    if(currentEvent.edge2 == null){ // means top edge
      for(int m = 0; m < activeListEdges.size(); m++ ){ // check comparison only with the active edges
          boolean flag = activeListEdges.get(m).aabb.intersectionTest(currentEvent.edge1.aabb);
          if(flag){
            Point intersection = activeListEdges.get(m).intersectionPoint(currentEvent.edge1);
            if(intersection != null)
              output_intersections.add(intersection);
          }
      }
      
      // insert in active list 
      activeListEdges.add(currentEvent.edge1);
      
    }
    else{ // means bottom edge
      // remove from active list 
      activeListEdges.remove(currentEvent.edge2);
    } //<>// //<>//
  }
  
  
  
  
  
  
  
  
  
  // brute algo for AABB
  //for( int i = 0; i < input_edges.size(); i++ ){
  //  for(int j = i+1; j < input_edges.size(); j++ ){
  //    boolean flag = input_edges.get(i).aabb.intersectionTest(input_edges.get(j).aabb); // O(n^2)
  //    if(flag){
  //        Point intersection = input_edges.get(i).intersectionPoint(input_edges.get(j));
  //        if(intersection != null)
  //          output_intersections.add(intersection);
  //    }
  //  }
  //}
  
}
