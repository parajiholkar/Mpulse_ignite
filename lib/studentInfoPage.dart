import 'package:flutter/material.dart';

class studentInfoPage extends StatefulWidget {
  final data ;
  const studentInfoPage({super.key, required this.data});

  @override
  State<studentInfoPage> createState() => _studentInfoPageState();
}

class _studentInfoPageState extends State<studentInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Student Information',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('First Name : ${widget.data['firstName']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('last Name : ${widget.data['lastName']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Email : ${widget.data['email']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Contact Number : ${widget.data['contactNumber']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('College Name : ${widget.data['collegeName']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Department : ${widget.data['department']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Team Member 2 : ${widget.data['teamMember2']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Team Member 3 : ${widget.data['teamMember3']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Team Member 4 : ${widget.data['teamMember4']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Year : ${widget.data['year']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: ListTile(
              title: Text('Event Name : ${widget.data['eventName']}'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: ListTile(
              title: Text('Payment ID : ${widget.data['payment ID']}'),
            ),
          ),
        ],
      ),
    ));
  }
}
