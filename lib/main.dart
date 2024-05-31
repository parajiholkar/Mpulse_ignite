import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mpulse_ignite/RegisterNowPage.dart';
import 'package:mpulse_ignite/RegisteredStudentPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                width: 150,
                height: 150,
                child: Image.asset('assets/ignite_logo.png'),
              ),
              SizedBox(
                height: 15,
              ),
              Text('P.E.S Modern College Of Engineering, Pune',style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
              SizedBox(
                height: 10,
              ),
              Text('Department Of Information Technology Presents',style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
              SizedBox(
                height: 15,
              ),
              Text('MPULSE IGNITE 2024', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterNowPage()));
                },
                child: Text('REGISTER NOW'),
                style: ElevatedButton.styleFrom(
                    primary: Color.alphaBlend(
                        Colors.blue.shade900, Colors.blue.shade500),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
              SizedBox(
                height: 13,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisteredStudentPage()));
                },
                child: Text('REGISTERED STUDENT'),
                style: ElevatedButton.styleFrom(
                    primary: Color.alphaBlend(
                        Colors.blue.shade900, Colors.blue.shade500),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
