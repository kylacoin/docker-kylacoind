# Debugging

## Things to Check

* RAM utilization -- kylacoind is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The kylacoin blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing kylacoind Logs

    docker logs kylacoind-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the kylacoind node, but will not connect to already running containers or processes.

    docker run -v kylacoind-data:/kylacoin --rm -it kylacoin/kylacoind bash -l

You can also attach bash into running container to debug running kylacoind

    docker exec -it kylacoind-node bash -l


