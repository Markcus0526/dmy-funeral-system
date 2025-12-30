package com.damytech.binzang.application;

import android.app.Application;
import android.content.Context;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.util.Log;
import cn.jpush.android.api.JPushInterface;
import com.damytech.binzang.R;
import com.damytech.misc.AppCommon;
import com.damytech.utils.Foreground;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-30
 * Time : 11:40
 * File Name : MainApplication
 */
public class MainApplication extends Application {
	private static final String TAG = "JPush";
	public static MediaPlayer audioPlayer = null;
	public static int media_length = 0;

	@Override
	public void onCreate() {
		Log.d(AppCommon.getPreferenceName(), "Application created");
		Log.d(TAG, "[ExampleApplication] onCreate");
		super.onCreate();

		JPushInterface.setDebugMode(true); 	// ���ÿ�����־,����ʱ��ر����?
		JPushInterface.init(this);     		// ��ʼ�� JPush

		Foreground.init(this);
		Foreground.get(this).addListener(myListener);

		audioPlayer = MediaPlayer.create(this, R.raw.back_audio_mp3);
		audioPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
			@Override
			public void onCompletion(MediaPlayer mp) {
				try {
					mp.seekTo(0);
					mp.start();
				}
				catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		});
	}

	Foreground.Listener myListener = new Foreground.Listener(){
	   public void onBecameForeground(){
		   try {
			   AudioManager am =
					   (AudioManager) getSystemService(Context.AUDIO_SERVICE);

			   am.setStreamVolume(
					   AudioManager.STREAM_MUSIC,
					   am.getStreamMaxVolume(AudioManager.STREAM_MUSIC) / 2,
					   0);

			   audioPlayer.seekTo(media_length);
			   audioPlayer.start();
		   }
		   catch (Exception ex) {
			   ex.printStackTrace();
		   }
	   }
	   public void onBecameBackground(){
		   try {
			   audioPlayer.pause();
			   media_length = audioPlayer.getCurrentPosition();
		   }
		   catch (Exception ex) {
			   ex.printStackTrace();
		   }
	   }
   	};
}
