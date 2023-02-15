/*-***
 *
 * This file defines a stand-alone lexical analyzer for a subset of the Pascal
 * programming language.  This is the same lexer that will later be integrated
 * with a CUP-based parser.  Here the lexer is driven by the simple Java test
 * program in ./PascalLexerTest.java, q.v.  See 330 Lecture Notes 2 and the
 * Assignment 2 writeup for further discussion.
 *
 */


import java_cup.runtime.*;


%%
/*-*
 * LEXICAL FUNCTIONS:
 */

%cup
%line
%column
%unicode
%class Lexer

%{

/**
 * Return a new Symbol with the given token id, and with the current line and
 * column numbers.
 */
Symbol newSym(int tokenId) {
    return new Symbol(tokenId, yyline, yycolumn);
}

/**
 * Return a new Symbol with the given token id, the current line and column
 * numbers, and the given token value.  The value is used for tokens such as
 * identifiers and numbers.
 */
Symbol newSym(int tokenId, Object value) {
    return new Symbol(tokenId, yyline, yycolumn, value);
}

%}


/*-*
 * PATTERN DEFINITIONS:
 */


/**
 * Implement patterns as regex here
 */

letter = [a-zA-Z]
digit = [0-9]
integer = {digit}+
id = {letter}| ({letter}|{digit})*
floating_point = {digit}+\.{digit}+
character = \'[^\'\\]\'
string = \"(\\.|[^\"])*\"
whitespace = [ \n\t\r]
inlinecomment = \\\\[^\n\r]+
multilinecomment = \\\*[\s\S]*?\*\\
%%
/**
 * LEXICAL RULES:
 */

/**
 * Implement terminals here, ORDER MATTERS!
 */

class               { return newSym(sym.CLASS,"class"); }
void                { return newSym(sym.VOID, "void"); }
final               { return newSym(sym.FINAL,"final"); }
int                 { return newSym(sym.INT, "int"); }
float               { return newSym(sym.FLOAT, "float"); }
char                { return newSym(sym.CHAR, "char"); }
bool                { return newSym(sym.BOOL, "bool"); }
true                { return newSym(sym.TRUE, "true"); }
false               { return newSym(sym.FALSE, "false"); }
if                  { return newSym(sym.IF, "if"); }
while               { return newSym(sym.WHILE, "while"); }
else                { return newSym(sym.ELSE, "else"); }
read                { return newSym(sym.READ, "read"); }
print               { return newSym(sym.PRINT, "print"); }
printline           { return newSym(sym.PRINTLINE, "printline"); }
return              { return newSym(sym.RETURN, "return"); }
"="                 { return newSym(sym.ASSIGN, "="); }
";"                 { return newSym(sym.SEMICOLON, ";"); }
"~"                 { return newSym(sym.NEGATION, "~"); }
"?"                 { return newSym(sym.QUESTION, "?"); }
":"                 { return newSym(sym.COLON, ":"); }
"++"                { return newSym(sym.UINC, "++"); }
"--"                { return newSym(sym.UDEC, "--"); }
"*"                 { return newSym(sym.MULTIPLY, "*"); }
"/"                 { return newSym(sym.DIVIDE, "/"); }
"+"                 { return newSym(sym.ADD, "+"); }
"-"                 { return newSym(sym.SUBTRACT, "-"); }
"<"                 { return newSym(sym.LT, "<"); }
">"                 { return newSym(sym.GT, ">"); }
"<="                { return newSym(sym.LTE, "<="); }
">="                { return newSym(sym.GTE, ">="); }
"=="                { return newSym(sym.ISEQ, "=="); }
"<>"                { return newSym(sym.ISNOTEQ, "<>"); }
"||"                { return newSym(sym.OR, "||"); }
"&&"                { return newSym(sym.AND, "&&"); }
"("                 { return newSym(sym.LPAREN, "("); }
")"                 { return newSym(sym.RPAREN, ")"); }
"{"                 { return newSym(sym.LCURBRACKET, "{"); }
"}"                 { return newSym(sym.RCURBRACKET, "}"); }
"["                 { return newSym(sym.LBOXBRACKET, "["); }
"]"                 { return newSym(sym.RBOXBRACKET, "]"); }
{integer}           { return newSym(sym.INTEGERLIT, Integer.parseInt(yytext())); }
{id}                { return newSym(sym.ID, yytext()); }
{character}         { return newSym(sym.CHARACTERLIT, yytext()); }
{floating_point}    { return newSym(sym.FLOATLIT, Double.valueOf(yytext())); }
{inlinecomment}     { return newSym(sym.INLINECOMMENT, yytext().substring(2)); }
{multilinecomment}  { 
                        String _text = yytext();
                        _text = _text.replaceAll("\n","");
                        int length = _text.length();
                        return newSym(sym.MULTILINECOMMENT, _text.substring(2, length-2));
                    }
{string}            { return newSym(sym.STRINGLIT, yytext()); }

{whitespace}    { /* Ignore whitespace. */ }
.               { System.out.println("Illegal char, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); } 