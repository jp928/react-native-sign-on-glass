package com.signonglass

import android.graphics.Color
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
    return SignOnGlassView(context)
  }

  @ReactProp(name = "color")
  override fun setColor(view: SignOnGlassView?, color: String?) {
    view?.setBackgroundColor(Color.parseColor(color))
  }

  companion object {
    const val NAME = "SignOnGlassView"
  }
}
