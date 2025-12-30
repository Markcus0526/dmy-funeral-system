package com.damytech.binzang.activities.custom;

import android.app.ProgressDialog;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.webkit.DownloadListener;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.preset_controls.WebContentView;
import com.damytech.utils.ToastUtility;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.*;
import java.net.URLDecoder;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 21:55
 * File Name : YouXiActivity
 */
public class YouXiActivity extends SuperActivity {
	private WebContentView webvYouXi;
	private ProgressDialog mDialog;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_youxi);
	}

	@Override
	protected void initializeActivity() {
		webvYouXi = (WebContentView)findViewById(R.id.webview_youxi);
		webvYouXi.getSettings().setJavaScriptEnabled(true);

		loadData();
	}

	private void loadData() {
		startProgress();
		CommManager.getGamePageUrl(game_url_delegate);
	}

	private CommDelegate game_url_delegate = new CommDelegate() {
		@Override
		public void getGamePageUrlResult(int retcode, String retmsg, String page_url) {
			super.getGamePageUrlResult(retcode, retmsg, page_url);
			stopProgress();

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				setGameData(page_url);
			} else {
				ToastUtility.showToast(YouXiActivity.this, retmsg);
			}
		}
	};


	private void setGameData(String url) {
		webvYouXi.loadURL(url);
		webvYouXi.setDownloadListener(new MyWebViewDownLoadListener());
	}



	private class MyWebViewDownLoadListener implements DownloadListener {
		@Override
		public void onDownloadStart(String url,
									String userAgent,
									String contentDisposition,
									String mimetype,
									long contentLength)
		{
			if (!Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
				ToastUtility.showToast(YouXiActivity.this, "请插入SD卡");
				return;
			}


			int notify_id = startProgressInNotificationArea("下载游戏", "下载中...");

			DownloaderTask task = new DownloaderTask();
			task.execute(url, "" + notify_id);
		}
	}

	private class DownloaderTask extends AsyncTask<String, Void, String> {
		int notify_id = 0;

		public DownloaderTask() {}

		/**
		 * Downloading progress
		 *
		 * @param params
		 * @return
		 */
		@Override
		protected String doInBackground(String... params) {
			String url = params[0];
			notify_id = Integer.parseInt(params[1]);

			String fileName = url.substring(url.lastIndexOf("/") + 1);
			try {
				fileName = URLDecoder.decode(fileName, "UTF-8");
			} catch (Exception ex) {
				ex.printStackTrace();
			}


			File directory = Environment.getExternalStorageDirectory();
			File file = new File(directory, fileName);
			if (file.exists()) {
				Log.i("tag", "The file has already exists.");
				return fileName;
			}


			try {
				HttpClient client = new DefaultHttpClient();

				HttpGet get = new HttpGet(url);
				HttpResponse response = client.execute(get);

				if (HttpStatus.SC_OK == response.getStatusLine().getStatusCode()) {
					HttpEntity entity = response.getEntity();

					InputStream input = entity.getContent();
					writeToSDCard(fileName, input);
					input.close();

					return fileName;
				} else {
					return null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}


		/**
		 * Download completed.
		 *
		 * @param result
		 */
		@Override
		protected void onPostExecute(String result) {
			// TODO Auto-generated method stub
			super.onPostExecute(result);

			if (result == null) {
				stopProgressInNotificationArea(notify_id, "下载失敗");
				ToastUtility.showToast(YouXiActivity.this, "下载失敗");
				return;
			}


			stopProgressInNotificationArea(notify_id, "已保存在SD卡");
			ToastUtility.showToast(YouXiActivity.this, "已保存在SD卡");

			File directory = Environment.getExternalStorageDirectory();
			File file = new File(directory,result);

			Intent intent = getFileIntent(file);
			YouXiActivity.this.startActivity(intent);
		}
	}


	public Intent getFileIntent(File file) {
		Uri uri = Uri.fromFile(file);
		String type = getMIMEType(file);

		Intent intent = new Intent("android.intent.action.VIEW");
		intent.addCategory("android.intent.category.DEFAULT");
		intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		intent.setDataAndType(uri, type);

		return intent;
	}


	public void writeToSDCard(String fileName, InputStream input) {
		if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
			File directory = Environment.getExternalStorageDirectory();
			File file = new File(directory, fileName);

			try {
				FileOutputStream fos = new FileOutputStream(file);

				byte[] b = new byte[2048];
				int j = 0;
				while ((j = input.read(b)) != -1) {
					fos.write(b, 0, j);
				}

				fos.flush();
				fos.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			Log.i("tag", "NO SDCard.");
		}
	}

	private String getMIMEType(File f) {
		String type = "";
		String fName = f.getName();
		String end = fName.substring(fName.lastIndexOf(".") + 1, fName.length()).toLowerCase();

		/* MimeType */
		if (end.equals("pdf")) {
			type = "application/pdf";
		} else if (end.equals("m4a")
				|| end.equals("mp3")
				|| end.equals("mid")
				|| end.equals("xmf")
				|| end.equals("ogg")
				|| end.equals("wav")) {
			type = "audio/*";
		} else if (end.equals("3gp")
				|| end.equals("mp4")) {
			type = "video/*";
		} else if (end.equals("jpg")
				|| end.equals("gif")
				|| end.equals("png")
				|| end.equals("jpeg")
				|| end.equals("bmp")) {
			type = "image/*";
		} else if (end.equals("apk")) {
			type = "application/vnd.android.package-archive";
		} else {
			type = "*/*";
		}

//		else if(end.equals("pptx")||end.equals("ppt")) {
//			type = "application/vnd.ms-powerpoint";
//		} else if(end.equals("docx")||end.equals("doc")) {
//			type = "application/vnd.ms-word";
//		} else if(end.equals("xlsx")||end.equals("xls")) {
//			type = "application/vnd.ms-excel";
//		}

		return type;
	}

}
