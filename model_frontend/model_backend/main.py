from fastapi import FastAPI
import numpy as np

app = FastAPI()

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
    features = np.array([

    ])

    prediction = model.predit([features])
    return {"Success rate": prediction[0]}
