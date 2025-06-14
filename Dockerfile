
FROM ubuntu:24.04

RUN apt-get update && apt-get install --no-install-recommends -y python3 python3-uvloop python3-cryptography python3-socks libcap2-bin ca-certificates && rm -rf /var/lib/apt/lists/*
RUN realpy=$(readlink -f $(which python3)) && setcap cap_net_bind_service=+ep "$realpy"
#RUN setcap cap_net_bind_service=+ep $(which python3)
#RUN setcap cap_net_bind_service=+ep /usr/bin/python3.10

RUN useradd tgproxy -u 10000

USER tgproxy

WORKDIR /home/tgproxy/

COPY --chown=tgproxy mtprotoproxy.py config.py /home/tgproxy/

CMD ["python3", "mtprotoproxy.py"]
