
import 'package:flutter/services.dart';

///flutter native 通信
class ChannelManager {

  //创建 BasicMessageChannel
  // flutter_and_native_100 为通信标识
  // StandardMessageCodec() 为参数传递的 编码方式
  static const messageChannel = const BasicMessageChannel(
      'flutter_and_native_100', StandardMessageCodec());

  //发送消息
 static Future<Map> sendMessage(Map arguments) async {
    Map reply = await messageChannel.send(arguments);
    //解析 原生发给 Flutter 的参数
    int code = reply["code"];
    String message = reply["message"];
    print("native返回的消息为 $code  $message");
    return reply;
  }

  //接收消息监听
 static void receiveMessage() {
    messageChannel.setMessageHandler((result) async {
      //解析 原生发给 Flutter 的参数
      int code = result["code"];
      String message = result["message"];
      print("接收到 native 发送的消息为 $code  $message");
      /*setState(() {
        recive = "receiveMessage: code:$code message:$message";
      });*/
      ///返回给native的消息
      return 'flutter的返回值：Flutter 已收到消息';
    });
  }
}