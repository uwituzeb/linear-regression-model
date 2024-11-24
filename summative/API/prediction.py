import json
from pathlib import Path
from fastapi import FastAPI, HTTPException
import numpy as np
from pydantic import BaseModel, EmailStr, Field
import uvicorn
import joblib
from fastapi.middleware.cors import CORSMiddleware
from sklearn.preprocessing import StandardScaler
import pandas as pd
import os

app = FastAPI(
    title="Salary Prediction API",
    description="""
A linear regression model that predicts salaries based on employee information.

## Features
* Predicts salaries using a linear regression model
* Support for multiple job roles and departments

## Usage
Make POST request to `/predict` endpoint with employee information to get salary predictions
    """,
    version="1.0.0",
    docs_url="/docs",
    openapi_url="/openapi.json"
)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

try:
    BASE_DIR = Path(__file__).resolve().parent
    MODEL_DIR = BASE_DIR / "linear_regression"
    
    model = joblib.load( MODEL_DIR / 'best_salary_model.pkl')
    scaler = joblib.load(MODEL_DIR  / 'salary_scaler.pkl')
    with open(MODEL_DIR / 'mappings.json', 'r') as file:
        mappings = json.load(file)
except Exception as e:
    print(f"Error loading model files: {str(e)}")
    raise

class PredictionInput(BaseModel):
    name: str = Field(..., min_length=2, max_length=50, description="Employee's full name", example="Marvin Doe")
    email: EmailStr = Field(..., description="Employee's email address", example="marvin@example.com")
    job_title: str = Field(..., description="Employee's job title", example="Software Engineer")
    department: str = Field(..., description="Employee's department", example="Management")
    gender: str = Field(..., description="Employee's gender", example="Male")
    education: str = Field(..., description="Highest education level", example="Masters")
    age: int = Field(..., gt=18, lt=100, description="Age in years", example=25)
    perf_eval: float = Field(..., ge=0, le=5,description="perfomance evaluation score", example=4.5)
    seniority: int = Field(..., ge=0, description="Years of experience in current  role", example=5)
    bonus: float = Field(..., ge=0, description="Annual bonus amount in USD", example=1000)

    class Config:
        schema_extra = {
            'example': {
                'name': 'John Doe',
                'email': 'john.doe@example.com',
                'job_title': 'Software Engineer',
                'department': 'Management',
                'gender': 'Male',
                'education': 'College',
                'age': 25,
                'perf_eval': 4.5,
                'seniority': 5,
                'bonus': 10000
            }
        }

def encode_categorical_data(input_data: PredictionInput):
    try:
        encoded_values = {
            'JobTitle_encoded': mappings['JobTitle'].get(input_data.job_title),
            'Dept_encoded': mappings['Dept'].get(input_data.department),
            'Gender_encoded': mappings['Gender'].get(input_data.gender),
            'Education_encoded': mappings['Education'].get(input_data.education)
        }

        if None in encoded_values.values():
            invalid_categories = [
                f"{key.split('_')[0]}: {getattr(input_data, key.split('_')[0].lower())}"
                for key, value in encoded_values.items()
                if value is None
            ]

            raise ValueError(f"Invalid categories found: {', '.join(invalid_categories)}")
        
        return encoded_values
    except Exception as e:
        raise ValueError(f"Error encoding categorical values: {str(e)}")
    

@app.post("/predict")
async def predict(input_data: PredictionInput):
    """
    Predict salary based on employee data

    Returns:
        dict: Contains status, employee name, email and predicted salary
    """
    try:
        encoded_categories = encode_categorical_data(input_data)

        features = np.array([
            input_data.age,
            input_data.perf_eval,
            input_data.seniority,
            input_data.bonus,
            encoded_categories['JobTitle_encoded'],
            encoded_categories['Dept_encoded'],
            encoded_categories['Gender_encoded'],
            encoded_categories['Education_encoded']
        ]).reshape(1, -1)

        features_scaled = scaler.transform(features)
        prediction = model.predict(features_scaled)

        return {
            "status": "success",
            "data": {
                "name": input_data.name,
                "email": input_data.email,
                "predicted_salary": round(float(prediction[0]), 2),
            }
        }
    except ValueError as ve:
        raise HTTPException(status_code=400, detail=str(ve))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")

    
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000)) 
    uvicorn.run(app, host="0.0.0.0", port=8000)