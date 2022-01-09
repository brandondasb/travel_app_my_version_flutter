import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_my_version/widgets/provider_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersTripsStreamSnapshot(context),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildTripCard(context, snapshot.data.docs[index]));
        },
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    //let u update data once available async* this will get use the data for current user
    yield* FirebaseFirestore.instance
        .collection("userData")
        .doc(uid)
        .collection('trips')
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot trip) {
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
                      trip.get('title'),
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
                        "${DateFormat('dd/MM/yyy').format(trip.get('startDate').toDate())} - ${DateFormat('dd/MM/yyy').format(trip.get('endDate').toDate())}"),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(children: <Widget>[
                  Text(
                    "£${(trip.get('budget')) == null ? "n/a" : trip.get('budget').toStringAsFixed(2)}",
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
