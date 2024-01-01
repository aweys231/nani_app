import 'package:flutter/material.dart';
class WorksheetHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Divider(thickness: 2.0, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('DAYS')),
                Expanded(child: Text('DATE')),
                Expanded(child: Text('TIME_S')),
                Expanded(child: Text('TIME_F')),
                Expanded(child: Text('BREAK')),
                Expanded(child: Text('HOURS')),
              ],
            ),
            Divider(thickness: 2.0, color: Colors.grey),
            // Displaying days of the week under the "DAYS" header
            buildDayRow('Mon'),
            buildDayRow('Tues'),
            buildDayRow('Wed'),
            buildDayRow('Thurs'),
            buildDayRow('Fri'),
            buildDayRow('Sat'),
            buildDayRow('Sun'),
            Divider(thickness: 2.0, color: Colors.grey),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildFormFieldWithLine("Signature:"),
                    Text("_________________"),
                    SizedBox(width: 5),
                    _buildFormFieldWithLine("Date:"),
                    Text("_____________"),
                  ],
                ),
                Row(
                  children: [
                    _buildFormFieldWithLine("Print Name:"),
                    Text("_____________________________________"),
                    SizedBox(width: 5),
                  ],
                ),
                Row(
                  children: [
                    _buildFormFieldWithLine("Position:"),
                    Text("_____________________________________"),
                    SizedBox(width: 5),
                  ],
                ),
                Row(
                  children: [
                    _buildFormFieldWithLine("Department:"),
                    Text("_____________________________________"),
                    // Divider(thickness: 2.0, color: Colors.grey),
                    SizedBox(width: 5),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDayRow(String day) {
    return Row(
      children: [
        Expanded(child: Text(day)),
        Container(
          width: 1.0,
          height: 40,
          color: Colors.red,
        ),
        Expanded(child: Text('DATE')),
        Container(
          width: 1.0,
          height: 40,
          color: Colors.red,
        ), // Add other widgets for date, time_s, time_f, break, hours as needed
        Expanded(child: Text('TIME_S')),
        Container(
          width: 1.0,
          height: 40,
          color: Colors.red,
        ),
        Expanded(child: Text('TIME_F')),
        Container(
          width: 1.0,
          height: 40,
          color: Colors.red,
        ),
        Expanded(child: Text('BREAK')),
        Container(
          width: 1.0,
          height: 40,
          color: Colors.red,
        ),
        Expanded(child: Text('HOURS')),
      ],
    );
  }

  //
  Widget _buildFormField(String labelText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        SizedBox(height: 16), // Adjust the spacing between fields
      ],
    );
  }

  Widget _buildFormFieldWithLine(String labelText) {
    return Row(
      children: [
        SizedBox(width: 5),
        _buildFormField(labelText),
      ],
    );
  }
}
