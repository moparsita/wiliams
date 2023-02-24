package today.parsa.wiliams.data;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import today.parsa.wiliams.R;

import com.kishcore.sdk.hybrid.api.PrintableData;

public class TestPrintableData implements PrintableData {
    @Override
    public View toView(Context context) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        return inflater.inflate(R.layout.test_printable_data, null);
    }

    @Override
    public int getHeight() {
        return 0;
    }
}
