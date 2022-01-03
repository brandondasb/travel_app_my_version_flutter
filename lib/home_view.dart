import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/Trip.dart';

class HomeView extends StatelessWidget {
  final List<Trip> tripList = [
    Trip("Goma", DateTime.now(), DateTime.now(), 200, "car"),
    Trip("Lagos", DateTime.now(), DateTime.now(), 200, "car"),
    Trip("Accra", DateTime.now(), DateTime.now(), 200, "car"),
    Trip("Kinshasa", DateTime.now(), DateTime.now(), 200, "car")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildTripCard(context, index),
      ),
    );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final trip = tripList[index];
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(
                  children: [
                    Text(
                      trip.title,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(
                  children: [
                    Text(
                        "${DateFormat('dd/MM/yyy').format(trip.startDate)} - ${DateFormat('dd/MM/yyy').format(trip.endDate)}"),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(
                    "£${trip.budget.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 35),
                  ),
                  const Spacer(),
                  const Icon(Icons.directions_car)
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
