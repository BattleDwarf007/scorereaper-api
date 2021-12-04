package model

import (
	"time"
)

type Point struct {
	Car      string    `json:"car"`
	ScanTime time.Time `json:"scan_time"`
	Location string    `json:"location"`
	User     string    `json:"user"`
	Points   int       `json:"points"`
}

type LapsScan struct {
	Car      string `json:"car"`
	Location string `json:"location"`
	User     string `json:"user"`
	LapTime  int    `json:"lap_time"`
}
