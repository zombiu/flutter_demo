package com.example.android_getx.utils;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleObserver;
import androidx.lifecycle.OnLifecycleEvent;
import androidx.lifecycle.ProcessLifecycleOwner;
import androidx.lifecycle.ViewModelProvider;
import androidx.lifecycle.ViewModelStore;


public class UIDelegate {

    private volatile static UIDelegate uiDelegate;
    private ViewModelStore viewModelStore;
    private ViewModelProvider viewModelProvider;
    private boolean isBackground = true;

    private Application application;

    public static UIDelegate getInstance() {
        if (uiDelegate == null) {
            synchronized (UIDelegate.class) {
                if (uiDelegate == null) {
                    uiDelegate = new UIDelegate();
                }
            }
        }
        return uiDelegate;
    }

    public void init(Application application) {
        this.application = application;
        viewModelStore = new ViewModelStore();
        ViewModelProvider.Factory factory = ViewModelProvider.AndroidViewModelFactory.getInstance(application);
        viewModelProvider = new ViewModelProvider(viewModelStore, factory);

        LoginViewModel loginViewModel = viewModelProvider.get(LoginViewModel.class);

        ProcessLifecycleOwner.get().getLifecycle().addObserver(new LifecycleObserver() {
            @OnLifecycleEvent(Lifecycle.Event.ON_START)
            public void onForeground() {
                isBackground = false;
                Log.e("-->>", "app进入前台");
                StatusCode loginState = null;
                Log.e("-->>", "app进入前台时的状态 " + loginState);
                Log.e("-->>", "网络是否可用 ");
//                handleLoginState(loginState);
                Log.e("-->>", "网络类型为 " + NetUtils.getNetworkTypes(application));
            }

            @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
            public void onBackground() {
                isBackground = true;
                Log.e("-->>", "app进入后台");
            }
        });

    }


}
