docker build -t belendor/multi-client-k8s:latest -t belendor/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t belendor/multi-server-k8s-pgfix:latest -t belendor/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t belendor/multi-worker-k8s:latest -t belendor/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push belendor/multi-client-k8s:latest
docker push belendor/multi-server-k8s-pgfix:latest
docker push belendor/multi-worker-k8s:latest

docker push belendor/multi-client-k8s:$SHA
docker push belendor/multi-server-k8s-pgfix:$SHA
docker push belendor/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=belendor/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=belendor/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=belendor/multi-worker-k8s:$SHA