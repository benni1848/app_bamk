import 'package:flutter/material.dart';
import 'package:app_bamk/presentation/search_page/widgets/search_page_form.dart';

enum ContentType { movie, game, music }

class SearchPage extends StatelessWidget {
  final List<String>? initialSelectedGenres;

  const SearchPage({super.key, this.initialSelectedGenres});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          backgroundColor: const Color(0xff1a1a1a),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/logo_bamk.png', height: 50),
              const Expanded(
                child: Center(
                  child: Text(
                    'Inhalte durchsuchen',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: 'Filme'),
              Tab(text: 'Spiele'),
              Tab(text: 'Musik'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchPageForm(
              initialSelectedGenres: initialSelectedGenres,
              contentType: ContentType.movie,
            ),
            SearchPageForm(
              initialSelectedGenres: initialSelectedGenres,
              contentType: ContentType.game,
            ),
            SearchPageForm(
              initialSelectedGenres: initialSelectedGenres,
              contentType: ContentType.music,
            ),
          ],
        ),
      ),
    );
  }
}
