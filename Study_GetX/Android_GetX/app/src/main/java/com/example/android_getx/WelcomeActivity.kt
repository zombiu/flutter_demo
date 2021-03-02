package com.example.android_getx

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class WelcomeActivity : AppCompatActivity() {
    private val go_flutter_page_btn: Button by lazy {
        findViewById(R.id.go_flutter_page_btn)
    }

    private lateinit var flutterEngine: FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.welcome_activity)

        go_flutter_page_btn.setOnClickListener {
//            var intent = Intent(this, MainActivity::class.java)
//            startActivity(intent)
            // 创建FlutterEngine对象

            // 创建FlutterEngine对象
            flutterEngine = createFlutterEngine()
            // 创建MethodChannel
//            createMethodChannel()
            // 跳转FlutterActivity
            startActivity(
                FlutterActivity
                    .withCachedEngine("my_engine_id")
                    .build(this)
            )
        }
    }

    private fun createFlutterEngine(): FlutterEngine {
        // 实例化FlutterEngine对象
        val flutterEngine = FlutterEngine(this)
        // 设置初始路由
        /*flutterEngine.navigationChannel.setInitialRoute(
            "route1?{\"name\":\"" + "yulong" + "\"}"
        )*/
        // 开始执行dart代码来pre-warm FlutterEngine
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        // 缓存FlutterEngine
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
        return flutterEngine
    }


}