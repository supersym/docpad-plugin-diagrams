PlantUML Dependency - reverse engineering java source files to generate PlantUML description (http://plantuml-depend.sourceforge.net)
=====================================================================================================================================

5, Jul 2011 - 1.1.0
====================
- Ant task available
- Correction a bug with the verbose level option, which was reloading the "logging.properties" file configuration
- Improving the way to get the program version, by using a properties file and managing to read a Maven version pattern

28, May 2011 - 1.0.1
====================
- Fixed an error when generating description with classes which have static imports

2, Dec 2010 - 1.0.0
====================
- First public release
- Fixed and issue when generating description with class which has a comment on the same line as the class declaration
- Fixed and issue when generating description with class importing all classes of a package, using the "*" character
- Fixed and issue when generating description with inner class, bad class order declaration
- Fixed and issue when generating description with generic class

Command line Usage
====================
	java -jar plantuml-dependency-1.0.1.jar [OPTIONS]


where optional options are:

	-about, --author, --authors
		To display information about PlantUML Dependency and its authors.

	-b, --basedir DIR
		The base directory where to look for source files. If not specified, the default pattern is "." i.e. the directory where the program is launched from.
		DIR specifies a valid and exsiting directory path, not a single file. It can be absolute or relative.

	-e, --exclude FILE_PATTERN
		To exclude files that match the provided pattern. If not specified, no file is excluded.
		FILE_PATTERN specifies a file pattern, with the same syntax as ANT patterns. It means that "**", "*" or "?" special characters can be used. For more information, please consult http://ant.apache.org/manual/dirtasks.html.

	-h, --help, -?
		To display this help message.

	-i, --include FILE_PATTERN
		To include files that match the provided pattern. If not specified, the default pattern is "**/*.PROGRAMMING_LANGUAGE_FILE_EXTENSION" depending on the programming language chosen (default is "java").
		FILE_PATTERN specifies a file pattern, with the same syntax as ANT patterns. It means that "**", "*" or "?" special characters can be used. For more information, please consult http://ant.apache.org/manual/dirtasks.html.

	-o, --output FILE
		To specify the output file path where to generate the PlantUML description.
		FILE specifies a valid file path, where the file doesn't already exist and is not a directory. It can be absolute or relative.

	-v, --verbose [VERBOSE_LEVEL]
		To display log information.
		VERBOSE_LEVEL specifies the verbose level. The argument may consist of either a level name or an integer value. Classical values are : "SEVERE":1000, "WARNING":900, "INFO":800, "CONFIG":700, "FINE":500, "FINER":400, "FINEST":300. By default, if the verbose option is specified but the level is not set, the value "INFO":800 is taken.

	-version
		To display versions information about PlantUML Dependency and Java.

Examples:

	java -jar plantuml-dependency-1.0.1.jar -h
	java -jar plantuml-dependency-1.0.1.jar -o plantuml.txt -b /home/graffity/workspace/plantuml-dependency -i **/*Test.java
	java -jar plantuml-dependency-1.0.1.jar -version -v

Known bugs or program limitations:

	- Be careful, in order to correctly parse source files, it must compile without any errors
	- Import instructions "import package_name.*" are ignored because the dependencies are not explicitly defined, use precise imports instead
	- Links between dependencies are found out by parsing "import" instructions, so PlantUML Dependency won't display dependencies which are called using their full names in the source code
