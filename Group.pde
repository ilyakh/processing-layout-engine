import java.util.ArrayList;

public class Group {
  ArrayList<Element> elements; 

  public Group() {
    this.elements = new ArrayList<Element>();
  }

  public boolean addElement( Element e ) {
    return this.elements.add( e );
  }

  public ArrayList<Group> splitInto( int quantity, boolean horizontal ) {

    this.sortByDate();

    ArrayList<Group> groups = new ArrayList<Group>();
    ArrayList<Element> elements = this.elements;

    for ( int i = 0; i < quantity; i++ ) {
      groups.add( new Group() );
    }
    
    println( elements.size() );

    if ( horizontal ) {
      // the events can be read from right to left in chronological succession      
      while ( elements.size() > 0 ) {
        for ( int i = 0; i < groups.size(); i++ ) {
          if ( elements.size() > 0 ) {
            groups.get(i).addElement( elements.get(0) );
            elements.remove(0);
          }
        }
      }
    } 
    else {
      // the events can be read from top-down for chronological succession
      
      int verticalQuantity = elements.size() / quantity+1;
      int currentGroupIndex = 0;
      int currentElementIndex = 0;

      while ( elements.size() > 0 && currentGroupIndex < quantity ) {
        groups.get(currentGroupIndex).addElement( elements.get(0) );
        elements.remove(0);
        currentElementIndex++;

        if (! (currentElementIndex < verticalQuantity) ) {
          currentGroupIndex++;
          currentElementIndex = 0;
        }
      }
    }

    return groups;
  }

  class ElementComparator implements Comparator<Element> {
    @Override
      public int compare( Element a, Element b ) {
      return a.date.compareTo( b.date );
    }
  }

  public void sortByDate() {
    Collections.sort( this.elements, new ElementComparator() );
  }

  public void renderVertical() {
    int current;
  }
}

