# Kubernetes Demo Projects

## Overview

This repository contains two small demo projects that illustrate common Kubernetes patterns:

1. **HPA Demo** (`HPA-Test/`) – Shows how to deploy a simple web application and scale it with a Horizontal Pod Autoscaler.
2. **PV Demo** (`PV-Test/`) – Demonstrates how to create a Persistent Volume, bind it to a Persistent Volume Claim, and share data between multiple pods.

### Prerequisites

- `kubectl` configured to talk to a cluster.
- A cluster with at least one node that can run the pods.
- `ab` (Apache Benchmark) installed on the machine running the HPA test script.

### Running the Demos

**HPA Demo**

```bash
cd HPA-Test
./test.sh default 2000 40
```

**PV Demo**

```bash
cd PV-Test
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

Refer to each folder's `README.md` for detailed instructions and step-by-step usage.

---

Feel free to tweak the manifests or the test parameters to experiment with different scenarios.
