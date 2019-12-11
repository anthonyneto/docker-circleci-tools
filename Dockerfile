FROM alpine:latest
LABEL maintainer "Anthony Neto <anthony.neto@gmail.com>"

RUN apk --no-cache add \
      bash \
      curl \
      git \
      docker \
      openssh-client

RUN DOCTL_VER=$(curl -w "%{url_effective}" -I -L -s -S https://github.com/digitalocean/doctl/releases/latest -o /dev/null | sed -e 's|.*/v||') \
    && curl -s -L https://github.com/digitalocean/doctl/releases/download/v$DOCTL_VER/doctl-$DOCTL_VER-linux-amd64.tar.gz  | tar xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/doctl

RUN KUBECTL_VER=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) \
    && curl -s -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VER/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN RIO_VER=$(curl -w "%{url_effective}" -I -L -s -S https://github.com/rancher/rio/releases/latest -o /dev/null | sed -e 's|.*/||') \
    && curl -s -L -o /usr/local/bin/rio https://github.com/rancher/rio/releases/download/$RIO_VER/rio-linux-amd64 \
    && chmod +x /usr/local/bin/rio

CMD ["ls", "/usr/local/bin"]
