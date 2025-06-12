import 'package:app_bamk/data/test_movie.dart';
import 'package:app_bamk/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_bamk/presentation/widgets/searchBar.dart' as custom;

class SearchPageForm extends StatefulWidget {
  const SearchPageForm({super.key});

  @override
  State<SearchPageForm> createState() => _SearchPageFormState();
}

class _SearchPageFormState extends State<SearchPageForm> {
  final List<MovieEntity> filme = testMovie;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        // Suchleiste oben
        custom.SearchBar(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),

        const SizedBox(height: 10),

        // Bereich für den Container
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              itemCount: filme.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (context, index) {
                final film = filme[index];

                return InkWell(
                  onTap: () {
                    //Navigator.pushNamed(context, "/", arguments: film);
                    Navigator.of(context).pushNamed('/search',
                        arguments:
                            film); // Route + Parameter für den Film übergeben
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
                              film.imageUrls.first,
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
        ),
      ]),
    );
  }
}
