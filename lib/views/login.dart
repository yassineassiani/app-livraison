// ignore_for_file: avoid_unnecessary_containers



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livraison/views/forget.dart';
import 'package:livraison/views/navbar.dart';
import 'package:livraison/views/navd.dart';
import 'package:livraison/views/welcome.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'homec.dart';
import 'homecc.dart';
import 'homed.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool pt = true;
  @override
  void initState() {
    super.initState();
    pt = true;
  }
TextEditingController ce =TextEditingController();
TextEditingController cp =TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.75  ),
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
          SizedBox(height:MediaQuery.of(context).size.height*0.01,),
          const Text("Welcome Back",
              style: TextStyle(
                 fontFamily:"CustomFont" ,
                  color: Color.fromARGB(255, 10, 161, 166),
                  fontSize: 41,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 2)),
          const Text("login to your account",
              style: TextStyle(
                 fontFamily:"CustomFont" ,
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  wordSpacing: 2)),
          Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height /2.4 ,
              margin: const EdgeInsets.only(top: .0),
              child: Lottie.asset("assets/animation_llfs24th.json")),
         
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
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller:cp,
              obscureText: pt ? true : false,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text("Entre Password"),
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
          ),
          
          Container(
            margin:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.5),
            child:  TextButton(
              onPressed:(){
                Get.to(()=>const For());
              },
              child:const Text("Forget Password?",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
           ) ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            width: 387,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 1, 115, 119), // Coin arrondi
            ),
            child:  Center(
              child: InkWell(
                onTap:()async{
                String  em=ce.text.trim();
                String  ps=cp.text.trim();

                if(em!="" && ps!="")
                  {
                    try {
                      final User? firebaseUser=(await FirebaseAuth.instance.signInWithEmailAndPassword(email: em, password: ps)).user;
                     if(firebaseUser!=null)
                    {
         
          
                     User? currentUser = FirebaseAuth.instance.currentUser;
                    if(currentUser!=null){
                    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get();
                   if (userSnapshot.exists) {
                    String role = userSnapshot.get("role");
                   if(role=="c")
                   {
                    Get.to(()=>const Navd());
                   }
                   else
                   {
          Get.to(()=>const Navcc());
                   }
         
                    }
         
        }
                    }}on FirebaseAuthException catch (e) {
                      print(e);
                    }

                  }
                },
                child:const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
