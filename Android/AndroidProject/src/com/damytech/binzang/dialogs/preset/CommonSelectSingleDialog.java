package com.damytech.binzang.dialogs.preset;

import android.content.Context;
import android.graphics.Point;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.utils.ResolutionUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by AnSI on 2/4/2015.
 */
public class CommonSelectSingleDialog extends SuperDialog {
    //**************************
    // member variables
    //**************************
    private String szTitle = "";

    private ListView item_list = null;
    private ArrayList<String> arrItems = new ArrayList<String>();

    private ItemAdpater adpater = null;
    public SelectItemListener delegate = null;  // used on parent activity

    //**************************
    // member functions
    //**************************
    public CommonSelectSingleDialog(Context context) {
        super(context);
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.preset_dlg_select_single);

        initialize();
    }

    // initialization process
    protected void initControls() {
        // initialize title
        TextView txt_title = (TextView)findViewById(R.id.txt_title);
        txt_title.setText(szTitle);

        adpater = new ItemAdpater(getContext(), arrItems);
        item_list = (ListView)findViewById(R.id.item_list);
        item_list.setAdapter(adpater);
    }

    private void onSelectItem(String item_data, int index) {
        if (delegate != null) {
            delegate.onItemClicked(item_data, index);
        }

        CommonSelectSingleDialog.this.dismiss();
    }

    //**************************
    // interfaces to child
    //**************************

    // title setting process
    public void setDialogTitle(String title) {
        szTitle = title;
    }

    // initialize item data
    public void initItemData(ArrayList<String> arrInitData) {

        arrItems.clear();

        for (int i = 0; i < arrInitData.size(); i++) {
            arrItems.add(arrInitData.get(i));
        }
    }

    // Item click interface
    public interface SelectItemListener {
        public void onItemClicked(String item_data, int index);
    }


    //**************************
    // other class definition
    //**************************

    // class : ItemHolder
    public class ItemHolder {
        public TextView txtName = null;
        public ImageButton btnName = null;
    }

    // class : ItemAdpater
    public class ItemAdpater extends ArrayAdapter<String> {
        public ItemAdpater(Context context, List<String> objects) {
            super(context, 0, objects);
        }

        public View getView(final int position, View convertView, ViewGroup parent) {
            String szItem = arrItems.get(position);

            ItemHolder holder = null;

            if (convertView == null) {
                holder = new ItemHolder();

                RelativeLayout item_layout = (RelativeLayout)getLayoutInflater().inflate(R.layout.preset_dlg_select_single_item, null);
                Point ptScreen = ResolutionUtility.getScreenSize(getContext().getApplicationContext());

                ResolutionUtility.instance.iterateChild(item_layout, ptScreen.x, ptScreen.y);


                TextView txtItem = (TextView)item_layout.findViewById(R.id.txt_item);
                ImageButton btnItem = (ImageButton)item_layout.findViewById(R.id.btn_item);

                btnItem.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        String szItemData = (String)v.getTag();
                        onSelectItem(szItemData, position);
                    }
                });

                holder.txtName = txtItem;
                holder.btnName = btnItem;

                convertView = item_layout;
                convertView.setTag(holder);
            } else {
                holder = (ItemHolder)convertView.getTag();
            }

            holder.txtName.setText(szItem);
            holder.btnName.setTag(szItem);

            return convertView;
        }
    }


}
