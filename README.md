# PayPredict

## Overview

PayPredict is a flutter-based mobile application that uses machine learning to predict salaries based on various employee attributes. Using a trained **Random Forest Regressor** model, the app provides salary estimates according to the employee information such as job title, education, experience, and performance. The app promotes fair compensation, career development, and informed decision-making in the job market hence contributing to Job Creation in terms of decent work and educational empowerment.

## Mission
PayPredict aligns with my mission at ALU which is a combination of job creation and education by offering tools that enhance career development and empower employees to make informed decisions. The app provides data-driven insights into salary trends, enabling fair compensation, fostering career development and promoting job creation. PayPredict also aims to bridge the gap between education and employment by providing insights into the value of skills and qualifications in the job market.

## Video Demo
To see how the app works live use this [PayApi demo link](https://www.youtube.com/watch?v=taqXp1NbmFE)

## Dataset

To create the random forest regressor model for the salary prediction API, [dataset](https://www.kaggle.com/datasets/nilimajauhari/glassdoor-analyze-gender-pay-gap) was used, sourced from the Kaggle platform. The dataset taken from glassdoor, contains the base pay for different job roles which makes it a perfect fit for the model necessary for salary prediction. The dataset contains about 9000 columns of data with detailed employee attributes/features i.e Job title, Education level, Years of Experience, Performance Evaluation, Age, Gender, Department, Seniority and Bonus, with a targeted variable of salary or base pay.

The dataset is included in this repository as well as the notebook where the model is created.
[Google colab](https://colab.research.google.com/drive/1VKI2AnDxjmTp6aaUqlwcOI5pb1xNjaOP?usp=sharing)

## API Documentation

Navigate to [docs](https://linear-regression-model-m7ix.onrender.com/docs) to try out the API through Swagger Docs. 
NB: Due to it being a free service, may take longer to load.

## Features

- Uses a trained random forest regressor model for accurate salary estimates. During model evaluation, the Random Forest Regressor outperformed other models i.e linear regression and decision tree models, by achieving the highest R² score.
- User-friendly design that is easy to navigate
- Input  validation to ensure accurate predictions
- Support for multiple job titles and departments

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio/VS code with Flutter extensions

### Installation

1. Clone the repository

```
git clone https://github.com/uwituzeb/linear-regression-model.git
cd linear-regression-model/summative/FlutterApp
```

2. Install dependencies
`flutter pub get`

3. Run the app
`flutter run`

## Model features

The salary prediction takes into account:

- Job Title
- Department
- Education Level
- Years of Experience
- Performance Evaluation Score
- Age
- Gender
- Annual Bonus

## API Endpoints

```
POST /predict
Content-Type: application/json

Request Body:
{
    "name": "John Doe",
    "email": "john.doe@example.com",
    "job_title": "Software Engineer",
    "department": "Management",
    "gender": "Male",
    "education": "Bachelor",
    "age": 25,
    "perf_eval": 4.5,
    "seniority": 5,
    "bonus": 10000
}
```


## Navigation

- The welcome screen(initial route) introduces the app and welcomes users with more information about the application
- The Home Screen is where the user will enter their data into a form and from there they can submit their information by clicking the `predict` button
- The Results Screen displays the results that came from the prediction

