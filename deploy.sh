#built images
docker build -t cliffdias/multi-client:latest -t cliffdias/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cliffdias/multi-server:latest -t cliffdias/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cliffdias/multi-worker:latest  -t cliffdias/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#push images to docker hub
docker push cliffdias/multi-client:latest
docker push cliffdias/multi-server:latest
docker push cliffdias/multi-worker:latest

docker push cliffdias/multi-client:$SHA
docker push cliffdias/multi-server:$SHA
docker push cliffdias/multi-worker:$SHA

#apply deplyment
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=cliffdias/multi-server:$SHA
kubectl set image deployments/client-deployment client=cliffdias/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cliffdias/multi-worker:$SHA