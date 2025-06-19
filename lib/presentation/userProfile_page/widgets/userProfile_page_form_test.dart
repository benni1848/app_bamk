import 'package:flutter/material.dart';
import 'package:app_bamk/api/services/user_service.dart';
import 'package:app_bamk/api/model/user_model.dart';
import 'package:app_bamk/domain/entities/user_entity.dart';
import 'package:app_bamk/api/services/comment_service.dart';
import 'package:app_bamk/api/model/comment_model.dart';
import 'package:app_bamk/domain/entities/comment_entity.dart';

class UserProfileFormTest extends StatefulWidget {
  const UserProfileFormTest({super.key});

  @override
  State<UserProfileFormTest> createState() => _UserProfileFormTestState();
}

class _UserProfileFormTestState extends State<UserProfileFormTest> {
  //late Future<UserEntity> _futureUser;
  //late Future<CommentEntity> _futureComment;
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    // Wait for both Services
    _futureData = Future.wait([
      UserService.fetchUserByUsername('Bamker'),
      CommentService.fetchCommentByUsername('Bamker'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Fehler: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Keine Daten gefunden'));
        }

        final user = snapshot.data![0] as UserEntity;
        final comments = snapshot.data![1] as List<CommentEntity>;

        return Column(
          children: [
            //* Container for "Benutzerprofil"
            Container(
              height: 225,
              width: double.infinity,
              color: const Color(0xFF1a1a1a),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Heading - Benutzerprofil
                  Text('Benutzerprofil',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF80B5E9),
                        fontWeight: FontWeight.bold,
                      )),
                  // Area for ProfilePicture
                  Padding(
                    padding: const EdgeInsets.all(17),
                    child: ClipOval(
                      child: Image.network(
                        user.profilePicture,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Area for Username
                  Text('${user.username} - ${user.id}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 15),
                ],
              ),
            ),

            //* Container for "Meine Kommentare"
            Container(
              height: 460,
              width: double.infinity,
              color: const Color(0xFF1a1a1a),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Meine Kommentare',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF80B5E9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFF80B5E9),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Comments - left
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comment.title,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  comment.inhalt,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  "Bewertung: ${comment.rating} von 10",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // ProfilePicture - right
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          child: ClipOval(
                                            child: Image.network(
                                              user.profilePicture,
                                              width: 75,
                                              height: 75,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ], // End of Children
        );
      }, // End of Builder
    );
  }
}
