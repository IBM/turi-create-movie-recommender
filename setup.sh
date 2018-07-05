# Download data from MovieLens

echo "Downloading data from movielens..."
cd local_model_training
if [ ! -f ml-latest.zip ]; then
  wget http://files.grouplens.org/datasets/movielens/ml-latest.zip
fi

echo "Downloading complete, inflating..."
unzip ml-latest.zip

echo "Setup complete."
