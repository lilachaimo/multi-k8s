docker build -t lilachyonash/multi-client:latest -t lilachyonash/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lilachyonash/multi-server:latest -t lilachyonash/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lilachyonash/multi-worker:latest -t lilachyonash/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lilachyonash/multi-client:latest
docker push lilachyonash/multi-server:latest
docker push lilachyonash/multi-worker:latest

docker push lilachyonash/multi-client:$SHA
docker push lilachyonash/multi-server:$SHA
docker push lilachyonash/multi-worker:$SHA

ubectl apply -f k8s
kubectl set image deployments/server-deployment server=lilachyonash/multi-server:$SHA
kubectl set image deployments/client-deployment server=lilachyonash/multi-client:$SHA
kubectl set image deployments/worker-deployment server=lilachyonash/multi-worker:$SHA