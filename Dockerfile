# Stage 1: Build the Go binary
FROM golang:latest AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy and compile the application
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

# Stage 2: Create a lightweight container for deployment
FROM alpine:3.18

RUN apk --no-cache add ca-certificates && \
    adduser -D -g '' appuser

# Working directory inside lightweight image
WORKDIR /home/appuser

# Copy the compiled binary from the builder stage
COPY --from=builder /app/app .

# Change ownership of the binary to the non-root user
RUN chown appuser:appuser app

# Expose port 8080
EXPOSE 8080

# Switch to non-root user
USER appuser

# Run the application
ENTRYPOINT ["./app"]