# Use an official Go runtime as a parent image for building
FROM golang:1.24 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and download dependencies
COPY go.mod ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go application
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./main.go

# --- Final Stage: Create a minimal runtime image ---
FROM gcr.io/distroless/static-debian11
WORKDIR /app

# Copy the binary and static files from the builder stage
COPY --from=builder /app/main .
COPY --from=builder /app/index.html .

# Expose port 8080
EXPOSE 8080

# Run the binary
CMD ["/app/main"]