package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperTabActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.preset_controls.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.structure.custom.STBonusLog;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by DavidYin on 2015.05.22.
 */
public class JiangJinMingXiBiao_JipinTabFrame extends SuperTabActivity.TabFrame {
    private int page_no = 0;
    private PullToRefreshListView pullList = null;
    private PullAdpater pullAdapter = null;
    private ArrayList<STBonusLog> arrBonusLogs = new ArrayList<STBonusLog>();

    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);

        View contentView = inflater.inflate(R.layout.activity_jiangjinmingxibiao_tab, container, false);

        initResolution(contentView);
        initControls(contentView);

        return contentView;
    }


    private void initControls(View parentView) {
        pullAdapter = new PullAdpater(parentActivity, arrBonusLogs);
        pullList = (PullToRefreshListView)parentView.findViewById(R.id.list_view);
        {
            pullList.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
            pullList.setOnRefreshListener(pullListRefreshListener);
            pullList.setAdapter(pullAdapter);
            pullList.getRefreshableView().setDivider(new ColorDrawable(Color.TRANSPARENT));
            pullList.getRefreshableView().setCacheColorHint(Color.parseColor("#FFF1F1F1"));
        }

        startProgress();
        getItemsFromService();
    }

    private PullToRefreshBase.OnRefreshListener pullListRefreshListener = new PullToRefreshBase.OnRefreshListener() {
        @Override
        public void onRefresh(PullToRefreshBase refreshView) {
            getItemsFromService();
        }
    };

    private void getItemsFromService() {
        page_no = arrBonusLogs.size() / AppCommon.getPageItemCount();
        CommManager.getBonusDetailList(AppCommon.loadUserIDLong(parentActivity.getApplicationContext()),
                1,
                page_no,
                list_delegate);
    }

    public class STViewHolder
    {
        TextView txtName = null;
        TextView txtNum = null;
        TextView txtTime = null;
        TextView txtPrice = null;
    }

    private class PullAdpater extends ArrayAdapter<STBonusLog> {
        public PullAdpater(Context context, List<STBonusLog> objects) {
            super(context, 0, objects);
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            STBonusLog item_info = arrBonusLogs.get(position);

            STViewHolder viewHolder = null;
            if (convertView == null) {
                RelativeLayout itemView = (RelativeLayout) parentActivity.getLayoutInflater().inflate(R.layout.item_jiangjinmingxi_layout, null);
                ResolutionUtility.instance.iterateChild(itemView, parentActivity.screen_size.x, parentActivity.screen_size.y);

                viewHolder = new STViewHolder();
                viewHolder.txtName = (TextView)itemView.findViewById(R.id.txt_name);
                viewHolder.txtNum = (TextView)itemView.findViewById(R.id.txt_no);
                viewHolder.txtTime = (TextView)itemView.findViewById(R.id.txt_time);
                viewHolder.txtPrice = (TextView)itemView.findViewById(R.id.txt_date);

                itemView.setTag(viewHolder);
                convertView = itemView;
            } else {
                viewHolder = (STViewHolder) convertView.getTag();
            }

            viewHolder.txtName.setText(item_info.user_name);
            viewHolder.txtNum.setText(item_info.tomb_no);
            viewHolder.txtTime.setText(item_info.buy_time);
            viewHolder.txtPrice.setText(item_info.bonus_desc);

            return convertView;
        }
    }


    private CommDelegate list_delegate = new CommDelegate() {
        @Override
        public void getBonusDetailListResult(int retcode, String retmsg, ArrayList<STBonusLog> arrLogs) {
            super.getBonusDetailListResult(retcode, retmsg, arrLogs);
            stopProgress();
            pullList.onRefreshComplete();

            if (retcode == CommErrMgr.ERRCODE_NONE) {
                for (int i = 0; i < arrLogs.size(); i++) {
                    STBonusLog item = arrLogs.get(i);

                    boolean isExist = false;
                    for (int j = 0; j < arrBonusLogs.size(); j++) {
                        STBonusLog orgItem = arrBonusLogs.get(j);
                        if (orgItem.uid == item.uid) {
                            isExist = true;
                            break;
                        }
                    }

                    if (!isExist)
                        arrBonusLogs.add(item);
                }

                pullAdapter.notifyDataSetChanged();
            } else {
                ToastUtility.showToast(parentActivity, retmsg);
            }
        }
    };
}
