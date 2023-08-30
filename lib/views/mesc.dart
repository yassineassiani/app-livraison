// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Meesge.dart';

class Mc extends StatefulWidget {
  const Mc({super.key});

  @override
  State<Mc> createState() => _McState();
}

class _McState extends State<Mc> {
  User? currentUser = FirebaseAuth.instance.currentUser;
    Stream<QuerySnapshot>getM()
{
   
  return FirebaseFirestore.instance.collection("Messge").doc(currentUser!.uid).collection("mess").snapshots();
  
}
  @override
  Widget build(BuildContext context) {
  
    return SingleChildScrollView(child:StreamBuilder<QuerySnapshot>(
          stream:getM(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return Text('Aucune donnée trouvée');
            }
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            print(documents.length);
            return  Container(color: const Color.fromARGB(255, 1, 115, 119) ,
              child: Padding(padding:  EdgeInsets.symmetric(horizontal:0),
              
                  child:Column(children:[SizedBox(height: 40,),Text("My Messges",style:TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  fontFamily:"CustomFont"
            
                )),SizedBox(height:30,),Container(
              height:MediaQuery.of(context).size.height /1,
              width:5000,
              padding: EdgeInsets.only(top:0,left:10,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.only(topLeft:Radius.circular(10),
                topRight: Radius.circular(10) ) 
                
              
              ),child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
               
                return Container(
                 
                  child: ListTile(
      onTap: null,
      leading: Container(child:CircleAvatar(radius: 30,backgroundImage: NetworkImage(documents[index]["photo"]!),))
     , title:Text(documents[index]["nom"],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 33,color:Colors.black87,fontFamily:"CustomFont")),trailing: InkWell(onTap:(){

Map<String, dynamic> arguments = {
    'photo':documents[index]["photo"],
    'id':documents[index]["id"],
    'nom':documents[index]["nom"]
  };Get.to( Mesg(), arguments:arguments);

     },child: Icon(Icons.arrow_forward_ios_rounded)) ,

      
    ),
                );
              },
              ))
                ])),
            );}
    ));
  }
}