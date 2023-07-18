FROM alpine:latest
ARG KUBECTL_VERSION="1.19.6"
ARG KUBECTL_DATE="2021-01-05"
ARG IAM_AUTH_VERSION="1.21.2"
ARG IAM_AUTH_DATE="2021-07-05"

RUN apk add py-pip curl
RUN pip install awscli

RUN aws --version

RUN curl -L -o /usr/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/${KUBECTL_VERSION}/{KUBECTL_DATE}/bin/linux/amd64/kubectl
RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/{IAM_AUTH_VERSION}/{IAM_AUTH_DATE}/bin/linux/amd64/aws-iam-authenticator

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/bin/aws-iam-authenticator
RUN chmod +x /usr/bin/kubectl
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
