RocksDB db\_bench

Runs an instance of RocksDB and benchmarks it with the db\_bench utility.

### Variables

* storageClass: storage class to provision from
* pvcsize: size of PVC used by RocksDB.  **Default:** 10Gi
* volname: Name of PVC to use. **Default:**
  vol-{{ACTION\_NAME}}-{{INSTANCE\_NUM}}

### Output Files

* Output from db\_bench is redirected to /output/output.log

### Parsers

* null-parser: no parsing, sends entire output from db\_bench to output
  collector
* db-bench-parser: parses the metrics reported at the end of a db\_bench run
  and outputs them in json format **default**
