import 'package:flutter/material.dart';

class ContainerTopTenMusic extends StatelessWidget {
  const ContainerTopTenMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            "Top 10 Musik",
            style: TextStyle(
              color: Color(0xFF80B5E9),
              fontSize: 20,
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
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            padding: const EdgeInsets.all(15),
            children: List.generate(
              10,
              (index) {
                return Column(
                  children: [
                    Image.asset(
                      "assets/film.jpg",
                      height: 110,
                    ),
                    Text(
                      "${index + 1}.",
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