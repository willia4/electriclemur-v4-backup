FROM mcr.microsoft.com/azure-cli

WORKDIR /root
RUN apk update && \
    apk add --no-cache curl  mongodb-tools

RUN curl -sSL "https://aka.ms/downloadazcopy-v10-linux" -o /root/azcopy.tar.gz && \
    tar --strip-components=1 -xzvf azcopy.tar.gz && \
    mv /root/azcopy /usr/bin/ && \
    chmod +x /usr/bin/azcopy

RUN mkdir -p /volumes/sites

COPY *.sh /
RUN chmod +x /entrypoint.sh
