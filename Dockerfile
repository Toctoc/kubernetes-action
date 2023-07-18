
FROM alpine:3.11
ARG KUBECTL_VERSION="1.15.10"

RUN apk add curl

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator

RUN unzip awscli-bundle.zip
RUN sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN aws --version

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/bin/kubectl
RUN chmod +x /usr/bin/aws-iam-authenticator
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
