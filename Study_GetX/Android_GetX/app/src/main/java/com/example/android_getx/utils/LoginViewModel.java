package com.example.android_getx.utils;


import android.util.Log;

import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModel;

public class LoginViewModel extends ViewModel {
    private MutableLiveData<StatusCode> statusCodeMutableLiveData = new MutableLiveData<StatusCode>();
    private final Observer<StatusCode> statusCodeObserver;
    private StatusCode statusCode;

    public LoginViewModel() {
        statusCodeObserver = new Observer<StatusCode>() {

            @Override
            public void onChanged(StatusCode statusCode) {
                Log.e("-->>", "当前状态为 " + statusCode);
                LoginViewModel.this.statusCode = statusCode;
                statusCodeMutableLiveData.setValue(statusCode);
            }
        };

    }

    public MutableLiveData<StatusCode> observerLoginState() {
        statusCodeMutableLiveData.setValue(statusCode);
        return statusCodeMutableLiveData;
    }

    public StatusCode getLoginState() {
        return statusCode;
    }

    @Override
    protected void onCleared() {

        super.onCleared();
    }
}
