package com.damytech.structure.baidu;

import org.json.JSONObject;

/**
 * Created by KimHM on 2015-01-30.
 */
public class STBaiduWeather {
	public String city = "";			// City name
	public String day = "";				// Day string
	public String degree = "";			// Minimum and Maximum degrees
	public String detail = "";			// Weather description
	public String note = "";			// Lunar day description
	public String wind = "";			// Wind level
	public String xiche_detail = "";	// Car cleaning instruction
	public String xiche_level = "";		// Car cleaning level description. "1" is the best.
	public String xianxing = "";		// Unknown.

	public static STBaiduWeather decodeFromJSON(JSONObject jsonObj) {
		STBaiduWeather weather_info = new STBaiduWeather();

		try { weather_info.city = jsonObj.getString("city"); } catch (Exception ex) { ex.printStackTrace(); }
		try { weather_info.day = jsonObj.getString("day"); } catch (Exception ex) { ex.printStackTrace(); }
		try { weather_info.degree = jsonObj.getString("degree"); } catch (Exception ex) { ex.printStackTrace(); }
		try { weather_info.detail = jsonObj.getString("detail"); } catch (Exception ex) { ex.printStackTrace(); }
		try { weather_info.note = jsonObj.getString("note"); } catch (Exception ex) { ex.printStackTrace(); }
		try { weather_info.xiche_detail = jsonObj.getString("xiche_detail"); } catch (Exception ex) { ex.printStackTrace(); }
		try { weather_info.xiche_level = jsonObj.getString("xiche_level"); } catch (Exception ex) { ex.printStackTrace(); }
		try { weather_info.xianxing = jsonObj.getString("xianxing"); } catch (Exception ex) { ex.printStackTrace(); }

		return weather_info;
	}
}
