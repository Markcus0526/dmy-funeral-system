package com.damytech.structure.baidu;

import org.json.JSONObject;

/**
 * Created by KimHM on 2015-01-31.
 */
public class STBaiduPlaceDetail {
	public String name = "";
	public double lat = 0;
	public double lng = 0;
	public String address = "";
	public String telephone = "";
	public String uid = "";
	public String tag = "";
	public String detail_url = "";
	public String type = "";
	public String overall_rating = "";
	public String service_rating = "";
	public String environment_rating = "";
	public String image_num = "";
	public String comment_num = "";


	public static STBaiduPlaceDetail decodeFromJSON(JSONObject jsonObj) {
		STBaiduPlaceDetail place_info = new STBaiduPlaceDetail();

		try { place_info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONObject location = jsonObj.getJSONObject("location");

			place_info.lat = location.getDouble("lat");
			place_info.lng = location.getDouble("lng");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		try { place_info.address = jsonObj.getString("address"); } catch (Exception ex) { ex.printStackTrace(); }
		try { place_info.telephone = jsonObj.getString("telephone"); } catch (Exception ex) { ex.printStackTrace(); }
		try { place_info.uid = jsonObj.getString("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONObject detail_info = jsonObj.getJSONObject("detail_info");

			try { place_info.tag = detail_info.getString("tag"); } catch (Exception ex) { ex.printStackTrace(); }
			try { place_info.detail_url = detail_info.getString("detail_url"); } catch (Exception ex) { ex.printStackTrace(); }
			try { place_info.type = detail_info.getString("type"); } catch (Exception ex) { ex.printStackTrace(); }
			try { place_info.overall_rating = detail_info.getString("overall_rating"); } catch (Exception ex) { ex.printStackTrace(); }
			try { place_info.service_rating = detail_info.getString("service_rating"); } catch (Exception ex) { ex.printStackTrace(); }
			try { place_info.environment_rating = detail_info.getString("environment_rating"); } catch (Exception ex) { ex.printStackTrace(); }
			try { place_info.image_num = detail_info.getString("image_num"); } catch (Exception ex) { ex.printStackTrace(); }
			try { place_info.comment_num = detail_info.getString("comment_num"); } catch (Exception ex) { ex.printStackTrace(); }
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return place_info;
	}
}
