package com.example.android_getx

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.blankj.utilcode.util.LogUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class WelcomeActivity : AppCompatActivity() {
    private val go_flutter_page_btn: Button by lazy {
        findViewById(R.id.go_flutter_page_btn)
    }
    private val go_flutter_page_btn2: Button by lazy {
        findViewById(R.id.go_flutter_page_btn2)
    }

//    private lateinit var flutterEngine: FlutterEngine
    private var flutterEngine: FlutterEngine? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.welcome_activity)

        go_flutter_page_btn.setOnClickListener {
            // 创建FlutterEngine对象
//            flutterEngine = createFlutterEngine()
            // 创建MethodChannel
//            createMethodChannel()

            // 设置初始路由
//            flutterEngine?.navigationChannel?.setInitialRoute("/provider")
            // 开始执行dart代码来pre-warm FlutterEngine
            /*flutterEngine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )*/
            // 跳转FlutterActivity
            /*var intent = FlutterActivity
                .withCachedEngine("my_engine_id")
                .build(this)
            //withNewEngine() 可以设置 route*/

            var intent = Intent(this, MainActivity::class.java)
            intent.putExtra("route", "/provider")
            startActivity(intent)
        }

        go_flutter_page_btn2.setOnClickListener {
            FlutterMainActivity.start(this)
        }
    }

    private fun createFlutterEngine(): FlutterEngine? {
        // 实例化FlutterEngine对象
        var flutterEngine = FlutterEngineCache.getInstance().get("my_engine_id")
        if (flutterEngine == null) {
//            flutterEngine = FlutterEngine(this)
            return null
        }
        LogUtils.e("--<< 获取的引擎是 ${flutterEngine}")
        // 设置初始路由
        flutterEngine.navigationChannel.setInitialRoute(
            "/video_conference_home?name=yulong"
        )
        // 开始执行dart代码来pre-warm FlutterEngine
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        // 缓存FlutterEngine
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
        return flutterEngine
    }


}