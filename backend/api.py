from fastapi import FastAPI, Request, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np

# Load Trained Artifacts
model = joblib.load("best_model.pkl")
scaler = joblib.load("scaler.pkl")
encoders = joblib.load("encoders.pkl")  # Optional, depending on use

# Define Input Schema with validation
class CropInput(BaseModel):
    soil_moisture: float = Field(..., ge=0, le=100, description="Soil moisture percentage (0-100)")
    soil_pH: float = Field(..., ge=3.0, le=9.0, description="Soil pH (3.0 - 9.0)")
    temperature: float = Field(..., description="Temperature in °C")
    rainfall: float = Field(..., description="Rainfall in mm")
    humidity: float = Field(..., description="Humidity in %")
    sunlight_hours: float = Field(..., description="Hours of sunlight per day")
    irrigation_type: int = Field(..., ge=0, le=2, description="Encoded irrigation type (e.g., 0=drip, 1=flood, 2=sprinkler)")
    fertilizer_type: int = Field(..., ge=0, le=3, description="Encoded fertilizer type")
    pesticide_usage: float = Field(..., ge=0.0, description="Pesticide usage in ml or kg")
    total_days: int = Field(..., ge=1, description="Total number of growing days")
    NDVI_index: float = Field(..., ge=0.0, le=1.0, description="NDVI vegetation index (0.0 - 1.0)")
    crop_type: int = Field(..., ge=0, le=12, description="Encoded crop type (e.g., 0 = maize, 1 = beans)")
    crop_disease_status: int = Field(..., ge=0, le=1, description="0 = Healthy, 1 = Diseased")

# Initialize FastAPI App
app = FastAPI(
    title="CropVision Yield Prediction API",
    description=" Predict crop yield in kg/hectare using environmental and soil data. \nBuilt with FastAPI and deployed via Render.",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Enable CORS (important for Flutter frontend)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # For dev/testing. Use domain in production.
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"message": " IKAZE to CropVision API! Go to /docs to explore."}

@app.post("/predict")
def predict_yield(data: CropInput):
    try:
        # Log parsed input
        print("Parsed input:", data.dict())

        # Prepare features
        features = np.array([[
            data.soil_moisture, data.soil_pH, data.temperature, data.rainfall,
            data.humidity, data.sunlight_hours, data.irrigation_type,
            data.fertilizer_type, data.pesticide_usage, data.total_days,
            data.NDVI_index, data.crop_type, data.crop_disease_status
        ]])

        # Transform and predict
        scaled = scaler.transform(features)
        prediction = model.predict(scaled)

        return {
            "predicted_yield_kg_per_hectare": round(prediction[0], 2)
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction failed: {str(e)}")
