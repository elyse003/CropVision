🌾 CropVision
Mission:
Empowering African farmers with smart crop yield predictions using real-time environmental and soil data.
Built with machine learning and mobile-first principles to bring AI to the fields.

 Public API Endpoint
API Base URL:
 https://cropvision.onrender.com
Swagger UI for testing:
 https://cropvision.onrender.com/docs

The /predict endpoint accepts 13 input features and returns the predicted crop yield in kg per hectare.

 Video Demo (5 minutes)
 Watch the demo on YouTube

The video includes:

Flutter app usage

API tested via Swagger UI

Jupyter notebook training 3 models

Explanation of performance and deployment

 How to Run the Mobile App
1  Requirements
Flutter 3.x

Android Studio / VSCode

Internet access


2  Run on Emulator or Real Device
bash
Copy
Edit
git clone https://github.com/your-username/CropVision.git
cd CropVision/linear_regression_model/summative/FlutterApp
flutter pub get
flutter run


3  App Features
Prediction screen: form with 13 inputs

About screen: describes the app’s mission

Splash screen: branding introduction

Uses HTTP POST to fetch predictions from API and displays results



 Project Folder Structure
bash
Copy
Edit
linear_regression_model/
└── summative/
    ├── linear_regression/
    │   └── multivariate.ipynb         # Jupyter notebook for model training
    ├── backend/
    │   ├── api.py              # FastAPI code
    │   ├── requirements.txt
    |   |──best_model.pkl 
    |   ├── scaler.pkl
    |   |──encoders.pkl
    ├           
    └── FlutterApp/                    
        └── lib/...
