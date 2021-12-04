package main

import (
	"github.com/BattleDwarf007/scorereaper-api/service"
	"github.com/Mallekoppie/goslow/platform"
	"net/http"
)

var Routes = platform.Routes{
	platform.Route{
		Path:        "/point",
		Method:      http.MethodPost,
		HandlerFunc: service.SavePoint,
		SlaMs:       0,
	},
	platform.Route{
		Path:        "/stopwatch",
		Method:      http.MethodPost,
		HandlerFunc: service.SaveLapsScan,
		SlaMs:       0,
	},
}
