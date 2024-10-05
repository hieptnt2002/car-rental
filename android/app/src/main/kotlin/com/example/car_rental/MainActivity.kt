package com.example.car_rental

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel = "flutter.method.channel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "getFlavor") {
                result.success(getFlavorSetting())
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getFlavorSetting(): String {
        return BuildConfig.FLAVOR;
    }
}
