module queries

go 1.21

replace github.com/jmpsec/osctrl/nodes => ../nodes

replace github.com/jmpsec/osctrl/utils => ../utils

require (
	github.com/jinzhu/gorm v1.9.16
	github.com/jmpsec/osctrl/nodes v0.0.0-20240710135334-c020425d8ffe
	github.com/jmpsec/osctrl/utils v0.0.0-20240710135334-c020425d8ffe
	gorm.io/gorm v1.25.10
)

require (
	github.com/google/uuid v1.6.0 // indirect
	github.com/jinzhu/inflection v1.0.0 // indirect
	github.com/jinzhu/now v1.1.5 // indirect
	github.com/segmentio/ksuid v1.0.4 // indirect
)
