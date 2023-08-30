import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraison/views/Meesge.dart';
import 'package:livraison/views/navd.dart';

class Ded extends StatefulWidget {
  const Ded({super.key});

  @override
  State<Ded> createState() => _DedState();
}

class _DedState extends State<Ded> {
  String photo="";
  String nom="";
  
  final String id = Get.arguments;
   Stream<DocumentSnapshot> getAnStream() {
    return FirebaseFirestore.instance.collection("users").doc(id).snapshots();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(backgroundColor: const Color.fromARGB(255, 1, 115, 119) ,body :SingleChildScrollView(
      child: StreamBuilder<DocumentSnapshot>(
        stream: getAnStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error loading data');
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available');
          }

          DocumentSnapshot doc = snapshot.data!;
          print(doc['profileImageUrl']);
           photo=doc['profileImageUrl'];
           nom=doc['userName'];

          return Column(children: [SizedBox(height: 50,),
            Padding(padding:  EdgeInsets.symmetric(horizontal:10),
            child: Stack(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [InkWell(child: Icon(Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
              ),
              onTap: (){
                Get.off(()=>Navd());
              },)
                
               
              ],),Padding(padding: EdgeInsets.symmetric(vertical: 10),child:
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [CircleAvatar(radius: 35,  backgroundImage: NetworkImage(doc['profileImageUrl']!)),
              SizedBox(height: 15,),Text(doc['userName'],style: TextStyle(
                fontSize: 30,fontFamily:"CustomFont",
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),SizedBox(height: 5,)
              ,SizedBox(height:0 ,),Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [Icon(Icons.star,color:Colors.amber),Text("(4.9)",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 20,fontFamily:"CustomFont",),),],)])
            )],))
          ,SizedBox(height:20,),Container(
            height:MediaQuery.of(context).size.height /1,
            width: double.infinity,
            padding: EdgeInsets.only(top:20,left:15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.only(topLeft:Radius.circular(10),
              topRight: Radius.circular(10) ) 

),
child:Column(children: [SizedBox(height: 12,),Text("Delivery  Information",style: TextStyle(fontWeight: FontWeight.bold,fontFamily:"CustomFont",fontSize:43,color:const Color.fromARGB(255, 1, 115, 119),  ),),SizedBox(height: 16,),Row(children: [SizedBox(width: 24),Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.email,color: Colors.white,),),SizedBox(width: 15,),Text(doc['useremail'],style:TextStyle(fontWeight:FontWeight.bold,fontFamily:"CustomFont",fontSize:32,color:const Color.fromARGB(255, 1, 115, 119),),)],),SizedBox(height: 20),Row(children: [SizedBox(width: 24),Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.call,color: Colors.white,),),SizedBox(width: 15,),Text(doc['userphone'],style:TextStyle(fontWeight:FontWeight.bold,fontFamily:"CustomFont",fontSize:32,color:const Color.fromARGB(255, 1, 115, 119),),)],),SizedBox(height: 20,),Row(children: [SizedBox(width: 24),Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.location_on,color: Colors.white,),),SizedBox(width: 15,),Text(doc['location'],style:TextStyle(fontWeight:FontWeight.bold,fontFamily:"CustomFont",fontSize:32,color:const Color.fromARGB(255, 1, 115, 119),),)],),SizedBox(height: 20,),Row(children: [SizedBox(width: 24),Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.car_crash,color: Colors.white,),),SizedBox(width: 15,),Text(doc['véhicule'],style:TextStyle(fontWeight:FontWeight.bold,fontFamily:"CustomFont",fontSize:32,color:const Color.fromARGB(255, 1, 115, 119),),)],),]),

)]);}))
,bottomNavigationBar:Container(height: 130,padding: EdgeInsets.all(15),decoration: BoxDecoration(color: Color.fromARGB(255, 250, 249, 249),boxShadow: [BoxShadow(color:Colors.black12,blurRadius: 4,spreadRadius: 2)],border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 209, 195, 195),
                width: 2.0,
))

),child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Delivery Price",style: TextStyle(color: Colors.black54,fontSize: 16),),Text("\$100-20",style: TextStyle(color:Colors.black54,fontWeight:FontWeight.bold,fontSize: 18),)],),SizedBox(height: 15,),InkWell(onTap:(){       Map<String, dynamic> arguments = {
    'photo':photo,
    'id':id,
    'nom':nom
  };Get.to( Mesg(), arguments:arguments);},child:Container(width:MediaQuery.of(context).size.width,padding: EdgeInsets.symmetric(vertical: 13),decoration: BoxDecoration(color:const Color.fromARGB(255, 1, 115, 119),borderRadius: BorderRadius.circular(10),),child: Center(child: Text("Send A Message",style: TextStyle(color: Colors.white,fontSize: 18 ,fontWeight: FontWeight.w500 ),),),))]),),);
  }
}