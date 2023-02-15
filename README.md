# Compiler construction phase 1
The project uses JFlex and Cup and thus needs the binaries(jar). The make file aids to run the project seamlessly. Since flex uses java, JDK is required. See the pre-req section

### Pre-Requisites
* Java JDK installed
* java-cup and jflex jar files(shared with the project)
* make binaries(installed in ubuntu, install MinGW in windows)

The tokens and regex are declared in tokens.jflex file and the symbols are defined in grammar.cup file. 

### Instructions
The make file has everything you need to run

* Navigate to the directory where the files are present for eg.

        cd  /home/yogi/cs6353-cc

* By default the make is set to the recipe `run` with the default file 
    
        make

    this will execute `make run` with file as basicTest.txt and generates the output as basicTest-output.txt

* To run any other file, the file has to passed as an argument.
        
        make filename=basicRegex.txt

    ensure the file has to be present in the same folder, or provide the full path

    The output will be both displayed on the terminal and saved to file by the name filename-output.txt, eg. basicRegex-output.txt

* The make command creats class file that is executed by Java, they can be cleaned up using the `clean` recipe
        
        make clean


