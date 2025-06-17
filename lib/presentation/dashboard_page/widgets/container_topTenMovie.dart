import 'package:flutter/material.dart';

class ContainerTopTenMovie extends StatefulWidget {
  const ContainerTopTenMovie({super.key});

  @override
  State<ContainerTopTenMovie> createState() => _ContainerTopTenMovieState();
}

class _ContainerTopTenMovieState extends State<ContainerTopTenMovie> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12, top: 0),
          child: Text(
            "Top 10 Filme",
            style: TextStyle(
              color: Color(0xFF80B5E9),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          width: 400,
          height: 300,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
          ),
          child: GridView.count(
            scrollDirection: Axis.horizontal, // Activate horizontal scroll
            crossAxisCount: 2,  // Create 2 rows
            padding: const EdgeInsets.all(15),
            children: List.generate(
              10, // generate 10 items
              (index) {
                return Column(
                  children: [
                    Image.asset(  // Insert MovieCover
                      "assets/film.jpg",
                      height: 110,
                    ),
                    Text(
                      "${index + 1}.",  // Insert current Index
                      style: const TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
