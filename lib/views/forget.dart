

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livraison/views/login.dart';

import 'package:lottie/lottie.dart';
import 'package:get/get.dart';


class For extends StatefulWidget {
  const For({super.key});

  @override
  State<For> createState() => _ForState();
}

class _ForState extends State<For> {
  TextEditingController ce =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(right: 333),
            child: TextButton(
                onPressed: () {
                  Get.off(() => const Login());
                },
                child: const Text(
                  "BACK",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 1, 154, 159)),
                )),
          ),
         const SizedBox(height: 40,),
          const Text("Forget Your Password",
              style: TextStyle(
                fontFamily:"CustomFont" ,
                  color: Color.fromARGB(255, 10, 161, 166),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 2)),
          const Text("login to your account",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  wordSpacing: 2)),
                 const SizedBox(height: 40),
          Container(
              alignment: Alignment.center,
              height: 450,
              margin: const EdgeInsets.only(top: .0),
              child: Lottie.asset("assets/animation_llgud5m9.json")),
         
           Padding(
            padding:const  EdgeInsets.all(12),
            child: TextField(
              controller: ce,
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Entre Email"),
                  prefixIcon: Icon(Icons.person)),
            ),
          ),
       
        
        const SizedBox(height: 10,)
          ,
        
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            width: 387,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 1, 115, 119), // Coin arrondi
            ),
            child:  Center(
              child: InkWell(
                onTap: (){
                  try {
          FirebaseAuth.instance.sendPasswordResetEmail(email: ce.text.trim()).then((value) => 
          
          {
            
            Get.off(()=>const Login())
          });
        
          
        }on FirebaseAuthException catch (e) {
          print(e);
          
        }
                  
                },
                child:const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    "SEND",
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