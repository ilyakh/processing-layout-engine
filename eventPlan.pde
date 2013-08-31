import processing.pdf.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Locale;
import java.util.Collections;
import java.util.Comparator;

Group events = new Group();
CSVInput input;

// fonts
PFont futuraCondensed;

// dimensions
// A4 at 300 dpi: 2480 X 3508
int documentHeight = 3508;
int documentWidth = 2480;  
int documentBaseFontSize = 60;

String inputFile = "events.txt";
String outputFile = "events.pdf";



public void setup() {
  colorMode( HSB, 100 );
  rectMode( CENTER );

  futuraCondensed = createFont( "Futura-Condensed-Normal", documentBaseFontSize );
  textFont( futuraCondensed );
  textAlign( LEFT );

  size( documentWidth, documentHeight ); 
  background( color( 100 ) );
  noLoop();
  
  input = new CSVInput( inputFile );
  input.getData();

  beginRecord( PDF, outputFile );
}

public void draw() {

  String[] tokens; 
  for ( int i = 0; i < input.lines.length; i++ ) {
    tokens = input.lines[i].split( "\t" );

    events.addElement(
    new Element( tokens[0], tokens[1], tokens[2] )  );
  }

  // split into groups (can be either columns or rows)
  int numberOfColumns = 3;

  ArrayList<Group> groups = events.splitInto( numberOfColumns, false );

  int defaultX = 100;
  int defaultY = 100;

  int currentXAnchor = 100;
  int currentYAnchor = 100;

  int offset = 10;

  int eventSpacing = 150;

  Locale noLocale = new Locale("no", "NB");
  
  for ( Group g: groups ) {
    for ( Element e: g.elements ) {
      // style settings: necessary repeat for PDF export
      fill( color( 0 ) ); 
      textFont( futuraCondensed );
      textAlign( LEFT );

      // print the date
      fill( color( 0, 0, 50 ) );
      textFont( futuraCondensed, documentBaseFontSize * .614 );

      SimpleDateFormat dateFormat = new SimpleDateFormat( "EEEE, dd. MMMM", noLocale );

      text( dateFormat.format( e.date ), currentXAnchor, currentYAnchor += (documentBaseFontSize *1.5) );

      // print the description
      fill( color( 0, 0, 0 ) );
      textFont( futuraCondensed, documentBaseFontSize );
      text( e.description, currentXAnchor, currentYAnchor += (documentBaseFontSize) );

      // list experts
      fill( color( 0, 0, 0 ) );
      textFont( futuraCondensed, documentBaseFontSize * .614 * .614 );

      int personsXAnchor = currentXAnchor; // create a sub-anchor for expert lists
      currentYAnchor = currentYAnchor + int( documentBaseFontSize * .614 );

      for ( int i = 0; i < e.persons.length; i++ ) {
        text( e.persons[i], personsXAnchor, currentYAnchor );
        // personsXAnchor += 150; // used to work fine, but I am getting rid of the non-parametric constants
        personsXAnchor += ( documentWidth / numberOfColumns / (numberOfColumns +2) );
      }

      // add detailed description
      String fullText = ( "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elementum mi " +
        "eget dolor consequat, vitae ullamcorper velit lacinia. Donec vitae lectus nibh. Pellentesque " +
        "dui nulla, dapibus eu quam vitae, pulvinar ultrices libero. Vestibulum non sagittis dui, " +
        "eget consequat quam. Quisque sodales hendrerit posuere. Cras cursus interdum nisi scelerisque " +
        "scelerisque. Aenean nec laoreet nibh. Vivamus facilisis nisi nisl, ac viverra tortor sodales vitae. " +
        "Aenean eu vestibulum est." );


      text( 
        utils.wordWrap( fullText, (documentWidth / numberOfColumns) - ( documentWidth / numberOfColumns / (numberOfColumns +2) ) ), 
        currentXAnchor, 
        currentYAnchor += (documentBaseFontSize) 
      );

      
      // space from the previous event and /
      currentYAnchor += eventSpacing;
    }
    currentYAnchor = defaultY; 
    currentXAnchor += documentWidth / numberOfColumns;
  }
  
  endRecord();
}

