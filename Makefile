JAVA=java
JAVAC=javac
JFLEX=$(JAVA) -jar jflex-full-1.8.2.jar
CUPJAR=./java-cup-11b.jar
CUP=$(JAVA) -jar $(CUPJAR)
CP=.:$(CUPJAR)
filename=basicTest.txt
fileWithOutExtension=$(basename $(filename))
outputfile=$(fileWithOutExtension)-output.txt

default: run

.SUFFIXES: $(SUFFIXES) .class .java

.java.class:
		$(JAVAC) -cp $(CP) $*.java

FILE=    Lexer.java      parser.java    sym.java \
    LexerTest.java

run: trigger

all: Lexer.java parser.java $(FILE:java=class)

trigger: all
		$(JAVA) -cp $(CP) LexerTest $(filename) > $(outputfile)
		cat $(filename)
		cat -n $(outputfile)

clean:
		rm -f *.class *~ *.bak Lexer.java parser.java sym.java
		rm *-output.txt

Lexer.java: tokens.jflex
		$(JFLEX) tokens.jflex

parser.java: grammar.cup
		$(CUP) -interface < grammar.cup

parserD.java: grammar.cup
		$(CUP) -interface -dump < grammar.cup
