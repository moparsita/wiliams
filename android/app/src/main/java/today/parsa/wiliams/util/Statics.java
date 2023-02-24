package today.parsa.wiliams.util;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

public class Statics {

    public static final String PRINT_QUALITY_PERCENT = "quality_percent";
    private static final String host_name = "com.kishcore.payonepos";

    private static SharedPreferences settings;
    private static Editor edit;

    @SuppressLint("CommitPrefEdits")
    public static void init(Context context) {
        settings = context.getSharedPreferences(host_name, Context.MODE_PRIVATE);
        edit = settings.edit();
    }
    public static int getPrintQuality() {
        return settings.getInt(PRINT_QUALITY_PERCENT, 70);
    }

    public static void setPrintQuality(int qualityPercent) {
        edit.putInt(PRINT_QUALITY_PERCENT, qualityPercent);
        edit.commit();
    }
}
