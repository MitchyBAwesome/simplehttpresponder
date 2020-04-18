# STEP 1 build executable binary

FROM golang:alpine As builder 
COPY . $GOPATH/src/github.com/MitchyBAwesome/simplehttpresponder/
WORKDIR $GOPATH/src/github.com/MitchyBAwesome/simplehttpresponder/

RUN apk add --no-cache git mercurial

#get dependancies
RUN go get -d -v

#build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/simplehttpresponder

# STEP 2 build a small image

# start from scratch
FROM scratch

# Copy our static executable from the builder
COPY --from=builder /go/bin/simplehttpresponder /go/bin/simplehttpresponder
ENTRYPOINT ["/go/bin/simplehttpresponder"]