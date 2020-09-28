import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intern_test/paymentModule.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  static final String id = "PaymentScreen";
  String dueAmount;
  int accountindex;

  PaymentScreen({this.dueAmount,this.accountindex});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {


  Razorpay _razorpay;
  TextEditingController _textEditingController = new TextEditingController();
  int amount;
  Firestore _firestore = Firestore.instance;
  bool ci=false;

  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_PDjVb3Q3TNjyJo',
      'amount': amount*100,
      'name': 'Zeeshan ',
      'description': 'Intern Test',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response)  async {
    setState(() {
      ci = true;
    });
    await UpdatePayment();
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId,);

  }



  Future<String> getData(int index) async {
    QuerySnapshot querySnapshot = await _firestore.collection("Payments").getDocuments();
   // print(querySnapshot.documents[index].documentID);
    return querySnapshot.documents[index].documentID;

  }


  Future UpdatePayment() async{
     String s = await getData(widget.accountindex);
     print(s);
    await _firestore.runTransaction((transaction)async{
      DocumentReference documentReference = _firestore.collection('Payments')
          .document(s);
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      int oldamount = snapshot.data['duePayment'];
      int  diff = oldamount - amount;

      await transaction.update(documentReference,{
        'duePayment' : diff,

      });

    });

  }


  void _handlePaymentError(PaymentFailureResponse response)   {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ci ? CircularProgressIndicator() : Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Your Due Payment",style: TextStyle(fontSize: 20),),

              SizedBox(height: 20,),

              Text(widget.dueAmount,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Amount to Pay"
                  ),
                  onChanged: (value){
                    amount = int.parse(value);
                  },
                ),
              ),
              RaisedButton(

                child: Text("Pay now"),
                onPressed: (){
                  openCheckout();
                },
              )
            ],
          ),
        )
        )
      );
  }
}
