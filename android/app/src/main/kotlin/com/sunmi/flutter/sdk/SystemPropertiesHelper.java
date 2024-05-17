package com.sunmi.flutter.sdk;

import java.lang.reflect.Method;

public final class SystemPropertiesHelper {

    private SystemPropertiesHelper() {
        throw new AssertionError();
    }

    public static String get(String key) {
        try {
            Class< ? > clazz = Class.forName("android.os.SystemProperties");
            Method method = clazz.getDeclaredMethod("get", String.class);
            method.setAccessible(true);
            return (String) method.invoke(null, key);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}