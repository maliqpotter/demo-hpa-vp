# Kubernetes Demo Projects

This repository contains two small demo projects that illustrate common Kubernetes patterns:

1. **HPA Demo** – Shows how to deploy a simple web application and scale it with a Horizontal Pod Autoscaler.
2. **PV Demo** – Demonstrates how to create a Persistent Volume, bind it to a Persistent Volume Claim, and share data between multiple pods.

Both demos come with a `test.sh` script that automates the deployment and verification steps.  The scripts assume you have `kubectl` configured to talk to a cluster and that the cluster has at least one node capable of running the pods.

## Running the Demos

```bash
# From the root of this repository
# 1. HPA Demo
cd HPA-Test
./test.sh default 2000 40

# 2. PV Demo
cd ../PV-Test
./test.sh
```

The scripts will:

- Apply the manifests.
- Wait for the pods to become ready.
- Run the application inside the pod.
- For the HPA demo, generate load with `ab` and stream pod/HPA status.
- For the PV demo, write a file from the first pod and read it from the others.

Feel free to tweak the manifests or the test parameters to experiment with different scenarios.
