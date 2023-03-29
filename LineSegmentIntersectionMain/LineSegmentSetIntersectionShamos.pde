
public void LineSegmentSetIntersectionShamos( ArrayList<Edge> input_edges, ArrayList<Point> output_intersections ){
  // TODO: Implement the optimized Shamos-Hoey method for calucating the intersections of a set of line segments.
  // The implemention does NOT need to use a line sweep status tree (a list is sufficient). However, performance matters!
  output_intersections.clear();
  
  //calc queue - same as AABB
  //event to 
  //intersectionPoint 
  
  
  // make the queue - ll , saves point n edge 
  
  // status list - double ll
  
  //sort by highest y 
  //make always with y 
  //priority queue - event queue 
  
  //loop through the events - may get some added later  
  //new node - new segment-check x for that - place it in status - compare with its neighbours 
  
  //ArrayList<EventQueue> queue;
  
  //System.out.println("i am here ");
  
  ArrayList<Event> eventQueueArr = new ArrayList<Event>();
  for(int i=0; i<input_edges.size(); i++){
    Edge currentEdge = input_edges.get(i);
    eventQueueArr.add(new Event(currentEdge.p0, currentEdge, null));
    eventQueueArr.add(new Event(currentEdge.p1, null, currentEdge));
  }
    
  Collections.sort( eventQueueArr, new Comparator<Event>(){
    public int compare(Event e0, Event e1 ){
      if( e0.p.p.y < e1.p.p.y ) return -1;
      if( e0.p.p.y > e1.p.p.y ) return  1;
      return 0;
    }
  });
  
  //System.out.println(" after "); //<>//
  //for(int i=0; i<eventQueueArr.size(); i++){
  //  System.out.println(i + " " + eventQueueArr.get(i).p.p.y);
  //}
  
  
  
  //insert in list by calculating x again at that y 
  
  // active status list 
  //LinkedList<Shamos> activeListNodes = new LinkedList<Shamos>();
  LinkedList<Edge> activeListEdge = new LinkedList<Edge>();
  LinkedList<Float> activeListPointX = new LinkedList<Float>();
  
  
  for(int j=0; j<eventQueueArr.size(); j++){
    Event currentEvent = eventQueueArr.get(j);
    
    // calculating new X for currentEvent Y, update x value in the list 
    float yVal = currentEvent.p.p.y;
    for(int m = 0; m < activeListEdge.size(); m++ ){ 
      Edge currentEdge = activeListEdge.get(m);
      float slope = (currentEdge.p1.p.y - currentEdge.p0.p.y) / (currentEdge.p1.p.x - currentEdge.p0.p.x); // (y2-y1)/(x2-x1)
      //System.out.println("2");
      float newX = (yVal - currentEdge.p1.p.y) / slope;
      newX = newX + currentEdge.p1.p.x;
      //float newX = (currentEdge.p0.p.x) +  ((currentEdge.p1.p.x - currentEdge.p0.p.x) * (yVal - currentEdge.p0.p.y))  / (currentEdge.p1.p.y - currentEdge.p0.p.y) ;
      activeListPointX.set(m, newX);
    }
    
    if(currentEvent.edge1 == null){ // top edge
      //System.out.println("in top");
      //System.out.println(activeListEdge.size());
      
      boolean inserted = false; //<>//
      for(int m = 0; m < activeListEdge.size(); m++ ){ // check comparison only with the active edges
        if(currentEvent.p.p.x < activeListPointX.get(m)){
          
          // compare with m-1
          if(m != 0){
            Point intersection = activeListEdge.get(m-1).intersectionPoint(currentEvent.edge2);
            if(intersection != null){
                output_intersections.add(intersection);
                
                // add intersection in the queue
                for(int n = 0; n < eventQueueArr.size(); n++ ){
                  if(intersection.p.y > eventQueueArr.get(n).p.p.y){
                    //eventQueueArr.add(n, new Event(intersection, activeListEdge.get(m-1), currentEvent.edge2));
                    //System.out.println("size " + eventQueueArr.size());
                    break;
                  }
                }
              }
          }
              
          //compare with m
          Point intersection = activeListEdge.get(m).intersectionPoint(currentEvent.edge2);
          if(intersection != null){
            //if(id == -1){
              output_intersections.add(intersection);
              
              // add intersection in the queue
              for(int n = 0; n < eventQueueArr.size(); n++ ){
                if(intersection.p.y > eventQueueArr.get(n).p.p.y){
                  //eventQueueArr.add(n, new Event(intersection, activeListEdge.get(m), currentEvent.edge2));
                  //System.out.println("here ");
                  break;
                }
              }
            //}
              
          }
          
          // insert at m
          activeListEdge.add(m,  currentEvent.edge2); //new Shamos(currentEvent.p.p.x, currentEvent.p.p.y, currentEvent.edge1));
          activeListPointX.add(m, currentEvent.p.p.x); //new Point(currentEvent.p.p.x, currentEvent.p.p.y));
          inserted = true;
          break;
        }
      }
      if(!inserted){ // if largest x, insert at end
        if(activeListEdge.size() != 0){
          Point intersection = activeListEdge.get(activeListEdge.size()-1).intersectionPoint(currentEvent.edge2);
          if(intersection != null){
              output_intersections.add(intersection);
              
              // add intersection in the queue
              for(int n = 0; n < eventQueueArr.size(); n++ ){
                if(intersection.p.y > eventQueueArr.get(n).p.p.y){
              //    eventQueueArr.add(n, new Event(intersection, currentEvent.edge1, currentEvent.edge2));
              //    break;
                }
              }
          }
        }
        
        //insert at end 
        activeListEdge.add(currentEvent.edge2); //new Shamos(currentEvent.p.p.x, currentEvent.p.p.y, currentEvent.edge1));
        activeListPointX.add(currentEvent.p.p.x); //new Point(currentEvent.p.p.x, currentEvent.p.p.y));
      }
    }
    
    else if(currentEvent.edge2 == null){ // bottom edge
      //System.out.println("in bottom");
      int idx = activeListEdge.indexOf(currentEvent.edge1); //will ideally never be -1
      if(idx != -1){
        activeListEdge.remove(idx);
        activeListPointX.remove(idx);
      }
    }
    
    else{
      //System.out.println("here ");
      // intersection point event 
      int idx1 = activeListEdge.indexOf(currentEvent.edge1);
      int idx2 = activeListEdge.indexOf(currentEvent.edge2);
      activeListEdge.set(idx1, currentEvent.edge2);
      activeListEdge.set(idx2, currentEvent.edge1);
      activeListPointX.set(idx1, currentEvent.p.p.x);
      activeListPointX.set(idx2, currentEvent.p.p.x);
      
      
      if(idx1 < idx2 && idx1 != 0){
        Point intersection = activeListEdge.get(idx1-1).intersectionPoint(currentEvent.edge1);
        if(intersection != null)
            output_intersections.add(intersection);
        intersection = activeListEdge.get(idx2+1).intersectionPoint(currentEvent.edge2);
          if(intersection != null)
              output_intersections.add(intersection);
      }
      
      
      if(idx1 < idx2 && idx1 != 0){
        Point intersection = activeListEdge.get(activeListEdge.size()-1).intersectionPoint(currentEvent.edge2);
        if(intersection != null)
            output_intersections.add(intersection);
      }
      
    }
    
    //System.out.println(activeListEdge.size()+ " " + activeListPointX.size());
      
      
      
  //    // insert in active list 
  //    activeListEdges.add(currentEvent.edge1);
      
  //  }
  //  else{ // means bottom edge
  //    // remove from active list 
  //    activeListEdges.remove(currentEvent.edge2);
  //  }
  }
  
  
  
  
  
  
  
  
  
  //for(int j=0; j<eventQueueArr.size(); j++){
  //  Event currentEvent = eventQueueArr.get(j);
  //  if(currentEvent.edge2 == null){ // means top edge
  //    for(int m = 0; m < activeListEdges.size(); m++ ){ // check comparison only with the active edges
  //        boolean flag = activeListEdges.get(m).aabb.intersectionTest(currentEvent.edge1.aabb);
  //        if(flag){
  //          Point intersection = activeListEdges.get(m).intersectionPoint(currentEvent.edge1);
  //          if(intersection != null)
  //            output_intersections.add(intersection);
  //        }
  //    }
      
  //    // insert in active list 
  //    activeListEdges.add(currentEvent.edge1);
      
  //  }
  //  else{ // means bottom edge
  //    // remove from active list 
  //    activeListEdges.remove(currentEvent.edge2);
  //  }
  //}
  
  
}

public void UpdateXValue( ArrayList<Edge> input_edges, ArrayList<Point> output_intersections ){
  
}
