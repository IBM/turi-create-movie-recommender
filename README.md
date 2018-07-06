# Creating a Movie Recommendation System with Turi Create

This code pattern is an iOS Application that helps you find new movies to watch! It's been built to show you how you can use Turi Create, Apple's new deep learning framework, to build amazing recommendation systems very quickly, locally, on your machine - in under 2 minutes training time.

When the reader has completed this Code Pattern, they will understand how to:

* Create "Item Similarity" recommender models in Turi Create
* Use Flask to expose a REST API that provides recommendations based off of users' past movie ratings
* Call that REST API from Swift to create a GUI around the recommender

[ARCHITECTURE IMAGE COMES HERE]

## Flow

1. Download the MovieLens latest dataset (at the time of writing, there are 26,000,000 rows of data).
2. Train an item similarity recommender with turi create on MovieLens.
3. Expose that model through a REST API with Flask.
4. Open a tunnel to the REST API with ngrok.
5. User searches for and rates movies on the iOS app.
6. iOS app sends the movie rating data to the REST API.
7. The REST API will provide the iOS App with a list of movies and their scores.
8. The iOS App will display those movies and scores.
9. User will watch & rate those movies, and go back to step 6, getting better recommendations every time.

## Included components

* [Turi Create](https://github.com/apple/turicreate): is a task-focused deep learning library - allowing you to build intelligent apps by focusing on the machine learning use case, not the algorithm.
* [Flask](http://flask.pocoo.org/): is a micro web framework.
* [ngrok](http://ngrok.com/): allows you to open an HTTPS tunnel into your REST API.

## Featured technologies

* [Artificial Intelligence](https://medium.com/ibm-data-science-experience): Artificial intelligence can be applied to disparate solution spaces to deliver disruptive technologies.
* [Python](https://www.python.org/): Python is a programming language that lets you work more quickly and integrate your systems more effectively.

## Prerequisites

The following are prerequisites to start developing this application:

* Xcode
* Turi Create (5.0 Beta 2)
* Cocoapods
* Python 2.7 & PIP
* Flask
* Jupyter
* ngrok

# Steps

(NOTE: I still need to add screenshots/pictures to all the steps!)

1. [Download and organize the latest MovieLens dataset](#1-download-and-organize-the-latest-movielens-dataset)
2. [Train the Turi Create Recommender model](#2-train-the-turi-create-recommender-model)
3. [Run the backend](#3-run-the-backend)
4. [Deploy the iOS app](#4-deploy-the-ios-app)

### 1. Download and organize the latest MovieLens dataset

There's a script available in the root directory of this repository, called `setup.sh`. Run this script - it'll download the movielens data, and organize it, for you.

### 2. Train the Turi Create Recommender model

In order for the recommendations to work, you need a trained model. Turi Create is a Python package that will train this model for you.

Go ahead and start your Jupyter Notebooks. In the `local_model_training` folder, open the `TrainRecommendationModel.ipynb` notebook. Run the notebook, and once it's done executing, you're going to have a folder called `movie_rec`, which contains the trained Turi Create model. Unlike other machine learning libraries, Turi Create does not use files for models - it uses folders.

### 4. Run the backend

Turi Create supports exporting recommender models to CoreML, so they can run on-device, and there's no need for a backend. However, it only works with iOS 12 and above (which is currently in Beta), and there's an [issue with linking the custom model framework](https://github.com/apple/turicreate/issues/799). Therefore, this code pattern will use a backend that takes requests from the iOS Application, and runs the users' preferences through the turi create model, to return predictions as to what the user would like to watch next.

First, copy the `movie_rec` folder (your trained model) from `local_model_training`, and paste it into the `serverside_prediction_api` folder. Once that's done, run the following command from a terminal window within that folder: `FLASK_APP=backend.py flask run`. This will run the `backend.py` file, which is the flask application.

### 5. Deploy the iOS app

Finally, you can run the front-end of the application. Go ahead into the `iOS_frontend/MovieRecommender` folder, and open the `xcworkspace` file. Once you're there, run the application by hitting `Cmd+R` or clicking the run button beside the window controls on the top left of Xcode.
