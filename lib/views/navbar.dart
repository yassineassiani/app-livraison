// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison/views/annonce.dart';
import 'package:livraison/views/homed.dart';
import 'package:livraison/views/setting.dart';

import 'homecc.dart';
import 'mesd.dart';

class Navcc extends StatefulWidget {
  const Navcc({super.key});

  @override
  State<Navcc> createState() => _NavccState();
}

class _NavccState extends State<Navcc> {
  int _selc=0;
  final _views=[Homd(),Md(),Sett()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:_views[_selc],
      bottomNavigationBar:Container(
        height: 80,
        child:BottomNavigationBar(
        backgroundColor:Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:Color.fromARGB(255, 10, 161, 166), 
        unselectedItemColor: Colors.black26,
        selectedLabelStyle:const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15
        ),
        currentIndex: _selc,
        onTap: (index){
          setState(() {
            _selc=index;
          });

        },
        items: [ BottomNavigationBarItem(icon:Icon(Icons.home_filled),label: "Home"),
        BottomNavigationBarItem(icon:Icon(CupertinoIcons.chat_bubble_text_fill),label: "Messges"),
       
        BottomNavigationBarItem(icon:Icon(Icons.settings),label: "setting"),
        
        
        
        
        
        ],

        )
    

      ),
    );
  }
}