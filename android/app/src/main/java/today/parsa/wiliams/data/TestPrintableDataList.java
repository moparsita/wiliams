package today.parsa.wiliams.data;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.kishcore.sdk.hybrid.api.PrintableData;
import today.parsa.wiliams.adapter.PrintListAdapter;
import today.parsa.wiliams.model.PrintModel;
import today.parsa.wiliams.util.Tools;
import today.parsa.wiliams.R;

import java.util.ArrayList;


public class TestPrintableDataList implements PrintableData {
    private final ArrayList<PrintModel> items;

    public TestPrintableDataList(ArrayList<PrintModel> items) {
        this.items = items;
    }

    @Override
    public View toView(Context context) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View root = null;
        if (inflater != null) {
            root = inflater.inflate(R.layout.list_printable_data, null);
        }

        ListView listView = root.findViewById(R.id.lv_test);
        listView.setAdapter(new PrintListAdapter(context, items));
        ViewGroup.LayoutParams layoutParams = listView.getLayoutParams();
        listView.setLayoutParams(layoutParams);
        Tools.setListViewHeightBasedOnChildren(listView);
        return root;
    }

    @Override
    public int getHeight() {
        return 0;
    }
}
