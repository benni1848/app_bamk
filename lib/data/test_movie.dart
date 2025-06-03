import 'package:app_bamk/api/model/movie_model.dart';

final testMovieJson = {
  "id": "1",
  "mediatype": "movie",
  "name": "Back to the Future",
  "genre": ["Adventure", "Comedy", "Sci-Fi"],
  "director": "Robert Zemeckis",
  "duration": 116,
  "published": "1985-07-03T00:00:00.000Z",
  "imageUrls": [
    "https://upload.wikimedia.org/wikipedia/en/d/d2/Back_to_the_Future.jpg"
  ],
  "trailerUrl": "https://www.youtube.com/watch?v=qvsgGtivCgs",
  "description":
      "Marty McFly, a 17-year-old high school student, is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his close friend, eccentric scientist Doc Brown.",
  "rating": 8.5
};

final testMovie = MovieModel.fromJson(testMovieJson);
