docker build -t bwan109/multi-client:latest -t bwan109/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bwan109/multi-server:latest -t bwan109/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bwan109/multi-worker:latest -t bwan109/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bwan109/multi-client:latest
docker push bwan109/multi-server:latest
docker push bwan109/multi-worker:latest

docker push bwan109/multi-client:$SHA
docker push bwan109/multi-server:$SHA
docker push bwan109/multi-worker:$SHA

kubectel apply -f k8s
kubectl set image deployments/server-deployment server=bwan910/multi-server:$SHA
kubectl set image deployments/client-deployment client=bwan910/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bwan910/multi-worker:$SHA
