
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intern_test/PaymentScreen.dart';



class PaymentModule extends StatefulWidget {
  static final String id = "PaymentModule.dart";

  @override
  _PaymentModuleState createState() => _PaymentModuleState();
}



class _PaymentModuleState extends State<PaymentModule> {

 Firestore _firestore = Firestore.instance;
  int amount;

  Future<int> getData(int index) async {
    QuerySnapshot querySnapshot = await _firestore.collection("Payments").getDocuments();
    /*This Code is just for problem statement for a single user without registration module Thats why the Hash of the email is hardcoded , With Registration Module The email can be taken
    * dynamically for all the user available in the database */
    print("DOremon");
    print(querySnapshot.documents[index].data["duePayment"]);
   return querySnapshot.documents[index].data["duePayment"];
    
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              RaisedButton(
                child: Text("USER 1"),
                onPressed: () async {
                  int s = await getData(0);
                  print(s);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen(dueAmount: s.toString(),accountindex: 0,)),
                  );

                },
              ),

              SizedBox(height: 100,),

              RaisedButton(
                child: Text("USER 2"),
                onPressed: () async {
                  int s = await getData(1);
                  print(s);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen(dueAmount: s.toString(),accountindex: 1,)),
                  );

                },
              ),

              SizedBox(height: 100,),

              RaisedButton(
                child: Text("USER 3"),
                onPressed: () async {
                  int s = await getData(2);
                  print(s);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen(dueAmount: s.toString(),accountindex: 2,)),
                  );
                },
              ),

              SizedBox(height: 100,),

              Text("Wait for 2-3 sec after pressing button")
            ],
          ),
        ),
      )
    );
  }
}
