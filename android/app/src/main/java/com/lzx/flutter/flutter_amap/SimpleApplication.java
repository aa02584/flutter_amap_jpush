package com.lzx.flutter.flutter_amap;

import android.app.Activity;

import androidx.annotation.CallSuper;
import androidx.multidex.MultiDexApplication;

import io.flutter.view.FlutterMain;

public class SimpleApplication extends MultiDexApplication {

    @Override
    @CallSuper
    public void onCreate() {
        super.onCreate();
        FlutterMain.startInitialization(this);
    }

    private Activity mCurrentActivity = null;
    public Activity getCurrentActivity() {
        return mCurrentActivity;
    }
    public void setCurrentActivity(Activity mCurrentActivity) {
        this.mCurrentActivity = mCurrentActivity;
    }
}
