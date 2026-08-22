# PV Demo

## Overview
This folder demonstrates **Persistent Volume** (PV) and **Persistent Volume Claim** (PVC) usage in Kubernetes.

The test harness is provided in `test.sh` and can be executed with the following steps:

1. Deploy the manifests (`pv.yaml`, `pvc.yaml`, `deployment.yaml`, `service.yaml`).
2. Verify that the pod writes a file to the shared volume.
3. Read the file from the other pods to confirm that the volume is shared.

### Prerequisites
- `kubectl` configured to talk to a cluster.
- A cluster with at least one node that can run the pod.

### Running the Test
```bash
# From the PV-Test directory
./test.sh
```

The script will:

1. Create the PV, PVC, deployment, and service.
2. Wait for the pods to be ready.
3. Write an `index.html` file from the first pod.
4. Read the file from the second and third pods and print its contents.
5. Optionally, you can inspect the file on the node by SSHing into the node and looking at `/mnt/data` (or the path defined in the PV).

---

Feel free to modify the PV size, storage class, or the application image to experiment with different storage scenarios.
