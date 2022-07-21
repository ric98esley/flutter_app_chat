import 'dart:io';
import 'package:chat_app/models/message_respose.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _focusNode = FocusNode();
  final _chatController = TextEditingController();
  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  List<ChatMessage> _messages = [];
  bool _writting = false;
  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService!.socket.on('private-message', _listenMessage);
    _loadHistory(chatService!.userFrom!.uid);
  }

  void _loadHistory(String userUID) async {
    List<Message> chat = await chatService!.getChat(userUID);
    final historyMsg = chat.map((m) => ChatMessage(
          texto: m.msg,
          uid: m.from,
          animationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 0))
            ..forward(),
        ));

    setState(() {
      _messages.insertAll(0, historyMsg);
    });

    print(chat);
  }

  void _listenMessage(dynamic data) {
    ChatMessage message = ChatMessage(
      texto: data['msg'],
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
      uid: data['from'],
    );
    setState(() {
      _messages.insert(0, message);
      message.animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final toUser = chatService!.userFrom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                child: Text(
                  toUser!.name.substring(0, 2),
                  style: TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.blue[100],
                maxRadius: 14,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                toUser.name,
                style: TextStyle(color: Colors.black87, fontSize: 12),
              )
            ]),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    itemCount: _messages.length,
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (_, i) => _messages[i])),
            Divider(
              height: 2,
            ),
            _inputChat()
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: [
        Flexible(
            child: TextField(
          controller: _chatController,
          onSubmitted: _handleSubmit,
          onChanged: (String text) {
            //Todo when there is value, it can post it
            setState(() {
              if (text.trim().length > 0) {
                _writting = true;
              } else {
                _writting = false;
              }
            });
          },
          decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          focusNode: _focusNode,
        )),
        // Boton de envia
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: Platform.isIOS
              ? CupertinoButton(child: Text('Enviar'), onPressed: () {})
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send),
                      onPressed: _writting
                          ? () => _handleSubmit(_chatController.text.trim())
                          : null,
                    ),
                  ),
                ),
        )
      ]),
    ));
  }

  _handleSubmit(String text) {
    if (text.length == 0) return;
    _chatController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      texto: text,
      uid: authService!.user.uid,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _writting = false;
    });
    socketService!.emit('private-message', {
      'from': authService!.user.uid,
      'to': chatService!.userFrom!.uid,
      'msg': text
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService!.socket.off('private-message');
    super.dispose();
  }
}
