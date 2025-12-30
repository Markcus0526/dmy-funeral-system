package com.damytech.binzang.activities.custom;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.structure.custom.ST36View;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ResolutionUtility;
import com.damytech.utils.ToastUtility;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 11:00
 * File Name : YuanQuHuoDongActivity
 */
public class SanLiuJingActivity extends SuperActivity {
	private ListView list_view = null;
	private ListAdapter adapter = null;
	private ArrayList<ST36View> arrViews = new ArrayList<ST36View>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_36birdseyeview);
	}

	@Override
	protected void initializeActivity() {
		list_view = (ListView)findViewById(R.id.list_view);
		adapter = new ListAdapter(SanLiuJingActivity.this, arrViews);
		list_view.setAdapter(adapter);

		startProgress();
		CommManager.get36Views(get_views_delegate);
	}


	public class ViewHolder {
		public TextView txt_title = null;
		public ImageView img_contents = null;
		public ImageButton btnItem = null;
	}


	public class ListAdapter extends ArrayAdapter<ST36View> {
		public ListAdapter(Context context, List<ST36View> objects) {
			super(context, 0, objects);
		}


		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			ST36View birds_view = arrViews.get(position);
			ViewHolder holder = null;

			if (convertView == null) {
				View item_view = getLayoutInflater().inflate(R.layout.item_36jing_layout, null);
				ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

				holder = new ViewHolder();

				holder.txt_title = (TextView)item_view.findViewById(R.id.txt_title);
				holder.img_contents = (ImageView)item_view.findViewById(R.id.img_contents);
				holder.btnItem = (ImageButton)item_view.findViewById(R.id.btn_item);
				holder.btnItem.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						onItemSelected((ST36View)v.getTag());
					}
				});

				item_view.setTag(holder);

				convertView = item_view;
			} else {
				holder = (ViewHolder)convertView.getTag();
			}

			holder.txt_title.setText(birds_view.title);
			BitmapUtility.setImageWithImageLoader(holder.img_contents, birds_view.image_url, loader_options);
			holder.btnItem.setTag(birds_view);

			return convertView;
		}
	}


	private CommDelegate get_views_delegate = new CommDelegate() {
		@Override
		public void get36ViewsResult(int retcode, String retmsg, ArrayList<ST36View> arrViews) {
			super.get36ViewsResult(retcode, retmsg, arrViews);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				SanLiuJingActivity.this.arrViews.clear();
				for (int i = 0; i < arrViews.size(); i++) {
					SanLiuJingActivity.this.arrViews.add(arrViews.get(i));
				}

				adapter.notifyDataSetChanged();
			} else {
				ToastUtility.showToast(SanLiuJingActivity.this, retmsg);
			}
		}
	};


	private void onItemSelected(ST36View view_info) {
		Bundle bundle = new Bundle();
		bundle.putLong(SanLiuJingJieShaoActivity.EXTRA_VIEW_ID, view_info.uid);

		pushNewActivityAnimated(SanLiuJingJieShaoActivity.class, bundle);
	}


}
