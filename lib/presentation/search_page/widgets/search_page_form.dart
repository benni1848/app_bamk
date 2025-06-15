import 'package:app_bamk/api/services/movie_service.dart';
import 'package:app_bamk/domain/entities/movie_entity.dart';
import 'package:app_bamk/presentation/film_page/film_page.dart';
import 'package:flutter/material.dart';
import 'package:app_bamk/api/model/movie_model.dart';
import 'package:app_bamk/presentation/widgets/searchBar.dart' as custom;

class SearchPageForm extends StatefulWidget {
  final List<String>? initialSelectedGenres;

  const SearchPageForm({super.key, this.initialSelectedGenres});

  @override
  State<SearchPageForm> createState() => _SearchPageFormState();
}

class _SearchPageFormState extends State<SearchPageForm> {
  List<MovieEntity> allMovies = [];
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
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final movies = await MovieService.fetchMovies();

      // Alle Genres aus allen Filmen sammeln, ohne Duplikate
      final genresSet = <String>{};
      for (var movie in movies) {
        genresSet.addAll(movie.genre);
      }

      setState(() {
        allMovies = movies;
        allGenres = genresSet.toList()..sort();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Fehler beim Laden der Filme: $e';
        isLoading = false;
      });
    }
  }

  // Gefilterte Filme anhand von Suchtext und Genre-Auswahl
  List<MovieEntity> get filteredMovies {
    final search = searchText.toLowerCase();

    return allMovies.where((movie) {
      // Filter nach Suchtext am Anfang eines Wortes
      final words = movie.name.toLowerCase().split(RegExp(r'[\s,.\-_:;!?]+'));
      final matchesSearch =
          search.isEmpty || words.any((word) => word.startsWith(search));

      // Filter nach Genre-Auswahl (wenn ausgewählt)
      final matchesGenre = selectedGenres.isEmpty ||
          movie.genre.any((g) => selectedGenres.contains(g));

      return matchesSearch && matchesGenre;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Suchleiste oben
          custom.SearchBar(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
          const SizedBox(height: 10),

          // Genre Multi-Select als Wrap mit Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: allGenres.map((genre) {
                final isSelected = selectedGenres.contains(genre);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(genre,
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black)),
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

          // Flexible Bereich für Grid, um Overflow zu vermeiden
          if (isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (error != null)
            Expanded(
              child: Center(
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),
            )
          else
            Expanded(
              child: filteredMovies.isEmpty
                  ? const Center(
                      child: Text(
                        'Keine Filme gefunden',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : GridView.builder(
                      itemCount: filteredMovies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 3,
                      ),
                      itemBuilder: (context, index) {
                        final film = filteredMovies[index];

                        return InkWell(
                          onTap: () async {
                            final selectedGenre = await Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilmPage(movie: film)),
                            );

                            if (selectedGenre != null &&
                                selectedGenre.isNotEmpty) {
                              setState(() {
                                selectedGenres = [selectedGenre];
                                searchText = '';
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
                                      film.coverImage,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    film.name,
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
                      },
                    ),
            ),
        ],
      ),
    );
  }
}
