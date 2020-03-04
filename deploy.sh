docker build -t bragur/multi-client:latest -t bragur/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bragur/multi-server:latest -t bragur/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bragur/multi-worker:latest -t bragur/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bragur/multi-client:latest
docker push bragur/multi-server:latest
docker push bragur/multi-worker:latest
docker push bragur/multi-client:$SHA
docker push bragur/multi-server:$SHA
docker push bragur/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bragur/multi-server:$SHA
kubectl set image deployments/client-deployment client=bragur/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bragur/multi-worker:$SHA