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

* [Turi Create](): is a task-focused deep learning library - allowing you to build intelligent apps by focusing on the machine learning use case, not the algorithm.
* [Flask](): is a micro web framework.
* [ngrok](): allows you to open an HTTPS tunnel into your REST API.

## Featured technologies

* ABCD
* EFGH

## Prerequisites:


