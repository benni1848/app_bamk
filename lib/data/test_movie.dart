import 'dart:convert';

import 'package:app_bamk/api/model/movie_model.dart';

String testMovieJson = '''[
  {
    "id": "1",
    "mediatype": "movie",
    "name": "The Electric State",
    "genre": ["Adventure", "Sci-Fi"],
    "director": "Anthony & Joe Russo",
    "duration": 130,
    "published": "2024-12-27",
    "imageUrls": ["https://m.media-amazon.com/images/M/MV5BZDU5YWE3MmItMGI0Ny00MWQ4LWE3NDktMjRkNDk5YmFjYTk2XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=zHZtR3MQZTw",
    "description": "Ein Mädchen reist mit einem Roboter durch ein postapokalyptisches Amerika, auf der Suche nach ihrem verschollenen Bruder.",
    "rating": 7.9
  },
  {
    "id": "2",
    "mediatype": "movie",
    "name": "Hypnotic",
    "genre": ["Thriller", "Mystery"],
    "director": "Matt Angel, Suzanne Coote",
    "duration": 88,
    "published": "2021-10-27",
    "imageUrls": ["https://m.media-amazon.com/images/M/MV5BZDYzYjJjYmEtYzg3Ny00MzZlLTk5ZWYtZWYyYjg4NmYwZGY0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=CDFoQYFBDkE&pp=0gcJCdgAo7VqN5tD",
    "description": "Eine Frau gerät nach Hypnosesitzungen in eine gefährliche psychologische Falle.",
    "rating": 6.2
  },
  {
    "id": "3",
    "mediatype": "movie",
    "name": "Wir",
    "genre": ["Horror", "Thriller"],
    "director": "Jordan Peele",
    "duration": 116,
    "published": "2019-03-22",
    "imageUrls": ["https://m.media-amazon.com/images/M/MV5BY2M4NGQxOTYtM2ZlOC00OWRhLWI1NzMtZTUzYzA5Y2UwMTE5XkEyXkFqcGc@._V1_.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=mGcYnVBPI1o&pp=0gcJCdgAo7VqN5tD",
    "description": "Eine Familie wird von mysteriösen Doppelgängern terrorisiert.",
    "rating": 6.8
  },
  {
    "id": "4",
    "mediatype": "movie",
    "name": "Delicious",
    "genre": ["Comedy", "History"],
    "director": "Éric Besnard",
    "duration": 112,
    "published": "2021-09-08",
    "imageUrls": ["https://m.media-amazon.com/images/M/MV5BNTFlZGNjMDAtOTJjYS00ODg3LTgzNjItMThlYWY2NWUwYTU3XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=g3aMCgnI9OE",
    "description": "Frankreich 1789: Ein Koch gründet mit Hilfe einer Frau das erste Restaurant der Welt.",
    "rating": 7.0
  },
  {
    "id": "5",
    "mediatype": "movie",
    "name": "Plankton: Der Film",
    "genre": ["Animation", "Comedy"],
    "director": "Dave Needham",
    "duration": 90,
    "published": "2025-05-01",
    "imageUrls": ["https://m.media-amazon.com/images/M/MV5BYmYyZjUzYjgtY2U1My00MTA4LTllNWEtNWU3ZThkOWRmMTY1XkEyXkFqcGc@._V1_.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=FHVKlhUgsqE",
    "description": "Plankton kämpft um die Anerkennung der Welt – und den Krabbenburger.",
    "rating": 7.5
  },
  {
    "id": "6",
    "mediatype": "movie",
    "name": "Bee Movie – Das Honigkomplott",
    "genre": ["Animation", "Comedy"],
    "director": "Simon J. Smith, Steve Hickner",
    "duration": 91,
    "published": "2007-11-02",
    "imageUrls": ["https://m.media-amazon.com/images/I/7116kIRsFYL._AC_UF894,1000_QL80_DpWeblab_.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=B-XbD9U8GKA",
    "description": "Barry B. Benson verklagt die Menschheit wegen Honigdiebstahls.",
    "rating": 6.1
  },
  {
    "id": "7",
    "mediatype": "movie",
    "name": "Karate Kid",
    "genre": ["Drama", "Sport"],
    "director": "John G. Avildsen",
    "duration": 126,
    "published": "1984-06-22",
    "imageUrls": ["https://upload.wikimedia.org/wikipedia/en/a/a9/Karate_kid.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=n7JhKCQnEqQ",
    "description": "Ein Teenager lernt mit Hilfe seines Mentors Karate zur Selbstverteidigung.",
    "rating": 7.3
  },
  {
    "id": "8",
    "mediatype": "movie",
    "name": "The Mother",
    "genre": ["Action", "Thriller"],
    "director": "Niki Caro",
    "duration": 115,
    "published": "2023-05-12",
    "imageUrls": ["https://resizing.flixster.com/IiigYhK4bleuE1G_pZnrKwlUfMM=/fit-in/705x460/v2/https://resizing.flixster.com/JzK3UGqleIyHBaG2447ek6FtjAY=/ems.cHJkLWVtcy1hc3NldHMvbW92aWVzLzNhMTUyMmY1LWMwMDgtNDFiMi05YzE3LTQyZDhhMWUyYjNhZS5qcGc="],
    "trailerUrl": "https://www.youtube.com/watch?v=8BFdFeOS3oM",
    "description": "Eine Auftragskillerin muss ihre Tochter vor gefährlichen Verfolgern beschützen.",
    "rating": 6.6
  },
  {
    "id": "9",
    "mediatype": "movie",
    "name": "Lift",
    "genre": ["Action", "Comedy"],
    "director": "F. Gary Gray",
    "duration": 104,
    "published": "2024-01-12",
    "imageUrls": ["https://m.media-amazon.com/images/M/MV5BOWRkYmNiNDUtYTY0OC00YTZlLTlmMTYtMTJhMTU4OTBkMDY5XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"],
    "trailerUrl": "https://www.youtube.com/watch?v=5G6dpaznU_g",
    "description": "Ein Meisterdieb plant einen riskanten Coup in einem Flugzeug.",
    "rating": 6.0
  },
  {
    "id": "10",
    "mediatype": "movie",
    "name": "Leo",
    "genre": ["Animation", "Family"],
    "director": "Robert Marianetti, Robert Smigel",
    "duration": 102,
    "published": "2023-11-21",
    "imageUrls": ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdSJkwoPDBY_7NpA22f0N765TGkvbIz8Z9Sw&s"],
    "trailerUrl": "https://www.youtube.com/watch?v=Vj9hHI4JkhY",
    "description": "Ein alter Klassenterrarier hilft Schülern, über sich hinauszuwachsen.",
    "rating": 7.2
  }
]''';
List<dynamic> jsonList = jsonDecode(testMovieJson);
List<MovieModel> testMovie = jsonList.map((movie)=>MovieModel.fromJson(movie)).toList();
