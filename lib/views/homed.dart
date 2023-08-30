// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livraison/views/Des.dart';

class Homd extends StatefulWidget {
  const Homd({super.key});

  @override
  State<Homd> createState() => _HomdState();
}

class _HomdState extends State<Homd> {
  List supp=[
    "Food",
    "Gaming",
    "Clothing",
    "Smart Phone",
    "Smart Watch",
    
    
  ];
   File? _imageFile;
  String? _imageUrl;
  String userName="";
  User? _user = FirebaseAuth.instance.currentUser;
  Future<String> getUserNameFromUID() async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
        .collection('users') // Remplacez 'users' par le nom de votre collection
        .doc(_user!.uid)
        .get();

    if (userDoc.exists) {
      String userName = userDoc['userName']; 
      print(userName);// Assurez-vous que 'name' correspond au champ du nom dans votre document
      return userName;
    } else {
      return 'User not found';
    }
  } catch (e) {
    print(e.toString());
    return 'Error';
  }
}
  @override
  void initState()  {
 


    
    super.initState();
    
    _retrieveProfileImageUrl();
  }

  Future<void> _retrieveProfileImageUrl() async {
    if (_user != null) {
      // Retrieve the profile image URL for the logged-in user from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      setState(() {
        _imageUrl = userSnapshot['profileImageUrl'];
      });
    }
  }

  Future<void> _selectAndUploadImage() async {
    File? imageFile = await pickImage();
    if (imageFile != null && _user != null) {
      String userId = _user!.uid;
      String? imageUrl = await uploadImageToStorage(imageFile, userId);
      if (imageUrl != null) {
        setState(() {
          _imageFile = imageFile;
          _imageUrl = imageUrl;
        });
        updateProfileImageUrl(userId, imageUrl);
      }
    }
  }

  Future<File?> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadImageToStorage(File imageFile, String userId) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('profile_images/$userId.png');

    final uploadTask = ref.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == TaskState.success) {
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    }

    return null;
  }

  Future<void> updateProfileImageUrl(String userId, String imageUrl) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users').doc(userId);
    await userDoc.set({'profileImageUrl': imageUrl}, SetOptions(merge: true));
  }
  Stream<QuerySnapshot> getUsersWithRoleDStream() {
  return FirebaseFirestore.instance
      .collection('annonce').snapshots();
}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(top:40),
        child:Column(crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [Padding(padding: EdgeInsets.symmetric(horizontal: 20),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
          
          
          
          ],)
        ),SizedBox(height: 15,),Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
          InkWell(
            onTap:_selectAndUploadImage,
            
            child: Container(padding:EdgeInsets.all(20),
            decoration: BoxDecoration(color: Color.fromARGB(255, 1, 115, 119)
            , borderRadius: BorderRadius.circular(10),
            boxShadow: const [ BoxShadow(color: Colors.black12,
            
            blurRadius: 6,spreadRadius: 4)]
             ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Row(children: [Container(
                padding:const  EdgeInsets.all(8),
                decoration:const  BoxDecoration(
                  color: Colors.white,
                  shape:BoxShape.circle,
                ),
                child:const Icon(Icons.add,color: Color.fromARGB(255, 1, 115, 119) ,
                size:35),
                
                
              ),SizedBox(width: 20,),_imageUrl != null
                ? CircleAvatar(
                  
                    radius: 27,
                    backgroundImage: NetworkImage(_imageUrl!),
                  )
                : Text('')],),SizedBox(height: 30),FutureBuilder<String>(
      future: getUserNameFromUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error loading user data');
        }
        
        

        return 
          Text(" Hello ${snapshot.data}",style: TextStyle(
                fontSize: 18,
                color:Color.fromARGB(255, 254, 249, 249),
                fontWeight: FontWeight.w500,
              ),);
      },
    ),SizedBox(height:5,),
              Text("Select Profil picture  ",style:TextStyle(color:Colors.white54),)],
            ),
            ),
          ),
           InkWell(
            onTap:null,
            
            child: Container(padding:EdgeInsets.all(20),
            decoration: BoxDecoration(color: Color.fromARGB(255, 198, 151, 105)
            , borderRadius: BorderRadius.circular(10),
            boxShadow: const [ BoxShadow(color: Colors.black12,
            
            blurRadius: 6,spreadRadius: 4)]
             ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Container(
                padding:const  EdgeInsets.all(8),
                decoration:const  BoxDecoration(
                  color: Colors.white,
                  shape:BoxShape.circle,
                ),
                child:const Icon(Icons.card_giftcard,color: Color.fromARGB(255, 198, 151, 105),
                size:35),
                
                
              ),SizedBox(height: 30),Text("At Home",style: TextStyle(
                fontSize: 18,
                color:const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),),SizedBox(height:5,),
              Text("Best App For Delivary",style:TextStyle(color:Colors.white54),)],
            ),
            ),
          )

          
        ],),
       SizedBox(height: 25,),Padding(padding: EdgeInsets.only(left: 20),

       child:Text("What does ouer app suppoort?",style:TextStyle(
        fontSize: 23,
        fontWeight:FontWeight.w500,
        color :Colors.black54
       ))) , SizedBox(height: 10),SizedBox(height: 70,child: 
       ListView.builder(shrinkWrap: true,scrollDirection: Axis.horizontal,itemCount:supp.length ,itemBuilder: (context,index){
        return Container(
          margin: EdgeInsets.symmetric(vertical:10,horizontal: 18 ),
          padding: EdgeInsets.symmetric(horizontal: 12),decoration: BoxDecoration(
            color:   Color.fromARGB(255, 198, 151, 105),
            borderRadius:BorderRadius.circular(10),
            boxShadow:const [BoxShadow(color:Colors.black12 ,blurRadius:4,spreadRadius: 2) ] 
          ),
          child:Center(child:Text(supp[index],style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color.fromARGB(255, 255, 255, 255)
          ),))
          
        );
       })
       ,),SizedBox(height: 15,)
       ,Padding(padding:EdgeInsets.only(left:15),  child:Text("Customer Advertisements",style:TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        color: Colors.black54



       ))
       
       
       
       ),StreamBuilder<QuerySnapshot>(
      stream: getUsersWithRoleDStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error loading user data');
        }


        List<QueryDocumentSnapshot>  ann = snapshot.data!.docs;
        
print(ann.length);
        return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount: ann.length
       , shrinkWrap: true,
       itemBuilder: (context,index){
        String p=ann[index]["wei"];
        return InkWell(
onTap: (){
    Get.to(Des(), arguments:ann[index].id);
  


},child:Container(
margin: EdgeInsets.only(left:20,right: 20,bottom: 20),


decoration: BoxDecoration(
  color: Colors.white12,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
      color: Color.fromARGB(255, 206, 194, 193), // Nouvelle couleur de la bordure
      width: 2, )
  
),
child: Column(
  children: [
    
    Container(
      margin: EdgeInsets.only(top:30),
      child: CircleAvatar(
        radius: 35,
         backgroundImage: NetworkImage(ann[index]['EprofileImageUrl']!)
        
      ),
    ),Container(
      margin: EdgeInsets.only(top:15,bottom: 5),
      child: Text(ann[index]["EName"],style: TextStyle(
        
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black54
      ),),
    ),Text("Weight($p)",style:TextStyle(
      color: Colors.black45,
      fontWeight: FontWeight.w600,
    ))
    

  ],
  
)
  )

        );
       }
     
       
        );
      },
    )],)
      );
    
    
  }
}