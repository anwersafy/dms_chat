import 'package:flutter/material.dart';
import 'package:frontend/pages/chat/view/input/chat_input.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:frontend/pages/chat/view/conversation/chat_conversation.dart';
import 'package:frontend/pages/chat/view/message/chat_message.dart';
import 'package:frontend/pages/chat/view/prompt/chat_prompt.dart';
import 'package:frontend/pages/chat/provider/chat_provider.dart';

///
/// 智能对话[AI-Conversation]
/// 页面子view位置[lib/pages/chat/view]
///
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends ConsumerState<ChatPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin  {
  String _selectedVersion = 'الاقتصاد'; // Default selected version
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    checkDefaultConversationMessage();

    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVersionChanged(String? newValue) {
    if (newValue != null) {
      _controller.reset();
      _selectedVersion = newValue;
      _controller.forward();
    }
  }


  ///校验默认对话消息
  checkDefaultConversationMessage() async {
    bool conversationExist =
        await ref.read(conversationProvider.notifier).checkConversationList();
    //默认对话不存在
    if (!conversationExist) {
      //新增对话
      final key =
          await ref.read(conversationProvider.notifier).addConversation();
      //新增打招呼语消息
      // await ref.read(conversationProvider.notifier).addDefaultMessages(key);
    }
    //查询所有对话
    ref.read(conversationProvider.notifier).queryConversationList();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const ChatConversation(),
              Container(
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, top: 16, bottom: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          width: 1)),
                  child: Column(children: [
                    Expanded(
                        child: Container(
                            alignment: Alignment.topCenter,
                            color: Theme.of(context).colorScheme.background,
                            constraints: const BoxConstraints(
                                minWidth: 360, maxWidth: 752),
                            child: const ChatMessage())),
                    Row(

                      children: [
                        Padding(
                          padding: const EdgeInsets.only( top: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              DropdownButton<String>(
                                //  style: TextStyle(fontSize: 24, color: Colors.grey[800]),
                                borderRadius: BorderRadius.circular(8),
                                underline: SizedBox(),

                                menuMaxHeight: 290,
                                  // padding: EdgeInsets.only( bottom: 20),


                                value: _selectedVersion,
                                onChanged: _onVersionChanged,
                                items: <String>['الاقتصاد', 'الصحه','الامن','التعليم','سياسه خارجيه'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text('$value'),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    width: 1)),
                              margin: const EdgeInsets.only(right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Checkbox(
                                    value: true,
                                    onChanged: (value){
                                      print(value);
                                    },
                                  ),

                                   Text('بيان صحفي',style: TextStyle(
                                     fontSize: 14


                                   ),)                                  ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      width: 1)),
                              margin: const EdgeInsets.only(right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Checkbox(
                                    value: true,
                                    onChanged: (value){
                                      print(value);
                                    },
                                  ),

                                  Text(' وقوع اصابات',style: TextStyle(
                                      fontSize: 14


                                  ),)                                  ],
                              )),
                        ),

                      ],
                    ),



                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ChatInput())
                  ])),
              //右侧聊天主题列表
              const ChatPrompt()
            ])
          ])),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
