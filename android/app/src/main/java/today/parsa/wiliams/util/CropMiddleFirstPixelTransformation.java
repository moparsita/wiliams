package today.parsa.wiliams.util;

import android.graphics.Bitmap;
import android.graphics.Color;
import android.util.Log;


/**
 * Created by MosiOne70 on 11/05/2021.
 */
public class CropMiddleFirstPixelTransformation {
    private int mWidth;
    private int mHeight;

    private static final String TAG = "CropMiddleFirstPixelTra";

    public static Bitmap TrimBitmap(Bitmap bmp) {
        int imgHeight = bmp.getHeight();
        int imgWidth = bmp.getWidth();
/*
        //TRIM WIDTH - LEFT
        int startWidth = 0;
        for (int x = 0; x < imgWidth; x++) {
            if (startWidth == 0) {
                for (int y = 0; y < imgHeight; y++) {
                    if (bmp.getPixel(x, y) != Color.TRANSPARENT) {
                        startWidth = x;
                        break;
                    }
                }
            } else break;
        }
        //TRIM WIDTH - RIGHT
        int endWidth = 0;
        for (int x = imgWidth - 1; x >= 0; x--) {
            if (endWidth == 0) {
                for (int y = 0; y < imgHeight; y++) {
                    if (bmp.getPixel(x, y) != Color.TRANSPARENT) {
                        endWidth = x;
                        break;
                    }
                }
            } else break;
        }
*/
        //TRIM HEIGHT - TOP
        int startHeight = 0;
        for (int y = 0; y < imgHeight; y++) {
            if (startHeight == 0) {
                for (int x = 0; x < imgWidth; x++) {
                    int pixColor = bmp.getPixel(x, y);

                    if (pixColor != Color.WHITE) {
                        Log.d(TAG, "HEIGHT - TOP: " + pixColor);
                        startHeight = y;
                        break;
                    }
                }
            } else break;
        }

        //TRIM HEIGHT - BOTTOM
        int endHeight = 0;
        for (int y = imgHeight - 1; y >= 0; y--) {
            if (endHeight == 0) {
                for (int x = 0; x < imgWidth; x++) {
                    int pixColor = bmp.getPixel(x, y);

                    if (pixColor != Color.WHITE) {
                        Log.d(TAG, "HEIGHT - BOTTOM: " + pixColor);
                        endHeight = y;
                        break;
                    }
                }
            } else break;
        }

        Log.d(TAG, "HEIGHT - startHeight: " + startHeight + "HEIGHT - endHeight: " + endHeight);
        return Bitmap.createBitmap(
                bmp,
                0,
                startHeight,
                imgWidth,
                endHeight - startHeight
        );
    }
}