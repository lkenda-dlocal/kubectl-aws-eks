FROM amazon/aws-cli:latest

ENV HTTP_PROXY="http://proxy.mgmt-dev.eu1:3128"
ENV HTTPS_PROXY="http://proxy.mgmt-dev.eu1:3128"
ENV NO_PROXY="127.0.0.1,169.254.169.254,localhost,.eks.amazonaws.com"

RUN curl -sL -o /usr/bin/jq https://stedolan.github.io/jq/download/linux64/jq
RUN chmod +x /usr/bin/jq
RUN curl -sL -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    curl -sL -o /usr/bin/aws-iam-authenticator $(curl -s https://api.github.com/repos/kubernetes-sigs/aws-iam-authenticator/releases/latest | jq -r ' .assets[] | select(.name | contains("linux_amd64")    )' | jq -r '.browser_download_url')  && \
    chmod +x /usr/bin/aws-iam-authenticator && \
    chmod +x /usr/bin/kubectl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
