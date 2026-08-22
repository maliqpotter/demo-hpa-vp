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

1. Deploy the manifests (`deployment.yaml`, `hpa.yaml`, `service.yaml`, `configmap.yaml`).
2. Run `apache2ctl -k start` inside the pod to start the web server.
3. Use `ab` (Apache Benchmark) to generate load.
4. Stream the pod and HPA status with `kubectl get pods -w` and `kubectl get hpa -w`.

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
