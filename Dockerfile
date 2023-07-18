FROM alpine:latest
ARG KUBECTL_VERSION="1.15.10"
RUN apk add --no-cache \
        python3 \
        py3-pip
RUN pip3 install pip
RUN pip3 install awscli==1.20.8 --no-build-isolation \
    && rm -rf /var/cache/apk/*
RUN aws --version
RUN apk add curl
RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl
RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
