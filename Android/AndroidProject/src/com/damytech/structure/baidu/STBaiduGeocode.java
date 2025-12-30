package com.damytech.structure.baidu;

import org.json.JSONObject;

/**
 * Created by KimHM on 2015-01-31.
 */
public class STBaiduGeocode {
	public double lng = 0;
	public double lat = 0;
	public String formatted_address = "";
	public String business = "";
	public String city = "";
	public String direction = "";
	public String distance = "";
	public String district = "";
	public String province = "";
	public String street = "";
	public String street_number = "";
	public String citycode = "";

	public static STBaiduGeocode decodeFromJSON(JSONObject jsonObj) {
		STBaiduGeocode geocode = new STBaiduGeocode();

		try {
			JSONObject location = jsonObj.getJSONObject("location");
			geocode.lng = location.getDouble("lng");
			geocode.lat = location.getDouble("lat");
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		try { geocode.formatted_address = jsonObj.getString("formatted_address"); } catch (Exception ex) { ex.printStackTrace(); }
		try { geocode.business = jsonObj.getString("business"); } catch (Exception ex) { ex.printStackTrace(); }

		try {
			JSONObject addressComponent = jsonObj.getJSONObject("addressComponent");

			try { geocode.city = addressComponent.getString("city"); } catch (Exception ex) { ex.printStackTrace(); }
			try { geocode.direction = addressComponent.getString("direction"); } catch (Exception ex) { ex.printStackTrace(); }
			try { geocode.distance = addressComponent.getString("distance"); } catch (Exception ex) { ex.printStackTrace(); }
			try { geocode.district = addressComponent.getString("district"); } catch (Exception ex) { ex.printStackTrace(); }
			try { geocode.province = addressComponent.getString("province"); } catch (Exception ex) { ex.printStackTrace(); }
			try { geocode.street = addressComponent.getString("street"); } catch (Exception ex) { ex.printStackTrace(); }
			try { geocode.street_number = addressComponent.getString("street_number"); } catch (Exception ex) { ex.printStackTrace(); }

		} catch (Exception ex) {
			ex.printStackTrace();
		}

		try { geocode.citycode = jsonObj.getString("cityCode"); } catch (Exception ex) { ex.printStackTrace(); }

		return geocode;
	}
}
