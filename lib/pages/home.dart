
import 'package:chatapp/HandleFireBase/authFireBase.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut() async{
    
    final credential = Provider.of<FireAuth>(context, listen: false);

    try {
      await credential.signOut();
    } catch (e) {
      showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Something went wrong please try again!'),
        ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout))
        ],
      ),
      body: buildUserList(),
    );
  }

  Widget buildUserList(){
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('users').snapshots(), builder: (context, snapshot) {
      if(snapshot.hasError){
        return const Text('Error');
      }

      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text('loading...');
      }

      return ListView(
        children: snapshot.data!.docs.map((doc) => buildUserListItem(doc)).toList() ,
      );

    },);
  }
   
  Widget buildUserListItem(DocumentSnapshot document){
     Map<String, dynamic> data = document.data()! as Map<String , dynamic>;

     if(_auth.currentUser!.email != data['email'] ){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(receiverUserEmail: data['email'], receiverUserId: data['uid'],),));
        },
      );
     }else{
      return Container();
     }
  }
}