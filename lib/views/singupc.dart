// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livraison/views/service.dart';
import 'package:livraison/views/welcome.dart';

import 'package:get/get.dart';


class Singupc extends StatefulWidget {
  const Singupc({super.key});
  

  @override
  State<Singupc> createState() => _SingupcState();
}

class _SingupcState extends State<Singupc> {
   bool pt = true;
  TextEditingController cu =TextEditingController();
  TextEditingController ce =TextEditingController();
  TextEditingController cp =TextEditingController();
  TextEditingController cph =TextEditingController();
  TextEditingController cl =TextEditingController();
  @override
  void initState() {
   
    super.initState();
    pt = true;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.only(right: 333),
            child: TextButton(
                onPressed: () {
                  Get.off(() => const welcome());
                },
                child: const Text(
                  "BACK",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 1, 154, 159)),
                )),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
             
            child: const Text("Register",
                style: TextStyle(
                   fontFamily:"CustomFont" ,
                    color: Color.fromARGB(255, 10, 161, 166),
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 2)),
          ),
          Container(
            child: const Text(" For",
                style: TextStyle(
                   fontFamily:"CustomFont" ,
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    wordSpacing: 2)),
          ),
          Container(
            child: const Text(" Account Customer",
                style: TextStyle(
                   fontFamily:"CustomFont" ,
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    wordSpacing: 2)),
          ),
          
          const SizedBox(height: 80,),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: cu,
              decoration:const  InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("UserName"),
                  prefixIcon: Icon(Icons.person)),
            ),
          ),
           Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: ce,
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[\w\.-]*$')),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),
      
        
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: cp,
              obscureText: pt ? true : false,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text("Password"),
                  prefixIcon: const Icon(Icons.lock),
                  suffix: InkWell(
                    child: pt
                        ? const Icon(CupertinoIcons.eye_slash_fill)
                        : const Icon(CupertinoIcons.eye_fill),
                    onTap: () {
                      if (pt == true) {
                        pt = false;
                      } else {
                        pt = true;
                      }
                      setState(() {});
                    },
                  )),
            ),
          ),  Padding(
  padding: const EdgeInsets.all(8),
  child: TextField(
    controller: cph,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: "Phone",
      prefixIcon: Icon(Icons.phone),
    ),
  ),
),
         
             Padding(
            padding:const  EdgeInsets.all(8),
            child: TextField(
              controller: cl ,
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Location"),
                  prefixIcon: Icon(Icons.home)),
            ),
          ),
           
        
          const SizedBox(height: 15),
         
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            width: 395,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 1, 115, 119), // Coin arrondi
            ),
            child:  Center(
              child: InkWell(
                onTap: (){
                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  String u =cu.text.trim();
                  String e=ce.text.trim();
                  String p=cp.text.trim();
                  String ph=cph.text.trim();
                  String l =cl.text.trim();
                  User? user = _auth.currentUser;
                  if(u!="" && e!="" && p!=""&&ph!=""&&l!="")
                  {
                    print(e);
FirebaseAuth.instance.createUserWithEmailAndPassword(email:e, password:p).then((value) async =>{
  
if (user != null && !user.emailVerified) {
  await user.sendEmailVerification(),
  singupc(u,ph,e,l)
}


});
                  }

                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}