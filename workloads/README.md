# Workloads

Workload specifications include all of the resource manifests needed to run a
particular workload.  For example, the fio workload specification includes the
manifests for the Job resource that runs the fio application, the PVC resource
for the volume that fio uses, and the ConfigMap that contains fio's
configuration.

## Included workloads

* Filebench
* fio
* megahit
* pgbench
* YCSB
* Rocks DB db\_bench

## Developing a workload

A workload is specified using a ConfigMap with a key/value for each resource
manifest.  See [template.yaml](template.yaml) to get started.

### Parameterization

Portions of resource manifests can be parametrized using double curly brackets,
e.g. `{{param-name}}`.  When the user instantiates the workload they can
provide values for the parameters.  A workload can also provide default values
for a parameter as an annotation on the workload's ConfigMap, in the format
`cnsbench.default.param-name: default-val`.

#### Standard parameters

There are some standard parameters that are replaced with values set by CNSBench
when the workload is instantiated rather than with values set by the user or
workload author.  These include:
* ACTION\_NAME: Name of the action in the benchmark that is instantiating this
  workload.
* INSTANCE\_NUM: If multiple copies of a workload are being created, this is the
  instance number of this particular workload instance.  See below for how
  ACTION\_NAME and INSTANCE\_NUM can be used to ensure resources are created
  with unique names.
* NUM\_INSTANCES: How many instances of this workload are being created for a
  particular action.  This can be used for example to divide a fixed amount of
  work evenly across the number of instances that are being created.
* volname: If a workload requires a volume, it should parameterize the name of
  that volume with this parameter.  This allows CNSBench to know if a
  non-default volume name has been provided, so it can skip creating objects
  with the role "volume" (see below for information on the "role" object
  annotation).


#### Multiple workload copies

There are two ways multiple copies of a workload can be created: the user can
specify the same workload in multiple "action" specifications of their
benchmark, or they can specify a number greater than one for the "count"
parameter in an "action" specification.

The standard parameters ACTION\_NAME and INSTANCE\_NUM can be used together to
ensure resources are unique, even if there are multiple copies of a workload.
For example, a workload resource named "fio-{{ACTION\_NAME}}" will be unique for
each action that workload appears in, and a resource named
"fio-{{ACTION\_NAME}}-{{INSTANCE\_NUM}}" will be unique for each copy of that
workload.

### Workload resource annotations

Annotations in a workload resource's metadata is used to provide CNSBench with
information such as whether any output needs to be collected from the resource.
Annotations are all optional, and available annotations are:
* role: Indicates the role this object has in the I/O workload:
  * "workload": Should be applied to the resource responsible for generating the
    I/O workload.  For example, the resource that runs the client in a
    client-server workload, or the resource that runs the synthetic benchmarking
    application.  CNSBench will waits for all resources with the "workload" role
    to complete before finishing the benchmark.
  * "volume": If the user has supplied a non-default value for the "volname"
    parameter, CNSBench will skip creating resources with the "volume" role.
    This allows users to use volumes that were pre-provisioned outside of
    CNSBench, or that were created using the Volume specification in the
    Benchmark.
* outputFile: Default file that should be collected after the resource completes
  running.
* parser: Default parser to run.

### Workload ConfigMap metadata

The ConfigMap should have the following metadata information:
```YAML
name: Name of workload.
namespace: cnsbench-library
labels:
  type: workload
annotations:
  cnsbench.default.param-name: Default value for parameter `param-name`.  Not required.
```

### Other considerations

Each resource with a role of "workload" gets an emptyDir volume attached which
is used for output collection.  The volume is mounted at `/output`, and the
workload's output must be written to a directory under this mountpoint.
