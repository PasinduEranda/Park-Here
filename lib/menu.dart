import 'package:flutter/material.dart';
import 'mybooking.dart'; // Importing MyBookingPage

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF545151), // Set background color to transparent
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF545151), // 25% transparent black
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align content at the top
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    'Parking Slots',
                    style: TextStyle(
                      color: Color.fromRGBO(107, 151, 151, 1),
                      fontSize: 36.0, // Decreased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 2.0,
                    width: 450.0,
                    color: Color(0xFF6B6E6F),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SlotWidget(slotName: 'Slot 01'),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: SlotWidget(slotName: 'Slot 02'),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: SlotWidget(slotName: 'Slot 03'),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SlotWidget(slotName: 'Slot 04'),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: SlotWidget(slotName: 'Slot 05'),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: SlotWidget(slotName: 'Slot 06'),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to MyBookingPage when "My Bookings" button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyBookingPage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0), // Increased vertical padding
                    child: Text(
                      'My Bookings',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFBF00), // Set button color to FFBF00
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // Set button border radius
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlotWidget extends StatelessWidget {
  final String slotName;

  const SlotWidget({Key? key, required this.slotName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0), // Decreased padding
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF6B6E6F),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slotName,
            style: TextStyle(
              fontSize: 20.0, // Decreased font size
              fontWeight: FontWeight.bold,
              color: Colors.white, // Changed color to white
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Availability',
            style: TextStyle(
              fontSize: 15.0, // Decreased font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF4BD469),
            ),
          ),
          SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'asset/logo.png',
              height: 100.0, // Set the desired height
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showSlotBookingDialog(context, slotName);
              },
              child: Text(
                'Book',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFFFFFFFF),
                ), // Decreased font size
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFBF00), // Set button color to FFBF00
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), // Set button border radius
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSlotBookingDialog(BuildContext context, String slotName) async {
  // Controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController durationHourController = TextEditingController();
  TextEditingController durationMinuteController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  List<int> hourOptions = List.generate(24, (index) => index);
  List<int> minuteOptions = [10, 20, 30, 40, 50];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Booking for $slotName'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Booking Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != DateTime.now()) {
                    dateController.text = pickedDate.toString().substring(0, 10);
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      hintText: 'Select booking date',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Time:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (pickedTime != null) {
                    selectedTime = pickedTime;
                    String formattedTime = pickedTime.format(context);
                    timeController.text = formattedTime;
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: timeController,
                    decoration: InputDecoration(
                      hintText: 'Select booking time',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Duration:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        hintText: 'Hour',
                      ),
                      value: null,
                      items: hourOptions.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value hour${value != 1 ? 's' : ''}'),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        if (value != null) {
                          durationHourController.text = value.toString();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        hintText: 'Minute',
                      ),
                      value: null,
                      items: minuteOptions.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value minute${value != 1 ? 's' : ''}'),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        if (value != null) {
                          durationMinuteController.text = value.toString();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement submit functionality here
                      String name = nameController.text;
                      String date = dateController.text;
                      String time = timeController.text;
                      String durationHours = durationHourController.text;
                      String durationMinutes = durationMinuteController.text;

                      // Perform validation and save the booking details
                      // Then close the dialog
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white, // Set button text color to white
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Set background color to green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Decrease border radius
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey, // Set text color to grey
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Decrease border radius
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

}