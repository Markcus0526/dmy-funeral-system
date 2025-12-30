package com.damytech.preset_controls;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.AttributeSet;
import android.webkit.WebView;
import android.webkit.WebViewClient;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:15
 * File Name : WebContentView
 */
public class WebContentView extends WebView {
	public WebContentView(Context context) {
		super(context);
		initialize();
	}

	public WebContentView(Context context, AttributeSet attrs) {
		super(context, attrs);
		initialize();
	}

	public WebContentView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		initialize();
	}


	private void initialize() {
		WebContentView.this.getSettings().setJavaScriptEnabled(true);
		WebContentView.this.getSettings().setSupportZoom(true);
		WebContentView.this.setWebViewClient(new WebContentViewClient());
	}


	public void loadHTMLString(String content) {
		WebContentView.this.loadData(content, "text/html; charset=UTF-8", null);
	}


	public void loadURL(String szUrl) {
		WebContentView.this.loadUrl(szUrl);
	}





	public static boolean openSystemBrowser(Context ctx, String url) {
		boolean bResult = true;

		try {
			Intent intent = new Intent();
			intent.setAction("android.intent.action.VIEW");

			Uri content_url = Uri.parse(url);
			intent.setData(content_url);

			ctx.startActivity(intent);
		} catch (Exception ex) {
			ex.printStackTrace();
			bResult = false;
		}

		return bResult;
	}


	public class WebContentViewClient extends WebViewClient {
		@Override
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			return false;
		}
	}


}
