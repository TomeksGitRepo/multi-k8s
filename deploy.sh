docker build -t tomdevacc/multi-client:latest -t tomdevacc/multi-client:$SHA -f ./client/Dockerfile ./client
docer build -t tomdevacc/multi-server:latest -t tomdevacc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tomdevacc/multi-worker:latest -t tomdevacc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tomdevacc/multi-client:latest
docker push tomdevacc/multi-server:latest
docker push tomdevacc/multi-worker:latest
docker push tomdevacc/multi-client:$SHA
docker push tomdevacc/multi-server:$SHA
docker push tomdevacc/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tomdevacc/multi-server:$SHA
kubectl set image deployments/client-deployment client=tomdevacc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tomdevacc/multi-worker:$SHA