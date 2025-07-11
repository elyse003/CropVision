#!/usr/bin/env python
# coding: utf-8

# In[1]:


## Import libraries
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np


# In[2]:


# Load model and scaler
model = joblib.load("best_model.pkl")
scaler = joblib.load("scaler.pkl")
encoders = joblib.load("encoders.pkl")


# In[3]:


# Input schema
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


# In[4]:


# FastAPI app
app = FastAPI(title="Crop Yield Prediction API")

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/predict")
def predict_crop_yield(data: CropInput):
    features = np.array([[data.soil_moisture, data.soil_pH, data.temperature, data.rainfall,
                          data.humidity, data.sunlight_hours, data.irrigation_type,
                          data.fertilizer_type, data.pesticide_usage, data.total_days,
                          data.NDVI_index, data.crop_type, data.crop_disease_status]])

    scaled = scaler.transform(features)
    prediction = model.predict(scaled)
    return {"predicted_yield_kg_per_hectare": round(prediction[0], 2)}


# In[ ]:




