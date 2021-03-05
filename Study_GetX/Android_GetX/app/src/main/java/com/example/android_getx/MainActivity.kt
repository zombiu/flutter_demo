package com.example.android_getx

import android.content.Context
import android.os.Bundle
import com.example.android_getx.utils.GitHubService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory


class MainActivity : FlutterActivity() {
    //属性的延迟加载 lazy是一个函数，返回一个委托对象Lazy，而message最终在编译后，会被替换为Lazy对象。
    private val message : String by lazy {
        // 下面这段代码将在第一次访问message时执行
       "123456"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_main)

        val retrofit = Retrofit.Builder()
            .baseUrl("https://api.github.com/")
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .build()

        val service = retrofit.create(GitHubService::class.java)

    }

    /**
     * 自定义FlutterActivity时，用来设置缓存FlutterEngine
     */
    /*override fun getCachedEngineId(): String? {
        return "my_engine_id"
    }*/

    override fun provideFlutterEngine(context: Context): FlutterEngine? = FlutterEngineCache.getInstance().get("my_engine_id")

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        //自动注册插件，无须手动注册
//        GeneratedPluginRegistrant.registerWith(flutterEngine);

        var channelPlugin = ChannelPlugin()
        channelPlugin.register(flutterEngine)
    }

    private fun createFlutterEngine(): FlutterEngine {
        // 实例化FlutterEngine对象
        val flutterEngine = FlutterEngine(this)
        // 设置初始路由
        flutterEngine.navigationChannel.setInitialRoute(
            "route1?{\"name\":\"" + "yulong" + "\"}"
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