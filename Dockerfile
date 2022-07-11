
FROM debian:bullseye
FROM node:16

RUN apt update && apt install jq -y

# Set the DENO_DIR environment variable to controll where the cache is built
RUN mkdir deno
ENV DENO_DIR=/deno
RUN sudo rm /etc/hosts
RUN echo "172.17.0.1       localhost" | sudo tee /etc/hosts > /dev/null

COPY --from=docker:dind /usr/local/bin/docker /bin/docker

# Download the Taqueria release binary for Linux to /bin/taq
ADD https://github.com/ecadlabs/taqueria/releases/download/v0.6.5/taq-linux /bin/taq

# Make the binary executable
RUN chmod +x /bin/taq

ENV PATH="/bin:{$PATH}"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
