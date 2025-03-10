package com.signonglass

import android.content.Context
import android.graphics.Bitmap
import android.util.AttributeSet
import android.util.Base64
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReactContext
import com.facebook.react.uimanager.events.RCTEventEmitter
import com.github.gcacace.signaturepad.views.SignaturePad
import java.io.ByteArrayOutputStream

class SignOnGlassView(context: Context?, attrs: AttributeSet?) : SignaturePad(context, attrs) {
    private var pencilWeight: Int = 2
    private var penColor: Int = android.graphics.Color.BLACK

    init {
      init()
    }

    private fun init() {
        // Set default properties
        setPenColor(penColor)
        setMinWidth(0.5f)
        setMaxWidth(pencilWeight.toFloat())

        // Set on signature listener
        setOnSignedListener(object : SignaturePad.OnSignedListener {
            override fun onStartSigning() {
                // Optional: Handle start of signing
            }

            override fun onSigned() {
                // Optional: Handle when signature is completed
            }

            override fun onClear() {
                // Optional: Handle when signature is cleared
            }
        })
    }

    fun setPencilWeight(weight: Int) {
        pencilWeight = weight
        setMaxWidth(weight.toFloat())
    }

    // Convert signature to base64 string
    fun getSignatureAsBase64(): String {
        val signatureBitmap = signatureBitmap
        if (signatureBitmap != null) {
            val byteArrayOutputStream = ByteArrayOutputStream()
            signatureBitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
            val byteArray = byteArrayOutputStream.toByteArray()
            return Base64.encodeToString(byteArray, Base64.DEFAULT)
        }
        return ""
    }

    // Emit the signature exposed event
    fun emitSignatureExposedEvent(signature: String) {
        val reactContext = context as ReactContext
        val event = Arguments.createMap()
        event.putString("signature", signature)

        reactContext.getJSModule(RCTEventEmitter::class.java).receiveEvent(
            id,
            "topSignatureExposed", // This should match the native event name expected in JS
            event
        )
    }
}
