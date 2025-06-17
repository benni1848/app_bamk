import 'package:flutter/material.dart';
import 'package:app_bamk/api/services/movie_service.dart';
import 'package:app_bamk/api/services/game_service.dart';
import 'package:app_bamk/api/services/music_service.dart';
import 'package:app_bamk/api/services/ticket_service.dart'; //Ticket-Service hinzugefügt

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

  final TextEditingController _userNameController =
      TextEditingController(); //Nutzernamen-Controller hinzugefügt
  final TextEditingController _messageController = TextEditingController();
  bool showTicketForm = false;
  String? successMessage;
  String? errorMessage;

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

  void sendTicket() async {
    final userName = _userNameController.text.trim(); //Nutzername abrufen
    final message = _messageController.text.trim();

    if (userName.isNotEmpty && message.isNotEmpty) {
      try {
        await TicketService.sendTicket(userName, message);
        setState(() {
          successMessage = "Ticket erfolgreich gesendet";
          errorMessage = null;
          showTicketForm = false;
        });
        _userNameController.clear(); //Nutzername-Feld leeren
        _messageController.clear();
      } catch (e) {
        setState(() {
          errorMessage = "Fehler beim Senden des Tickets";
          successMessage = null;
        });
      }
    }
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                showTicketForm = !showTicketForm;
              });
            },
            child: Text(showTicketForm
                ? "Ticket schreiben schließen"
                : "Ticket schreiben"),
          ),
          if (showTicketForm) ...[
            SizedBox(height: 10),
            TextField(
              controller: _userNameController,
              style: TextStyle(
                  color: Colors.white), //Weißer Text auf dunklem Hintergrund
              decoration: InputDecoration(
                labelText: "Benutzername",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _messageController,
              style: TextStyle(
                  color: Colors.white), //Weißer Text auf dunklem Hintergrund
              decoration: InputDecoration(
                labelText: "Ticket-Nachricht",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: sendTicket,
              child: Text("Ticket senden"),
            ),
            SizedBox(height: 10),
            if (successMessage != null)
              Text(successMessage!, style: TextStyle(color: Colors.green)),
            if (errorMessage != null)
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
          ],
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
              child: allItems.isEmpty
                  ? const Center(child: Text("Keine Inhalte gefunden"))
                  : GridView.builder(
                      itemCount: allItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 3,
                      ),
                      itemBuilder: (context, index) {
                        final item = allItems[index];
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
                              children: [
                                Expanded(
                                    child: Image.network(image,
                                        fit: BoxFit.cover)),
                                Text(title,
                                    style: TextStyle(color: Colors.white)),
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
