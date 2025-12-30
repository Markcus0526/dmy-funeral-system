package com.damytech.binzang.dialogs.custom;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.media.Image;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.custom.ZhengQuQuanJingActivity;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.SuperDialog;
import com.damytech.structure.custom.STAreaPoint;
import com.damytech.utils.BitmapUtility;

/**
 * Created by kimoc on 4/10/15.
 */
public class MapAreaPopupDlg extends SuperDialog {
	private TextView txtTitle = null;
	private ImageView imgArea = null;
	private TextView txtContent = null;

	private STAreaPoint mAreaInfo = new STAreaPoint();
	private MapAreaPopupDelegate delegate = null;

	public MapAreaPopupDlg(Context context) {
		super(context);
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.dlg_mapareapopup);
		getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));

		initialize();
	}

	@Override
	protected void initControls()
	{
		txtTitle = (TextView) findViewById(R.id.txt_title);
		txtTitle.setText(mAreaInfo.name);

		txtContent = (TextView) findViewById(R.id.txt_content);
		txtContent.setText(mAreaInfo.contents);
		txtContent.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				onTapBackground();
			}
		});

		try {
			SuperActivity parentActivity = (SuperActivity)getOwnerActivity();

			imgArea = (ImageView) findViewById(R.id.img_area);
			BitmapUtility.setImageWithImageLoader(imgArea, mAreaInfo.image_url, parentActivity.loader_options);
			imgArea.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					onTapBackground();
				}
			});
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void setDataInfo(STAreaPoint info, MapAreaPopupDelegate delegate)
	{
		mAreaInfo = info;
		this.delegate = delegate;
	}

	public void onTapBackground()
	{
		if (delegate != null)
			delegate.onClicked(mAreaInfo.uid, mAreaInfo.type);

		MapAreaPopupDlg.this.dismiss();
	}


	public interface MapAreaPopupDelegate {
		public void onClicked(long uid, int type);
	}
}
