package com.damytech.binzang.dialogs.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.SuperDialog;
import com.damytech.structure.custom.STParentBirthNotify;
import com.damytech.structure.custom.STTomb;
import com.damytech.utils.BitmapUtility;

/**
 * Created by DavidYin on 2015.05.22.
 */
public class ParentBirthNotifyDlg extends SuperDialog {
    public SuperActivity parentActivity = null;

    private TextView txtDesc = null;
    private TextView txtDate = null;
    private TextView txtNo = null;

    private Button btnConfirm = null;

    public STParentBirthNotify notify_info = null;

    public ParentBirthNotifyDlg(Context context) {
        super(context);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dlg_parent_birth_notify);

        initialize();
    }


    public void init(SuperActivity parentActivity,
                     STParentBirthNotify notify)
    {
        this.parentActivity = parentActivity;
        this.notify_info = notify;
    }


    // initialization process
    protected void initControls() {
        // initialize title
        txtDesc = (TextView)findViewById(R.id.txt_desc);
        txtNo = (TextView)findViewById(R.id.txt_no);
        txtDate = (TextView)findViewById(R.id.txt_date);

        if (notify_info != null) {
            txtDesc.setText(notify_info.desc);
            txtDate.setText(notify_info.date);
            txtNo.setText(notify_info.tomb_no);
        }


        btnConfirm = (Button)findViewById(R.id.btn_confirm);
        btnConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ParentBirthNotifyDlg.this.dismiss();
            }
        });
    }


    public interface DialogResultListener {
        public void onConfirmed(long uid);
    }
}
