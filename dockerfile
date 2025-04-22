FROM alpine AS BUILDER
WORKDIR /home/project
RUN apk update --no-cache && apk add git automake autoconf alpine-sdk ncurses-dev ncurses-static
COPY app.c ./
RUN gcc app.c -o app && ls -l app  # Check that the app binary is created

FROM alpine:latest
WORKDIR /home/app_home

# Install runtime dependencies (e.g., libc6-compat)
RUN apk add --no-cache libc6-compat

# Copy the compiled app binary from the BUILDER stage
COPY --from=builder /home/project/app .

# Use absolute path in CMD to avoid any relative path issues
CMD ["/home/app_home/app"]

