docker build -t jeremybamaddox/multi-client:latest -t jeremybamaddox/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeremybamaddox/multi-server:latest -t jeremybamaddox/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeremybamaddox/multi-worker:latest -t jeremybamaddox/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jeremybamaddox/multi-client:latest
docker push jeremybamaddox/multi-server:latest
docker push jeremybamaddox/multi-worker:latest
docker push jeremybamaddox/multi-client:$SHA
docker push jeremybamaddox/multi-server:$SHA
docker push jeremybamaddox/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeremybamaddox/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeremybamaddox/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jeremybamaddox/multi-worker:$SHA