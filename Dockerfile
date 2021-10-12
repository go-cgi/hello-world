##
## Build
##

FROM golang:1.16-buster AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN GOPROXY=https://goproxy.cn go mod download

COPY *.go ./

RUN GOPROXY=https://goproxy.cn go build -o /server

##
## Deploy
##

FROM alpine

WORKDIR /

COPY --from=build /server /server

EXPOSE 8100

ENTRYPOINT ["/server"]
