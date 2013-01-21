
Notes
-----

+ Graphviz and PlantUML share a large portion of their codebase
+ The latter is more suitable for diagrams and has a simpler language
+ Note that as far as I can see, you can't mix a Class with Use Case

They are two different notations used for different things (just that I like
hybrids)

Features
--------

### Phase I

+ use a simple language (dot) to write up diagrams inside a HTML textarea;
+ submit a click and send a base64-derived string to the PlantUML server;
+ returns a diagram image in PNG or other format for your comfort.

Phase I is implemented as per 27 dec 2012. It has 2 scripts in coffeescript
which perform both synchronous and asynchronous transformation of your write
up, both do the same, use whichever one you like. Furthermore it uses a
JavaScript implementation of the RFC 1951 standard to deflate and inflate,
thanks to [dankogai](https://github.com/dankogai/js-deflate) for this.

### Phase II

- save the to be persisted image to your dedicated location on the computer.



Rationale
---------

This plugin is heavily inspired by the shorthand notation used to created
diagrams as in the C program Graphviz. There are several web-based
implementations that evolve around, if not are based on, this language called
DOT.

+ www.diagrammr.com
+ www.plantuml.com

The first site has as a big drawback that it's language is a subset of dot and
that the code/implementation is very limited as it is. Often your diagram will
break as a result of being too large for the image frame and thus will not
load. The source code also does not lend itself for some of the features I had
in mind, has too much complexity which is not required and, most importantly,
relies of Graphviz being installed on the machine to generate the diagrams.
This also counts for PlantUML.

    PlantUML is using GraphViz/DOT to compute node positionning for every UML
    diagrams (except Sequence Diagram). The fact that DOT computes
    automatically the position of node is a key feature, and algorithms
    implemented in DOT usually give very good result. However, there are some
    drawbacks of using DOT : the computation is done by an external program
    (dot.exe on Windows, dot on linux), and that means that : PlantUML has to
    create a new process for each diagram, (and communication with this new
    process can be source of bugs).  Users have to install DOT on their system,
    in addition of Java. PlantUML is not fully portable.  Another way of using
    DOT would be to use it as a library, and to link it with PlantUML using JNI
    (Java Native Interface) but that would not be perfect thought. If a Java
    version of GraphViz/DOT would exist, this would allow to greatly simplify
    the installation and the use of PlantUML.  Unfortunatly, this does not
    exist today...

But even if it would, I would still not be satisfied because it must rely on
Java. However, unless I would find another proper implementation, for certain
some features of this plugin must rely on Java.  Luckily, we have a node.js
package that can run Jar files for us so these features would not require
additional action from the user, as long as they have the Sun or OpenJRE
runtime implementations of Java installed on their computers.

    So what about porting GraphViz/DOT to Java ? As GraphViz/DOT is written in
    C, and as Java syntax is close to C syntax, it is possible to translate the
    C source of GraphViz to Java source, although this is a large and complex
    task.

    The good news is that we don't need to translate the whole GraphViz sources
    to Java : this is due to the fact that PlantUML uses only a limited portion
    of GraphViz. Firstly, only DOT algorithm is used (neato, ... and other are
    not used). Secondly, the parsing of the DOT language is not need : PlantUML
    could directly build the diagram in memory without generating DOT language.
    And thirdly all the drawing code of GraphViz is not needed anymore, since
    the drawing is done in Java

    This translation of DOT to Java is a new project called JDot. This project
    will not depend on PlantUML : classes will be completely independent of
    PlantUML and other open source Java projects would be able to use it, if
    they wish.

PlantUML does support a lot of frameworks, you can use them in wikis and many
languages yet there is no real JavaScript based implementation. I hope this
humble attempt may bring some more of the modelling world to Node, in
particular Docpad as it offers rendering features - which means that I can
write a plugin to support inline diagrams to code.

