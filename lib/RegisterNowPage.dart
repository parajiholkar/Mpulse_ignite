import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class RegisterNowPage extends StatefulWidget {
  const RegisterNowPage({super.key});

  @override
  State<RegisterNowPage> createState() => _RegisterNowPageState();
}

class _RegisterNowPageState extends State<RegisterNowPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  final collegeNameController = TextEditingController();
  final departmentController = TextEditingController();
  final teamMember2Controller = TextEditingController();
  final teamMember3Controller = TextEditingController();
  final teamMember4Controller = TextEditingController();
  String? year;
  String? eventName;
  final paymentIDController = TextEditingController();
  bool isProcessing = false ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Event Registration',
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
        body: (isProcessing)? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 25,right: 25,top: 20,bottom: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'First Name',
                  ),
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Last Name',
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  controller: contactNumberController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Contact number',
                  ),
                ),
                TextFormField(
                  controller: collegeNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'College Name',
                  ),
                ),
                TextFormField(
                  controller: departmentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Department',
                  ),
                ),
                DropdownButton<String>(
                  value: year,
                  isExpanded: true,
                  underline: Container(
                    width: 0,
                    height: 0,
                  ),
                  hint: Text('Select Year'),
                  onChanged: (String? newValue) {
                    setState(() {
                      year = newValue!;
                    });
                  },
                  items: <String>['1st', '2nd', '3rd', '4th']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: eventName,
                  isExpanded: true,
                  underline: Container(
                    width: 0,
                    height: 0,
                  ),
                  hint: Text('Select Event Name'),
                  onChanged: (String? newValue) {
                    setState(() {
                      eventName = newValue!;
                    });
                  },
                  items: <String>[
                    'Algo Mania',
                    'DesignX 2.0',
                    'Hackathon',
                    'Mock Placement',
                    'Binary Breakout'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TeamMemberWidget(),
                TextFormField(
                  controller: paymentIDController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Payment ID',
                  ),
                ),
                SizedBox(height: 10,),
                UpiQRWidget(),
                SizedBox(height: 25,),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isProcessing = true ;
                      });
                      bool internetConnection = await InternetConnectionChecker().hasConnection;
                      if(!internetConnection){
                        showAlertDialogBox();
                        setState(() {
                          isProcessing = false ;
                        });
                        return ;
                      }
                      if (firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          contactNumberController.text.isNotEmpty &&
                          collegeNameController.text.isNotEmpty &&
                          departmentController.text.isNotEmpty &&
                          paymentIDController.text.isNotEmpty &&
                          year != null &&
                          year!.isNotEmpty &&
                          eventName != null &&
                          eventName!.isNotEmpty) {

                        try{
                          await FirebaseFirestore.instance
                              .collection('igniteRegistrations')
                              .add({
                            'firstName': firstNameController.text,
                            'lastName': lastNameController.text,
                            'email': emailController.text,
                            'contactNumber': contactNumberController.text,
                            'collegeName': collegeNameController.text,
                            'department': departmentController.text,
                            'teamMember2': teamMember2Controller.text.toString(),
                            'teamMember3': teamMember3Controller.text.toString(),
                            'teamMember4': teamMember4Controller.text.toString(),
                            'year': year,
                            'eventName': eventName,
                            'payment ID': paymentIDController.text,
                            'timestamp': Timestamp.now(),
                          });
                          registreationsuccessDialogBox();
                          firstNameController.clear() ;
                          lastNameController.clear() ;
                          emailController.clear() ;
                          contactNumberController.clear();
                          collegeNameController.clear() ;
                          departmentController.clear() ;
                          paymentIDController.clear() ;
                        }catch(e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error ${e.toString()}',style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: Colors.red,));
                        }

                        setState(() {
                          isProcessing = false ;
                        });
                      }
                      else{
                        setState(() {
                          isProcessing = false ;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Fill All the Information")));
                      }
                      setState(() {
                        isProcessing = false ;
                      });
                    },
                    child: Text('SUBMIT', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                        primary: Color.alphaBlend(
                            Colors.blue.shade900, Colors.blue.shade500),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget UpiQRWidget(){

    if(eventName == null){
      return Center();
    }

    if(eventName != null && eventName == 'Algo Mania'){
      return Column(
        children: [
          Text('Please pay Rs. 30 for Algo Mania on below QR'),
          SizedBox(height: 5,),
          Container(width: MediaQuery.of(context).size.width/1.5,child: Image.asset('assets/30.png'),),
        ],
      ) ;
    }
    else if(eventName != null && eventName == 'DesignX 2.0'){
      return Column(
        children: [
          Text('Please pay Rs. 30 for DesignX 2.0 on below QR'),
          SizedBox(height: 5,),
          Container(width: MediaQuery.of(context).size.width/1.5,child: Image.asset('assets/30.png'),),
        ],
      ) ;
    }
    else if(eventName != null && eventName == 'Hackathon'){
      return Column(
        children: [
          Text('Please pay Rs. 50 for Hackathon on below QR'),
          SizedBox(height: 5,),
          Container(width: MediaQuery.of(context).size.width/1.5,child: Image.asset('assets/QR.png'),),
        ],
      ) ;
    }
    else if(eventName != null && eventName == 'Binary Breakout'){
      return Column(
        children: [
          Text('Please pay Rs. 30 for Binary Breakout on below QR'),
          SizedBox(height: 5,),
          Container(width: MediaQuery.of(context).size.width/1.5,child: Image.asset('assets/30.png'),),
        ],
      ) ;
    }
    else if(eventName != null && eventName == 'Mock Placement') {
      return Column(
        children: [
          Text('Please pay Rs. 30 for Mock Placement on below QR'),
          SizedBox(height: 5,),
          Container(width: MediaQuery.of(context).size.width/1.5,child: Image.asset('assets/30.png'),),
        ],
      ) ;
    }
    else {
      return Center();
    }

  }

  Widget TeamMemberWidget(){

    if(eventName == null){
      return Center();
    }

    if(eventName != null && eventName == 'Algo Mania'){
      return algomania() ;
    }
    else if(eventName != null && eventName == 'DesignX 2.0'){
      return desinX() ;
    }
    else if(eventName != null && eventName == 'Hackathon'){
      return hackathonOrBinary() ;
    }
    else if(eventName != null && eventName == 'Binary Breakout'){
      return hackathonOrBinary() ;
    }
    else {
      return Center();
    }

  }

  Widget desinX(){
    return Column(
      children: [
        TextFormField(
          controller: teamMember2Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Team Member 2',
          ),
        ),
        TextFormField(
          controller: teamMember3Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Team Member 3',
          ),
        ),
      ],
    );
  }

  Widget algomania(){
    return Column(
      children: [
        TextFormField(
          controller: teamMember2Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Team Member 2',
          ),
        ),
      ],
    );
  }
  Widget hackathonOrBinary(){
    return Column(
      children: [
        TextFormField(
          controller: teamMember2Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Team Member 2',
          ),
        ),
        TextFormField(
          controller: teamMember3Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Team Member 3',
          ),
        ),
        TextFormField(
          controller: teamMember4Controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Team Member 4',
          ),
        ),
      ],
    );
  }

  void registreationsuccessDialogBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:
          Text('✨🎉Registration Completed',style: TextStyle(),),
          content: Text(
            'Congratulations! Your registration is completed.',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, 'cancel');
                },
                child: const Text('OK'))
          ],
        ));
  }

  void showAlertDialogBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(Icons.signal_wifi_connected_no_internet_4_outlined),
          title:
          Text('No Internet Connection', textAlign: TextAlign.center,style: TextStyle(),),
          content: Text(
            'Please Check Your Internet Connectivity',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, 'cancel');
                },
                child: const Text('OK'))
          ],
        ));
  }

}
