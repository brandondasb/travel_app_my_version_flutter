import 'package:flutter/material.dart';
import 'package:travel_app_my_version/explore_view.dart';
import 'package:travel_app_my_version/home_view.dart';
import 'package:travel_app_my_version/past_trips_view.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomeView(), ExploreView(), PastTripsView()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("travel Budget app"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabbedTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Past trips"),
        ],
      ),
    );
  }

  void onTabbedTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
