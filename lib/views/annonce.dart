// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livraison/views/listeannonce.dart';

import 'navd.dart';

class Anonc extends StatefulWidget {
  const Anonc({super.key});

  @override
  State<Anonc> createState() => _AnoncState();
}

class _AnoncState extends State<Anonc> {
  TextEditingController _controller = TextEditingController();
  String selectedOption = '5kg';
  List<String> dropdownOptions = ['5kg', '10kg', '20kg',"30kg"];
   TextEditingController cu =TextEditingController();
  TextEditingController ce =TextEditingController();
  TextEditingController cp =TextEditingController();
  TextEditingController cph =TextEditingController();
  TextEditingController cl =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(child:Column(children: [SizedBox(height: 100,),
        Container(child: Text("Launch a Delivery",style:TextStyle(
           fontSize: 43,
           fontWeight: FontWeight.bold,
           wordSpacing: 2,
           letterSpacing: 1,
           fontFamily: "CustomFont",
            color: Color.fromARGB(255, 10, 161, 166),
       

        ),),)
      ,Container(child:  Text("Apply Here!",style:
       TextStyle(
         fontFamily:"CustomFont" ,
        color: Colors.black54,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        wordSpacing: 2
       )),),SizedBox(height: 60,),
        Padding(
            padding:const  EdgeInsets.all(10),
            child: TextField(
              controller: cu,
              
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Recipient's Name"),
                  prefixIcon: Icon(Icons.person)),
            ),
          ), Padding(
            padding:const  EdgeInsets.all(10),
            child: TextField(
              controller: ce,
              
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                  prefixIcon: Icon(Icons.email)),
            ),
          ),
          Padding(
            padding:const  EdgeInsets.all(10),
            child: TextField(
  keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  controller: cph,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: "Recipient's Phone",
    prefixIcon: Icon(Icons.phone),
  ),
)
          ),
           Padding(
            padding:const  EdgeInsets.all(10),
            child: TextField(
              controller: cl,
              
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Recipient's Location"),
                  prefixIcon: Icon(Icons.home)),
            ),
          ),  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select the weight'),
                    content: DropdownButton<String>(
                      value: selectedOption,
                      onChanged: (newValue) {
                        setState(() {
                          selectedOption = newValue!;
                          _controller.text = newValue;
                          Navigator.of(context).pop();
                        });
                      },
                      items: dropdownOptions
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
              child: Padding(
                padding:const  EdgeInsets.all(10),
                child: AbsorbPointer(
                  child: TextField(
                    controller:cp,
                    decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Weight Of The Concrete"),
                    prefixIcon: Icon(Icons.fitness_center)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),SizedBox(height: 20,),Container(
  margin:const EdgeInsets.only(bottom: 20.0),
  width: 389,
 
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),  color:const Color.fromARGB(255, 1, 115, 119),// Coin arrondi
  ),
  child:   Center(
    child: InkWell(
        onTap:()async{
          
           String u =cu.text.trim();
                  String e=ce.text.trim();
                  String p=cp.text.trim();
                  String ph=cph.text.trim();
                  String l =cl.text.trim();
                   
                  print(p);
                 
                  if(u!="" && e!="" && p!=""&&ph!=""&&l!="")
                  {
print("hhhhhhhhhhhh");
           User? currentUser = FirebaseAuth.instance.currentUser;
           if(currentUser!=null){
                    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get();
                   if (userSnapshot.exists) {
                    
try {
    FirebaseFirestore.instance.collection("annonce").doc().set(
            {
              "EName":userSnapshot.get("userName"),
              "Ephone":userSnapshot.get("userphone"),
              "Eemail":userSnapshot.get("useremail"),
              "Elocation":userSnapshot.get("location"),
              "EprofileImageUrl":userSnapshot.get("profileImageUrl"),
              "DName":cu.text.trim(),
              "Dphone":cph.text.trim(),
              "Demail":ce.text.trim(),
              "Dlocation":cl.text.trim(),
              "wei":cp.text.trim(),
              "id":currentUser.uid
              
            }).then((value) =>{
           Get.off(()=>ListA())
  });   
            
          
  }on FirebaseAuthException catch (e) {
   print("erer:$e");
  }



                   }
         }}},

       
        child:const  Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Text("APPLY",  style: TextStyle(
      color: Colors.white, 
      fontSize: 22, 
       fontWeight: FontWeight.bold
    ),
      )))))])
    );
}}