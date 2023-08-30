


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:livraison/views/login.dart';

singupc(String userName, String uphone, String uemail,String loc)
{
  User? currentUser=FirebaseAuth.instance.currentUser;

  try {
    FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set(
            {
              "userName":userName,
              "userphone":uphone,
              "useremail":uemail,
              "location":loc,
              "role":"c",
              "profileImageUrl":null
            }
          ).then((value) =>{
            FirebaseAuth.instance.signOut(),
            Get.to(()=> const Login())
          });   
  }on FirebaseAuthException catch (e) {
   print("erer:$e");
  }
}
singupd(String userName, String uphone, String uemail,String loc,String vhicule)
{
  User? currentUser=FirebaseAuth.instance.currentUser;

  try {
    FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set(
            {
              "userName":userName,
              "userphone":uphone,
              "useremail":uemail,
              "location":loc,
              "véhicule":vhicule,

              "role":"d",
              "profileImageUrl":null
            }
          ).then((value) =>{
            FirebaseAuth.instance.signOut(),
            Get.to(()=> const Login())
          });   
  }on FirebaseAuthException catch (e) {
   print("erer:$e");
  }
}
class chats extends ChangeNotifier
{
  final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
Future<void>sendMessage(String rid,String mesg)async
{
  final String cuid=_firebaseAuth.currentUser!.uid;
  final String cure=_firebaseAuth.currentUser!.email.toString();
  final Timestamp timestamp=Timestamp.now();
  Message nem=Message(sid: cuid, sEmail: cure, rid: rid, message: mesg, timestamp: timestamp);
  List<String> ids=[cuid,rid];
  ids.sort();

  String chatids=ids.join("_");
  await _firestore.collection('chat').doc(chatids).collection("messges").add(nem.toMap());
}
Stream<QuerySnapshot>getM(String userid,String oth)
{
   List<String> ids=[userid,oth];
  ids.sort();
  String chatids=ids.join("_");
  print(chatids);
  return _firestore.collection('chat').doc(chatids).collection("messges").orderBy('timestamp',descending: false).snapshots();
  
}
}
class Message{
  final String sid;
  final String sEmail;
  final String rid;
  final String message;
  final Timestamp timestamp;
  Message({required this.sid,required this.sEmail,required this.rid,required this.message,required this.timestamp});
Map<String,dynamic>toMap()
{
  return{
    "sid":sid,
    "sEmail":sEmail,
    "rid":rid,
    "messsage":message,
    "timestamp":timestamp,
  };
}
  

}