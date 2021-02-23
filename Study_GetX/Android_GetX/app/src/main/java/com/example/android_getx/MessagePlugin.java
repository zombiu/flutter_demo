package com.example.android_getx;

import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * GeneratedPluginRegistrant
 * 这个类是根据 pubspec.yaml 中的依赖生成的
 * 如果需要GeneratedPluginRegistrant中自动注册插件，那么需要创建对应的插件
 */
public class MessagePlugin implements FlutterPlugin , MethodChannel.MethodCallHandler, ActivityAware {
    private Context applicationContext;
    private MethodChannel methodChannel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getApplicationContext(), binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        applicationContext = null;
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }

    /** Plugin registration. */
    @SuppressWarnings("deprecation")
    public static void registerWith(io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
        final MessagePlugin instance = new MessagePlugin();
        instance.onAttachedToEngine(registrar.context(), registrar.messenger());
    }

    private void onAttachedToEngine(Context applicationContext, BinaryMessenger messenger) {
        this.applicationContext = applicationContext;
        methodChannel = new MethodChannel(messenger, "plugins.flutter.io/message_plugin");
        methodChannel.setMethodCallHandler(this);
    }
}
