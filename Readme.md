## Apertium scripts - Readme

This repository contains several bash scripts to help Apertium language pair contributors. Their usage and purpose are detailed below.

### transfer_documentation.sh

This script reads a T1X, T2X or T3X file and generates a documentation wikitable ready to be used in the Apertium wiki. It allows the creation of a list of all transfer rules and macros reliably and with little effort. The resulting wikitable includes macro names, rule numbers, patterns and a brief description of each macro/rule. Usage:
```
transfer_documentation.sh input_file output_file
```
Descriptions are retrieved from XML comments in the macro/rule definition. If no comment is found, the output is a placeholder message.

### sort_monodix.sh

This script reads a text file containing a series of monodix entries and sorts them alphabetically. It does not support sorting a full monodix file (like apertium-dixtools), but rather a list of entries. Usage:
```
sort_monodix.sh input_file output_file
```

### sort_bidix.sh

This script reads a text file containing a series of bidix entries and sorts them alphabetically according to the left-side language. It does not support sorting a full bidix file (like apertium-dixtools), but rather a list of entries. Usage:
```
sort_bidix.sh input_file output_file
```
