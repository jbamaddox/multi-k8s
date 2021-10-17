docker build -t jbamaddox/multi-client:latest -t jbamaddox/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jbamaddox/multi-server:latest -t jbamaddox/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jbamaddox/multi-worker:latest -t jbamaddox/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jbamaddox/multi-client:latest
docker push jbamaddox/multi-server:latest
docker push jbamaddox/multi-worker:latest
docker push jbamaddox/multi-client:$SHA
docker push jbamaddox/multi-server:$SHA
docker push jbamaddox/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jbamaddox/multi-server:$SHA
kubectl set image deployments/client-deployment client=jbamaddox/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jbamaddox/multi-worker:$SHA