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

* [Artificial Intelligence](https://www.ibm.com/products/data-science-experience): Artificial intelligence can be applied to disparate solution spaces to deliver disruptive technologies.
* [Python](https://www.python.org/): Python is a programming language that lets you work more quickly and integrate your systems more effectively.

## Prerequisites

The following are prerequisites to start developing this application:

* [Xcode](https://developer.apple.com/xcode/)
* [Turi Create (5.0 Beta 2)](http://github.com/apple/turicreate)
* [Cocoapods](http://cocoapods.org)
* [Python 2.7](https://www.python.org/) & [PIP](https://pypi.org/project/pip/)
* [Flask](http://flask.pocoo.org)
* [Jupyter](http://jupyter.org)
* [ngrok](http://ngrok.com)

# Steps

1. [Download and organize the latest MovieLens dataset](#1-download-and-organize-the-latest-movielens-dataset)
2. [Train the Turi Create Recommender model](#2-train-the-turi-create-recommender-model)
3. [Run the backend](#3-run-the-backend)
4. [Deploy the iOS app](#4-deploy-the-ios-app)

### 1. Download and organize the latest MovieLens dataset

In order to get the MovieLens dataset setup, run the following script:

`$ sh setup.sh`

It'll download the data and move the files to their relevant locations.

### 2. Train the Turi Create Recommender model

In order for the recommendations to work, you need a trained model. Turi Create is a Python package that will train this model for you.

Go ahead and start your Jupyter Notebooks. In the `local_model_training` folder, open the `TrainRecommendationModel.ipynb` notebook. Run the notebook, and once it's done executing, you're going to have a folder called `movie_rec`, which contains the trained Turi Create model. Unlike other machine learning libraries, Turi Create does not use files for models; instead, it uses folders.

### 4. Run the backend

Turi Create supports exporting recommender models to CoreML, so they can run on-device, and there's no need for a backend. However, it only works with iOS 12 and above (which is currently in Beta), and there's an [issue with linking the custom model framework](https://github.com/apple/turicreate/issues/799). Therefore, this code pattern will use a backend that takes requests from the iOS Application, and runs the users' preferences through the Turi Create model, to return predictions as to what the user would like to watch next.

First, copy the `movie_rec` folder (your trained model) from `local_model_training`, and paste it into the `serverside_prediction_api` folder. Once that's done, run the following command from a terminal window within that folder:

`FLASK_APP=backend.py flask run`

This will run the `backend.py` file, which is the flask application.

Next, open up a tunnel to the backend with [ngrok](https://www.ngrok.com), so your iOS App can access it:

`ngrok http 5000` (change 5000 to whichever port you chose with Flask)

### 5. Deploy the iOS app

Finally, you can run the front-end of the application.

Start by pointing your iOS app to the backend. Go to the `iOS_Frontend/MovieRecommender/MovieRecommender/MovieHandler.swift` file, and change the `backend` constant to the link of the ngrok tunnel.

Then, in the `iOS_frontend/MovieRecommender` folder, and open the `xcworkspace` file. Once you're there, run the application by hitting <kbd>&#8984;</kbd> + <kbd>R</kbd> or clicking the run button beside the window controls on the top left of Xcode.
