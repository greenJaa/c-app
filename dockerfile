# syntax=docker/dockerfile:1

FROM alpine:3.20 AS BUILDER
WORKDIR ./ 
RUN apk update --no-cache || (sleep 5 && apk update --no-cache)
RUN apk add --no-cache git automake autoconf alpine-sdk ncurses-dev ncurses-static || \
    (sleep 5 && apk add --no-cache git automake autoconf alpine-sdk ncurses-dev ncurses-static)
#RUN apk update --no-cache && apk add git automake autoconf alpine-sdk ncurses-dev ncurses-static
COPY app.c ./
RUN gcc app.c -o app

FROM alpine:latest
WORKDIR .
COPY --from=builder app ./
CMD ["./app"]
