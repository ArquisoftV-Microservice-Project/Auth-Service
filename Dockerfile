FROM golang:1.18.2 AS builder
WORKDIR /app
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
COPY . .
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o auth-api
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/auth-api .
EXPOSE 8000
ENV JWT_SECRET=PRFT \
    AUTH_API_PORT=8000 \
    USERS_API_ADDRESS=http://127.0.0.1:8083
CMD ["./auth-api"]
