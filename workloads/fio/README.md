fio

Runs fio.  Includes a default configuration, or user can create their own
in a ConfigMap and provide the name of that ConfigMap.

### Variables

* storageClass: storage class to provision from
* fiosize: size of file used by fio for I/O.  **Default:** 6g
* pvcsize: size of PVC used by fio.  Should be large enough to fit `fiosize.
  **Default:** 7Gi
* rw: I/O operation mix, either randread, randwrite, read, write, or rw.
  **Default:** rw
* pctread: if `rw` is `rw`, the percent of the I/O operations that should be
  reads.  **Default:** 50
* config: name of ConfigMap with the config file for initializing fio.
  **Default:** fio-rw-config, which is included in this I/O workload
  specification.
* initConfig: name of ConfigMap with the config file for initializing fio.
  Generally this config file will be the same as the one used for running fio,
  but with a shorter runtime.  **Default:** fio-rw-initconfig, included as part
  of this I/O workload specification.
* volname: Name of PVC to use. **Default:**
  vol-{{ACTION\_NAME}}-{{INSTANCE\_NUM}}

### Output Files

* [json+](https://fio.readthedocs.io/en/latest/fio_doc.html#id2) formatted
  output is written to /output/output.json

### Parsers

* null-parser: no parsing, sends entire json+ output from fio to output
  collector
* basic **default**

### Using your own fio configuration

Create ConfigMaps from your fio configuration files, e.g.
```
kubectl create cm test-config --from-file test-config
kubectl create cm test-config-init --from-file test-config-init
```

Note that the name of the ConfigMap must match the name of the file the
ConfigMap is created from.

Then, in your benchmark configuration set the `config` and `initConfig`
variables, e.g.

```
workloads:
- name: fio
  workload: fio
  vars:
    storageClass: local-storage
    pvcsize: 4Gi
    config: test-config
    initConfig: test-config-init
```
