package com.example.car_monitor

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Enable onBackInvoked callback for Android 13+ back navigation
        // This is the programmatic way to enable the back navigation callback
        // which works in conjunction with the manifest setting
        window.setDecorFitsSystemWindows(false)
        super.onCreate(savedInstanceState)
    }
}
