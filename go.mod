module apollo

go 1.21.3

require (
	github.com/c12s/oort v1.0.0
	github.com/gocql/gocql v1.6.0
	github.com/hashicorp/vault-client-go v0.4.2
	github.com/neo4j/neo4j-go-driver/v4 v4.4.1
	github.com/scylladb/gocqlx/v3 v3.0.1
	google.golang.org/grpc v1.65.0
	google.golang.org/protobuf v1.34.1
)

require (
	github.com/golang/snappy v0.0.4 // indirect
	github.com/hailocab/go-hostpool v0.0.0-20160125115350-e80d13ce29ed // indirect
	github.com/hashicorp/go-cleanhttp v0.5.2 // indirect
	github.com/hashicorp/go-hclog v0.16.2 // indirect
	github.com/hashicorp/go-retryablehttp v0.7.1 // indirect
	github.com/hashicorp/go-rootcerts v1.0.2 // indirect
	github.com/hashicorp/go-secure-stdlib/strutil v0.1.2 // indirect
	github.com/mattn/go-colorable v0.1.6 // indirect
	github.com/mattn/go-isatty v0.0.12 // indirect
	github.com/mitchellh/go-homedir v1.1.0 // indirect
	github.com/ryanuber/go-glob v1.0.0 // indirect
	golang.org/x/time v0.3.0 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
)

require (
	github.com/golang-jwt/jwt/v5 v5.2.1
	github.com/klauspost/compress v1.17.0 // indirect
	github.com/nats-io/nats.go v1.31.0 // indirect
	github.com/nats-io/nkeys v0.4.5 // indirect
	github.com/nats-io/nuid v1.0.1 // indirect
	golang.org/x/crypto v0.23.0 // indirect
)

require (
	github.com/scylladb/go-reflectx v1.0.1 // indirect
	golang.org/x/net v0.25.0 // indirect
	golang.org/x/sys v0.20.0 // indirect
	golang.org/x/text v0.15.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240528184218-531527333157 // indirect
)

replace github.com/c12s/oort => ../oort

replace github.com/c12s/magnetar => ../magnetar

replace github.com/gocql/gocql => github.com/scylladb/gocql v1.6.0
