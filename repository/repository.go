package repository

import (
	"fmt"
	"github.com/BattleDwarf007/scorereaper-api/constants"
	"github.com/BattleDwarf007/scorereaper-api/model"
	"github.com/Mallekoppie/goslow/platform"
	"go.uber.org/zap"

	"database/sql"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

var (
	connectionString string
)

func init() {
	config := model.Config{}
	err := platform.GetComponentConfiguration("databaseconfig", &config)
	if err != nil {
		platform.Logger.Fatal("Unable to load configuration")
	}
	dbPort := config.DBPort
	dbHost := config.DBServer
	database := config.Database

	// I know it is bad to have the password hard-coded, but I need vault.. Next time :P
	// TODO: Get Vault
	connectionString = fmt.Sprintf("user:password@tcp(%s:%s)/%s?parseTime=true&multiStatements=true", dbHost, dbPort, database)

}

func getDB() (*sql.DB, error) {
	db, err := sql.Open("mysql", connectionString)
	if err != nil {
		platform.Logger.Error("Error opening DB: ", zap.Error(err))
		return nil, err
	}

	return db, nil
}

func SavePoint(input model.Point) error {
	db, err := getDB()
	if err != nil {
		return err
	}

	call, err := db.Prepare(constants.SavePointsScanSQL)
	if err != nil {
		platform.Logger.Error("Error preparing statement: ", zap.Error(err))
		//log.Fatalln("Error preparing statement: ", err.Error())
	}

	result, err := call.Exec(input.Car, input.ScanTime, input.Points, input.User, input.Location)
	if err != nil {
		platform.Logger.Error("Error calling stored procedure to insert: ", zap.Error(err))
		//log.Fatalln("Error calling stored procedure to insert: ", err.Error())
	}

	affected, err := result.RowsAffected()
	if err != nil {
		//log.Fatalln("Error getting rows affectred: ", err.Error())
		platform.Logger.Error("Error getting rows affectred: ", zap.Error(err))
	}
	log.Println("Stored procedure insert rows affected: ", affected)

	return nil
}

func SaveLapsScan(input model.LapsScan) error {
	db, err := getDB()
	if err != nil {
		return err
	}

	call, err := db.Prepare(constants.SaveLapsScanSQL)
	if err != nil {
		platform.Logger.Error("Error preparing statement: ", zap.Error(err))
		//log.Fatalln("Error preparing statement: ", err.Error())
	}

	result, err := call.Exec(input.Car, input.Location, input.User, input.LapTime)
	if err != nil {
		platform.Logger.Error("Error calling stored procedure to insert: ", zap.Error(err))
		//log.Fatalln("Error calling stored procedure to insert: ", err.Error())
	}

	affected, err := result.RowsAffected()
	if err != nil {
		//log.Fatalln("Error getting rows affectred: ", err.Error())
		platform.Logger.Error("Error getting rows affectred: ", zap.Error(err))
	}
	log.Println("Stored procedure insert rows affected: ", affected)

	return nil
}

//TODO: Add functions for retrieving the data from the DB
