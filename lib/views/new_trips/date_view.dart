import 'dart:async';

// import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app_my_version/models/Trip.dart';

import 'budget_view.dart';

class NewTripDateView extends StatefulWidget {
  final Trip trip;

  const NewTripDateView({Key? key, required this.trip}) : super(key: key);

  @override
  State<NewTripDateView> createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
  late DateTime date;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 7)),
  );

  Future displayDateRangePicker(BuildContext context) async {
    // final List<DateTime> picked = await DateRagePicker.showDatePicker(
    //     context: context,
    //     initialFirstDate: _startDate,
    //     initialLastDate: _endDate,
    //     firstDate: DateTime(DateTime.now().year - 50),
    //     lastDate: DateTime(DateTime.now().year + 50));
    //once date picked
    // if (picked != null && picked.length == 2) {
    //   setState(() {
    //     _startDate = picked[0];
    //     _endDate = picked[1];
    //   });
    // }

    // final List<DateTime> newDate = await showDatePicker(
    //     context: context,
    //     //     initialLastDate: _endDate,
    //     firstDate: DateTime(DateTime.now().year - 50),
    //     lastDate: DateTime(DateTime.now().year + 50),
    //     initialDate: _startDate);
    // if (newDate == null) return;
    // setState(() => date = newDate);
    // setState(() {
    //   _startDate = newDate[0];
    //   _endDate = newDate[1];
    // });
    /** attempt for the date range**/
    final initialDateRange = DateTimeRange(start: _startDate, end: _endDate);

    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 50),
        initialDateRange: initialDateRange);
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }

  String getFrom() {
    if (dateRange != null) {
      return DateFormat('dd/MM/yyyy').format(dateRange.start);
    } else {
      return "from";
    }
  }

  String getUntil() {
    if (dateRange != null) {
      return DateFormat('dd/MM/yyyy').format(dateRange.end);
    } else {
      return "from";
    }
  }

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
              Text("Location ${widget.trip.title}"),
              ElevatedButton(
                onPressed: () async {
                  await displayDateRangePicker(context);
                },
                child: Text("Select date"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(getFrom()),
                  Text(getUntil()),
                ],
              ),
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  widget.trip.startDate = dateRange.start;
                  widget.trip.endDate = dateRange.end;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewTripBudgetView(trip: widget.trip)),
                  );
                },
              )
            ],
          ),
        ));
  }
}
