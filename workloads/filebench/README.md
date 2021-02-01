Workload for [filebench](https://github.com/filebench/filebench).

Must disable ASLR on nodes: `echo 0 | sudo tee /proc/sys/kernel/randomize_va_space` (see issue [#110](https://github.com/filebench/filebench/issues/110)).

### Variables

* storageClass: storage class to provision volume from
* workload: Workload to use. **Default:** mongo
* pvcsize: Size of provisioned volume. **Default:** 7Gi
* volname: Name of PVC to use. **Default:**
  vol-{{ACTION\_NAME}}-{{INSTANCE\_NUM}}

### Output files

* stdout from the Filebench application is written to /output/output

### Parsers

* null-parser **default**
