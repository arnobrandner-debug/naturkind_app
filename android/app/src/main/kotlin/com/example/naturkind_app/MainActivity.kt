package com.example.naturkind_app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onResume() {
        super.onResume()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "default_channel"
            val channelName = "Allgemein"
            val nm = getSystemService(NotificationManager::class.java)
            // Channel nur einmalig anlegen, falls noch nicht vorhanden
            if (nm?.getNotificationChannel(channelId) == null) {
                val ch = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_DEFAULT)
                nm?.createNotificationChannel(ch)
            }
        }
    }
}
