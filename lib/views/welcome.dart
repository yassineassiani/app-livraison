// ignore_for_file: depend_on_referenced_packages, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:livraison/views/login.dart';
import 'package:livraison/views/singupc.dart';
import 'package:livraison/views/singupd.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(

      child:Column(

        children: [ const SizedBox(height: 40,),const Text("Fast Delivery Application",style:
       TextStyle(
         fontFamily:"CustomFont" ,
        color: Color.fromARGB(255, 10, 161, 166),
        fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        wordSpacing: 2
       )),
       const Text("welcome!",style:
       TextStyle(
         fontFamily:"CustomFont" ,
        color: Colors.black54,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        wordSpacing: 2
       )),
       
       
       Container( alignment:Alignment.center,height:MediaQuery.of(context).size.height /2.37 ,margin:const EdgeInsets.only(top: .0),child: Lottie.asset("assets/animation_llfs24th.json")),
       const SizedBox(height:20,),
      
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Container(
          width: MediaQuery.of(context).size.width /1.05,
         
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),  color:const Color.fromARGB(255, 17, 174, 179),// Coin arrondi
  ),
  child:  Center(
    child:   InkWell(
        onTap: (){
          Get.to(() => const Singupd());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [Container(margin:const EdgeInsets.only(right: 26), // Adjust the value as needed
  child:const Icon(
    Icons.email_outlined,
    color: Colors.white,
    size: 24,
  ),),
             const Text("Sing Up For  Delivery ",  style: TextStyle(
      color: Colors.white, 
      fontSize: 22, 
      fontWeight: FontWeight.bold
      
    ),
  ),
            ],
          ),
        ),
        
     
     
    ),
  ),
),
const SizedBox(height: 15,),
Container(
  width: MediaQuery.of(context).size.width /1.05,
 
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),  color:const Color.fromARGB(255, 17, 174, 179),// Coin arrondi
  ),
  child:   Center(
    child: InkWell(
        onTap: (){
          Get.to(() => const Singupc());
        },
        child: Padding(
          padding:const  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [Container(margin:const EdgeInsets.only(right: 26), // Adjust the value as needed
  child:const Icon(
    Icons.email_outlined,
    color: Colors.white,
    size: 24,
  ),),
              const Text("Sing Up For Customer",  style: TextStyle(
                color: Colors.white, 
                fontSize: 22, 
                 fontWeight: FontWeight.bold
              ),
            ),
        ]),
        ),
        
     
     
    ),
  ),
),const SizedBox(height: 10,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,  
  children: [Container(
  width:MediaQuery.of(context).size.width /2.55,
  child:const Divider(
    color: Color.fromARGB(255, 185, 184, 184) ,
    thickness: 2,
  )),Container(
  width:20,
  child:const Divider(
    color: Colors.white ,
    thickness: 3.0,
  )),const Text("Or", style: TextStyle(
       
      fontSize: 17, 
      color: Color.fromARGB(255, 111, 110, 110)
       
    ),),Container(
  width:20.0,
  child:const Divider(
    color: Colors.white ,
    thickness: 3.0,
  )),Container(
  width:MediaQuery.of(context).size.width /2.55,
  child:const Divider(
    color: Color.fromARGB(255, 185, 184, 184),
    thickness: 2,
  )),const SizedBox(height: 50,)],),
  
Container(
  margin:const EdgeInsets.only(bottom: 20.0),
  width:MediaQuery.of(context).size.width /1.05,
 
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),  color:const Color.fromARGB(255, 1, 115, 119),// Coin arrondi
  ),
  child:   Center(
    child: InkWell(
        onTap: (){
Get.to(() => const Login());
        },
        child:const  Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Text("Login",  style: TextStyle(
      color: Colors.white, 
      fontSize: 22, 
       fontWeight: FontWeight.bold
    ),
  ),
        ),
        
     
     
    ),
  ),
),



        ],
       ),
       

        
        
        
        ],
      )
    );
  }
}