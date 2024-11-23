# PayPredict

## Overview

PayPredict is a flutter based mobile application that uses machine learning to predict salaries based on various employee attributes. Using a trained model, the app provides salary estimates according to the employee information such as job title, education, experience, and performance. The app promotes fair compensation, career development, and informed decision-making in the job market hence promoting Job Creation in terms of Decent Work and Quality Education.

## Features

- Uses a trained linear regression model for accurate salary estimates
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
