FROM python:3.10-alpine as builder

RUN apk update && apk add --no-cache tzdata alpine-sdk ca-certificates
ADD requirements.txt /tmp/
RUN pip3 install --user -r /tmp/requirements.txt && rm /tmp/requirements.txt


FROM python:3.10-alpine
WORKDIR /SearchGram/searchgram
ENV TZ=Asia/Shanghai

COPY --from=builder /root/.local /usr/local
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY . /SearchGram

ENTRYPOINT ["/usr/local/bin/python"]
