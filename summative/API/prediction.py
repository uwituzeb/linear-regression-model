import json
from fastapi import FastAPI, HTTPException
import numpy as np
from pydantic import BaseModel, EmailStr, Field
import uvicorn
import joblib
from fastapi.middleware.cors import CORSMiddleware
from sklearn.preprocessing import StandardScaler
import pandas as pd

app = FastAPI()

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

try:
    model = joblib.load('best_salary_model.pkl')
    scaler = joblib.load('salary_scaler.pkl')
    with open('mappings.json', 'r') as file:
        mappings = json.load(file)
except Exception as e:
    print(f"Error loading model files: {str(e)}")
    raise

class PredictionInput(BaseModel):
    name: str = Field(..., min_length=2, max_length=50)
    email: EmailStr
    job_title: str
    department: str
    gender: str
    education: str
    age: int = Field(..., gt=18, lt=100)
    perf_eval: float = Field(..., ge=0, le=5)
    seniority: int = Field(..., ge=0)
    bonus: float = Field(..., ge=0)

    class Config:
        schema_extra = {
            'example': {
                'name': 'John Doe',
                'email': 'john.doe@example.com',
                'job_title': 'Software Engineer',
                'department': 'Engineering',
                'gender': 'Male',
                'education': 'Bachelor',
                'age': 25,
                'perf_eval': 4.5,
                'seniority': 5,
                'bonus': 10000
            }
        }

def encode_categorical_data(input_data: PredictionInput):
    try:
        encoded_values = {
            'job_title_encoded': mappings['JobTitle'].get(input_data.job_title),
            'department_encoded': mappings['Dept'].get(input_data.department),
            'gender_encoded': mappings['Gender'].get(input_data.gender),
            'education_encoded': mappings['Education'].get(input_data.education)
        }

        if None in encoded_values.values():
            invalid_categories = [
                f"{key.split('_')[0]}: {getattr(input_data, key.split('_')[0])}"
                for key, value in encoded_values.items()
                if value is None
            ]

            raise ValueError(f"Invalid categories found: {', '.join(invalid_categories)}")
        
        return encoded_values
    except Exception as e:
        raise ValueError(f"Error encoding categorical values: {str(e)}")
    

@app.post("/predict")
async def predict(input_data: PredictionInput):
    try:
        encoded_categories = encode_categorical_data(input_data)

        features = np.array([
            input_data.age,
            input_data.perf_eval,
            input_data.seniority,
            input_data.bonus,
            encoded_categories['job_title_encoded'],
            encoded_categories['department_encoded'],
            encoded_categories['gender_encoded'],
            encoded_categories['education_encoded']
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

# model = joblib.load('best_salary_model.pkl')
# scaler = joblib.load('salary_scaler.pkl')

# # categorical variables mapping


# job_title_mapping = {
#    'Software Engineer': 0,
#     'Data Scientist': 1,
#     'Product Manager': 2,
#     'Sales Representative': 3,
#     'Marketing Specialist': 4 
# }

# department_mapping = {
#     'Engineering': 0,
#     'Data Science': 1,
#     'Product': 2,
#     'Sales': 3,
#     'Marketing': 4
# }

# gender_mapping = {
#     'Male': 0,
#     'Female': 1,
#     'Other': 2,
# }

# education_mapping = {
#     'High School': 0,
#     'Bachelor': 1,
#     'Masters': 2,
#     'PhD': 3,
# }

# class PredictionInput(BaseModel):
#     name: str = Field(..., min_length=2, max_length=50)
#     email: EmailStr
#     job_title: str
#     department: str
#     gender: str
#     education: str
#     seniority: int
#     perf_eval: float
#     age: int

    

# @app.post("/predict")
# async def predict(input: PredictionInput):
#     # Convert input data to model expected format
#     try:
#         features = np.array([
#             input.age, input.perf_eval, input.seniority, 0, 
#             job_title_mapping.get(input.job_title, -1),
#             department_mapping.get(input.department, -1),
#             gender_mapping.get(input.gender, -1),
#             education_mapping.get(input.education, -1)

#         ]).reshape(1, -1)

#         if -1 in features:
#             raise HTTPException(
#                 status_code=400,
#                 error_message="Invalid data"
#             )
        
#         features_scaled = scaler.transform(features)
#         prediction = model.predict(features_scaled)

#         return {
#             "name": input.name,
#             "email": input.email,
#             "predicted_salary": float(prediction[0]),
#             "model_confidence": "High" if prediction[0] > 0 else "Low"
#         }
#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))

    
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)