package today.parsa.wiliams;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.widget.Toast;

import com.kishcore.sdk.hybrid.api.SDKManager;
import com.kishcore.sdk.hybrid.api.WaterMarkLanguage;

import java.util.ArrayList;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugins.GeneratedPluginRegistrant;
import today.parsa.wiliams.model.PrintModel;

public class MainActivity extends FlutterActivity {
    private static final String PRINTER_CHANNEL = "today.parsa.wiliams/printer";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {


        new MethodChannel(flutterEngine.getDartExecutor(), PRINTER_CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("printFactor")) {
                            printFactor();


                        }
                    }
                }
        );
    }



        private void printFactor() {
            if (SDKManager.getPrinterStatus() == SDKManager.STATUS_OK) {
                //Print method takes an instance of Printable Data and a DataCallback as input
                //In this example, the printer starts printing an instance of TestPrintableDataList
                //then after successful end of printing first item it starts printing an instance of ListPrintableData.

                //***** Print View or List of Objects *****
                ArrayList<PrintModel> printModels = new ArrayList<>();
                String title = "تست", des = "این سطر شماره ";
                int count = 4;
                for (int i = 1; i <= count; i++) {
                    printModels.add(new PrintModel(title + i, des + i));
                }

//                SDKManager.print(MainActivity.this, new TestPrintableData(), objects -> SDKManager.print(MainActivity.this, new ListPrintableData("این سطر اول است", "سطر دوم پایین تر است", "سطر سوم زیر سطر دوم است."), null));
                // SDKManager.print(MainActivity.this, new TestPrintableDataList(printModels), data -> Toast.makeText(MainActivity.this, "پرینت پایان یافت.", Toast.LENGTH_SHORT).show());
//                SDKManager.print(MainActivity.this, new TestPrintableData(), objects -> SDKManager.print(MainActivity.this, new ListPrintableData("این سطر اول است", "سطر دوم پایین تر است", "سطر سوم زیر سطر دوم است."), null));
                    /*SDKManager.print(MainActivity.this, new TestPrintableData(), data -> {
                        SDKManager.print(MainActivity.this, new TestPrintableDataList(printModels), data1 -> {*//*
                            SDKManager.print(MainActivity.this, new TestPrintableDataList(printModels), data2 -> {
                                SDKManager.print(MainActivity.this, new TestPrintableDataList(printModels), null);
                            });
                        *//*});
                    });*/

                //***** Print Bitmap *****
//                SDKManager.print(MainActivity.this, new ListPrintableData("این سطر اول است", "سطر دوم پایین تر است", "سطر سوم زیر سطر دوم است."), null);
//                SDKManager.print(MainActivity.this, new TestPrintableDataList(printModels), 75, WaterMarkLanguage.ENGLISH, true, null);
                Bitmap bmp = BitmapFactory.decodeResource(getResources(), R.drawable.bitmap_print_test);
                SDKManager.printBitmap(MainActivity.this, bmp, true, 70, WaterMarkLanguage.ENGLISH, true, data -> {
//                    'End of print';
                });
            } else {
                Toast.makeText(this, "پرینتر با مشکل مواجه شده است.", Toast.LENGTH_SHORT).show();
            }
        }
}
