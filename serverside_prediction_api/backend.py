from flask import Flask
from flask import request
app = Flask(__name__)

import turicreate as tc

import json

model = tc.load_model("movie_rec")

@app.route("/recommend", methods=['POST'])
def recommend():
	user_preferences = request.form
	user_preferences = tc.SFrame({"movieId": map(int, json.loads(user_preferences["movieIds"])), "ratings": json.loads(user_preferences["ratings"])})
	recommendations = model.recommend_from_interactions(user_preferences)
	return json.dumps({"movieId": list(recommendations["movieId"]), "score": list(recommendations["score"])})
