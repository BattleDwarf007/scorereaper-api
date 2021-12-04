package repository

import (
	"github.com/BattleDwarf007/scorereaper-api/model"
	"log"
	"testing"
	"time"
)

func TestSavePoint(t *testing.T) {
	input := model.Point{
		Car:      "A001",
		ScanTime: time.Now(),
		Location: "checkpoint1",
		User:     "user1",
		Points:   50,
	}

	err := SavePoint(input)
	if err != nil {
		log.Println("Save point failed: ", err.Error())
		t.Fail()
	}
}

func TestSaveStopwatch(t *testing.T) {
	input := model.LapsScan{
		Car:      "A001",
		Location: "Sprint",
		User:     "User01",
		LapTime:  50000, // Time is in milliseconds
	}

	err := SaveLapsScan(input)
	if err != nil {
		log.Println("Save point failed: ", err.Error())
		t.Fail()
	}
}
