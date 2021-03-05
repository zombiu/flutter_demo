package com.example.android_getx

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragment

class FlutterMainActivity : AppCompatActivity() {

    companion object {
        fun start(context: Context) {
            val intent = Intent(context, FlutterMainActivity::class.java)
            context.startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_flutter_main)

        //直接启动FlutterFragment
        var fragmentManager = getSupportFragmentManager();
        //默认路由,相当于:initialRoute("/")
        //FlutterFragment flutterFragment = FlutterFragment.createDefault();
        var flutterFragment:FlutterFragment = FlutterFragment.withNewEngine()
            .initialRoute("/provider")   //设置路由
            .build()
        fragmentManager
            .beginTransaction()
            .add(R.id.fragment_container, flutterFragment, "flutter_fragment")
            .commit();
    }
}