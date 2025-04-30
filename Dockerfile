FROM golang:1.24.2-alpine3.21 AS builder

WORKDIR /src

COPY go.mod /src
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main ./main.go

FROM debian:bullseye-slim
WORKDIR /app

COPY --from=builder /src/main .
COPY --from=builder /src/index.html .

EXPOSE 8080

CMD ["/app/main"]