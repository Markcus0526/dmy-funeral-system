package com.damytech.communication;

import android.util.Base64;
import com.damytech.structure.baidu.*;
import com.damytech.structure.custom.*;
import com.damytech.communication.http_conn.AsyncHttpResponseHandler;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-12
 * Time : 16:32
 * File Name : CommParser
 *
 * Description : This class is for parsing the data which is returned from web service
 *
 */
public class CommParser {
	// Public service api parsers

	/**
	 * async_requestWeatherInfo_handler
	 */
	public static AsyncHttpResponseHandler async_requestWeatherInfo_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			ArrayList<STBaiduWeather> arrWeathers = new ArrayList<STBaiduWeather>();

			try {
				JSONArray arrWeatherInfos = new JSONArray(content);

				for (int i = 0; i < arrWeatherInfos.length(); i++) {
					JSONObject json_weather_item = arrWeatherInfos.getJSONObject(i);

					STBaiduWeather weather_item = STBaiduWeather.decodeFromJSON(json_weather_item);
					arrWeathers.add(weather_item);
				}

				delegate.requestWeatherInfoResult(CommErrMgr.ERRCODE_NONE,
						CommErrMgr.ERRMSG_SUCCESS,
						arrWeathers);
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.requestWeatherInfoResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.requestWeatherInfoResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	/**
	 * async_google2baidu_hndler
	 */
	public static AsyncHttpResponseHandler async_google2baidu_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			double lat = 0, lng = 0;
			try {
				JSONObject result = new JSONObject(content);

				int error = result.getInt("error");
				if (error == 0) {
					// Return position information is encoded with Base64.
					// Must decode using Base64
					String x = result.getString("x");
					String y = result.getString("y");

					String xStr = new String(Base64.decode(x, Base64.DEFAULT), "UTF-8");
					String yStr = new String(Base64.decode(y, Base64.DEFAULT), "UTF-8");

					lng = Double.parseDouble(xStr);
					lat = Double.parseDouble(yStr);
					///////////////////////////////////////////////////////////////////

					delegate.google2baiduResult(CommErrMgr.ERRCODE_NONE,
							CommErrMgr.ERRMSG_SUCCESS,
							lat,
							lng);
				} else {
					delegate.google2baiduResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							-1,
							-1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.google2baiduResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						-1,
						-1);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.google2baiduResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						-1,
						-1);
			}
		}
	};


	/**
	 * async_reverseGeocode_handler
	 */
	public static AsyncHttpResponseHandler async_reverseGeocode_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				String retcode = result.getString("status");
				if (retcode.toUpperCase().equals("OK")) {
					JSONObject data = result.getJSONObject("result");
					STBaiduGeocode geocode_info = STBaiduGeocode.decodeFromJSON(data);

					delegate.reverseGeocodeResult(CommErrMgr.ERRCODE_NONE,
							CommErrMgr.ERRMSG_SUCCESS,
							geocode_info);
				} else {
					delegate.reverseGeocodeResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.reverseGeocodeResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.reverseGeocodeResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	/**
	 * async_nearbySearch_handler
	 */
	public static AsyncHttpResponseHandler async_nearbySearch_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject json_content = new JSONObject(content);

				ArrayList<STBaiduNearbyPlace> arrPlaces = new ArrayList<STBaiduNearbyPlace>();

				int status = json_content.getInt("status");
				if (status == 0) {
					JSONArray arrJSONResult = json_content.getJSONArray("results");
					for (int i = 0; i < arrJSONResult.length(); i++) {
						JSONObject nearby_item = arrJSONResult.getJSONObject(i);

						STBaiduNearbyPlace placeinfo = STBaiduNearbyPlace.decodeFromJSON(nearby_item);
						arrPlaces.add(placeinfo);
					}

					delegate.nearbySearchResult(CommErrMgr.ERRCODE_NONE,
							CommErrMgr.ERRMSG_SUCCESS,
							arrPlaces);
				} else {
					delegate.nearbySearchResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.nearbySearchResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.nearbySearchResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	/**
	 * async_placeDetail_handler
	 */
	public static AsyncHttpResponseHandler async_placeDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject json_content = new JSONObject(content);

				int status = json_content.getInt("status");
				if (status == 0) {
					JSONArray arrJSONPlaces = json_content.getJSONArray("result");

					ArrayList<STBaiduPlaceDetail> arrPlaces = new ArrayList<STBaiduPlaceDetail>();

					for (int i = 0; i < arrJSONPlaces.length(); i++) {
						JSONObject json_place_item = arrJSONPlaces.getJSONObject(i);

						STBaiduPlaceDetail detail_info = STBaiduPlaceDetail.decodeFromJSON(json_place_item);
						arrPlaces.add(detail_info);

						delegate.placeDetailResult(CommErrMgr.ERRCODE_NONE,
								CommErrMgr.ERRMSG_SUCCESS,
								arrPlaces);
					}
				} else {
					delegate.placeDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.placeDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.placeDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	// Project service apis
	public static AsyncHttpResponseHandler async_bannerImages_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STAdvertImage> arrImages = new ArrayList<STAdvertImage>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray arrJSONImages = result.getJSONArray("retdata");
					for (int i = 0; i < arrJSONImages.length(); i++) {
						STAdvertImage image = STAdvertImage.decodeFromJSON(arrJSONImages.getJSONObject(i));
						arrImages.add(image);
					}

					delegate.getBannerImagesResult(retcode, retmsg, arrImages);
				} else {
					delegate.getBannerImagesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBannerImagesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBannerImagesResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_areaPoints_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STAreaPoint> arrPoints = new ArrayList<STAreaPoint>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray arrJSONPoints = result.getJSONArray("retdata");
					for (int i = 0; i < arrJSONPoints.length(); i++) {
						STAreaPoint point = STAreaPoint.decodeFromJSON(arrJSONPoints.getJSONObject(i));
						arrPoints.add(point);
					}

					delegate.getAreaPointsResult(retcode, retmsg, arrPoints);
				} else {
					delegate.getAreaPointsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAreaPointsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAreaPointsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_areaPointDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STAreaPoint point = STAreaPoint.decodeFromJSON(retdata);

					delegate.getAreaPointDetailResult(retcode, retmsg, point);
				} else {
					delegate.getAreaPointDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAreaPointDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAreaPointDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_oneDragonAreas_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");

					ArrayList<STDragonServiceCity> arrCities = new ArrayList<STDragonServiceCity>();

					for (int i = 0; i < retdata.length(); i++) {
						JSONObject json_city = retdata.getJSONObject(i);
						STDragonServiceCity city = STDragonServiceCity.decodeFromJSON(json_city);
						arrCities.add(city);
					}

					delegate.getOneDragonAreasResult(retcode, retmsg, arrCities);
				} else {
					delegate.getOneDragonAreasResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOneDragonAreasResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOneDragonAreasResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_oneDragonAreaDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STDragonServiceArea area = STDragonServiceArea.decodeFromJSON(retdata);
					delegate.getOneDragonAreaDetailResult(retcode, retmsg, area);
				} else {
					delegate.getOneDragonAreaDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOneDragonAreaDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOneDragonAreaDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_oneDragonCompanyDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STDragonService service = STDragonService.decodeFromJSON(retdata);
					delegate.getOneDragonCompanyDetailResult(retcode, retmsg, service);
				} else {
					delegate.getOneDragonCompanyDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOneDragonCompanyDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOneDragonCompanyDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_tombKnowledge_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STTombKnowledge knowledge = STTombKnowledge.decodeFromJSON(retdata);
					delegate.getTombKnowledgeResult(retcode, retmsg, knowledge);
				} else {
					delegate.getTombKnowledgeResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getTombKnowledgeResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getTombKnowledgeResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_afterService_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STAfterService service = STAfterService.decodeFromJSON(retdata);

					delegate.getAfterServiceResult(retcode, retmsg, service);
				} else {
					delegate.getAfterServiceResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAfterServiceResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAfterServiceResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_funeralProducts_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STProduct> arrProducts = new ArrayList<STProduct>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray arrJSONProducts = result.getJSONArray("retdata");
					for (int i = 0; i < arrJSONProducts.length(); i++) {
						STProduct product = STProduct.decodeFromJSON(arrJSONProducts.getJSONObject(i));
						arrProducts.add(product);
					}

					delegate.getFuneralProductsResult(retcode, retmsg, arrProducts);
				} else {
					delegate.getFuneralProductsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getFuneralProductsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getFuneralProductsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_36Views_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<ST36View> arrViews = new ArrayList<ST36View>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray arrJSONProducts = result.getJSONArray("retdata");
					for (int i = 0; i < arrJSONProducts.length(); i++) {
						ST36View view = ST36View.decodeFromJSON(arrJSONProducts.getJSONObject(i));
						arrViews.add(view);
					}

					delegate.get36ViewsResult(retcode, retmsg, arrViews);
				} else {
					delegate.get36ViewsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.get36ViewsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.get36ViewsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_36ViewDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<ST36View> arrViews = new ArrayList<ST36View>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject view_info = result.getJSONObject("retdata");
					ST36View view = ST36View.decodeFromJSON(view_info);

					delegate.get36ViewDetailResult(retcode, retmsg, view);
				} else {
					delegate.get36ViewDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.get36ViewDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.get36ViewDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_navDestination_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				double lat = 0, lng = 0;

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					lat = retdata.getDouble("lat");
					lng = retdata.getDouble("lng");

					delegate.getNavDestinationResult(retcode, retmsg, lat, lng);
				} else {
					delegate.getNavDestinationResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							-1, -1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getNavDestinationResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						-1, -1);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getNavDestinationResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						-1, -1);
			}
		}
	};



	public static AsyncHttpResponseHandler async_officeIntros_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STOfficeCity> arrCities = new ArrayList<STOfficeCity>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject json_city = retdata.getJSONObject(i);
						STOfficeCity city_info = STOfficeCity.decodeFromJSON(json_city);
						arrCities.add(city_info);
					}

					delegate.getOfficeIntrosResult(retcode, retmsg, arrCities);
				} else {
					delegate.getOfficeIntrosResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficeIntrosResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficeIntrosResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_officeDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STOffice office_info = STOffice.decodeFromJSON(retdata);

					delegate.getOfficeDetailResult(retcode, retmsg, office_info);
				} else {
					delegate.getOfficeDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficeDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficeDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getCompanyIntro_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String contents = "";
				String phone = "";
				String imageUrl = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					contents = retdata.getString("contents");
					phone = retdata.getString("phone");
					imageUrl = retdata.getString("image_url");

					delegate.getCompanyIntroResult(retcode, retmsg, contents, phone, imageUrl);
				} else {
					delegate.getCompanyIntroResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"", "", "");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getCompanyIntroResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"", "", "");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getCompanyIntroResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"", "", "");
			}
		}
	};


	public static AsyncHttpResponseHandler async_getFoodPageUrl_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String page_url = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					page_url = retdata.getString("page_url");

					delegate.getFoodPageUrlResult(retcode, retmsg, page_url);
				} else {
					delegate.getFoodPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getFoodPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getFoodPageUrlResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"");
			}
		}
	};


	public static AsyncHttpResponseHandler async_getShopPageUrl_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String page_url = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					page_url = retdata.getString("page_url");

					delegate.getShopPageUrlResult(retcode, retmsg, page_url);
				} else {
					delegate.getShopPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getShopPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getShopPageUrlResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"");
			}
		}
	};


	public static AsyncHttpResponseHandler async_getHotelPageUrl_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String page_url = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					page_url = retdata.getString("page_url");

					delegate.getHotelPageUrlResult(retcode, retmsg, page_url);
				} else {
					delegate.getHotelPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getHotelPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getHotelPageUrlResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"");
			}
		}
	};


	public static AsyncHttpResponseHandler async_getJournalPageUrl_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String plane_page_url = "";
				String train_page_url = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					plane_page_url = retdata.getString("plane_page_url");
					train_page_url = retdata.getString("train_page_url");

					delegate.getJournalPageUrlResult(retcode, retmsg, plane_page_url, train_page_url);
				} else {
					delegate.getJournalPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"", "");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getJournalPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"", "");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getJournalPageUrlResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"", "");
			}
		}
	};


	public static AsyncHttpResponseHandler async_getCinemaPageUrl_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String page_url = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					page_url = retdata.getString("page_url");

					delegate.getCinemaPageUrlResult(retcode, retmsg, page_url);
				} else {
					delegate.getCinemaPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getCinemaPageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getCinemaPageUrlResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"");
			}
		}
	};



	public static AsyncHttpResponseHandler async_getGamePageUrl_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String page_url = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					page_url = retdata.getString("page_url");

					delegate.getGamePageUrlResult(retcode, retmsg, page_url);
				} else {
					delegate.getGamePageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getGamePageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getGamePageUrlResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"");
			}
		}
	};



	public static AsyncHttpResponseHandler async_getExamTimeTableImageUrl_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				String worker_url = "";
				String school_url = "";
				String photo_url = "";

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					worker_url = retdata.getString("worker_image_url");
					school_url = retdata.getString("school_image_url");
					photo_url = retdata.getString("photo_image_url");

					delegate.getExamTimeTableImageUrlResult(retcode, retmsg, worker_url, school_url, photo_url);
				} else {
					delegate.getExamTimeTableImageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							"", "", "");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getExamTimeTableImageUrlResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						"", "", "");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getExamTimeTableImageUrlResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						"", "", "");
			}
		}
	};



	public static AsyncHttpResponseHandler async_getMtQiPanViews_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STMtQiPanView> arrViews = new ArrayList<STMtQiPanView>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject json_view_info = retdata.getJSONObject(i);
						STMtQiPanView view_info = STMtQiPanView.decodeFromJSON(json_view_info);
						arrViews.add(view_info);
					}

					delegate.getMtQiPanViewsResult(retcode, retmsg, arrViews);
				} else {
					delegate.getMtQiPanViewsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getMtQiPanViewsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getMtQiPanViewsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getMtQiPanViewDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STMtQiPanView view_info = STMtQiPanView.decodeFromJSON(retdata);

					delegate.getMtQiPanViewDetailResult(retcode, retmsg, view_info);
				} else {
					delegate.getMtQiPanViewDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getMtQiPanViewDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getMtQiPanViewDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_reserveVisitResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					delegate.reserveVisitResult(retcode, retmsg);
				} else {
					delegate.reserveVisitResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.reserveVisitResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage());
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.reserveVisitResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR);
			}
		}
	};



	public static AsyncHttpResponseHandler async_loginUserResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					long user_id = 0;
					String user_realname = "";
					String access_token = "";
					int user_type = 0;
					long office_id = 0;
					String office_name = "";
					String id_image_url = "";

					JSONObject retdata = result.getJSONObject("retdata");
					user_id = retdata.getLong("user_id");
					user_realname = retdata.getString("name");
					access_token = retdata.getString("access_token");
					user_type = retdata.getInt("user_type");
					try { office_id = retdata.getLong("office_id"); } catch (Exception ex) { ex.printStackTrace(); }
					try { office_name = retdata.getString("office_name"); } catch (Exception ex) { ex.printStackTrace(); }
					try { id_image_url = retdata.getString("credential_image"); } catch (Exception ex) { ex.printStackTrace(); }

					delegate.loginUserResult(retcode, retmsg, user_id, user_realname, access_token, user_type, office_id, office_name, id_image_url);
				} else {
					delegate.loginUserResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							-1, "", "", -1, -1, "", "");
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.loginUserResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						-1, "", "", -1, -1, "", "");
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.loginUserResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						-1, "", "", -1, -1, "", "");
			}
		}
	};



	public static AsyncHttpResponseHandler async_forgotPasswordResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					delegate.forgotPasswordResult(retcode, retmsg);
				} else {
					delegate.forgotPasswordResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.forgotPasswordResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage());
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.forgotPasswordResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getAdvertsResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STAdvertImage> arrAdverts = new ArrayList<STAdvertImage>();
				ArrayList<STRelative> arrRelatives = new ArrayList<STRelative>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");

					JSONArray arrJSONAdverts = retdata.getJSONArray("adverts");
					JSONArray arrJSONRelatives = retdata.getJSONArray("relative_dates");

					for (int i = 0; i < arrJSONAdverts.length(); i++) {
						STAdvertImage advert = STAdvertImage.decodeFromJSON(arrJSONAdverts.getJSONObject(i));
						arrAdverts.add(advert);
					}

					for (int i = 0; i < arrJSONRelatives.length(); i++) {
						STRelative relative = STRelative.decodeFromJSON(arrJSONRelatives.getJSONObject(i));
						arrRelatives.add(relative);
					}

					delegate.getAdvertsResult(retcode, retmsg, arrAdverts, arrRelatives);
				} else {
					delegate.getAdvertsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAdvertsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null, null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAdvertsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getActivitiesResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STActivity> arrActivities = new ArrayList<STActivity>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");

					for (int i = 0; i < retdata.length(); i++) {
						STActivity activity = STActivity.decodeFromJSON(retdata.getJSONObject(i));
						arrActivities.add(activity);
					}

					delegate.getActivitiesResult(retcode, retmsg, arrActivities);
				} else {
					delegate.getActivitiesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getActivitiesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getActivitiesResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getNewActivityCountResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");

					int count = retdata.getInt("count");
					delegate.getNewActivityCountResult(retcode, retmsg, count);
				} else {
					delegate.getNewActivityCountResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							0);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getNewActivityCountResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						0);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getNewActivityCountResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						0);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getActivityDetailResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STActivity activity = STActivity.decodeFromJSON(retdata);
					delegate.getActivityDetailResult(retcode, retmsg, activity);
				} else {
					delegate.getActivityDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE,
							null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getActivityDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(),
						null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getActivityDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR,
						null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_readActivityResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					delegate.readActivityResult(retcode, retmsg);
				} else {
					delegate.readActivityResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.readActivityResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage());
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.readActivityResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getRelativeDataResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STRelative> arrRelatives = new ArrayList<STRelative>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray arrJSONRelatives = result.getJSONArray("retdata");
					for (int i = 0; i < arrJSONRelatives.length(); i++) {
						STRelative relative = STRelative.decodeFromJSON(arrJSONRelatives.getJSONObject(i));
						arrRelatives.add(relative);
					}

					delegate.getRelativeDataResult(retcode, retmsg, arrRelatives);
				} else {
					delegate.getRelativeDataResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getRelativeDataResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getRelativeDataResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getBillsResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STBill> arrBills = new ArrayList<STBill>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray arrJSONBills = result.getJSONArray("retdata");
					for (int i = 0; i < arrJSONBills.length(); i++) {
						STBill bill = STBill.decodeFromJSON(arrJSONBills.getJSONObject(i));
						arrBills.add(bill);
					}

					delegate.getBillsResult(retcode, retmsg, arrBills);
				} else {
					delegate.getBillsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBillsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBillsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getBillDetailResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject json_bill = result.getJSONObject("retdata");
					STBill bill = STBill.decodeFromJSON(json_bill);

					delegate.getBillDetailResult(retcode, retmsg, bill);
				} else {
					delegate.getBillDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBillDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBillDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getDeputyLogsResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STDeputyLog> arrLogs = new ArrayList<STDeputyLog>();

					JSONArray arrJSONLogs = result.getJSONArray("retdata");
					for (int i = 0; i < arrJSONLogs.length(); i++) {
						STDeputyLog deputy_log = STDeputyLog.decodeFromJSON(arrJSONLogs.getJSONObject(i));
						arrLogs.add(deputy_log);
					}

					delegate.getDeputyLogsResult(retcode, retmsg, arrLogs);
				} else {
					delegate.getDeputyLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getDeputyLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getDeputyLogsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getDeputyLogDetailResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject json_log = result.getJSONObject("retdata");
					STDeputyLog deputy_log = STDeputyLog.decodeFromJSON(json_log);

					delegate.getDeputyLogDetailResult(retcode, retmsg, deputy_log);
				} else {
					delegate.getDeputyLogDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getDeputyLogDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getDeputyLogDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getServicePeopleResult_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STEmployee emp_info = STEmployee.decodeFromJSON(retdata);

					delegate.getServicePeopleInfoResult(retcode, retmsg, emp_info);
				} else {
					delegate.getServicePeopleInfoResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getServicePeopleInfoResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getServicePeopleInfoResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getTombListForCustomer_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STTomb> arrItems = new ArrayList<STTomb>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STTomb item = STTomb.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getTombListForCustomerResult(retcode, retmsg, arrItems);
				} else {
					delegate.getTombListForCustomerResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getTombListForCustomerResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getTombListForCustomerResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};




	public static AsyncHttpResponseHandler async_reserveCeremony_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					delegate.reserveCeremonyResult(retcode, retmsg);
				} else {
					delegate.reserveCeremonyResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.reserveCeremonyResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage());
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.reserveCeremonyResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getActivityProducts_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STProduct> arrProducts = new ArrayList<STProduct>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonProduct = retdata.getJSONObject(i);
						STProduct product = STProduct.decodeFromJSON(jsonProduct);
						arrProducts.add(product);
					}

					delegate.getActivityProductsResult(retcode, retmsg, arrProducts);
				} else {
					delegate.getActivityProductsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getActivityProductsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getActivityProductsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getBonusFormula_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					double discount_limit = retdata.getDouble("discount_limit");
					double commission = retdata.getDouble("commission");
					double tax_rate = retdata.getDouble("tax_rate");

					delegate.getBonusFormulaResult(retcode, retmsg, discount_limit, commission, tax_rate);
				} else {
					delegate.getBonusFormulaResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, 0, 0, 0);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBonusFormulaResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), 0, 0, 0);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBonusFormulaResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, 0, 0, 0);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getBonusLogs_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STBonusLog> arrLogs = new ArrayList<STBonusLog>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonLog = retdata.getJSONObject(i);
						STBonusLog bonusLog = STBonusLog.decodeFromJSON(jsonLog);
						arrLogs.add(bonusLog);
					}

					delegate.getBonusDetailListResult(retcode, retmsg, arrLogs);
				} else {
					delegate.getBonusDetailListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBonusDetailListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBonusDetailListResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getDepositLogs_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STDepositLog> arrLogs = new ArrayList<STDepositLog>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonLog = retdata.getJSONObject(i);
						STDepositLog depositLog = STDepositLog.decodeFromJSON(jsonLog);
						arrLogs.add(depositLog);
					}

					delegate.getDepositLogsResult(retcode, retmsg, arrLogs);
				} else {
					delegate.getDepositLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getDepositLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getDepositLogsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getAgentDepositLogs_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STDepositLog> arrLogs = new ArrayList<STDepositLog>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonLog = retdata.getJSONObject(i);
						STDepositLog depositLog = STDepositLog.decodeFromJSON(jsonLog);
						arrLogs.add(depositLog);
					}

					delegate.getAgentDepositLogsResult(retcode, retmsg, arrLogs);
				} else {
					delegate.getAgentDepositLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAgentDepositLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAgentDepositLogsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getCustomers_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STCustomer> arrCustomers = new ArrayList<STCustomer>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonItem = retdata.getJSONObject(i);
						STCustomer customer = STCustomer.decodeFromJSON(jsonItem);
						arrCustomers.add(customer);
					}

					delegate.getCustomerListResult(retcode, retmsg, arrCustomers);
				} else {
					delegate.getCustomerListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getCustomerListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getCustomerListResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getTombs_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				ArrayList<STTomb> arrTombs = new ArrayList<STTomb>();

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonItem = retdata.getJSONObject(i);
						STTomb item = STTomb.decodeFromJSON(jsonItem);
						arrTombs.add(item);
					}

					delegate.getTombListResult(retcode, retmsg, arrTombs);
				} else {
					delegate.getTombListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getTombListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getTombListResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getTombDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STTomb item = STTomb.decodeFromJSON(retdata);

					delegate.getTombDetailResult(retcode, retmsg, item);
				} else {
					delegate.getTombDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getTombDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getTombDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getTombStonePlaces_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STTombStoneArea> arrAreas = new ArrayList<STTombStoneArea>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonArea = retdata.getJSONObject(i);
						STTombStoneArea area = STTombStoneArea.decodeFromJSON(jsonArea);
						arrAreas.add(area);
					}

					delegate.getTombStonePlacesResult(retcode, retmsg, arrAreas);
				} else {
					delegate.getTombStonePlacesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getTombStonePlacesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getTombStonePlacesResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_reserveTombPlace_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					delegate.reserveTombPlaceResult(retcode, retmsg);
				} else {
					delegate.reserveTombPlaceResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.reserveTombPlaceResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage());
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.reserveTombPlaceResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getAgents_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STAgent> arrAgents = new ArrayList<STAgent>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonAgent = retdata.getJSONObject(i);
						STAgent agent = STAgent.decodeFromJSON(jsonAgent);
						arrAgents.add(agent);
					}

					delegate.getAgentsResult(retcode, retmsg, arrAgents);
				} else {
					delegate.getAgentsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAgentsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAgentsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getBuyProductCount_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					int count = retdata.getInt("count");

					delegate.getBuyProductCountResult(retcode, retmsg, count);
				} else {
					delegate.getBuyProductCountResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, -1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBuyProductCountResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), -1);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBuyProductCountResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, -1);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getBuyProductLogs_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					ArrayList<STBuyProductLog> arrLogs = new ArrayList<STBuyProductLog>();
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonLog = retdata.getJSONObject(i);
						STBuyProductLog log_info = STBuyProductLog.decodeFromJSON(jsonLog);
						arrLogs.add(log_info);
					}

					delegate.getBuyProductLogsResult(retcode, retmsg, arrLogs);
				} else {
					delegate.getBuyProductLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBuyProductLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBuyProductLogsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getBuyProductLogDetail_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					STBuyProductLog log_info = STBuyProductLog.decodeFromJSON(retdata);

					delegate.getBuyProductLogDetailResult(retcode, retmsg, log_info);
				} else {
					delegate.getBuyProductLogDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getBuyProductLogDetailResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getBuyProductLogDetailResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_readBuyProductLog_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					delegate.readBuyProductLogResult(retcode, retmsg);
				} else {
					delegate.readBuyProductLogResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.readBuyProductLogResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage());
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.readBuyProductLogResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getVocationDates_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONArray retdata = result.getJSONArray("retdata");
					ArrayList<STVocation> arrVocations = new ArrayList<STVocation>();
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonLog = retdata.getJSONObject(i);
						STVocation log_info = STVocation.decodeFromJSON(jsonLog);
						arrVocations.add(log_info);
					}

					delegate.getVocationDatesResult(retcode, retmsg, arrVocations);
				} else {
					delegate.getVocationDatesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getVocationDatesResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getVocationDatesResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_cancelVocation_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					long vocation_id = retdata.getLong("cancelled_id");

					delegate.cancelVocationResult(retcode, retmsg, vocation_id);
				} else {
					delegate.cancelVocationResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, -1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.cancelVocationResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), -1);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.cancelVocationResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, -1);
			}
		}
	};



	public static AsyncHttpResponseHandler async_submitVocation_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					delegate.submitVocationResult(retcode, retmsg);
				} else {
					delegate.submitVocationResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							retmsg);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.submitVocationResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage());
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.submitVocationResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getOfficeList_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STOfficeCity> arrCities = new ArrayList<STOfficeCity>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STOfficeCity city = STOfficeCity.decodeFromJSON(jsonObj);
						arrCities.add(city);
					}

					delegate.getOfficeListResult(retcode, retmsg, arrCities);
				} else {
					delegate.getOfficeListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficeListResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficeListResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getOfficeAttendance_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STVocation> arrItems = new ArrayList<STVocation>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STVocation item = STVocation.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getOfficeAttendanceResult(retcode, retmsg, arrItems);
				} else {
					delegate.getOfficeAttendanceResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficeAttendanceResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficeAttendanceResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getOfficesCurMonthScore_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STMonthlyScore> arrItems = new ArrayList<STMonthlyScore>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STMonthlyScore item = STMonthlyScore.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getOfficesCurMonthScoreResult(retcode, retmsg, arrItems);
				} else {
					delegate.getOfficesCurMonthScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficesCurMonthScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficesCurMonthScoreResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getOfficeMonthlyScore_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STMonthlyScore> arrItems = new ArrayList<STMonthlyScore>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STMonthlyScore item = STMonthlyScore.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getOfficeMonthlyScoreResult(retcode, retmsg, arrItems);
				} else {
					delegate.getOfficeMonthlyScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficeMonthlyScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficeMonthlyScoreResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getEmployeesDailyScore_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STDailyScore> arrItems = new ArrayList<STDailyScore>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STDailyScore item = STDailyScore.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getEmployeesDailyScoreResult(retcode, retmsg, arrItems);
				} else {
					delegate.getEmployeesDailyScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getEmployeesDailyScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getEmployeesDailyScoreResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getOfficesDailyScore_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STDailyScore> arrItems = new ArrayList<STDailyScore>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STDailyScore item = STDailyScore.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getOfficesDailyScoreResult(retcode, retmsg, arrItems);
				} else {
					delegate.getOfficesDailyScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficesDailyScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficesDailyScoreResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getEmployeePersonalScore_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STPersonalScore_Boss> arrItems = new ArrayList<STPersonalScore_Boss>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STPersonalScore_Boss item = STPersonalScore_Boss.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getEmployeePersonalScoreResult(retcode, retmsg, arrItems);
				} else {
					delegate.getEmployeePersonalScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getEmployeePersonalScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getEmployeePersonalScoreResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


	public static AsyncHttpResponseHandler async_getEmployeePersonalScoreMgr_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STEmpScore_Manager> arrItems = new ArrayList<STEmpScore_Manager>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STEmpScore_Manager item = STEmpScore_Manager.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getEmployeePersonalScoreMgrResult(retcode, retmsg, arrItems);
				} else {
					delegate.getEmployeePersonalScoreMgrResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getEmployeePersonalScoreMgrResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getEmployeePersonalScoreMgrResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getAgentPersonalScore_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STPersonalScore_Boss> arrItems = new ArrayList<STPersonalScore_Boss>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STPersonalScore_Boss item = STPersonalScore_Boss.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getAgentPersonalScoreResult(retcode, retmsg, arrItems);
				} else {
					delegate.getAgentPersonalScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAgentPersonalScoreResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAgentPersonalScoreResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getOfficeDepositLogs_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STOfficeDepositLog> arrItems = new ArrayList<STOfficeDepositLog>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STOfficeDepositLog item = STOfficeDepositLog.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getOfficesDepositLogsResult(retcode, retmsg, arrItems);
				} else {
					delegate.getOfficesDepositLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getOfficesDepositLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getOfficesDepositLogsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};




	public static AsyncHttpResponseHandler async_getAgentPersonalScoreMgr_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STAgentScore_Mgr> arrItems = new ArrayList<STAgentScore_Mgr>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STAgentScore_Mgr item = STAgentScore_Mgr.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getAgentPersonalScoreMgrResult(retcode, retmsg, arrItems);
				} else {
					delegate.getAgentPersonalScoreMgrResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getAgentPersonalScoreMgrResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getAgentPersonalScoreMgrResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_getReserveLogs_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STReserveLog> arrItems = new ArrayList<STReserveLog>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STReserveLog item = STReserveLog.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.getReserveLogsResult(retcode, retmsg, arrItems);
				} else {
					delegate.getReserveLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.getReserveLogsResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.getReserveLogsResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};



	public static AsyncHttpResponseHandler async_cancelReserve_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					long cancelled_id = retdata.getLong("cancelled_id");

					delegate.cancelReserveResult(retcode, retmsg, cancelled_id);
				} else {
					delegate.cancelReserveResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, -1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.cancelReserveResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), -1);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.cancelReserveResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, -1);
			}
		}
	};



	public static AsyncHttpResponseHandler async_confirmReserve_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					JSONObject retdata = result.getJSONObject("retdata");
					long confirmed_id = retdata.getLong("confirmed_id");

					delegate.confirmReserveResult(retcode, retmsg, confirmed_id);
				} else {
					delegate.confirmReserveResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, -1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.confirmReserveResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), -1);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.confirmReserveResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, -1);
			}
		}
	};


	public static AsyncHttpResponseHandler async_checkParentBirthNotify_handler = new AsyncHttpResponseHandler() {
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);

			if (delegate == null)
				return;

			try {
				JSONObject result = new JSONObject(content);

				int retcode = result.getInt("retcode");
				String retmsg = result.getString("retmsg");

				if (retcode == CommErrMgr.ERRCODE_NONE) {
					ArrayList<STParentBirthNotify> arrItems = new ArrayList<STParentBirthNotify>();
					JSONArray retdata = result.getJSONArray("retdata");
					for (int i = 0; i < retdata.length(); i++) {
						JSONObject jsonObj = retdata.getJSONObject(i);
						STParentBirthNotify item = STParentBirthNotify.decodeFromJSON(jsonObj);
						arrItems.add(item);
					}

					delegate.checkParentBirthNotifyResult(retcode, retmsg, arrItems);
				} else {
					delegate.checkParentBirthNotifyResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
							CommErrMgr.ERRMSG_FAILURE, null);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				delegate.checkParentBirthNotifyResult(CommErrMgr.ERRCODE_CLIENT_EXCEPTION,
						ex.getMessage(), null);
			}
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);

			if (delegate != null) {
				delegate.checkParentBirthNotifyResult(CommErrMgr.ERRCODE_NETERROR,
						CommErrMgr.ERRMSG_NETERROR, null);
			}
		}
	};


}
