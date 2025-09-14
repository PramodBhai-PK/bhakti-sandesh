package com.pkbhai.bhaktisandesh

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.android.gms.ads.MobileAds

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.pkbhai.bhaktisandesh/admob"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setAdMobAppId") {
                val appId = call.argument<String>("appId")
                if (appId != null) {
                    MobileAds.initialize(this) { initializationStatus ->
                        result.success(true)
                    }
                } else {
                    result.error("INVALID_APP_ID", "AdMob App ID is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}