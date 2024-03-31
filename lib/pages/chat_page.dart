import 'package:chatapp/HandleFireBase/chat_service.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
          _buildMessageInput()
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder(stream: _chatService.getMessages(widget.receiverUserId , _firebaseAuth.currentUser!.uid), builder: (context, snapshot) {
      if(snapshot.hasError){
        return Text('Error${snapshot.error}');
      }
      
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text('Loading...');
      }

      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
      );
    },);
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;


    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)?Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(children: [
        Text(data['senderEmail']),
        Text(data['message'])
      ],),
    );

  }


  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child:
                MyTextField(obscure: false, text: 'Enter message', controller: _messageController)),
        
        IconButton(onPressed: sendMessage, icon: Icon(Icons.send))
      ],
    );
  }
}
