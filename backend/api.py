#!/usr/bin/env python
# coding: utf-8

#  Import Libraries
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np

#  Load Trained Resources
model = joblib.load("best_model.pkl")
scaler = joblib.load("scaler.pkl")
encoders = joblib.load("encoders.pkl")  # May not be used, but loaded for compatibility

#  Define Input Schema
class CropInput(BaseModel):
    soil_moisture: float = Field(..., ge=0, le=100)
    soil_pH: float = Field(..., ge=3.0, le=9.0)
    temperature: float
    rainfall: float
    humidity: float
    sunlight_hours: float
    irrigation_type: int
    fertilizer_type: int
    pesticide_usage: float
    total_days: int
    NDVI_index: float
    crop_type: int
    crop_disease_status: int

#  Create FastAPI App
app = FastAPI(title="CropVision Yield Prediction API")

#  Enable CORS for Flutter Integration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Open to all origins (good for testing)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#  Debug Endpoint: Raw Request Inspection
@app.post("/debug")
async def debug_raw(request: Request):
    raw_body = await request.body()
    print("Raw request body:", raw_body.decode("utf-8"))
    return {"status": "Received raw body for inspection."}

#  Prediction Endpoint with Logging
@app.post("/predict")
def predict_crop_yield(data: CropInput):
    #  Log the parsed input
    print("Parsed request:", data.dict())

    #  Prepare feature array
    features = np.array([[
        data.soil_moisture,
        data.soil_pH,
        data.temperature,
        data.rainfall,
        data.humidity,
        data.sunlight_hours,
        data.irrigation_type,
        data.fertilizer_type,
        data.pesticide_usage,
        data.total_days,
        data.NDVI_index,
        data.crop_type,
        data.crop_disease_status
    ]])

    #  Scale and Predict
    scaled = scaler.transform(features)
    prediction = model.predict(scaled)

    # Return Predicted Yield
    return {"predicted_yield_kg_per_hectare": round(prediction[0], 2)}