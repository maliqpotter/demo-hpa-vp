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

**Step 1 — Apply the manifests**
```bash
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

**Step 2 — Run the shared-volume test**
```bash
# Write from the first pod
POD1=$(kubectl get pods -l app=nginx-pv-demo -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $POD1 -- sh -c 'echo "<h1>Ditulis dari '"$POD1"'</h1>" > /usr/share/nginx/html/index.html'

# Check from the second & third pods — the same content should appear
POD2=$(kubectl get pods -l app=nginx-pv-demo -o jsonpath='{.items[1].metadata.name}')
kubectl exec -it $POD2 -- cat /usr/share/nginx/html/index.html
```

If the output shows the HTML written by the first pod, the Persistent Volume is shared correctly across all pods.

---

Feel free to modify the PV size, storage class, or the application image to experiment with different storage scenarios.
