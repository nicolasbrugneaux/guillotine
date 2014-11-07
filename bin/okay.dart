library okay;

/**
 * @author Muy
 */
String okay( String blabla )
{
    int baseRepeat        = 4;
    RegExp regeeex        = new RegExp(
        r'([A-Z]*?[^AEIOUYµ])?([AEIOUYµ]+)([^AEIOUYµ]+E?)?$' );
    String okaaayedBlabla = '';
    List sentences        = blabla.trim().toUpperCase().split( '. ' );

    for ( String sentence in sentences )
    {
        List splitted             = sentence.split( ' ' );
        String okaaaySentence     = sentence.substring( 0,
        sentence.lastIndexOf( ' ' ) );
        String lastWooord         = splitted[splitted.length-1];
        Match foouuund            = regeeex.firstMatch( lastWooord );

        String lastVoweeels       = foouuund != null ? foouuund[2] : '';
        String newVoweeels        = '';

        if ( lastVoweeels.length > 0 )
        {
            int repeatCount = baseRepeat;

            for ( int j = lastVoweeels.length - 1; j >= 0; j-- )
            {
                String voweeel = lastVoweeels[j];

                for ( int k = 0; k < repeatCount; k++ )
                {
                    voweeel += lastVoweeels[j];
                }

                repeatCount = ( repeatCount - 1 ) >= 1 ? repeatCount - 1 : 1 ;
                newVoweeels = voweeel + newVoweeels;
            }

            // replace last occurence
            int li      = lastWooord.lastIndexOf( lastVoweeels );
            lastWooord  = lastWooord.substring( 0, li ) + newVoweeels +
            lastWooord.substring( li + lastVoweeels.length );
        }

        okaaaySentence += ' ' + lastWooord + '! ';

        okaaayedBlabla += okaaaySentence;
    }

    return okaaayedBlabla.trim();
}
