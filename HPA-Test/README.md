# HPA Demo

## Overview
This folder contains a simple deployment that demonstrates **Horizontal Pod Autoscaling** (HPA) in Kubernetes.

The test harness is provided in `test.sh` and can be executed with the following arguments:

```
./test.sh <namespace> <target-requests> <target-concurrency>
```

Example:

```
./test.sh default 2000 40
```

The script will:

1. Fetch the NodePort and node IP from the cluster.
2. Display the current HPA status.
3. Run `ab` (Apache Benchmark) to generate load against the service.
4. Print instructions for monitoring scale-up and scale-down.

### Prerequisites
- `kubectl` configured to talk to a cluster.
- `ab` (Apache Benchmark) installed on the machine running the script.
- A cluster with at least one node that can run the pod.

### Running the Test
```bash
# From the HPA-Test directory
./test.sh default 2000 40
```

You should see the pod scaling up/down in response to the load and the HPA metrics.

---

Feel free to tweak the `targetCPUUtilizationPercentage` in `hpa.yaml` or the `replicas` in `deployment.yaml` to experiment with different scaling behaviours.
