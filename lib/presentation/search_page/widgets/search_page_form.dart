import 'package:flutter/material.dart';
import 'package:app_bamk/api/services/movie_service.dart';
import 'package:app_bamk/api/services/game_service.dart';
import 'package:app_bamk/api/services/music_service.dart';

import 'package:app_bamk/domain/entities/movie_entity.dart';
import 'package:app_bamk/domain/entities/game_entity.dart';
import 'package:app_bamk/domain/entities/music_entity.dart';

import 'package:app_bamk/presentation/film_page/film_page.dart';
import 'package:app_bamk/presentation/game_page/game_page.dart';
import 'package:app_bamk/presentation/music_page/music_page.dart';

import 'package:app_bamk/presentation/search_page/search_page.dart'; // für ContentType
import 'package:app_bamk/presentation/widgets/searchBar.dart' as custom;

class SearchPageForm extends StatefulWidget {
  final List<String>? initialSelectedGenres;
  final ContentType contentType;

  const SearchPageForm({
    super.key,
    this.initialSelectedGenres,
    required this.contentType,
  });

  @override
  State<SearchPageForm> createState() => _SearchPageFormState();
}

class _SearchPageFormState extends State<SearchPageForm> {
  List<Object> allItems = [];
  String searchText = '';
  bool isLoading = true;
  String? error;

  List<String> selectedGenres = [];
  List<String> allGenres = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedGenres != null) {
      selectedGenres = List.from(widget.initialSelectedGenres!);
    }
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final movies = await MovieService.fetchMovies();
      final games = await GameService.fetchGames();
      final music = await MusicService.fetchMusic();

      movies.sort((a, b) => b.published.compareTo(a.published));
      games.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
      music.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));

      final genreSet = <String>{};
      List<Object> filteredItems;

      switch (widget.contentType) {
        case ContentType.movie:
          filteredItems = movies;
          genreSet.addAll(movies.expand((m) => m.genre));
          break;
        case ContentType.game:
          filteredItems = games;
          genreSet.addAll(games.expand((g) => g.genre));
          break;
        case ContentType.music:
          filteredItems = music;
          genreSet.addAll(music.expand((m) => m.genre));
          break;
      }

      setState(() {
        allItems = filteredItems;
        allGenres = genreSet.toList()..sort();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Fehler beim Laden der Inhalte: $e';
        isLoading = false;
      });
    }
  }

  List<Object> get filteredItems {
    final search = searchText.toLowerCase();

    return allItems.where((item) {
      late final String name;
      late final List<String> genres;

      if (item is MovieEntity) {
        name = item.name;
        genres = item.genre;
      } else if (item is GameEntity || item is MusicEntity) {
        name = (item as dynamic).title;
        genres = (item as dynamic).genre;
      } else {
        return false;
      }

      final words = name.toLowerCase().split(RegExp(r'[\s,.\-_:;!?]+'));
      final matchesSearch =
          search.isEmpty || words.any((w) => w.startsWith(search));
      final matchesGenre =
          selectedGenres.isEmpty || genres.any(selectedGenres.contains);

      return matchesSearch && matchesGenre;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          custom.SearchBar(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: allGenres.map((genre) {
                final isSelected = selectedGenres.contains(genre);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(
                      genre,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    selectedColor: Colors.blueAccent,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGenres.add(genre);
                        } else {
                          selectedGenres.remove(genre);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          if (isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (error != null)
            Expanded(child: Center(child: Text(error!)))
          else
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text("Keine Inhalte gefunden"))
                  : GridView.builder(
                      itemCount: filteredItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 3,
                      ),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final title = (item is MovieEntity)
                            ? item.name
                            : (item as dynamic).title;
                        final image = (item as dynamic).coverImage;

                        return InkWell(
                          onTap: () async {
                            String? selectedGenre;

                            if (item is MovieEntity) {
                              selectedGenre = await Navigator.push<String?>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FilmPage(movie: item),
                                ),
                              );
                            } else if (item is GameEntity) {
                              selectedGenre = await Navigator.push<String?>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GamePage(game: item),
                                ),
                              );
                            } else if (item is MusicEntity) {
                              selectedGenre = await Navigator.push<String?>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MusicPage(music: item),
                                ),
                              );
                            }

                            if (selectedGenre != null && mounted) {
                              setState(() {
                                if (!selectedGenres.contains(selectedGenre)) {
                                  selectedGenres = [
                                    selectedGenre!
                                  ]; // Nur dieses Genre auswählen
                                }
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Card(
                            color: const Color(0xff1a1a1a),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(
                                      image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
        ],
      ),
    );
  }
}
