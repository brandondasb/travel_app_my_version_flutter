import 'package:flutter/material.dart';
import 'package:travel_app_my_version/models/Trip.dart';

import 'budget_view.dart';

class NewTripDateView extends StatelessWidget {
  final Trip trip;

  const NewTripDateView({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Trip - Date'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Location ${trip.title}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Text("Enter a start date"),
                  Text("Enter a End date"),
                ],
              ),
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  trip.startDate = DateTime.now();
                  trip.endDate = DateTime.now();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTripBudgetView(trip: trip)),
                  );
                },
              )
            ],
          ),
        ));
  }
}
