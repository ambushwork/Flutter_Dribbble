package com.netatmo.ylu.flutter_dribbble

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.TextView

class AuthCallbackActivity : Activity(){
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_auth_callback)
        val code_text_view = findViewById<TextView>(R.id.code_text)
        if(Intent.ACTION_VIEW == intent?.action){
            val intentData = intent.data
            val code = intentData?.getQueryParameter("code")
            code_text_view.text = code
        }
    }
}