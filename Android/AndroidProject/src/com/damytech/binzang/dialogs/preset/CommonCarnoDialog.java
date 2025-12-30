package com.damytech.binzang.dialogs.preset;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import com.damytech.binzang.R;
import com.damytech.preset_controls.WheelPicker.OnWheelChangedListener;
import com.damytech.preset_controls.WheelPicker.WheelAdapter;
import com.damytech.preset_controls.WheelPicker.WheelView;
import com.damytech.utils.StringUtility;

/**
 * Created by KimHM on 2015-02-18.
 */
public class CommonCarnoDialog extends SuperDialog {
	private Button btnConfirm = null;
	private Button btnCancel = null;

	private CarNoDelegate delegate = null;

	private String sel_carno = "";

	private WheelView province_wheelview = null;
	private WheelView city_wheelview = null;
	private WheelView carno_wheelview1 = null;
	private WheelView carno_wheelview2 = null;
	private WheelView carno_wheelview3 = null;
	private WheelView carno_wheelview4 = null;
	private WheelView carno_wheelview5 = null;

	private WheelAdapter province_wheeladapter = null;
	private WheelAdapter city_wheeladapter = null;
	private WheelAdapter carno_wheeladapter1 = null;
	private WheelAdapter carno_wheeladapter2 = null;
	private WheelAdapter carno_wheeladapter3 = null;
	private WheelAdapter carno_wheeladapter4 = null;
	private WheelAdapter carno_wheeladapter5 = null;

	private final String[] arrCarNoPrefix = new String[] {
			"京",  "津",  "冀",  "晋",  "蒙",
			"辽",  "吉",  "黑",  "沪",  "苏",
			"浙",  "皖",  "闽",  "赣",  "鲁",
			"豫",  "鄂",  "湘",  "粤",  "琼",
			"渝",  "川",  "贵",  "云",  "藏",
			"陕",  "甘",  "青",  "宁",  "新"
	};


	private final String[] arrEngChars = new String[] {
			"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
	};


	private final String[] arrAlphaNums = new String[] {
			"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
			"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
	};


	public CommonCarnoDialog(Context context) {
		super(context);
	}


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.preset_dlg_carno);

		initialize();
	}


	public void initWithDelegate(String def_carno, CarNoDelegate delegate) {
		sel_carno = StringUtility.eatString(def_carno, "-");
		this.delegate = delegate;
	}


	@Override
	protected void initControls() {
		btnConfirm = (Button)findViewById(R.id.btn_confirm);
		btnCancel = (Button)findViewById(R.id.btn_cancel);

		btnConfirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickConfirm();
			}
		});
		btnCancel.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickCancel();
			}
		});

		province_wheelview = (WheelView)findViewById(R.id.province_view);
		city_wheelview = (WheelView)findViewById(R.id.city_view);

		carno_wheelview1 = (WheelView)findViewById(R.id.carno_view1);
		carno_wheelview2 = (WheelView)findViewById(R.id.carno_view2);
		carno_wheelview3 = (WheelView)findViewById(R.id.carno_view3);
		carno_wheelview4 = (WheelView)findViewById(R.id.carno_view4);
		carno_wheelview5 = (WheelView)findViewById(R.id.carno_view5);

		province_wheeladapter = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrCarNoPrefix.length; }
			@Override
			public String getItem(int index) { return arrCarNoPrefix[index]; }
			@Override
			public int getMaximumLength() { return arrCarNoPrefix.length; }
		};
		province_wheelview.setAdapter(province_wheeladapter);

		city_wheeladapter = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrEngChars.length; }
			@Override
			public String getItem(int index) { return arrEngChars[index]; }
			@Override
			public int getMaximumLength() { return arrEngChars.length; }
		};
		city_wheelview.setAdapter(city_wheeladapter);

		carno_wheeladapter1 = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrAlphaNums.length; }
			@Override
			public String getItem(int index) { return arrAlphaNums[index]; }
			@Override
			public int getMaximumLength() { return arrAlphaNums.length; }
		};
		carno_wheelview1.setAdapter(carno_wheeladapter1);

		carno_wheeladapter2 = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrAlphaNums.length; }
			@Override
			public String getItem(int index) { return arrAlphaNums[index]; }
			@Override
			public int getMaximumLength() { return arrAlphaNums.length; }
		};
		carno_wheelview2.setAdapter(carno_wheeladapter2);

		carno_wheeladapter3 = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrAlphaNums.length; }
			@Override
			public String getItem(int index) { return arrAlphaNums[index]; }
			@Override
			public int getMaximumLength() { return arrAlphaNums.length; }
		};
		carno_wheelview3.setAdapter(carno_wheeladapter3);

		carno_wheeladapter4 = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrAlphaNums.length; }
			@Override
			public String getItem(int index) { return arrAlphaNums[index]; }
			@Override
			public int getMaximumLength() { return arrAlphaNums.length; }
		};
		carno_wheelview4.setAdapter(carno_wheeladapter4);

		carno_wheeladapter5 = new WheelAdapter() {
			@Override
			public int getItemsCount() { return arrAlphaNums.length; }
			@Override
			public String getItem(int index) { return arrAlphaNums[index]; }
			@Override
			public int getMaximumLength() { return arrAlphaNums.length; }
		};
		carno_wheelview5.setAdapter(carno_wheeladapter5);

		setCurrentItems();

		province_wheelview.addChangingListener(changed_listener);
		city_wheelview.addChangingListener(changed_listener);
		carno_wheelview1.addChangingListener(changed_listener);
		carno_wheelview2.addChangingListener(changed_listener);
		carno_wheelview3.addChangingListener(changed_listener);
		carno_wheelview4.addChangingListener(changed_listener);
		carno_wheelview5.addChangingListener(changed_listener);
	}



	private void setCurrentItems() {
		if (sel_carno.length() > 0) {
			String sel_prefix = sel_carno.substring(0, 1);
			for (int i = 0; i < arrCarNoPrefix.length; i++) {
				if (sel_prefix.equals(arrCarNoPrefix[i])) {
					province_wheelview.setCurrentItem(i);
					break;
				}
			}
		}


		if (sel_carno.length() > 1) {
			String city_char = sel_carno.substring(1, 2);
			for (int i = 0; i < arrEngChars.length; i++) {
				if (city_char.equals(arrEngChars[i])) {
					city_wheelview.setCurrentItem(i);
					break;
				}
			}
		}



		if (sel_carno.length() > 2) {
			String carno_part = sel_carno.substring(2, 3);
			for (int i = 0; i < arrAlphaNums.length; i++) {
				if (carno_part.equals(arrAlphaNums[i])) {
					carno_wheelview1.setCurrentItem(i);
					break;
				}
			}
		}



		if (sel_carno.length() > 3) {
			String carno_part = sel_carno.substring(3, 4);
			for (int i = 0; i < arrAlphaNums.length; i++) {
				if (carno_part.equals(arrAlphaNums[i])) {
					carno_wheelview2.setCurrentItem(i);
					break;
				}
			}
		}


		if (sel_carno.length() > 4) {
			String carno_part = sel_carno.substring(4, 5);
			for (int i = 0; i < arrAlphaNums.length; i++) {
				if (carno_part.equals(arrAlphaNums[i])) {
					carno_wheelview3.setCurrentItem(i);
					break;
				}
			}
		}


		if (sel_carno.length() > 5) {
			String carno_part = sel_carno.substring(5, 6);
			for (int i = 0; i < arrAlphaNums.length; i++) {
				if (carno_part.equals(arrAlphaNums[i])) {
					carno_wheelview4.setCurrentItem(i);
					break;
				}
			}
		}


		if (sel_carno.length() > 6) {
			String carno_part = sel_carno.substring(6, 7);
			for (int i = 0; i < arrAlphaNums.length; i++) {
				if (carno_part.equals(arrAlphaNums[i])) {
					carno_wheelview5.setCurrentItem(i);
					break;
				}
			}
		}
	}


	private OnWheelChangedListener changed_listener = new OnWheelChangedListener() {
		@Override
		public void onChanged(WheelView wheel, int oldValue, int newValue) {
			updateCarNo();
		}
	};


	private void updateCarNo() {
		int nCurIndex = 0;

		nCurIndex = province_wheelview.getCurrentItem();
		sel_carno = arrCarNoPrefix[nCurIndex];

		nCurIndex = city_wheelview.getCurrentItem();
		sel_carno += arrAlphaNums[nCurIndex];

		nCurIndex = carno_wheelview1.getCurrentItem();
		sel_carno += arrAlphaNums[nCurIndex];

		nCurIndex = carno_wheelview2.getCurrentItem();
		sel_carno += arrAlphaNums[nCurIndex];

		nCurIndex = carno_wheelview3.getCurrentItem();
		sel_carno += arrAlphaNums[nCurIndex];

		nCurIndex = carno_wheelview4.getCurrentItem();
		sel_carno += arrAlphaNums[nCurIndex];

		nCurIndex = carno_wheelview5.getCurrentItem();
		sel_carno += arrAlphaNums[nCurIndex];
	}


	private void onClickConfirm() {
		updateCarNo();

		if (delegate != null)
			delegate.onCarNoSelected(sel_carno);

		CommonCarnoDialog.this.dismiss();
	}

	private void onClickCancel() {
		CommonCarnoDialog.this.dismiss();
	}


	public interface CarNoDelegate {
		public void onCarNoSelected(String szCarNo);
	}

}
