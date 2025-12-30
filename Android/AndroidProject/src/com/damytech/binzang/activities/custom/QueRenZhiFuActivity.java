package com.damytech.binzang.activities.custom;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.view.View;
import android.widget.*;
import com.alipay.sdk.app.PayTask;
import com.damytech.binzang.R;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.binzang.dialogs.preset.CommonAlertDialog;
import com.damytech.communication.CommDelegate;
import com.damytech.communication.CommErrMgr;
import com.damytech.communication.CommManager;
import com.damytech.misc.AppCommon;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 21:50
 * File Name : QueRenZhiFuActivity
 */
public class QueRenZhiFuActivity extends SuperActivity {
	public static final String EXTRA_RESERVE_TIME = "yuyueshijian";
	public static final String EXTRA_SERVICE_NAME = "fuwuleimingcheng";
	public static final String EXTRA_SERVICE_ID = "fuwu_id";
	public static final String EXTRA_SERVICE_PRICE = "jiage";
	public static final String EXTRA_PRODUCTS = "jipinmulu";
	public static final String EXTRA_CUSTOMER_ID = "jiukehu_id";
	public static final String EXTRA_TOMB_ID = "mudi_id";
	public static final String EXTRA_IS_DEPUTYSERVICE = "is_deputyservice";


	private Button btnConfirm = null;

	private TextView lblServiceName = null;

	private TextView txtTime = null;
	private TextView txtServiceType = null;
	private TextView txtServiceName = null;
	private TextView txtDeputy = null;
	private TextView txtPrice = null;

	private LinearLayout products_layout = null;
	private TextView txtTotalPrice = null;

	private long tomb_id = -1;
	private int is_deputyservice = 0;
	private long customer_id = -1;
	private String reserve_time = "";
	private long service_id = 0;
	private double price = 0;
	private ArrayList<STProduct> arrProducts = new ArrayList<STProduct>();

	// Zhifubao stuff
	public static final String PARTNER = "2088711781493746";
	public static final String SELLER = "2088711781493746";
	public static final String RSA_PRIVATE = "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAKZDqD2PO6jt4lA1I3v8q1qvv2qMgjur4u2ihREKozEyl0UjU6IX9ZQyClJ3rtr6wugWIVc+efVI2bcKY+3q7+FSDbSihatsUnhar9I+GZSXR6dEru+TtlbqopRAOoSRTbjQbctlZG2E2lPuRcjEPAoVDdp2DymLLWWuzQvmt4z9AgMBAAECgYEAiMwuBshsy+c+R8QQ+BjCXBEyK1aEaNhaFC+d0JGyB+6aK9aPH1UbR92MRKIYii+8YfyjXgcXjUttZn70DXM5/hPRexNBfgYIUUQoUYnchs4DKsIXdjNSP8lbJue0jBPPBM7cbAqOqzMmY83XSEKT6pPQClsbfPbMEaKk3QWsdwECQQDaz8006zu7b7WTbg7QVe3C3AbtyRZa8/Df/vTncYarxibK77ZcVNhCLoDLTSa6Cyf59tl8FnmUSFiOCmx2BeIhAkEAwoWWqJNC54T/xfLSX5QAahV2l7OWzJGnjQD1gI25Ssf5L/VsSqZ7W7/87vEfLXvXokePuzV8Ga4jdRDTq7WHXQJBAIi/oeHWuaf0sqgG+l8dtNA5LmNhbwU8u2diMbCLdLzZw9jEY1Xk+Jqz8W4dM3zGCB/iNB2m9ijD5gQvY4WHO8ECQQCQVjm9ak/ppNl5Ez2gqBxKmxR9akfKEYYG7aA9PGwyHgI74Nry5WeBZAsVbZtZz5vokTsIiZ5FG965fbvinHcNAkBYYHib7GGFIw3Ok8U8Hos64WldfT9sn7wgSOV6qE77CKK4HFZeF4dcqSACkT6iG3ALnL6b76s0lsfaXqQjeNxz";

	private static final int SDK_PAY_FLAG = 1;
	private static final int SDK_CHECK_FLAG = 2;



	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState, R.layout.activity_querenzhifu);
	}

	@Override
	protected void initializeActivity() {
		tomb_id = getIntent().getLongExtra(EXTRA_TOMB_ID, -1);
		is_deputyservice = getIntent().getIntExtra(EXTRA_IS_DEPUTYSERVICE, 0);
		customer_id = getIntent().getLongExtra(EXTRA_CUSTOMER_ID, -1);
		reserve_time = getIntent().getStringExtra(EXTRA_RESERVE_TIME);
		service_id = getIntent().getLongExtra(EXTRA_SERVICE_ID, -1);
		price = getIntent().getDoubleExtra(EXTRA_SERVICE_PRICE, 0);

		String szTemp = getIntent().getStringExtra(EXTRA_PRODUCTS);
		double totalPrice = price;
		try {
			JSONArray arrJSONProducts = new JSONArray(szTemp);
			for (int i = 0; i < arrJSONProducts.length(); i++) {
				JSONObject jsonProduct = arrJSONProducts.getJSONObject(i);
				STProduct product = STProduct.decodeFromJSON(jsonProduct);
				arrProducts.add(product);
				totalPrice += product.price * product.amount;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}


		btnConfirm = (Button)findViewById(R.id.btn_confirm_pay);
		btnConfirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				onClickedConfirm();
			}
		});


		txtTime = (TextView)findViewById(R.id.txt_reserve_time);
		txtTime.setText(reserve_time);

		txtServiceType = (TextView)findViewById(R.id.txt_service_type);
		if (service_id >= 0)
			txtServiceType.setText("落葬");
		else
			txtServiceType.setText("祭拜");

		lblServiceName = (TextView)findViewById(R.id.lbl_service_name);
		txtServiceName = (TextView)findViewById(R.id.txt_service_name);
		if(getIntent().getStringExtra(EXTRA_SERVICE_NAME) == null ||
				getIntent().getStringExtra(EXTRA_SERVICE_NAME).length() <= 0) {
			txtServiceName.setVisibility(View.INVISIBLE);
			lblServiceName.setVisibility(View.INVISIBLE);
		}
		txtServiceName.setText(getIntent().getStringExtra(EXTRA_SERVICE_NAME));


		txtDeputy = (TextView)findViewById(R.id.txt_deputy);

		if (is_deputyservice == 1) {
			txtDeputy.setText("是");
		} else {
			txtDeputy.setText("否");
		}


		txtPrice = (TextView)findViewById(R.id.txt_date);
		txtPrice.setText("￥" + StringUtility.formatDouble(price));

		txtTotalPrice = (TextView)findViewById(R.id.txt_total_price);
		txtTotalPrice.setText("￥" + StringUtility.formatDouble(totalPrice));


		products_layout = (LinearLayout)findViewById(R.id.products_list_layout);
		for (int i = 0; i < arrProducts.size(); i++) {
			STProduct product = arrProducts.get(i);
			products_layout.addView(createView(product));
		}
	}


	private View createView(STProduct product_info) {
		View item_view = getLayoutInflater().inflate(R.layout.item_zhifujipin_layout, null);
		ResolutionUtility.instance.iterateChild(item_view, screen_size.x, screen_size.y);

		ImageView imgProduct = (ImageView)item_view.findViewById(R.id.img_product);
		BitmapUtility.setImageWithImageLoader(imgProduct, product_info.image_url, loader_options);
		TextView txtType = (TextView)item_view.findViewById(R.id.txt_type);
		txtType.setText(product_info.type_desc);
		TextView txtName = (TextView)item_view.findViewById(R.id.txt_name);
		txtName.setText(product_info.title);
		TextView txtPrice = (TextView)item_view.findViewById(R.id.txt_date);
		txtPrice.setText(product_info.price_desc);
		TextView txtCount = (TextView)item_view.findViewById(R.id.txt_count);
		txtCount.setText("" + product_info.amount);

		return item_view;
	}



	private void onClickedConfirm() {
		//pay(String.valueOf(price));
		startProgress();
		CommManager.reserveCeremony(AppCommon.loadUserIDLong(getApplicationContext()),
				customer_id,
				reserve_time,
				tomb_id,
				is_deputyservice,
				service_id,
				arrProducts,
				reserve_delegate);
	}



	private CommDelegate reserve_delegate = new CommDelegate() {
		@Override
		public void reserveCeremonyResult(int retcode, String retmsg) {
			super.reserveCeremonyResult(retcode, retmsg);
			stopProgress();

			ToastUtility.showToast(QueRenZhiFuActivity.this, retmsg);

			if (retcode == CommErrMgr.ERRCODE_NONE) {
				popOverCurActivityAnimated();
			}
		}
	};


	@Override
	public void onClickedBack() {
		CommonAlertDialog dialog = new CommonAlertDialog.Builder(QueRenZhiFuActivity.this)
				.type(CommonAlertDialog.DIALOGTYPE_CONFIRM)
				.message("确定取消支付吗？")
				.positiveListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						QueRenZhiFuActivity.super.onClickedBack();
					}
				})
				.build();
		dialog.show();
	}

	/**
	 * get the out_trade_no for an order. 获取外部订单号
	 *
	 */
	public String getOutTradeNo() {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss",
				Locale.getDefault());
		Date date = new Date();
		String key = format.format(date);

		key = key + String.format("%06d", AppCommon.loadUserIDLong(getApplicationContext()));

		return key;
	}

	/**
	 * sign the order info. 对订单信息进行签名
	 *
	 * @param content
	 *            待签名订单信息
	 */
	public String sign(String content) {
		return com.damytech.utils.SignUtils.sign(content, RSA_PRIVATE);
	}

	/**
	 * get the sign type we use. 获取签名方式
	 *
	 */
	public String getSignType() {
		return "sign_type=\"RSA\"";
	}

	/**
	 * create the order info. 创建订单信息
	 *
	 */
	public String getOrderInfo(String subject, String body, String price) {
		// 合作者身份ID
		String orderInfo = "partner=" + "\"" + PARTNER + "\"";

		// 卖家支付宝账号
		orderInfo += "&seller_id=" + "\"" + SELLER + "\"";

		// 商户网站唯一订单号
		orderInfo += "&out_trade_no=" + "\"" + getOutTradeNo() + "\"";

		// 商品名称
		orderInfo += "&subject=" + "\"" + subject + "\"";

		// 商品详情
		orderInfo += "&body=" + "\"" + body + "\"";

		// 商品金额
		orderInfo += "&total_fee=" + "\"" + price + "\"";

		// 服务器异步通知页面路径
		orderInfo += "&notify_url=" + "\"" + "http://notify.msp.hk/notify.htm"
				+ "\"";

		// 接口名称， 固定值
		orderInfo += "&service=\"mobile.securitypay.pay\"";

		// 支付类型， 固定值
		orderInfo += "&payment_type=\"1\"";

		// 参数编码， 固定值
		orderInfo += "&_input_charset=\"utf-8\"";

		// 设置未付款交易的超时时间
		// 默认30分钟，一旦超时，该笔交易就会自动被关闭。
		// 取值范围：1m～15d。
		// m-分钟，h-小时，d-天，1c-当天（无论交易何时创建，都在0点关闭）。
		// 该参数数值不接受小数点，如1.5h，可转换为90m。
		orderInfo += "&it_b_pay=\"30m\"";

		// 支付宝处理完请求后，当前页面跳转到商户指定页面的路径，可空
		orderInfo += "&return_url=\"http://m.alipay.com\"";

		// 调用银行卡支付，需配置此参数，参与签名， 固定值
		// orderInfo += "&paymethod=\"expressGateway\"";

		return orderInfo;
	}

	/**
	 * call alipay sdk pay. 调用SDK支付
	 *
	 */
	public void pay(String i_szPayCost) {
		String orderInfo = getOrderInfo(getString(R.string.STR_PAY_SUBJECT),
				String.format(getString(R.string.STR_PAY_BODY), AppCommon.loadUserIDLong(getApplicationContext()), i_szPayCost), i_szPayCost);
		String sign = sign(orderInfo);
		try {
			// 仅需对sign 做URL编码
			sign = URLEncoder.encode(sign, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		final String payInfo = orderInfo + "&sign=\"" + sign + "\"&"
				+ getSignType();

		Runnable payRunnable = new Runnable() {

			@Override
			public void run() {
				// 构造PayTask 对象
				PayTask alipay = new PayTask(QueRenZhiFuActivity.this);
				// 调用支付接口
				String result = alipay.pay(payInfo);

				Message msg = new Message();
				msg.what = SDK_PAY_FLAG;
				msg.obj = result;
				mHandler.sendMessage(msg);
			}
		};

		Thread payThread = new Thread(payRunnable);
		payThread.start();
	}

    /* ----------------- Zhifubao ------------------ */

	private Handler mHandler = new Handler() {
		public void handleMessage(Message msg) {
			switch (msg.what) {
				case SDK_PAY_FLAG: {
					Result resultObj = new Result((String) msg.obj);
					String resultStatus = resultObj.resultStatus;

					// 判断resultStatus 为“9000”则代表支付成功，具体状态码代表含义可参考接口文档
					if (TextUtils.equals(resultStatus, "9000")) {
						Toast.makeText(QueRenZhiFuActivity.this, "支付宝：支付成功",
								Toast.LENGTH_SHORT).show();
						startProgress();
						CommManager.reserveCeremony(AppCommon.loadUserIDLong(getApplicationContext()),
								customer_id,
								reserve_time,
								tomb_id,
								is_deputyservice,
								service_id,
								arrProducts,
								reserve_delegate);
					} else {
						// 判断resultStatus 为非“9000”则代表可能支付失败
						// “8000” 代表支付结果因为支付渠道原因或者系统原因还在等待支付结果确认，最终交易是否成功以服务端异步通知为准（小概率状态）
						if (TextUtils.equals(resultStatus, "8000")) {
							Toast.makeText(QueRenZhiFuActivity.this, "支付宝：支付结果确认中",
									Toast.LENGTH_SHORT).show();

						} else {
							Toast.makeText(QueRenZhiFuActivity.this, "支付宝：支付失败",
									Toast.LENGTH_SHORT).show();

						}
					}
					break;
				}
				case SDK_CHECK_FLAG: {
					Toast.makeText(QueRenZhiFuActivity.this, "支付宝：检查结果为" + msg.obj,
							Toast.LENGTH_SHORT).show();
					break;
				}
				default:
					break;
			}
		};
	};
}


