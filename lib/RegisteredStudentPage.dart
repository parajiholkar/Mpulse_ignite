import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mpulse_ignite/studentInfoPage.dart';

class RegisteredStudentPage extends StatefulWidget {
  const RegisteredStudentPage({super.key});

  @override
  State<RegisteredStudentPage> createState() => _RegisteredStudentPageState();
}

class _RegisteredStudentPageState extends State<RegisteredStudentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Registered Students',
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
        body: Container(
          margin: EdgeInsets.only(top: 5, bottom: 10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('igniteRegistrations')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error${snapshot.error}"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.data!.size == 0) {
                return Center(child: Text('Registertion not Present'));
              }

              if (snapshot.hasData && snapshot.data != null) {
                return ListView(
                  children: snapshot.data!.docs
                      .map<Widget>((doc) => buildRegistrationItem(doc))
                      .toList(),
                );
              } else {
                return Center(child: Text('Registertion not Present'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildRegistrationItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic> ;
    DocumentReference reference = document.reference ;

    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => studentInfoPage(data: data,)));
        },
        title: Text('${data['firstName']} ${data['lastName']}'),
        subtitle: Text('Payment ID :${data['payment ID']},  Event Name :${data['eventName']}'),
      ),
    );
  }
}
