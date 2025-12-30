package com.damytech.communication;

import android.content.Context;
import com.damytech.binzang.activities.preset.SuperActivity;
import com.damytech.misc.AppCommon;
import com.damytech.communication.http_conn.AsyncHttpClient;
import com.damytech.communication.http_conn.RequestParams;
import com.damytech.structure.custom.STProduct;
import com.damytech.utils.StringUtility;
import com.damytech.utils.SysDevUtility;
import org.apache.http.entity.StringEntity;
import org.json.JSONArray;
import org.json.JSONObject;

import java.net.URLEncoder;
import java.util.ArrayList;


/*
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 13-12-28
 * Time: 下午22:12
 * To change this template use File | Settings | File Templates.
 *
 * @Warning
 * 		Before use public methods,
 * 		must confirm the api return format is matching the parse method.
 * 		If return format gets different,
 * 		parse method can cause error or parsed data can not be correct.
 *
 * 		All the public apis has its sample url.
 * 		Before use the api, please use the web browser to confirm the url and confirm return format.
 * 		Hope this helps you.
*/

public class CommManager {
	/***************************** Constants *****************************/
	public static String getServiceBaseUrl() { return "http://218.60.131.41:10291/Service.svc/"; }
//	public static String getServiceBaseUrl() { return "http://192.168.1.18:10241/Service.svc/"; }

	private static String getPlatform() { return "0"; }
	public static int getTimeOut() { return 10 * 1000; }

	private static String createCheckSum(String method_name) {
		String check_sum = "";

		Context app_ctx = SuperActivity.top_instance.getApplicationContext();
		String access_token = AppCommon.loadAccessToken(app_ctx);
		check_sum = StringUtility.MD5Hash(access_token + "," + method_name);

		return check_sum;
	}



	/************************ Public service APIs ************************/
	/**
	 * API method to return weather information of six days from today.
	 *
	 * @Note	Wish to confirm the url below before use.
	 * 			If return format is different from the current parse method, please correct parse method.
	 * 			"http://http://traffic.kakamobi.com/weather.ashx?city=沈阳市"
	 *
	 * @param city_name			The city name to get weather information. Use chinese city name.
	 * @param delegate			Callback handler
	 *
	 * @see com.damytech.structure.baidu.STBaiduWeather
	 * @see com.damytech.communication.CommDelegate
	 */
	public static void requestWeatherInfo(String city_name,
										  CommDelegate delegate) {
		String url = "http://traffic.kakamobi.com/weather.ashx?city=";
		String correct_cityname = "";

		CommParser.async_requestWeatherInfo_handler.delegate = delegate;

		try {
			correct_cityname = URLEncoder.encode(city_name, "utf-8");
			url += correct_cityname;

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_requestWeatherInfo_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_requestWeatherInfo_handler.onFailure(null, ex.getMessage());
		}

	}


	/**
	 * API method to convert google location to baidu location.
	 *
	 * @Note	Wish to confirm the url below before use.
	 * 			If return format is different from the current parse method, please correct parse method.
	 * 			"http://api.map.baidu.com/ag/coord/convert?from=2&to=4&x=123&y=41",
	 * 			If error code is 0, this means request succeeded.
	 *
	 * @param fLatitude			Google latitude value to convert.
	 * @param fLongitude		Google longitude value to convert.
	 * @param delegate			Callback handler.
	 *
	 * @see com.damytech.communication.CommDelegate
	 *
	 */
	public static void google2baidu(double fLatitude,
									double fLongitude,
									CommDelegate delegate)
	{
		String url = "http://api.map.baidu.com/ag/coord/convert?from=2&to=4"
				+ "&x=" + fLongitude
				+ "&y=" + fLatitude;

		CommParser.async_google2baidu_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_google2baidu_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_google2baidu_handler.onFailure(null, ex.getMessage());
		}
	}


	/**
	 * API method to get place information from the coordinate
	 *
	 * @Note	Wish to confirm the url below before use.
	 * 			If return format is different from the current parse method, please correct parse method.
	 * 			"http://api.map.baidu.com/geocoder?location=41,123&output=json&key=p9mWsPwmgQKl4fgr5YxqhmhI",
	 * 			If status code is "OK", this means request succeeded.
	 *
	 * @param latitude			Latitude to get the detailed place information.
	 * @param longitude		 Longitude to get the detailed place information.
	 * @param delegate		  Callback handler.
	 *
	 * @see com.damytech.structure.baidu.STBaiduGeocode
	 * @see com.damytech.communication.CommDelegate
	 *
	 */
	public static void reverseGeocode(double latitude,
									  double longitude,
									  CommDelegate delegate)
	{
		String url = "http://api.map.baidu.com/geocoder?location="
				+ latitude + "," + longitude
				+ "&output=json&key="
				+ AppCommon.getBaiduServiceKey();

		CommParser.async_reverseGeocode_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut() * 4);
			client.get(url, CommParser.async_reverseGeocode_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_reverseGeocode_handler.onFailure(null, ex.getMessage());
		}
	}


	/**
	 * API method to get nearby places from the specified coordinate
	 *
	 * @Note	Wish to confirm the url below before use.
	 * 			If return format is different from the current parse method, please correct parse method.
	 * 			"http://api.map.baidu.com/place/v2/search?query=%E5%8A%A0%E6%B2%B9%E7%AB%99&location=41.79,123.39&radius=2000&output=json&ak=p9mWsPwmgQKl4fgr5YxqhmhI",
	 * 			If status code is 0, this means request succeeded.
	 *
	 * @param lat		 The latitude value of the core place.
	 * @param lng		 The longitude value of the core place.
	 * @param keyword	 The keyword to search place. The url above used "加油站" as keyword.
	 * @param delegate	Callback handler.
	 *
	 * @see com.damytech.structure.baidu.STBaiduNearbyPlace
	 * @see com.damytech.communication.CommDelegate
	 *
	 */
	public static void nearbySearch(double lat,
									double lng,
									String keyword,
									CommDelegate delegate)
	{
		String url = "http://api.map.baidu.com/place/v2/search?"
				+ "query=" + keyword
				+ "&location=" + lat + "," + lng
				+ "&radius=2000&output=json&ak=" + AppCommon.getBaiduServiceKey();

		CommParser.async_nearbySearch_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_nearbySearch_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_nearbySearch_handler.onFailure(null, ex.getMessage());
		}
	}


	/**
	 * API method to get nearby places from the specified coordinate
	 *
	 * @Note	Wish to confirm the url below before use.
	 * 			If return format is different from the current parse method, please correct parse method.
	 * 			"http://api.map.baidu.com/place/v2/detail?uids=23b34dfa57ee3a22a1d230b8,d3e38aade74aad76704b870f&ak=p9mWsPwmgQKl4fgr5YxqhmhI&output=json&scope=2",
	 * 			If status code is 0, this means request succeeded.
	 *
	 * @param uids
	 * @param delegate
	 */
	public static void placeDetail(ArrayList<String> uids,
								   CommDelegate delegate)
	{
		String url = "http://api.map.baidu.com/place/v2/detail?uids=";

		CommParser.async_placeDetail_handler.delegate = delegate;

		try {
			for (int i = 0; i < uids.size(); i++) {
				if (i > 0)
					url += ",";
				url += uids.get(i);
			}

			url += "&ak=" + AppCommon.getBaiduServiceKey();
			url += "&output=json&scope=2";

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_placeDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_placeDetail_handler.onFailure(null, ex.getMessage());
		}
	}
	////////////////////////////////////////////////////////////////////////////////////



	/*******************************************************************
	 * Api Methods for this project. Add api method which you want.
	 *******************************************************************/
	public static void getBannerImages(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getBannerImages";

		CommParser.async_bannerImages_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_bannerImages_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_bannerImages_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getAreaPoints(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getAreaPoints";

		CommParser.async_areaPoints_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_areaPoints_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_areaPoints_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getAreaPointDetail(long area_id, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getAreaPointDetail";

		CommParser.async_areaPointDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("area_id", "" + area_id);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_areaPointDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_areaPointDetail_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getOneDragonAreas(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getOneDragonAreas";

		CommParser.async_oneDragonAreas_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_oneDragonAreas_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_oneDragonAreas_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getOneDragonAreaDetail(long area_id, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getOneDragonAreaDetail";

		CommParser.async_oneDragonAreaDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("area_id", "" + area_id);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_oneDragonAreaDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_oneDragonAreaDetail_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getOneDragonCompanyDetail(long service_id, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getOneDragonCompanyDetail";

		CommParser.async_oneDragonCompanyDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("service_id", "" + service_id);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_oneDragonCompanyDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_oneDragonCompanyDetail_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getTombKnowledge(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getTombKnowledge";

		CommParser.async_tombKnowledge_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_tombKnowledge_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_tombKnowledge_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getAfterService(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getAfterService";

		CommParser.async_afterService_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_afterService_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_afterService_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getFuneralProducts(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getFuneralProducts";

		CommParser.async_funeralProducts_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_funeralProducts_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_funeralProducts_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void get36Views(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "get36Views";

		CommParser.async_36Views_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_36Views_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_36Views_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void get36ViewDetail(long view_id, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "get36ViewDetail";

		CommParser.async_36ViewDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("view_id", "" + view_id);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_36ViewDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_36ViewDetail_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getNavDestination(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getNavDestination";

		CommParser.async_navDestination_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_navDestination_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_navDestination_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getOfficeIntros(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getOfficeIntros";

		CommParser.async_officeIntros_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_officeIntros_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_officeIntros_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getOfficeDetail(long office_id, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getOfficeDetail";

		CommParser.async_officeDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("office_id", "" + office_id);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_officeDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_officeDetail_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getCompanyIntro(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getCompanyIntro";

		CommParser.async_getCompanyIntro_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getCompanyIntro_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getCompanyIntro_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getFoodPageUrl(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getFoodPageUrl";

		CommParser.async_getFoodPageUrl_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getFoodPageUrl_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getFoodPageUrl_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getShopPageUrl(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getShopPageUrl";

		CommParser.async_getShopPageUrl_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getShopPageUrl_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getShopPageUrl_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getHotelPageUrl(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getHotelPageUrl";

		CommParser.async_getHotelPageUrl_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getHotelPageUrl_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getHotelPageUrl_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getJournalPageUrl(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getJournalPageUrl";

		CommParser.async_getJournalPageUrl_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getJournalPageUrl_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getJournalPageUrl_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getCinemaPageUrl(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getCinemaPageUrl";

		CommParser.async_getCinemaPageUrl_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getCinemaPageUrl_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getCinemaPageUrl_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getGamePageUrl(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getGamePageUrl";

		CommParser.async_getGamePageUrl_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getGamePageUrl_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getGamePageUrl_handler.onFailure(null, ex.getMessage());
		}
	}

	public static void getExamTimeTableImageUrl(CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getExamTimeTableImageUrl";

		CommParser.async_getExamTimeTableImageUrl_handler.delegate = delegate;

		try {
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, CommParser.async_getExamTimeTableImageUrl_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getExamTimeTableImageUrl_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getMtQiPanViews(int page_no, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getMtQiPanViews";

		CommParser.async_getMtQiPanViews_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("page_no", "" + page_no);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getMtQiPanViews_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getMtQiPanViews_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getMtQiPanViewDetail(long view_id, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "getMtQiPanViewDetail";

		CommParser.async_getMtQiPanViewDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("view_id", "" + view_id);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getMtQiPanViewDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getMtQiPanViewDetail_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void reserveVisit(String phone, String nickname, long office_id, String reserve_time, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "reserveVisit";

		CommParser.async_reserveVisitResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("phone", phone);
			params.put("nick_name", nickname);
			params.put("office_id", "" + office_id);
			params.put("reserve_time", reserve_time);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_reserveVisitResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_reserveVisitResult_handler.onFailure(null, ex.getMessage());
		}
	}

	public static void loginUser(String user_name, String password, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "loginUser";

		CommParser.async_loginUserResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_name", user_name);
			params.put("password", password);
			params.put("platform", getPlatform());
			params.put("device_token", SysDevUtility.getAndroidID(SuperActivity.top_instance.getApplication()));

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_loginUserResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_loginUserResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void forgotPassword(String user_name, String phone, String new_password, CommDelegate delegate) {
		String url = getServiceBaseUrl() + "forgotPassword";

		CommParser.async_forgotPasswordResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_name", user_name);
			params.put("phone", phone);
			params.put("new_password", new_password);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_forgotPasswordResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_forgotPasswordResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getAdverts(long user_id, CommDelegate delegate) {
		String method_name = "getAdverts";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getAdvertsResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getAdvertsResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getAdvertsResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getActivities(long user_id, CommDelegate delegate) {
		String method_name = "getActivities";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getActivitiesResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getActivitiesResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getActivitiesResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getNewActivityCount(long user_id, CommDelegate delegate) {
		String method_name = "getNewActivityCount";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getNewActivityCountResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getNewActivityCountResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getNewActivityCountResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getActivityDetail(long user_id, long activity_id, CommDelegate delegate) {
		String method_name = "getActivityDetail";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getActivityDetailResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("activity_id", "" + activity_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getActivityDetailResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getActivityDetailResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void readActivity(long user_id, long activity_id, CommDelegate delegate) {
		String method_name = "readActivity";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_readActivityResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("activity_id", "" + activity_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_readActivityResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_readActivityResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getRelativeData(long user_id, CommDelegate delegate) {
		String method_name = "getRelativeData";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getRelativeDataResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getRelativeDataResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getRelativeDataResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getBills(long user_id, int page_no, CommDelegate delegate) {
		String method_name = "getBills";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getBillsResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getBillsResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getBillsResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getBillDetail(long user_id, long bill_id, CommDelegate delegate) {
		String method_name = "getBillDetail";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getBillDetailResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("bill_id", "" + bill_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getBillDetailResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getBillDetailResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getDeputyLogs(long user_id, int page_no, CommDelegate delegate) {
		String method_name = "getDeputyLogs";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getDeputyLogsResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getDeputyLogsResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getDeputyLogsResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getDeputyLogDetail(long user_id, long log_id, CommDelegate delegate) {
		String method_name = "getDeputyLogDetail";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getDeputyLogDetailResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("log_id", "" + log_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getDeputyLogDetailResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getDeputyLogDetailResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getServicePeopleInfo(long user_id, CommDelegate delegate) {
		String method_name = "getServicePeopleInfo";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getServicePeopleResult_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getServicePeopleResult_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getServicePeopleResult_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getTombListForCustomer(long user_id, CommDelegate delegate) {
		String method_name = "getTombListForCustomer";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getTombListForCustomer_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getTombListForCustomer_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getTombListForCustomer_handler.onFailure(null, ex.getMessage());
		}
	}




	public static void reserveCeremony(long user_id,
									   long customer_id,
									   String reserve_time,
									   long tomb_id,
									   int is_deputyservice,
									   long bury_service_id,
									   ArrayList<STProduct> arrProducts,
									   CommDelegate delegate)
	{
		String method_name = "reserveCeremony";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_reserveCeremony_handler.delegate = delegate;

		try {
			JSONObject params = new JSONObject();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("customer_id", "" + customer_id);
			params.put("reserve_time", reserve_time);
			params.put("tomb_id", "" + tomb_id);
			params.put("is_deputyservice", "" + is_deputyservice);
			params.put("bury_service_id", "" + bury_service_id);

			JSONArray arrJSONProducts = new JSONArray();
			for (int i = 0; i < arrProducts.size(); i++) {
				STProduct product = arrProducts.get(i);

				JSONObject jsonObj = new JSONObject();
				jsonObj.put("uid", product.uid);
				jsonObj.put("count", product.amount);
				arrJSONProducts.put(jsonObj);
			}

			params.put("products", arrJSONProducts.toString());
			params.put("check_sum", check_sum);

			StringEntity entity = new StringEntity(params.toString(), "UTF-8");

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.post(null, url, entity, "application/json", CommParser.async_reserveCeremony_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_reserveCeremony_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getActivityProducts(long user_id, CommDelegate delegate) {
		String method_name = "getActivityProducts";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getActivityProducts_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getActivityProducts_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getActivityProducts_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getBonusFormula(long user_id, CommDelegate delegate) {
		String method_name = "getBonusFormula";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getBonusFormula_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getBonusFormula_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getBonusFormula_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getBonusDetailList(long user_id, int bonus_type, int page_no, CommDelegate delegate) {
		String method_name = "getBonusDetailList";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getBonusLogs_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("bonus_type", "" + bonus_type);
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getBonusLogs_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getBonusLogs_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getDepositLogs(long user_id, long aim_user_id, int page_no, CommDelegate delegate) {
		String method_name = "getDepositLogs";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getDepositLogs_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("aim_user_id", "" + aim_user_id);
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getDepositLogs_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getDepositLogs_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getAgentDepositLogs(long user_id, long aim_user_id, int page_no, CommDelegate delegate) {
		String method_name = "getAgentDepositLogs";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getAgentDepositLogs_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("aim_user_id", "" + aim_user_id);
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getAgentDepositLogs_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getAgentDepositLogs_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getCustomerList(long user_id, CommDelegate delegate) {
		String method_name = "getCustomerList";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getCustomers_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getCustomers_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getCustomers_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getTombList(long user_id, long area_id, CommDelegate delegate) {
		String method_name = "getTombList";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getTombs_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("area_id", "" + area_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getTombs_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getTombs_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getTombDetail(long user_id, long tomb_id, CommDelegate delegate) {
		String method_name = "getTombDetail";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getTombDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("tomb_id", "" + tomb_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getTombDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getTombDetail_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getTombStonePlaces(long user_id, long area_id, CommDelegate delegate) {
		String method_name = "getTombStonePlaces";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getTombStonePlaces_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("area_id", "" + area_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getTombStonePlaces_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getTombStonePlaces_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void reserveTombPlace(long user_id,
										String customer_name,
										String customer_phone,
										String death_people1,
										String mgr_people1,
										String death_people2,
										String mgr_people2,
										long tomb_area_id,
										long tomb_site_id,
										long tomb_tablet_id,
										CommDelegate delegate) {
		String method_name = "reserveTombPlace";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_reserveTombPlace_handler.delegate = delegate;

		try {
			JSONObject params = new JSONObject();
			params.put("user_id", user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("customer_name", customer_name);
			params.put("customer_phone", customer_phone);
			params.put("death_people1", death_people1);
			params.put("mgr_people1", mgr_people1);
			params.put("death_people2", death_people2);
			params.put("mgr_people2", mgr_people2);
			params.put("tomb_area_id", tomb_area_id);
			params.put("tomb_site_id", tomb_site_id);
			params.put("tomb_tablet_id", tomb_tablet_id);
			params.put("check_sum", check_sum);

			StringEntity entity = new StringEntity(params.toString(), "UTF-8");

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.post(null, url, entity, "application/json", CommParser.async_reserveTombPlace_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_reserveTombPlace_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getAgents(long user_id, CommDelegate delegate) {
		String method_name = "getAgents";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getAgents_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getAgents_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getAgents_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getBuyProductCount(long user_id, CommDelegate delegate) {
		String method_name = "getBuyProductCount";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getBuyProductCount_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getBuyProductCount_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getBuyProductCount_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getBuyProductLogs(long user_id, int page_no, int state, CommDelegate delegate) {
		String method_name = "getBuyProductLogs";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getBuyProductLogs_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("state", "" + state);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getBuyProductLogs_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getBuyProductLogs_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getBuyProductLogDetail(long user_id, long log_id, CommDelegate delegate) {
		String method_name = "getBuyProductLogDetail";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getBuyProductLogDetail_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("log_id", "" + log_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getBuyProductLogDetail_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getBuyProductLogDetail_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void readBuyProductLog(long user_id, long log_id, CommDelegate delegate) {
		String method_name = "readBuyProductLog";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_readBuyProductLog_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("log_id", "" + log_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_readBuyProductLog_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_readBuyProductLog_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getVocationDates(long user_id, CommDelegate delegate) {
		String method_name = "getVocationDates";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getVocationDates_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getVocationDates_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getVocationDates_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void cancelVocation(long user_id, long vocation_id, CommDelegate delegate) {
		String method_name = "cancelVocation";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_cancelVocation_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("vocation_id", "" + vocation_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_cancelVocation_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_cancelVocation_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void submitVocation(long user_id, int reason, String date, CommDelegate delegate) {
		String method_name = "submitVocation";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_submitVocation_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("reason", "" + reason);
			params.put("date", date);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_submitVocation_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_submitVocation_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getOfficeList(long user_id, CommDelegate delegate) {
		String method_name = "getOfficeList";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getOfficeList_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getOfficeList_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getOfficeList_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getOfficeAttendance(long user_id, long office_id, CommDelegate delegate) {
		String method_name = "getOfficeAttendance";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getOfficeAttendance_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("office_id", "" + office_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getOfficeAttendance_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getOfficeAttendance_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getOfficesCurMonthScore(long user_id, int month, CommDelegate delegate) {
		String method_name = "getOfficesCurMonthScore";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getOfficesCurMonthScore_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("month", "" + month);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getOfficesCurMonthScore_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getOfficesCurMonthScore_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getOfficeMonthlyScore(long user_id, long office_id, CommDelegate delegate) {
		String method_name = "getOfficeMonthlyScore";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getOfficeMonthlyScore_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("office_id", "" + office_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getOfficeMonthlyScore_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getOfficeMonthlyScore_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getEmployeesDailyScore(long user_id, long office_id, CommDelegate delegate) {
		String method_name = "getEmployeesDailyScore";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getEmployeesDailyScore_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("office_id", "" + office_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getEmployeesDailyScore_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getEmployeesDailyScore_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getOfficesDailyScore(long user_id, CommDelegate delegate) {
		String method_name = "getOfficesDailyScore";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getOfficesDailyScore_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getOfficesDailyScore_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getOfficesDailyScore_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getEmployeePersonalScore(long user_id, int page_no, CommDelegate delegate) {
		String method_name = "getEmployeePersonalScore";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getEmployeePersonalScore_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getEmployeePersonalScore_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getEmployeePersonalScore_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void getEmployeePersonalScoreMgr(long user_id, CommDelegate delegate) {
		String method_name = "getEmployeePersonalScoreMgr";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getEmployeePersonalScoreMgr_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getEmployeePersonalScoreMgr_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getEmployeePersonalScoreMgr_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getAgentPersonalScore(long user_id, int page_no, CommDelegate delegate) {
		String method_name = "getAgentPersonalScore";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getAgentPersonalScore_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getAgentPersonalScore_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getAgentPersonalScore_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getOfficesDepositLogs(long user_id, int page_no, CommDelegate delegate) {
		String method_name = "getOfficesDepositLogs";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getOfficeDepositLogs_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getOfficeDepositLogs_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getOfficeDepositLogs_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getAgentPersonalScoreMgr(long user_id, int page_no, CommDelegate delegate) {
		String method_name = "getAgentPersonalScoreMgr";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getAgentPersonalScoreMgr_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getAgentPersonalScoreMgr_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getAgentPersonalScoreMgr_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void getReserveLogs(long user_id, int page_no, CommDelegate delegate) {
		String method_name = "getReserveLogs";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_getReserveLogs_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("page_no", "" + page_no);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_getReserveLogs_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_getReserveLogs_handler.onFailure(null, ex.getMessage());
		}
	}



	public static void cancelReserve(long user_id, long log_id, CommDelegate delegate) {
		String method_name = "cancelReserve";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_cancelReserve_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("log_id", "" + log_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_cancelReserve_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_cancelReserve_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void confirmReserve(long user_id, long log_id, CommDelegate delegate) {
		String method_name = "confirmReserve";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_confirmReserve_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("user_id", "" + user_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("log_id", "" + log_id);
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_confirmReserve_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_confirmReserve_handler.onFailure(null, ex.getMessage());
		}
	}


	public static void checkParentBirthNotify(long client_id, CommDelegate delegate) {
		String method_name = "checkParentBirthNotify";
		String url = getServiceBaseUrl() + method_name;
		String check_sum = createCheckSum(method_name);

		CommParser.async_checkParentBirthNotify_handler.delegate = delegate;

		try {
			RequestParams params = new RequestParams();
			params.put("client_id", "" + client_id);
			params.put("user_type", "" + AppCommon.loadUserType(SuperActivity.top_instance.getApplicationContext()));
			params.put("check_sum", check_sum);

			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, params, CommParser.async_checkParentBirthNotify_handler);
		} catch (Exception ex) {
			ex.printStackTrace();
			CommParser.async_checkParentBirthNotify_handler.onFailure(null, ex.getMessage());
		}
	}
}


