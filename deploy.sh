docker build -t praja/multi-client:latest -t praja/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t praja/multi-server:latest -t praja/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t praja/multi-worker:latest -t praja/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push praja/multi-client:latest
docker push praja/multi-server:latest
docker push praja/multi-worker:latest

docker push praja/multi-client:$SHA
docker push praja/multi-server:$SHA
docker push praja/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=praja/multi-client:$SHA
kubectl set image deployments/server-deployment server=praja/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=praja/multi-worker:$SHA
