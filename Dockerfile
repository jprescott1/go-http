FROM golang:1.24 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main ./main.go

FROM gcr.io/distroless/static-debian11
WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/index.html .

EXPOSE 8080

CMD ["/app/main"]