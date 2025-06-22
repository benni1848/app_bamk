import 'package:app_bamk/api/services/auth_service.dart';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app_bamk/api/services/user_service.dart';
import 'package:app_bamk/domain/entities/user_entity.dart';
import 'package:app_bamk/api/services/comment_service.dart';
import 'package:app_bamk/domain/entities/comment_entity.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({super.key});

  @override
  State<UserProfileForm> createState() => _UserProfileFormTestState();
}

class _UserProfileFormTestState extends State<UserProfileForm> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    final username = Provider.of<UserProvider>(context, listen: false).username;

    if (username != null) {
      _futureData = Future.wait([
        UserService.fetchUserByUsername(username),
        CommentService.fetchCommentByUsername(username),
      ]);
    } else {
      _futureData = Future.error("Kein Benutzer eingeloggt");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          Future.microtask(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          });
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Keine Daten gefunden'));
        }

        final user = snapshot.data![0] as UserEntity;
        final comments = snapshot.data![1] as List<CommentEntity>;

        return ListView(
          children: [
            // Container - UserProfile
            Container(
              height: 225,
              width: double.infinity,
              color: const Color(0xFF1a1a1a),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // UserProfile - Heading
                  const Text(
                    'Benutzerprofil',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF80B5E9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    // ProfilePicture
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
                  // Username & UserID
                  Text(
                    '${user.username} - ${user.id}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),

            // Container - Comments
            Container(
              height: 390,
              width: double.infinity,
              color: const Color(0xFF1a1a1a),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // Comments - Heading
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
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF80B5E9),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white54,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Comment - Title
                                            Text(
                                              comment.title,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            // Comment - Content
                                            Text(
                                              comment.inhalt,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            // Comment - Rating
                                            Text(
                                              "Bewertung: ${comment.rating} von 10",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Comment - ProfilePicture
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Function - Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color(0xFFE97F80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final authService = AuthService();
                  await authService.logout();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
