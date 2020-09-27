// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:madicate/Screen/SongPlayer.dart';
// class MusicList extends StatefulWidget {
//   @override
//   static String id='testing';
//   final String path;
//   final String Scrtitle;
//
//   MusicList(this.path,this.Scrtitle);
//
//   _MusicListState createState() => _MusicListState();
// }
//
// class _MusicListState extends State<MusicList> {
//
//   Future getdata() async{
//     QuerySnapshot qn= await Firestore.instance.collection(widget.path).getDocuments();
//       return qn.documents;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final querydata=MediaQuery.of(context);
//     final screenSize = querydata.size;
//
//     return FutureBuilder(
//       future: getdata(),
//       builder: (context,snapshot){
//         if(snapshot.connectionState==ConnectionState.waiting){
//           return Center(child: CircularProgressIndicator()
//           );
//         }
//         else{
//           return Scaffold(
//             backgroundColor: Colors.blue[200],
//             appBar: AppBar(
//               title: Text(widget.Scrtitle),
//             ),
//             body: Container(
//               child: Column(
//                 children: [
//                   SizedBox(height: 100,),
//                   Container(
//                     height: screenSize.height/2,
//                     color: Colors.blue[200],
//                     child: Scaffold(
//                       backgroundColor: Colors.blue[200],
//                       body: ListView.builder(
//                           itemCount: snapshot.data.length,
//                           shrinkWrap: true,
//                           itemBuilder: (context,index){
//                             return Padding(
//                               padding:  EdgeInsets.symmetric(horizontal: screenSize.height/70,vertical: screenSize.width/40),
//                               child: Card(
//                                 child: InkWell(
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding:  EdgeInsets.all(screenSize.height/50),
//                                         child: Padding(
//                                           padding:  EdgeInsets.only(left:screenSize.width/30),
//                                           child: Text(snapshot.data[index].data["title"],
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: screenSize.height/40
//                                             ),),
//                                         ),
//                                       ),
//
//                                       Expanded(
//                                         child: SizedBox(width: screenSize.width/20,),
//                                       ),
//                                       //TODO
//                                       Container(
//                                         child: Card(
//                                           child: InkWell(
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.all(screenSize.height / 50),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(
//                                                         left: screenSize.width / 30),
//                                                     child: Text(
//                                                       snapshot.data[index].get("ownerName"),
//                                                       style: TextStyle(
//                                                           fontWeight: FontWeight.w400,
//                                                           fontSize: screenSize.height / 25),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: SizedBox(
//                                                     width: screenSize.width / 20,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             onTap: (){
//                                               print("The car is here");
//                                             },
//                                           ),
//                                           elevation: 2.0,
//                                           //shadowColor: Colors.black,
//                                         ),
//                                       ),
//                                       //TODO
//                                       Padding(
//                                         padding: const EdgeInsets.only(right:20.0),
//                                         child: Icon(Icons.arrow_forward,size: 30.0,color: Colors.green,),
//                                       ),
//                                     ],
//                                   ),
//                                   onTap: () => Navigator.push(context, MaterialPageRoute(
//                                       builder: (context)=>SongPage(snapshot.data[index].data["title"],snapshot.data[index].data["link"]))),
//                                 ),
//                                 elevation: 2.0,
//                                 //shadowColor: Colors.black,
//                               ),
//                             );
//                           }
//                       )
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//
//         }
//       },
//     );
//   }
// }
//
//
//
//
//
//
//

// body: ListView.builder(
// itemCount: snapshot.data.length,
// shrinkWrap: true,
// itemBuilder: (context, index) {
// return Padding(
// padding: EdgeInsets.symmetric(
// horizontal: screenSize.height / 70,
// vertical: screenSize.width / 40),
// child: Card(
// elevation: 3.0,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.all(Radius.circular(10))
// ),
//
// child: Padding(
// padding:  EdgeInsets.symmetric(vertical:20),
// child: Column(
// children: [
// Text("Car name: "+snapshot.data[index].id,style: TextStyle(fontSize: screenSize.height/30,),),
// Divider(
// thickness: 2.0,
// ),
// Text("Owner Name:"+snapshot.data[index].get("ownerName"),style: TextStyle(fontSize: screenSize.height/30,),),
// ],
// ),
// ),
// ),
// );
// }
// )