FROM golang:1.19 as builder

#
RUN mkdir -p $GOPATH/src/gitlab.7i.uz/invan/invan_billing_service 
WORKDIR $GOPATH/src/gitlab.7i.uz/invan/invan_billing_service

# Copy the local package files to the container's workspace.
COPY . ./

# installing depends and build
RUN export CGO_ENABLED=0 && \
  export GOOS=linux && \
  go mod vendor && \
  make build && \
  mv ./bin/invan_billing_service /

FROM alpine
COPY --from=builder invan_billing_service .
ENTRYPOINT ["/invan_billing_service"]
