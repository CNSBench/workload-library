# Parsers

Parsers process an output file.  A user can indicate which parser to use for an
output file in their benchmark specification, or the workload specification can
specify a default parser to use for an output file.  Workload specifications can
include a parser for that workload, or parsers which might be useful for
multiple workloads can be added to this directory and be made available globally
to all workloads when the Workload Library is installed.

## Included parsers

null-parser: Default parser, just outputs the specified file as is without doing
any processing.

## Developing a new parser

A parser is specified using a ConfigMap with a single data field consisting of
the parser script.  The name of the script does not matter. The script will be
invoked with the first argument being the filename of the file that should be
parsed.  The parsed output should be printed to stdout.

The ConfigMap should have the following metadata information:
```
name: Name of parser.  When a workload or user references which parser should be
      used for a particular output, this is the name that is used.
namespace: cnsbench-library
labels:
  type: parser
annotations:
  container: Name of the container image that the parser will run in.  By
             default the image cnsbench/utility is used, which includes Python
             3.8.5, the jq JSON parsing utility, and curl.  If other utilities
             will be needed by the parser, specify an image that includes those
             utilities.
```

See
[null-parser.yaml](https://github.com/CNSBench/workload-library/blob/master/parsers/null-parser.yaml) for an example.
