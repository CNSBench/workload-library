pgbench

Runs an instance of PostgreSQL and the pgbench benchmarking tool.

### Variables
* storageClass: storage class PV should be allocated from.
* pvcsize: size of PVC used by fio.  Should be large enough to fit `fiosize`
* runtime: maximum pgbench runtime in seconds.  Default is 600

### Output Files
pgbench output is written to /output/out.

### Parsers

* null-parser **default**
