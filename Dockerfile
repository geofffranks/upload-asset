FROM debian:stable-slim

RUN apt update && apt install jq curl file -y

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
