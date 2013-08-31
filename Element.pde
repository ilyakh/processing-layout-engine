

public class Element {
  public Date date;
  public String description;
  public String[] persons;

  public Element( String date, String description, String persons ) {
    this.date = this.getDate( date );
    this.description = description;
    this.persons = this.getPersons( persons );
  }

  private Date getDate( String date ) {
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Date result = null;
    
    try {
      result = df.parse( date );
    } catch ( ParseException e ) {
      println( e ); 
    }
    return result;
  }

  private String[] getPersons( String persons ) {
    String[] personsArray = persons.split( ", " );
    return personsArray;
  }
}

