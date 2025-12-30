package com.damytech.binzang.activities.preset;

import android.app.Activity;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.widget.MediaController;
import android.widget.VideoView;
import com.damytech.binzang.R;
import com.damytech.utils.ToastUtility;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 21:16
 * File Name : PresetVideoPlayerActivity
 */
public class PresetVideoPlayerActivity extends SuperActivity {
	public static final String EXTRA_VIDEO_URL = "video_url";

	private String video_url = "";

	private VideoView video_view = null;
	private MediaController mediaController = null;
	private Uri uriVideo = null;


	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.preset_activity_video_player);
	}

	@Override
	protected void onPause() {
		super.onPause();

		if (video_view != null) {
			video_view.stopPlayback();
		}
	}

	@Override
	public void initializeActivity() {
		video_url = getIntent().getStringExtra(EXTRA_VIDEO_URL);

		startProgress();

		video_view = (VideoView)findViewById(R.id.video_view);

		MediaController mediaController = new MediaController(PresetVideoPlayerActivity.this);

		uriVideo = Uri.parse(video_url);
		video_view.setMediaController(mediaController);
		video_view.setVideoURI(uriVideo);

		video_view.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
			@Override
			public void onPrepared(MediaPlayer mp) {
				stopProgress();
				mp.start();
			}
		});

		video_view.setOnErrorListener(new MediaPlayer.OnErrorListener() {
			@Override
			public boolean onError(MediaPlayer mp, int what, int extra) {
				stopProgress();
				ToastUtility.showToast(PresetVideoPlayerActivity.this, "抱歉，播放视频出问题");
				return true;
			}
		});

		video_view.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
			@Override
			public void onCompletion(MediaPlayer mp) {
				stopProgress();
				//popOverCurActivityAnimated();
			}
		});
	}


	public static void startVideoActivity(SuperActivity activity, String video_url) {
		Bundle bundle = new Bundle();
		bundle.putString(EXTRA_VIDEO_URL, video_url);

		activity.pushNewActivityAnimated(PresetVideoPlayerActivity.class, bundle);
	}

}


