from fastapi import FastAPI, HTTPException
import numpy as np
import uvicorn
import joblib
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

model = joblib.load('')

class PredictionInput(BaseModel):
    name: str
    email: str
    education_level: str
    years_experience: int
    skills: str
    mentorship_involvement: str
    
@app.post("/predict")
async def predict(input: PredictionInput):
    # Convert to model expected format
    try:
        features = np.array([

        ])
        prediction = model.predit([features])
        return {"Success rate": prediction[0]}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    
