#!/usr/bin/env bash
# Load test dari LUAR cluster pakai Apache Benchmark (ab), hit service NodePort.
# Jalankan script ini dari mesin yang punya akses network ke node (bukan dari dalam pod).
set -e

NAMESPACE="${1:-default}"
SVC="memory-demo-svc"
HPA="memory-demo-hpa"
REQUESTS="${2:-2000}"
CONCURRENCY="${3:-40}"
# Catatan: jangan asal set concurrency terlalu tinggi. Tiap request nahan
# ~2MB memory di server selama beberapa detik (lihat configmap.yaml).
# concurrency 40 x 2MB = ~80MB, masih di bawah limit 256Mi per pod tapi
# cukup buat lewatin target 50% utilization. Naikkan pelan-pelan aja
# (mis. 40 -> 60 -> 80) sambil pantau di test-watch-scaledown.sh,
# jangan langsung lompat ke ratusan atau pod-nya bisa OOMKilled.

if ! command -v ab >/dev/null 2>&1; then
  echo "Apache Benchmark (ab) belum terinstall di mesin ini."
  echo "  Ubuntu/Debian : sudo apt install apache2-utils"
  echo "  macOS         : brew install httpd"
  exit 1
fi

echo "== Ambil NodePort dari service =="
NODE_PORT=$(kubectl get svc "$SVC" -n "$NAMESPACE" -o jsonpath='{.spec.ports[0].nodePort}')

echo "== Ambil IP node (coba ExternalIP dulu, fallback ke InternalIP) =="
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
if [ -z "$NODE_IP" ]; then
  NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
fi
# Kalau pakai minikube dan IP di atas gak nyambung, pakai ini sebagai gantinya:
# NODE_IP=$(minikube ip)

if [ -z "$NODE_IP" ]; then
  echo "Gagal deteksi node IP otomatis."
  echo "Coba jalankan manual: NODE_IP=<ip-node> ab -n $REQUESTS -c $CONCURRENCY http://<ip-node>:$NODE_PORT/"
  exit 1
fi

URL="http://${NODE_IP}:${NODE_PORT}/"
echo "Target: $URL"
echo ""
echo "== Kondisi awal HPA =="
kubectl get hpa "$HPA" -n "$NAMESPACE"

echo ""
echo "== Jalankan ab: $REQUESTS request, concurrency $CONCURRENCY =="
ab -n "$REQUESTS" -c "$CONCURRENCY" "$URL"

echo ""
echo "Load selesai dikirim. Pantau scale up di terminal lain dengan:"
echo "  kubectl get hpa $HPA -n $NAMESPACE -w"
echo "Atau jalankan test-watch-scaledown.sh buat pantau otomatis + lihat scale down-nya nanti."