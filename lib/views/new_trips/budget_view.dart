import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_my_version/models/Trip.dart';

class NewTripBudgetView extends StatelessWidget {
  final Trip trip;
  FirebaseFirestore db = FirebaseFirestore.instance;

  NewTripBudgetView({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    _titleController.text = trip.title;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Trip - Budget'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Location ${trip.title}"),
              Text(
                  "Start Date ${DateFormat('dd/MM/yyyy').format(trip.startDate)}"),
              Text("End Date ${DateFormat('dd/MM/yyyy').format(trip.endDate)}"),
              ElevatedButton(
                child: const Text("Finish"),
                onPressed: () async {
                  // save to firebase
                  await db.collection("trips").add(trip.toJson());

                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
        ));
  }
}
