package service

import (
	"net/http"

	"github.com/BattleDwarf007/scorereaper-api/model"
	"github.com/BattleDwarf007/scorereaper-api/repository"

	"github.com/Mallekoppie/goslow/platform"
	"go.uber.org/zap"
)

func SavePoint(w http.ResponseWriter, r *http.Request) {
	platform.Logger.Info("Executing SavePoint")

	input := model.Point{}

	err := platform.JsonMarshaller.ReadJsonRequest(r.Body, &input)
	if err != nil {
		platform.Logger.Error("Unable to read request for SavePoint", zap.Error(err))
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	err = repository.SavePoint(input)
	if err != nil {
		platform.Logger.Error("Error saving scan to DB for SavePoint", zap.Error(err))
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusAccepted)
}

func SaveLapsScan(w http.ResponseWriter, r *http.Request) {
	platform.Logger.Info("Executing SaveLapsScan")

	input := model.LapsScan{}

	err := platform.JsonMarshaller.ReadJsonRequest(r.Body, &input)
	if err != nil {
		platform.Logger.Error("Unable to read request for SaveLapsScan", zap.Error(err))
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	err = repository.SaveLapsScan(input)
	if err != nil {
		platform.Logger.Error("Error saving scan to DB for SaveLapsScan", zap.Error(err))
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusAccepted)
}
