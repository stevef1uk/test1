// GENERATED FILE so do not edit or will be overwritten upon next generate
package data

import (
  "test1/models"
  "test1/restapi/operations"
    middleware "github.com/go-openapi/runtime/middleware"
    "github.com/gocql/gocql"
    "os"
    "log"
)

var session *gocql.Session

func SetUp() {
  var err error
  log.Println("Connecting to Cassandra DB on ", os.Getenv("CASSANDRA_SERVICE_HOST"))
  cluster := gocql.NewCluster(os.Getenv("CASSANDRA_SERVICE_HOST"))
  cluster.Keyspace = "demo"
  cluster.Consistency = gocql.One
  session, err = cluster.CreateSession()
  if ( err != nil ) {
	  log.Fatal("Have you set the env var CASSANDRA_SERVICE_HOST. Connection to Cannandra failed", err)
  } else {
	  log.Println("Connection to Cannandra established")
  }
}

func Stop() {
    log.Println("Stopping Cassandra")
    session.Close()
}

func Search(params operations.GetAccounts2Params) middleware.Responder {

    var id int64
    var name string
    var sex bool
    var events [] int64
    ret := &operations.GetAccounts2OK{}
    ret.Payload = make([]*models.GetAccounts2OKBodyItems,1)
    if err := session.Query(`SELECT id,name,sex,events FROM accounts2 WHERE id = ? and name = ? `,params.ID,params.Name).Consistency(gocql.One).Scan(&id,&name,&sex,&events); err != nil {
        // No data
        log.Println("No data? ", err)
        return operations.NewGetAccounts2BadRequest()
    }
    payLoad := new(models.GetAccounts2OKBodyItems)
    
    ret.Payload[0] = payLoad
    payLoad.ID = &id
    payLoad.Name = &name
    payLoad.Sex = &sex
    
		payLoad.Events = make([]int64,len(events) )
		for i := 0; i < len(events); i++ {
        payLoad.Events[i] = int64(events[i])
		}

    return operations.NewGetAccounts2OK().WithPayload(ret.Payload)
}
