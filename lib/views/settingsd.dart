import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraison/views/welcome.dart';

class Settt extends StatefulWidget {
  const Settt({super.key});

  @override
  State<Settt> createState() => _SetttState();
}

class _SetttState extends State<Settt> {
  User? user=FirebaseAuth.instance.currentUser;
  
  Stream<DocumentSnapshot>getu(){
    return FirebaseFirestore.instance.collection("users").doc(user!.uid).snapshots();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top:50,left:20,right:20),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text("Settings",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
    ),SizedBox(height: 30,),StreamBuilder<DocumentSnapshot>(
        stream: getu(),
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

          return ListTile(leading: CircleAvatar(radius: 30,backgroundImage: NetworkImage(doc['profileImageUrl']!),),title: Text(doc["userName"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),subtitle:Text("Profile") ,);
  })
    ,Divider(height: 50,),
    ListTile(
      onTap: null,
      leading: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.deepPurple.shade100,shape: BoxShape.circle),child: Icon(Icons.notifications_none_outlined,color: Colors.deepPurple,),)
     , title:Text("Notification",style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),trailing: Icon(Icons.arrow_forward_ios_rounded) ,

      
    ),SizedBox(height: 20,),
    ListTile(
      onTap: null,
      leading: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.indigo.shade100,shape: BoxShape.circle),child: Icon(Icons.privacy_tip_outlined,color: Colors.indigo,),)
     , title:Text("Privacy",style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),trailing: Icon(Icons.arrow_forward_ios_rounded) ,

      
    ),SizedBox(height: 20,),
    ListTile(
      onTap: null,
      leading: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.green.shade100,shape: BoxShape.circle),child: Icon(Icons.settings_suggest_outlined,color: Colors.green,),)
     , title:Text("General",style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),trailing: Icon(Icons.arrow_forward_ios_rounded) ,

      
    ),SizedBox(height: 20,),ListTile(
      onTap: null,
      leading: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.orange.shade100,shape: BoxShape.circle),child: Icon(Icons.info_outline_rounded,color: Colors.orange,),)
     , title:Text("About Us",style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),trailing: Icon(Icons.arrow_forward_ios_rounded) ,

      
    ),Divider(height: 40,),SizedBox(height: 20,),ListTile(
      onTap:(){FirebaseAuth.instance.signOut();
                Get.off(() => const welcome());},
      leading: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(color: Colors.redAccent.shade100,shape: BoxShape.circle),child: Icon(Icons.logout,color: Colors.redAccent,),)
     , title:Text("Log Out",style:TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),trailing: Icon(Icons.arrow_forward_ios_rounded) ,
        
      
    )],
    ));
  }
}