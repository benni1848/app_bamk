import 'package:flutter/material.dart';

class ContainerProfilePicture extends StatefulWidget {
  const ContainerProfilePicture({super.key});

  @override
  State<ContainerProfilePicture> createState() =>
      _ContainerProfilePictureState();
}

class _ContainerProfilePictureState extends State<ContainerProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      width: double.infinity,
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          // Area for ProfilePicture
          Padding(
            padding: const EdgeInsets.all(25),
            child: ClipOval(
              child: Image.network(
                "https://www.nachrichten.at/storage/image/2/6/2/4/904262_artikeldetail-1x1_1Au4nU_G0rQkE.jpg",
                width: 100,
                height: 100,
              ),
            ),
          ),

          // Area for Username & ID
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Max Mustermann - 001",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
