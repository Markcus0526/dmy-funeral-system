package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/*
 * File Name: STUser.java
 * Creator: KimHM
 * Date: 2015-04-07
 * Time: 15:22:29
 */


public class STCustomer {
	public long uid = 0;
	public String name = "";
	public String phone = "";
	public ArrayList<STTomb> tombs = new ArrayList<STTomb>();

	public static STCustomer decodeFromJSON(JSONObject jsonObj) {
		STCustomer info = new STCustomer();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.phone = jsonObj.getString("phone"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.tombs.clear();

			JSONArray arrTombs = jsonObj.getJSONArray("tombs");
			for (int i = 0; i < arrTombs.length(); i++) {
				JSONObject jsonTomb = arrTombs.getJSONObject(i);
				STTomb tombinfo = STTomb.decodeFromJSON(jsonTomb);
				info.tombs.add(tombinfo);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("phone", phone); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONTombs = new JSONArray();
			for (int i = 0; i < tombs.size(); i++) {
				STTomb tomb_info = tombs.get(i);
				arrJSONTombs.put(tomb_info.encodeToJSON());
			}
			result.put("tombs", arrJSONTombs);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
}
