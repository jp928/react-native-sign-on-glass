package com.signonglass

import android.graphics.Color
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.common.MapBuilder
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.viewmanagers.SignOnGlassViewManagerInterface
import com.facebook.react.viewmanagers.SignOnGlassViewManagerDelegate

@ReactModule(name = SignOnGlassViewManager.NAME)
class SignOnGlassViewManager : SimpleViewManager<SignOnGlassView>(),
  SignOnGlassViewManagerInterface<SignOnGlassView> {
  private val mDelegate: ViewManagerDelegate<SignOnGlassView>

  init {
    mDelegate = SignOnGlassViewManagerDelegate(this)
  }

  override fun getDelegate(): ViewManagerDelegate<SignOnGlassView>? {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): SignOnGlassView {
    return SignOnGlassView(context, null)
  }

  @ReactProp(name = "color")
  override fun setColor(view: SignOnGlassView?, color: String?) {
    if (view != null && color != null) {
      try {
        val parsedColor = Color.parseColor(color)
        // view.setPenColor(parsedColor)
        view.setBackgroundColor(parsedColor)
      } catch (e: IllegalArgumentException) {
        // Handle invalid color format
        // view.setPenColor(Color.BLACK)
      }
    }
  }

  @ReactProp(name = "pencilWeight", defaultInt = 2)
  override fun setPencilWeight(view: SignOnGlassView?, weight: Int) {
    view?.setPencilWeight(weight)
  }

  // Handle commands from JavaScript
  override fun receiveCommand(view: SignOnGlassView, commandId: String, args: ReadableArray?) {
    when (commandId) {
      "clearSignature" -> {
        view.clear()
      }
      "exposeSignature" -> {
        val signature = view.getSignatureAsBase64()
        view.emitSignatureExposedEvent(signature)
      }
    }
  }

  // Export direct event types
  override fun getExportedCustomDirectEventTypeConstants(): MutableMap<String, Any>? {
    return MapBuilder.builder<String, Any>()
      .put(
        "topSignatureExposed",
        MapBuilder.of(
          "registrationName",
          "onSignatureExposed"
        )
      )
      .build()
  }

  // Implement the missing abstract methods from SignOnGlassViewManagerInterface
  override fun clearSignature(view: SignOnGlassView?) {
    view?.clear()
  }

  override fun exposeSignature(view: SignOnGlassView?) {
    val signature = view?.getSignatureAsBase64() ?: ""
    view?.emitSignatureExposedEvent(signature)
  }


  companion object {
    const val NAME = "SignOnGlassView"
  }
}