# Stage 1: Build the Go binary
FROM golang:1.23 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy and compile the application
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o app .

# Stage 2: Create a lightweight container for deployment
FROM alpine:3.18

# Working directory inside lightweight image
WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /app/app .

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["./app"]