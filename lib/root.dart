import 'package:app_bamk/presentation/dashboard_page/dashboard_page.dart';
import 'package:app_bamk/presentation/search_page/search_page.dart';
import 'package:app_bamk/presentation/userProfile_page/userProfile_page.dart';
import 'package:flutter/material.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Ansichten speichern
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardPage(),
          SearchPage(),
          UserProfile()
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        // Ändern des aktuellen Indexes beim klicken auf ein Icon
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff1a1a1a),
        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ]),
      
    );
  }
}
