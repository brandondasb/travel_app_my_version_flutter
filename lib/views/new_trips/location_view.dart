import 'package:flutter/material.dart';
import 'package:travel_app_my_version/models/Trip.dart';

import 'date_view.dart';

class NewTripLocationView extends StatelessWidget {
  final Trip trip;

  const NewTripLocationView({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    _titleController.text = trip.title;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Trip - Location'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter A Location"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController,
                  autocorrect: true,
                ),
              ),
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  trip.title = _titleController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTripDateView(trip: trip)),
                  );
                },
              )
            ],
          ),
        ));
  }
}
