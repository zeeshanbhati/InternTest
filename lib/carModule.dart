import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class CarModule extends StatefulWidget {
  static final String id = "CarModule.dart";
 // CarModule({Key key, this.title}) : super(key: key);
  //final String title;
  @override
  _CarModuleState createState() => _CarModuleState();
}

class _CarModuleState extends State<CarModule> {

  Firestore _firestore = Firestore.instance;
  TextEditingController textEditingController = new TextEditingController();
  String newowner;
  bool checker=false;
  bool initialcheker;



  Future<bool> getBooleanforState() async{
    QuerySnapshot querySnapshot = await _firestore.collection("Cars").getDocuments();
    setState(() {
      initialcheker = querySnapshot.documents[0].data["hasOwner"];
    });
  }

  Future getData() async {
    QuerySnapshot querySnapshot = await _firestore.collection("Cars").getDocuments();
    checker = querySnapshot.documents[0].data["hasOwner"];
    return querySnapshot.documents;
  }




  Future updateOwner() async{

    await _firestore.runTransaction((transaction)async{
      DocumentReference documentReference = _firestore.collection('Cars')
          .document("Ferrari");
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      //String newOwnerOfCar = snapshot.data['ownerName'];

      await transaction.update(documentReference,{
        'ownerName' : newowner,
        'hasOwner' : true,
      });

      setState(() {
        getData();
      });
    });

  }



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final querydata=MediaQuery.of(context);
    final screenSize = querydata.size;

    return Scaffold(
      appBar: AppBar(title: Text("Car App"),),
      body: Container(
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                future: getData(),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else{
                    return Container(
                      child: Center(
                        child: Container(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 100,),
                              Text("Car Owner: "+snapshot.data[0].data["ownerName"],style: TextStyle(fontSize: 30),),
                              SizedBox(height: 10,),
                              Text(snapshot.data[0].data["hasOwner"].toString(),style: TextStyle(fontSize: 30),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ) ,
            ),

            Container(
              child:  checker ? Text("You are the Owner"): TextField(
                controller: textEditingController,
                onChanged: (value){
                  newowner = value;
                },
              ),
            ),

            RaisedButton(
              child: Text("Press"),
              onPressed: (){
                if(checker==false){
                  updateOwner();
                  textEditingController.clear();
                  setState(() {
                    checker = true;
                  });
                }
                else{
                  print("Already Owned");
                }

              },
            ),

          ],
        ),
      ),
    );
  }
}