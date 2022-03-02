package com.sunmi.sunmi_flutter_sdk;

import android.annotation.SuppressLint;

import java.lang.reflect.Method;

public final class SystemPropertiesHelper {

    private SystemPropertiesHelper() {
        throw new AssertionError();
    }

    @SuppressLint("PrivateApi")
    public static String get(String key) {
        try {
            Class<?> clazz = Class.forName("android.os.SystemProperties");
            Method method = clazz.getDeclaredMethod("get", String.class);
            method.setAccessible(true);
            return (String) method.invoke(null, key);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}