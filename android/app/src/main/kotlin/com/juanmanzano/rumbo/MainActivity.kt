package com.juanmanzano.rumbo

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/// Recibe ofertas compartidas desde otras apps («Compartir → Rumbo») y las
/// guarda hasta que Flutter las pide por el canal `rumbo/share`.
class MainActivity : FlutterActivity() {
    private var channel: MethodChannel? = null
    private var pending: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        pending = sharedText(intent)
        channel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "rumbo/share",
        ).apply {
            setMethodCallHandler { call, result ->
                if (call.method == "takeShared") {
                    result.success(pending)
                    pending = null
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    // Con la app ya abierta (launchMode singleTop) el texto llega aquí.
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        pending = sharedText(intent) ?: return
        channel?.invokeMethod("shared", null)
    }

    private fun sharedText(intent: Intent?): String? =
        if (intent?.action == Intent.ACTION_SEND && intent.type == "text/plain") {
            intent.getStringExtra(Intent.EXTRA_TEXT)
        } else {
            null
        }
}
