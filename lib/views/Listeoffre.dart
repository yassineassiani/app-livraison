import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Meesge.dart';
import 'listeannonce.dart';

class Lo extends StatefulWidget {
  const Lo({super.key});

  @override
  State<Lo> createState() => _LoState();
}

class _LoState extends State<Lo> {
    final String id = Get.arguments;

  Stream<QuerySnapshot> getAnStream() {
    return FirebaseFirestore.instance.collection("annonce2").where('id', isEqualTo:id ).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: const Color.fromARGB(255, 1, 115, 119) ,body :SingleChildScrollView(child:Column(children: [SizedBox(height: 50,),
            Padding(padding:  EdgeInsets.symmetric(horizontal:10),
            child: Stack(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [InkWell(child: Icon(Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 25,
              ),
              onTap: (){
                Get.off(()=>ListA());
              },),]),])),SizedBox(height:20,),Text("My Offers",style:TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontWeight: FontWeight.bold,
                fontFamily:"CustomFont"

              )),Container(child:Text("Delivery Information",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 21,
                fontFamily:"CustomFont"),) ,),SizedBox(height:30,),Container(
            height:MediaQuery.of(context).size.height /1,
            width: double.infinity,
            padding: EdgeInsets.only(top:0,left:10,right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.only(topLeft:Radius.circular(10),
              topRight: Radius.circular(10) ) 

            )
            ,
            child:StreamBuilder<QuerySnapshot>(
      stream:getAnStream(),
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
  
),child: Row(children: [Column(children: [Container(margin: EdgeInsets.only(left: 10,top:10),child: CircleAvatar(
        radius: 35,
         backgroundImage: NetworkImage(documents[index]['EprofileImageUrl']!)
        
      ),),Container(margin: EdgeInsets.only(left:9),child:Text(documents[index]['DName'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95)),))],),Column(children: [Row(children: [Container(margin:EdgeInsets.only(left: 28,top: 13),child:Icon(Icons.phone,size: 26,color: Color.fromARGB(255, 76, 171, 174),)),Container(margin:EdgeInsets.only(left: 0,top: 10),child: Text(documents[index]['Dphone'],style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95))))],),Row(children: [Container(margin:EdgeInsets.only(top:10,left:00),child:Icon(Icons.home,size:30,color:Color.fromARGB(255, 76, 171, 174),)),Container(margin:EdgeInsets.only(top:10),child:Text(documents[index]['Dlocation'],style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95))))]),],),Expanded(child: Column(children: [Row(children: [Container(margin:EdgeInsets.only(top:12,left:20) ,child:Icon(size:26,Icons.car_crash,color: Color.fromARGB(255, 76, 171, 174),)),Container(margin:EdgeInsets.only(top:10),child:Text(documents[index]['Dvéhicule'],style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95)))),        ],),Row(children: [Container(margin:EdgeInsets.only(top:12,left:20) ,child:Icon(size:27,Icons.attach_money_rounded,color: Color.fromARGB(255, 76, 171, 174),)),Container(margin:EdgeInsets.only(top:10),child:Text(documents[index]['Dvéhicule'],style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color.fromARGB(221, 106, 95, 95))))])],)),Container(decoration: BoxDecoration(color:Color.fromARGB(255, 76, 171, 174),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),),height: 110,width: 50 ,child:InkWell(onTap: (){Map<String, dynamic> arguments = {
    'photo':documents[index]['EprofileImageUrl'],
    'id':documents[index]['idd'],
    'nom':documents[index]['DName']
  };Get.to( Mesg(), arguments:arguments);},child: Center(child:Icon(CupertinoIcons.chat_bubble_text_fill,color:Colors.white))))]),);});}))])));
  }
}