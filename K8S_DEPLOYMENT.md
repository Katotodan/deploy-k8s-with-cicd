# Kubernetes Deployment Guide

## Prerequisites

- Kubernetes cluster (GKE, EKS, AKS, or local)
- kubectl configured
- Docker Hub account
- GitHub repository with Actions enabled

## Deployment Flow

1. **Push to main** → Triggers workflow
2. **Build image** → Tagged with commit SHA
3. **Push to registry** → Docker Hub
4. **Update deployment** → kubectl set image
5. **Rolling update** → 3 pods updated sequentially
6. **Health checks** → Verify new pods
7. **Complete** → Old pods terminated

## Manual Deployment

```bash
kubectl apply -f k8s/
kubectl rollout status deployment/web-app
kubectl get svc web-app
```

## Rollback

```bash
# View revision history
kubectl rollout history deployment/web-app

# Rollback to previous version
kubectl rollout undo deployment/web-app

# Rollback to specific revision
kubectl rollout undo deployment/web-app --to-revision=2
```

## Monitoring

```bash
# Watch pods
kubectl get pods -w

# Check logs
kubectl logs -f deployment/web-app

# Describe deployment
kubectl describe deployment web-app
```

## Troubleshooting

### ImagePullBackOff
- Verify image exists in registry
- Check image tag is correct
- Ensure imagePullSecrets configured

### CrashLoopBackOff
- Check pod logs: `kubectl logs pod-name`
- Verify environment variables
- Check resource limits
- Review health check endpoints

### Deployment Stuck
- Check rollout status
- Review pod events
- Verify readiness probes
- Check resource availability
