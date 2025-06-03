import 'package:flutter/material.dart';

class SearchPageForm extends StatefulWidget {
  const SearchPageForm({super.key});

  @override
  State<SearchPageForm> createState() => _SearchPageFormState();
}

class _SearchPageFormState extends State<SearchPageForm> {
  // Beispieldaten zum testen
  final List<Map<String, dynamic>> filme = [
    {
      'titel': 'Kevin alleine zuhause',
      'bildUrl':
          'https://m.media-amazon.com/images/I/91Ces1-cQLL._AC_UF894,1000_QL80_.jpg',
      'bewertung': 8.8,
    },
    {
      'titel': 'Kevin alleine in der HSHL',
      'bildUrl':
          'https://m.media-amazon.com/images/I/91067nB8SXL._AC_UF894,1000_QL80_.jpg',
      'bewertung': 4.6,
    },
    {
      'titel': 'Levin in einer weitentfernen Galaxie',
      'bildUrl': 'https://lumiere-a.akamaihd.net/v1/images/image_1c5cb625.jpeg',
      'bewertung': 9.9,
    },
    {
      'titel': 'Levin in einer weitentfernen Galaxie',
      'bildUrl': 'https://lumiere-a.akamaihd.net/v1/images/image_1c5cb625.jpeg',
      'bewertung': 9.9,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        itemCount: filme.length, // Number of content
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 Columns
          crossAxisSpacing: 10, // horizontal space between Cells
          mainAxisSpacing: 10, // vertical space between Cells
          childAspectRatio: 2 / 3, // Relationship between width and height
        ),

        itemBuilder: (context, index) {
          final film = filme[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    // Border for Content
                    color: Color(0xFF000000),
                    blurRadius: 2,
                    offset: Offset(3, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRect(
                    child: Image.network(film['bildUrl']),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    film['titel'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
