import 'package:flutter/material.dart';
import 'package:travel_app_my_version/explore_view.dart';
import 'package:travel_app_my_version/past_trips_view.dart';
import 'package:travel_app_my_version/services/auth_service.dart';
import 'package:travel_app_my_version/views/home_view.dart';
import 'package:travel_app_my_version/views/new_trips/location_view.dart';
import 'package:travel_app_my_version/widgets/provider_widget.dart';

import 'models/Trip.dart';

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
    final newTrip = Trip("", DateTime.now(), DateTime.now(), 200, "car");
    return Scaffold(
      appBar: AppBar(
        title: const Text("travel Budget app"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewTripLocationView(trip: newTrip)));
            },
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out!");
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
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
