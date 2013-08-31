public class CSVInput {
  public String[] lines;

  public CSVInput( String filename ) {
    this.lines = loadStrings( filename );
  }

  public String [] getData() {
    for ( int i = 0; i < lines.length; i++ ) {
      String[] tokens = splitTokens( this.lines[i], "\t" );
      int x = int( tokens[0] );
      String abc = tokens[1];
    }

    return this.lines;
  }
}

