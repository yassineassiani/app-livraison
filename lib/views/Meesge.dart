import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraison/views/service.dart';

class Mesg extends StatefulWidget {
  const Mesg({super.key});

  @override
  State<Mesg> createState() => _MesgState();
}

class _MesgState extends State<Mesg> {
int? count;
   final  arg = Get.arguments;
   String get id => arg["id"];
   String get photo => arg["photo"];
  String get nom => arg["nom"];

  TextEditingController n = TextEditingController();
  final chats cs = chats();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void sendM() async {
    if (n.text.isNotEmpty) {
      await cs.sendMessage(id, n.text);
      n.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  PreferredSize(preferredSize: Size.fromHeight(70), child: AppBar(backgroundColor:const Color.fromARGB(255, 1, 115, 119),leadingWidth: 30,title:Row(children: [CircleAvatar(radius: 25,backgroundImage: NetworkImage(photo!),)
      ,Padding(padding: EdgeInsets.only(left:10),child: Text(nom,style: TextStyle(color: Colors.white),),)],)),),
      
      body: Column(children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: cs.getM(id, _firebaseAuth.currentUser!.uid),
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
             count =documents.length;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                var alignment=(documents[index]['sid']==_firebaseAuth.currentUser!.uid)?Alignment.centerRight:Alignment.centerLeft;
                var coleur=(documents[index]['sid']==_firebaseAuth.currentUser!.uid)?Color.fromARGB(255, 66, 180, 184):Color.fromARGB(255, 210, 210, 218);
                var c=(documents[index]['sid']==_firebaseAuth.currentUser!.uid)?UpperNipMessageClipper(MessageType.send):UpperNipMessageClipper(MessageType.receive);
                var p=(documents[index]['sid']==_firebaseAuth.currentUser!.uid)?EdgeInsets.only(top:20,left:80):EdgeInsets.only(right: 80);
                var cc=(documents[index]['sid']==_firebaseAuth.currentUser!.uid)?Colors.white:Colors.black;
                return Container(
                  alignment: alignment,
                  child:Padding(padding:p,child: ClipPath(clipper: c,child:Container(padding:EdgeInsets.all(20),decoration: BoxDecoration(color: coleur),child:Text(documents[index]["messsage"],style: TextStyle(fontSize: 16,color: cc) ,)),) ),
                );
              },
            );
          },
        )),
        Container(height: 56, decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 205, 182, 180),
                width: 2.0,
              ),
            ),
          ),child:Row(children: [Padding(padding: EdgeInsets.only(left: 8),child:Icon(Icons.add,size: 30,)),Padding(padding: EdgeInsets.only(left: 5),child:Icon(Icons.emoji_emotions,color: Colors.amber,size: 30,)),Padding(padding: EdgeInsets.only(left:10),child:Container(alignment: Alignment.centerRight,width:270,child:TextFormField(
                controller: n,
                decoration: InputDecoration(hintText: 'Type something',border: InputBorder.none),
                obscureText: false,
              ),)),Spacer(),InkWell(onTap:()async{sendM();if(count==0&&n.text.isNotEmpty){
                  User? currentUser = FirebaseAuth.instance.currentUser;
 DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).get();
try {

    FirebaseFirestore.instance.collection("Messge").doc(currentUser.uid).collection("mess").add(
      
            {
              "nom":nom,
              "id":id,
              "photo":photo


            }

    ) ; 
    FirebaseFirestore.instance.collection("Messge").doc(id).collection("mess").add(
            
             {
              "id":currentUser.uid,

                  "nom": userSnapshot.get("userName"),
                  "photo": userSnapshot.get("profileImageUrl")
             }
    ) ; 
            
          
  }on FirebaseAuthException catch (e) {
   print("erer:$e");
  }

              }},child: Padding(padding: EdgeInsets.only(right: 10),child:Icon(Icons.send,size: 30,color:const Color.fromARGB(255, 1, 115, 119) ,)))],))
        
      ]),
    );
  }
}