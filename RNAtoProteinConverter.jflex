%%
%class RNAtoProteinFasta
%standalone
%line
%column
%state PATTERN
%state TEMP

Whitespace = [\t\n]+
Newline = [\>]
LineTerminator = \r|\n|\r\n
Sequence = [ACUG][ACUG][ACUG]+{LineTerminator}
InputCharacter = [^\r\n]?[^\r\n]{LineTerminator}

%{

String s = "";

static int sequenceCount = 0, sequenceLength = 0;

StringBuffer string = new StringBuffer();

public static String translation(String temp) {
    int i = 0;
    String result = "";
    while (i <= temp.length() - 3) {
    String triplet = temp.substring(i,i+=3);
        if (triplet.equals("UUU") || triplet.equals("UUC"))
            result += 'F';
        if (triplet.equals("UUA") || triplet.equals("UUG")
                || triplet.equals("CUU") || triplet.equals("CUC")
                || triplet.equals("CUA") || triplet.equals("CUA")
                || triplet.equals("CUG"))
            result += 'L';
        if (triplet.equals("AUU") || triplet.equals("AUC")
                || triplet.equals("AUA"))
            result += 'I';
        if (triplet.equals("AUG"))
            result += 'M';
        if (triplet.equals("GUU") || triplet.equals("GUC")
                || triplet.equals("GUA") || triplet.equals("GUG"))
            result += 'V';
        if (triplet.equals("UCU") || triplet.equals("UCC")
                || triplet.equals("UCA") || triplet.equals("UCG"))
            result += 'S';
        if (triplet.equals("AGA") || triplet.equals("AGG"))
            result += 'R';
        if (triplet.equals("AGU") || triplet.equals("AGC"))
            result += 'S';
        if (triplet.equals("UGG"))
            result += 'W';
        if (triplet.equals("UGU") || triplet.equals("UGC"))
            result += 'C';
        if (triplet.equals("GAA") || triplet.equals("GAG"))
            result += 'E';
        if (triplet.equals("GAU") || triplet.equals("GAC"))
            result += 'D';
        if (triplet.equals("AAA") || triplet.equals("AAG"))
            result += 'K';
        if (triplet.equals("AAU") || triplet.equals("AAC"))
            result += 'N';
        if (triplet.equals("CAA") || triplet.equals("CAG"))
            result += 'Q';
        if (triplet.equals("CAU") || triplet.equals("CAC"))
            result += 'H';
        if (triplet.equals("UAU") || triplet.equals("UAC"))
            result += 'Y';
        if (triplet.equals("CCG") || triplet.equals("CCA")
                || triplet.equals("CCC") || triplet.equals("CCU"))
            result += 'P';
        if (triplet.equals("ACG") || triplet.equals("ACA")
                || triplet.equals("ACC") || triplet.equals("ACU"))
            result += 'T';
        if (triplet.equals("GCG") || triplet.equals("GCA")
                || triplet.equals("GCC") || triplet.equals("GCU"))
            result += 'A';
        if (triplet.equals("CGG") || triplet.equals("CGA")
                || triplet.equals("CGC") || triplet.equals("CGU"))
            result += 'R';
        if (triplet.equals("GGG") || triplet.equals("GGA")
                || triplet.equals("GGC") || triplet.equals("GGU"))
            result += 'G';
        if (triplet.equals("UAG") || triplet.equals("UAA")
                || triplet.equals("UGA"))
            result += '.';
    }
    return result;
}

public String getString(String S){
    return S;
}

%}

%%


<YYINITIAL> {
    
{Newline}   {   

    int lineNo = yyline+1;
    sequenceCount++;
    System.out.println("FastaFile Line No: "+lineNo); 
    System.out.println("Sequence: "+sequenceCount);
    System.out.println("RNA Sequence Details:");
    yybegin(TEMP);   }

}

<TEMP> {
    
{LineTerminator}    {
 
    yybegin(PATTERN);

}

}

<PATTERN> {
    
{LineTerminator} {

    System.out.println("\nRNA Sequence Length: "+sequenceLength);
    System.out.println("|RNA Sequence|:\n"+s);
    System.out.println("Protein Sequence Length: "+translation(s).length());
    System.out.println("|Protein Sequence|:\n"+translation(s));
    s = "";
    sequenceLength = 0;
    System.out.println("***************************\n");
    yybegin(YYINITIAL);
}

{InputCharacter}    {/* Do Nothing */}

{Sequence}          {   

    s = s.concat(yytext().trim());  
    sequenceLength += yytext().trim().length();

}

{Whitespace}        {System.out.println("rol");}    
\n                  {/* Do Nothing */}
.                   {/* Do Nothing */}

}