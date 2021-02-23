package com.example.android_getx;

import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import com.blankj.utilcode.util.LogUtils;
import com.blankj.utilcode.util.Utils;
import com.example.android_getx.utils.UIDelegate;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;

public class ChannelPlugin {
    private BasicMessageChannel<Object> mMessageChannel;

    public void register(FlutterEngine flutterEngine) {
        //消息接收监听
        //BasicMessageChannel （主要是传递字符串和一些半结构体的数据）
        //创建通
        mMessageChannel = new BasicMessageChannel<Object>(flutterEngine.getDartExecutor(), "flutter_and_native_100", StandardMessageCodec.INSTANCE);
        // 接收消息监听
        mMessageChannel.setMessageHandler(new BasicMessageChannel.MessageHandler<Object>() {
            @Override
            public void onMessage(Object o, BasicMessageChannel.Reply<Object> reply) {

                Map<Object, Object> arguments = (Map<Object, Object>) o;

                //方法名标识
                String lMethod = (String) arguments.get("method");

                //测试 reply.reply()方法 发消息给Flutter
                if (lMethod.equals("test")) {
                    LogUtils.e("-->>flutter 调用到了 android test");
                    Toast.makeText(Utils.getApp(), "flutter 调用到了 android test", Toast.LENGTH_SHORT).show();
                    //回调Flutter
                    Map<String, Object> resultMap = new HashMap<>();
                    resultMap.put("message", "reply.reply 返回给flutter的数据");
                    resultMap.put("code", 200);
                    //回调 此方法只能使用一次
                    reply.reply(resultMap);
                } else if (lMethod.equals("test2")) {
                    //测试 mMessageChannel.send 发消息给Flutter
                    //Android 可通过这个方法来主动向 Flutter中发送消息
                    //只有Flutter 中注册了消息监听 才能接收到这个方法向 Flutter 中发送的消息
                    channelSendMessage();
                } else if (lMethod.equals("test3")) {
                    //测试通过Flutter打开Android Activity
                    Toast.makeText(Utils.getApp(), "flutter 调用到了 android test3", Toast.LENGTH_SHORT).show();
//                    Intent lIntent = new Intent(MainActivity.this, TestBasicMessageActivity.class);
//                    MainActivity.this.startActivity(lIntent);
                }
            }
        });

    }

    private void channelSendMessage() {
        LogUtils.e("-->>flutter 调用到了 android channelSendMessage");
        Toast.makeText(Utils.getApp(), "flutter 调用到了 android test", Toast.LENGTH_SHORT).show();
        //构建参数
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "reply.reply 返回给flutter的数据");
        resultMap.put("code", 200);
        //向 Flutter 中发送消息
        //参数 二可以再次接收到 Flutter 中的回调
        //也可以直接使用 mMessageChannel.send(resultMap）
        mMessageChannel.send(resultMap, new BasicMessageChannel.Reply<Object>() {
            @Override
            public void reply(Object o) {

                Log.d("mMessageChannel", "mMessageChannel send 回调 " + o);
            }
        });
    }
}
