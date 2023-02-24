package today.parsa.wiliams.data;

import android.annotation.SuppressLint;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import androidx.annotation.NonNull;

import com.kishcore.sdk.hybrid.api.PrintableData;

import java.util.ArrayList;
import java.util.Arrays;
import today.parsa.wiliams.R;


public class ListPrintableData implements PrintableData {

    private ArrayList<String> items;

    public ListPrintableData(@NonNull String... itemsList) {
        this.items = new ArrayList<>(Arrays.asList(itemsList));
    }

    @Override
    public View toView(Context context) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        @SuppressLint("InflateParams") View root = inflater.inflate(R.layout.list_printable_data, null);
        ArrayAdapter<String> itemsAdapter = new ArrayAdapter<>(context, R.layout.list_item, items);
        ListView listView = root.findViewById(R.id.lv_test);
        listView.setAdapter(itemsAdapter);

        ViewGroup.LayoutParams layoutParams = listView.getLayoutParams();
        layoutParams.height = items.size() * 55;
        listView.setLayoutParams(layoutParams);
        return root;
    }

    @Override
    public int getHeight() {
        return 0;
    }
}
