package com.damytech.structure.baidu;

import org.json.JSONObject;

/**
 * Created by KimHM on 2015-01-31.
 */
public class STBaiduNearbyPlace {
	public String name = "";
	public double lat = 0;
	public double lng = 0;
	public String address = "";
	public String street_id = "";
	public String uid = "";

	public static STBaiduNearbyPlace decodeFromJSON(JSONObject jsonObj) {
		STBaiduNearbyPlace place = new STBaiduNearbyPlace();

		try { place.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONObject location = jsonObj.getJSONObject("location");

			place.lat = location.getDouble("lat");
			place.lng = location.getDouble("lng");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		try { place.address = jsonObj.getString("address"); } catch (Exception ex) { ex.printStackTrace(); }
		try { place.street_id = jsonObj.getString("street_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { place.uid = jsonObj.getString("uid"); } catch (Exception ex) { ex.printStackTrace(); }

		return place;
	}
}
