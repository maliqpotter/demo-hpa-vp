#!/usr/bin/env bash
# Hapus semua resource demo HPA (deployment, service, hpa, configmap).
set -e

NAMESPACE="${1:-default}"

echo "Menghapus resource memory-demo di namespace: $NAMESPACE"
kubectl delete hpa memory-demo-hpa -n "$NAMESPACE" --ignore-not-found
kubectl delete service memory-demo-svc -n "$NAMESPACE" --ignore-not-found
kubectl delete deployment memory-demo -n "$NAMESPACE" --ignore-not-found
kubectl delete configmap memory-demo-app -n "$NAMESPACE" --ignore-not-found

echo ""
echo "Selesai. Cek sisa resource:"
kubectl get all -n "$NAMESPACE" -l app=memory-demo