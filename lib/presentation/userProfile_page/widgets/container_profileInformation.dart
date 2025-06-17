import 'package:flutter/material.dart';

class ContainerProfileInformation extends StatefulWidget {
  const ContainerProfileInformation({super.key});

  @override
  State<ContainerProfileInformation> createState() =>
      _ContainerProfileInformationState();
}

class _ContainerProfileInformationState
    extends State<ContainerProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Area for Heading
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Meine Kommentare",
              style: TextStyle(
                color: Color(0xFF80B5E9),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Container for Comment 1
          Container(
            margin: const EdgeInsets.all(12),
            width: 350,
            height: 100,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              color: Color(0xFF80B5E9),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/film.jpg",
                  width: 80,
                  height: 100,
                  alignment: Alignment.centerLeft,
                ),
                const Expanded(
                  child: Text(
                    "Guter Film!",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          // Container for Comment 2
          Container(
            margin: const EdgeInsets.all(12),
            width: 350,
            height: 100,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              color: Color(0xFF80B5E9),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/film.jpg",
                  width: 80,
                  height: 100,
                  alignment: Alignment.centerLeft,
                ),
                const Expanded(
                  child: Text(
                    "Empfehlenswert!",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
