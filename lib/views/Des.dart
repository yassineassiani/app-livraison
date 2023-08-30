// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraison/views/Meesge.dart';
import 'package:livraison/views/navbar.dart';
import 'package:livraison/views/navd.dart';

class Des extends StatefulWidget {
  const Des({super.key});

  @override
  State<Des> createState() => _DesState();
}

class _DesState extends State<Des> {
  final String id = Get.arguments;
 


  Stream<DocumentSnapshot> getAnStream() {
    return FirebaseFirestore.instance.collection("annonce").doc(id).snapshots();
  }
TextEditingController cp =TextEditingController();
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
          print(doc['EprofileImageUrl']);

          return Column(children: [SizedBox(height: 50,),
            Padding(padding:  EdgeInsets.symmetric(horizontal:10),
            child: Stack(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [InkWell(child: Icon(Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
              ),
              onTap: (){
                Get.off(()=>Navcc());
              },)
                
               
              ],),Padding(padding: EdgeInsets.symmetric(vertical: 10),child:
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [CircleAvatar(radius: 35,  backgroundImage: NetworkImage(doc['EprofileImageUrl']!)),
              SizedBox(height: 15,),Text(doc['EName'],style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),SizedBox(height: 20,),Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.call,color: Colors.white,),),SizedBox(width: 20,),Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.email,color: Colors.white,),),SizedBox(width: 20,),InkWell(onTap: (){ Map<String, dynamic> arguments = {
    'photo':doc['EprofileImageUrl'],
    'id':doc['id'],
    'nom':doc['EName']
  };Get.to( Mesg(), arguments:arguments);},child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(CupertinoIcons.chat_bubble_text_fill,color: Colors.white,),))],
              )],))
            ],))
          ,SizedBox(height:20,),Container(
            height:MediaQuery.of(context).size.height /1.5,
            width: double.infinity,
            padding: EdgeInsets.only(top:20,left:15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.only(topLeft:Radius.circular(10),
              topRight: Radius.circular(10) ) 

            ),
          child:Column(children: [SizedBox(height: 30,),Container(child: Text("Destination Information",style: TextStyle(
         fontFamily:"CustomFont" ,
        color:  const Color.fromARGB(255, 1, 115, 119),
        fontSize: 38,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        wordSpacing: 2
       ),),),SizedBox(height: 40,),Row(children: [Container(margin: EdgeInsets.only(left: 15),padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.person,color: Colors.white,),),Container(margin:EdgeInsets.only(left: 15),child:Text(doc['DName'],style: TextStyle(
       fontSize: 35,      
       fontWeight: FontWeight.bold,
       color:  const Color.fromARGB(255, 1, 115, 119),
fontFamily:"CustomFont"

       ),),)],),SizedBox(height: 20,),Row(children: [Container(margin: EdgeInsets.only(left: 15),padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.email,color: Colors.white,),),Container(margin:EdgeInsets.only(left: 15),child:Text(doc['Demail'],style: TextStyle(
       fontSize: 35,      
       fontWeight: FontWeight.bold,
       color:  const Color.fromARGB(255, 1, 115, 119),
fontFamily:"CustomFont"

       ),),)],),SizedBox(height: 20,),Row(children: [Container(margin: EdgeInsets.only(left: 15),padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.phone,color: Colors.white,),),Container(margin:EdgeInsets.only(left: 15),child:Text(doc['Dphone'],style: TextStyle(
       fontSize: 30,      
       fontWeight: FontWeight.bold,
       color:  const Color.fromARGB(255, 1, 115, 119),
fontFamily:"CustomFont"

       ),),)],),SizedBox(height: 20,),Row(children: [Container(margin: EdgeInsets.only(left: 15),padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Color.fromARGB(255, 63, 148, 151),shape:BoxShape.circle),child: Icon(Icons.fitness_center,color: Colors.white,),),Container(margin:EdgeInsets.only(left: 15),child:Text(doc['DName'],style: TextStyle(
       fontSize: 35,      
       fontWeight: FontWeight.bold,
color:  const Color.fromARGB(255, 1, 115, 119),
fontFamily:"CustomFont"
       ),),)],), SizedBox(height: 25,),Row(children: [SizedBox(width: 7,),Container(width: 270,child:Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: cp,
              
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Price"),
                  prefixIcon: Icon(Icons.attach_money)),  
            ),
          ) ,),Container(
  margin:const EdgeInsets.only(),
  width: 100,
  height: 66,
 
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),  color:const Color.fromARGB(255, 1, 115, 119),// Coin arrondi
  ),
  child:   Center(
    child: InkWell(
        onTap: ()async{
         
          if(cp.text.trim()!="")
          {User? currentUser = FirebaseAuth.instance.currentUser;
             if(currentUser!=null){
               
                    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get();
try {
    FirebaseFirestore.instance.collection("annonce2").doc().set(
            {
              "DName":userSnapshot.get("userName"),
              "Dphone":userSnapshot.get("userphone"),
              "Demail":userSnapshot.get("useremail"),
              "Dlocation":userSnapshot.get("location"),
              "EprofileImageUrl":userSnapshot.get("profileImageUrl"),
              "Dvéhicule":userSnapshot.get("véhicule"),
              "id":id,
              "idd":currentUser.uid
             
              
            }).then((value) =>{
           Get.off(()=>Navcc())
  });   
            
          
  }on FirebaseAuthException catch (e) {
   print("erer:$e");
  }
             }
          }

        },
        child:const  Padding(

          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Text("SEND",  style: TextStyle(
      color: Colors.white, 
      fontSize: 22, 
       fontWeight: FontWeight.bold
    ),
  ),
        ),
        
     
     
    ),
  ),
),],)],)),],);
        },
      ),
    ));
  }
}