import 'package:flutter/material.dart';

class MyBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF545151), // Set background color to match MenuPage
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Center(
            child: Text(
              'My Bookings',
              style: TextStyle(
                color: Color.fromRGBO(107, 151, 151, 1),
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: MediaQuery.of(context).size.height * 0.3, // Adjusted container height
            width: MediaQuery.of(context).size.width * 0.8, // Adjusted container width
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              children: [
                BookingItem(
                  slotNumber: 'Slot 01',
                  customerName: 'John Doe',
                  date: '2024-05-01',
                  startTime: '10:00 AM',
                  durationHours: '2',
                  durationMinutes: '30',
                ),
                // Add more BookingItem widgets as needed
              ],
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
            child: Text(
              'Back',
              style: TextStyle(color: Colors.white), // Change button text color to white
            ),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              minimumSize: Size(120, 50), // Adjusted back button width
              backgroundColor: Color.fromRGBO(255, 191, 0, 1), // Set button color to yellow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0), // Decrease border radius
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingItem extends StatelessWidget {
  final String slotNumber;
  final String customerName;
  final String date;
  final String startTime;
  final String durationHours;
  final String durationMinutes;

  const BookingItem({
    Key? key,
    required this.slotNumber,
    required this.customerName,
    required this.date,
    required this.startTime,
    required this.durationHours,
    required this.durationMinutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(107, 151, 151, 1).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Slot Number: $slotNumber',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(107, 151, 151, 1),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Customer Name: $customerName',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(107, 151, 151, 1),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Date: $date',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(107, 151, 151, 1),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Start Time: $startTime',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(107, 151, 151, 1),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Duration: $durationHours hour${durationHours != '1' ? 's' : ''} $durationMinutes minute${durationMinutes != '1' ? 's' : ''}',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(107, 151, 151, 1),
            ),
          ),
        ],
      ),
    );
  }
}
