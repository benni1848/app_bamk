import 'package:app_bamk/api/services/music_service.dart';
import 'package:app_bamk/api/model/music_model.dart';
import 'package:app_bamk/domain/entities/music_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_bamk/api/services/movie_service.dart';
import 'package:app_bamk/api/model/movie_model.dart';
import 'package:app_bamk/domain/entities/movie_entity.dart';

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

        final List<MovieModel> movies = snapshot.data![0] as List<MovieModel>;
        final List<MusicModel> musicList =
            snapshot.data![1] as List<MusicModel>;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Area for Top 10 Movies
                Text(
                  "Top 10 Filme",
                  style: TextStyle(
                    color: Color(0xFF80B5E9),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 250,
                  color: Color(0xFF1a1a1a),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 150,
                                child: Image.network(movie.coverImage,
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '- ${index + 1} -',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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

                SizedBox(height: 30),

                // Area for top 10 Musik
                Text(
                  "Top 10 Musik",
                  style: TextStyle(
                    color: Color(0xFF80B5E9),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 250,
                  color: Color(0xFF1a1a1a),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: musicList.length,
                    itemBuilder: (context, index) {
                      final music = musicList[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 150,
                                child: Image.network(music.coverImage,
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '- ${index + 1} -',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
