package com.damytech.binzang.activities.custom;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.structure.custom.STTombKnowledge;
import com.damytech.utils.AppUtility;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;

/**
 * Created by DavidYin on 2015.05.24.
 */
public class BinZangXinWenActivity extends SuperActivity {

    private WebContentView webView = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState, R.layout.activity_binzangxingwen);
    }

    @Override
    protected void initializeActivity() {
        webView = (WebContentView)findViewById(R.id.web_view);

        // get company intro info
        startProgress();
        CommManager.getTombKnowledge(lingyuan_knowledge_delegate);
    }

    private CommDelegate lingyuan_knowledge_delegate = new CommDelegate() {
        @Override
        public void getTombKnowledgeResult(int retcode, String retmsg, STTombKnowledge info) {
            super.getTombKnowledgeResult(retcode, retmsg, info);
            stopProgress();

            if (retcode == CommErrMgr.ERRCODE_NONE) {
                setContents(info);
            } else {
                ToastUtility.showToast(BinZangXinWenActivity.this, retmsg);
            }
        }
    };


    private void setContents(STTombKnowledge info) {
        webView.loadURL(info.bury_news_url);
    }
}