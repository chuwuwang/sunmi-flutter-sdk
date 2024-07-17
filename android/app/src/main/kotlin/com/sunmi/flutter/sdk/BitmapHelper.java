package com.sunmi.flutter.sdk;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.util.Base64;

import java.io.ByteArrayOutputStream;

public class BitmapHelper {

    public static Bitmap scale(Bitmap bitmap, int newWidth, int newHeight) {
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        float scaleWidth = (float) newWidth / width;
        float scaleHeight = (float) newHeight / height;
        Matrix matrix = new Matrix();
        matrix.postScale(scaleWidth, scaleHeight);
        return Bitmap.createBitmap(bitmap, 0, 0, width, height, matrix, true);
    }

    public static String bitmap2Base64String(Bitmap bitmap) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
        byte[] bytes = outputStream.toByteArray();
        return Base64.encodeToString(bytes, Base64.DEFAULT);
    }

    public static Bitmap base64String2Bitmap(String base64) {
        byte[] bytes = Base64.decode(base64, Base64.DEFAULT);
        return BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
    }

    public static Bitmap addBackgroundBitmap(Bitmap orginBitmap, int color) {
        Paint paint = new Paint();
        paint.setColor(color);
        int width = orginBitmap.getWidth();
        int height = orginBitmap.getHeight();
        Bitmap.Config config = orginBitmap.getConfig();
        Bitmap bitmap = Bitmap.createBitmap(width, height, config);
        Canvas canvas = new Canvas(bitmap);
        canvas.drawRect(0, 0, width, height, paint);
        canvas.drawBitmap(orginBitmap, 0, 0, paint);
        return bitmap;
    }

    /**
     * O T S U 算法获取二值图
     *
     * @param srcBitmap 图像像素数组地址（ ARGB 格式）
     * @return 二值图像素数组地址
     */
    public static Bitmap bitmap2OTSUBitmap(Bitmap srcBitmap) {
        int width = srcBitmap.getWidth();
        int height = srcBitmap.getHeight();
        double pixel_total = width * height; // 像素总数
        if (pixel_total == 0) return null;

        Bitmap bitmap = srcBitmap.copy(Bitmap.Config.ARGB_8888, true);

        long sum1 = 0;          // 总灰度值
        long sumB = 0;          // 背景总灰度值
        double wB = 0.0;        // 背景像素点比例
        double wF = 0.0;        // 前景像素点比例
        double mB = 0.0;        // 背景平均灰度值
        double mF = 0.0;        // 前景平均灰度值
        double max_g = 0.0;     // 最大类间方差
        double g = 0.0;         // 类间方差
        int threshold = 0;      // 阈值
        double[] histogram = new double[256]; // 灰度直方图, 下标是灰度值, 保存内容是灰度值对应的像素点总数

        // 获取灰度直方图和总灰度
        for (int i = 0; i < pixel_total; i++) {
            int x = i % width;
            int y = i / width;
            int pixel = bitmap.getPixel(x, y);
            // 分离三原色及透明度
            int alpha = Color.alpha(pixel);
            int red = Color.red(pixel);
            int green = Color.green(pixel);
            int blue = Color.blue(pixel);

            int gray = (red * 38 + green * 75 + blue * 15) >> 7;
            if (alpha == 0 && gray == 0) {
                gray = 0xFF;
            }
            if (gray > 0xFF) {
                gray = 0xFF;
            }
            bitmap.setPixel(x, y, gray | 0xFFFFFF00);
            // 计算灰度直方图分布, Histogram 数组下标是灰度值, 保存内容是灰度值对应像素点数
            histogram[gray]++;
            sum1 += gray;
        }

        // O T S U 算法
        for (int i = 0; i < 256; i++) {
            wB = wB + histogram[i]; // 这里不算比例，减少运算，不会影响求 T
            wF = pixel_total - wB;
            if (wB == 0 || wF == 0) {
                continue;
            }
            sumB = (long) (sumB + i * histogram[i]);
            mB = sumB / wB;
            mF = (sum1 - sumB) / wF;
            g = wB * wF * (mB - mF) * (mB - mF);
            if (g >= max_g) {
                threshold = i;
                max_g = g;
            }
        }

        for (int i = 0; i < pixel_total; i++) {
            int x = i % width;
            int y = i / width;
            int pixel = bitmap.getPixel(x, y) & 0x000000FF;
            int color = pixel <= threshold ? 0xFF000000 : 0xFFFFFFFF;
            bitmap.setPixel(x, y, color);
        }

        return bitmap;
    }

    /**
     * 平均灰度算法获取二值图
     */
    public static Bitmap grayAverageBitmap2BinaryBitmap(Bitmap srcBitmap) {
        int width = srcBitmap.getWidth();
        int height = srcBitmap.getHeight();
        double pixel_total = width * height; // 像素总数
        if (pixel_total == 0) return null;

        Bitmap bitmap = srcBitmap.copy(Bitmap.Config.ARGB_8888, true);

        long sum = 0;           // 总灰度
        int threshold = 0;      // 阈值
        for (int i = 0; i < pixel_total; i++) {
            int x = i % width;
            int y = i / width;
            int pixel = bitmap.getPixel(x, y);

            // 分离三原色及透明度
            int alpha = Color.alpha(pixel);
            int red = Color.red(pixel);
            int green = Color.green(pixel);
            int blue = Color.blue(pixel);

            int gray = (red * 38 + green * 75 + blue * 15) >> 7;
            if (alpha == 0 && gray == 0) {
                gray = 0xFF;
            }

            if (gray > 0xFF) {
                gray = 0xFF;
            }
            bitmap.setPixel(x, y, gray | 0xFFFFFF00);
            sum += gray;
        }

        // 计算平均灰度
        threshold = (int) (sum / pixel_total);

        for (int i = 0; i < pixel_total; i++) {
            int x = i % width;
            int y = i / width;
            int pixel = bitmap.getPixel(x, y) & 0x000000FF;
            int color = pixel <= threshold ? 0xFF000000 : 0xFFFFFFFF;
            bitmap.setPixel(x, y, color);
        }

        return bitmap;
    }

    public static Bitmap bitmap2GrayBitmap(Bitmap bmSrc) {
        int width = bmSrc.getWidth();
        int height = bmSrc.getHeight();
        // 创建目标灰度图像
        Bitmap bmpGray = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
        // 创建画布
        Canvas c = new Canvas(bmpGray);
        Paint paint = new Paint();
        ColorMatrix cm = new ColorMatrix();
        cm.setSaturation(0);
        ColorMatrixColorFilter f = new ColorMatrixColorFilter(cm);
        paint.setColorFilter(f);
        c.drawBitmap(bmSrc, 0, 0, paint);
        return bmpGray;
    }

    public static Bitmap grayBitmap2BinaryBitmap(Bitmap srcBitmap, boolean isReverse) {
        int width = srcBitmap.getWidth();
        int height = srcBitmap.getHeight();
        // 创建二值化图像
        Bitmap binaryBitmap = srcBitmap.copy(Bitmap.Config.ARGB_8888, true);
        // 依次循环, 对图像的像素进行处理
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                // 得到当前像素的值
                int col = binaryBitmap.getPixel(i, j);
                // 得到alpha通道的值
                int alpha = Color.alpha(col);
                // 得到图像的像素RGB的值
                int red = Color.red(col);
                int green = Color.green(col);
                int blue = Color.blue(col);
                // 用公式X = 0.3×R+0.59×G+0.11×B计算出X代替原来的RGB
                // int gray = (int) ((float) red * 0.3 + (float) green * 0.59 + (float) blue * 0.11);
                int gray = (red * 38 + green * 75 + blue * 15) >> 7;  // 降低浮点运算
                // 对图像进行二值化处理
                if (gray > 128) {
                    gray = isReverse ? 0xFF000000 : 0xFFFFFFFF;
                } else {
                    gray = isReverse ? 0xFFFFFFFF : 0xFF000000;
                }
                // 设置新图像的当前像素值
                binaryBitmap.setPixel(i, j, gray);
            }
        }
        return binaryBitmap;
    }

    /**
     * 提高图片亮度
     */
    public static Bitmap bitmap2LightBitmap(Bitmap bitmap) {
        // 得到图像的宽度和长度
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        Bitmap outputBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        // 依次循环对图像的像素进行处理
        final float[] a = new float[20];
        a[0] = a[6] = a[12] = a[18] = 1;
        a[4] = a[9] = a[14] = 50;
        ColorMatrix cm = new ColorMatrix(a);
        Paint paint = new Paint();
        ColorMatrixColorFilter f = new ColorMatrixColorFilter(cm);
        paint.setColorFilter(f);
        Canvas c = new Canvas(outputBitmap);
        c.drawBitmap(bitmap, 0, 0, paint);
        return outputBitmap;
    }

}
