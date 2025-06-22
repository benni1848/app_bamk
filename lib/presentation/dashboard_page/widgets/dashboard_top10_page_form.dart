import 'package:app_bamk/api/services/comment_service.dart';
import 'package:app_bamk/api/services/game_service.dart';
import 'package:app_bamk/api/services/user_service.dart';
import 'package:flutter/material.dart';
// Music
import 'package:app_bamk/api/services/music_service.dart';
import 'package:app_bamk/api/model/music_model.dart';
import 'package:app_bamk/domain/entities/music_entity.dart';
// Movies
import 'package:app_bamk/api/services/movie_service.dart';
import 'package:app_bamk/api/model/movie_model.dart';
import 'package:app_bamk/domain/entities/movie_entity.dart';
// Games
import 'package:app_bamk/api/services/game_service.dart';
import 'package:app_bamk/api/model/game_model.dart';
import 'package:app_bamk/domain/entities/game_entity.dart';
// Comments
import 'package:app_bamk/api/services/comment_service.dart';
import 'package:app_bamk/api/model/comment_model.dart';
import 'package:app_bamk/domain/entities/comment_entity.dart';

class DashboardTop10PageForm extends StatefulWidget {
  const DashboardTop10PageForm({super.key});

  @override
  State<DashboardTop10PageForm> createState() => _DashboardTop10PageFormState();
}

class _DashboardTop10PageFormState extends State<DashboardTop10PageForm> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    // Wait for both Services
    _futureData = Future.wait([
      MovieService.fetchtop10(),
      MusicService.fetchtop10(),
      GameService.fetchtop10(),
      CommentService.fetchCommentLast(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Fehler: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Keine Daten gefunden'));
        }

        final List<MovieModel> movieList =
            snapshot.data![0] as List<MovieModel>;
        final List<MusicModel> musicList =
            snapshot.data![1] as List<MusicModel>;
        final List<GameModel> gameList = snapshot.data![2] as List<GameModel>;
        final List<CommentModel> commentList =
            snapshot.data![3] as List<CommentModel>;

        // ScrollView for Top 10
        return SingleChildScrollView(
          child: Padding(
            // Padding for Heading
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Area for top 10 movie - Heading
                Text(
                  "Top 10 Filme",
                  style: TextStyle(
                    color: Color(0xFF80B5E9),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Space under Heading
                SizedBox(height: 3),
                Container(
                  height: 140,
                  color: Color(0xFF1a1a1a),
                  // Area for top 10 movie - Items
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      final movie = movieList[index];
                      return Padding(
                        // Padding for MovieCover
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 80,
                          // Margin between items
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Area for MovieCover
                              SizedBox(
                                height: 100,
                                width: 75,
                                child: Image.network(movie.coverImage,
                                    fit: BoxFit.cover),
                              ),
                              // Area for MovieIndex
                              SizedBox(height: 5),
                              Text(
                                '- ${index + 1} -',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Space betweeen container top 10 Movie & Music
                SizedBox(height: 15),

                // Area for top 10 musik - Heading
                Text(
                  "Top 10 Musik",
                  style: TextStyle(
                    color: Color(0xFF80B5E9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Space under Heading
                SizedBox(height: 3),
                Container(
                  height: 140,
                  color: Color(0xFF1a1a1a),
                  // Area for top 10 musik - items
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: musicList.length,
                    itemBuilder: (context, index) {
                      final music = musicList[index];
                      return Padding(
                        // Padding for MovieCover
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 80,
                          // Margin between items
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Area for MusicCover
                              SizedBox(
                                height: 100,
                                width: 75,
                                child: Image.network(music.coverImage,
                                    fit: BoxFit.cover),
                              ),
                              // Area for MusicIndex
                              SizedBox(height: 5),
                              Text(
                                '- ${index + 1} -',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15),

                // Area for top 10 games - Heading
                Text(
                  "Top 10 Spiele",
                  style: TextStyle(
                    color: Color(0xFF80B5E9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Space under Heading
                SizedBox(height: 3),
                Container(
                  height: 140,
                  color: Color(0xFF1a1a1a),
                  // Area for top 10 games - items
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: gameList.length,
                    itemBuilder: (context, index) {
                      final game = gameList[index];
                      return Padding(
                        // Padding for GameCover
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 80,
                          // Margin between items
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Area for GameCover
                              SizedBox(
                                height: 100,
                                width: 75,
                                child: Image.network(game.coverImage,
                                    fit: BoxFit.cover),
                              ),
                              // Area for GameIndex
                              SizedBox(height: 5),
                              Text(
                                '- ${index + 1} -',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Space between container top 10 Games & following container
                SizedBox(height: 15),

                // Area for the last 10 comments - Heading
                Text(
                  "Die 10 letzten Kommentare",
                  style: TextStyle(
                    color: Color(0xFF80B5E9),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Space under Heading
                SizedBox(height: 3),
                Container(
                  height: 160,
                  color: Color(0xFF1a1a1a),
                  // Area for the last 10 comments - items
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: commentList.length,
                    itemBuilder: (context, index) {
                      final comment = commentList[index];
                      return Padding(
                        // Padding for CommentContainer
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 80,
                          // Margin between items
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Outer container
                              Container(
                                height: 120,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF80B5E9),
                                ),
                                child: Padding(
                                  // Padding between inner and outer container (white & blue)
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white54,
                                    ),
                                    child: Padding(
                                      // Padding between white container and content
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Comment - Title
                                                Text(
                                                  "${comment.title}",  // extract only the date
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                // Comment - Content
                                                Text(
                                                  comment.inhalt,
                                                  // Handle Overflow
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(height: 1),
                                                // Comment - Rating
                                                Text(
                                                  "${comment.username} hat ${comment.rating} von 10 Punkte gegeben",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Comment - ProfilePicture
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
