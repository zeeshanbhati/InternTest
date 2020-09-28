import 'package:flutter/material.dart';
import 'package:intern_test/PaymentScreen.dart';
import 'package:intern_test/carModule.dart';
import 'package:intern_test/paymentModule.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.id,
      routes: <String,WidgetBuilder>{
        CarModule.id:(BuildContext context)=>CarModule(),
        PaymentModule.id:(BuildContext context)=>PaymentModule(),
        PaymentScreen.id:(BuildContext context)=>PaymentScreen(),
      },

      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  static final String id = "Homescreen.dart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(child: Text("Car Module"),onPressed: (){
              Navigator.pushNamed(context, CarModule.id);
            },),
            SizedBox(height: 50,),
            RaisedButton(child: Text("Payment Module"),onPressed: (){
              Navigator.pushNamed(context, PaymentModule.id);
            },),
          ],
        ),
      ),

    );
  }
}



