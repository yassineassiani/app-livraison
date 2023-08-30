// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraison/views/Listeoffre.dart';

import 'navd.dart';

class ListA extends StatefulWidget {
  const ListA({super.key});
  

  

  @override
  State<ListA> createState() => _ListAState();
}

class _ListAState extends State<ListA> {
  Stream<QuerySnapshot>getA()
  {
     User? currentUser = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection("annonce").where('id', isEqualTo:currentUser!.uid.toString() )
      .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color.fromARGB(255, 1, 115, 119) ,body :SingleChildScrollView(child:Column(children: [SizedBox(height: 50,),
            Padding(padding:  EdgeInsets.symmetric(horizontal:10),
            child: Stack(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [InkWell(child: Icon(Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
              ),
              onTap: (){
                Get.off(()=>Navd());
              },),]),])),SizedBox(height:20,),Text("My Post",style:TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontWeight: FontWeight.bold,
                fontFamily:"CustomFont"

              )),Container(child:Text("Destination Information",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 21,
                fontFamily:"CustomFont"),) ,),SizedBox(height:30,),Container(
            height:MediaQuery.of(context).size.height /1,
            width: double.infinity,
            padding: EdgeInsets.only(top:0,left:10,right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.only(topLeft:Radius.circular(10),
              topRight: Radius.circular(10) ) 

            ),
    child:StreamBuilder<QuerySnapshot>(
      stream: getA(),
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
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
              return Container(
width: 0,
height: 110,
margin: EdgeInsets.only(right: 0,bottom: 20),



decoration: BoxDecoration(
  color: Colors.white12,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
      color:  Color.fromARGB(255, 76, 171, 174), // Nouvelle couleur de la bordure
      width: 2.5 )
  
),child: Row(children: [Column(children: [Container(margin: EdgeInsets.only(left: 20,top:10),padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 76, 171, 174),shape:BoxShape.circle),child: Icon(Icons.person,color: Colors.white,size: 50,),),Container(margin: EdgeInsets.only(left:19),child:Text(documents[index]['DName'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95)),))],),Column(children: [Row(children: [Container(margin:EdgeInsets.only(left: 25,top: 13),child:Icon(Icons.phone,size: 30,color: Color.fromARGB(255, 76, 171, 174),)),Container(margin:EdgeInsets.only(top: 10),child: Text(documents[index]['Dphone'],style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95))))],),Row(children: [Container(margin:EdgeInsets.only(top:10,left:3),child:Icon(Icons.home,size:35,color:Color.fromARGB(255, 76, 171, 174),)),Container(margin:EdgeInsets.only(top:10),child:Text(documents[index]['Dlocation'],style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95))))]),],),Expanded(child: Column(children: [Row(children: [Container(margin:EdgeInsets.only(top:12,left:20) ,child:Icon(size:30,Icons.fitness_center,color: Color.fromARGB(255, 76, 171, 174),)),Container(margin:EdgeInsets.only(top:10),child:Text(documents[index]['wei'],style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95))))],)],)),Container(decoration: BoxDecoration(color:Color.fromARGB(255, 76, 171, 174),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),),height: 110,width: 50 ,child:InkWell(onTap: (){Get.to(Lo(), arguments:documents[index].id);},child: Center(child:Icon(Icons.arrow_forward_ios,color:Colors.white))))]),);

               } );
  }) ,)])
 )); }
}