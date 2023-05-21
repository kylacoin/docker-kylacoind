kylacoind config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v kylacoind-data:/kylacoin/.kylacoin --name=kylacoind-node -d \
            -p 5111:5111 \
            -p 127.0.0.1:5110:5110 \
            -e REGTEST=0 \
            -e DISABLEWALLET=1 \
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            kylacoin/kylacoind

Or you can use your very own config file like that:

        docker run -v kylacoind-data:/kylacoin/.kylacoin --name=kylacoind-node -d \
            -p 5111:5111 \
            -p 127.0.0.1:5110:5110 \
            -v /etc/mykylacoin.conf:/kylacoin/.kylacoin/kylacoin.conf \
            kylacoin/kylacoind
