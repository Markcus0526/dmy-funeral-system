package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-17
 * Time : 18:37
 * File Name : STOfficeCity
 */

public class STOfficeCity {
	public long uid = 0;
	public String name = "";
	public ArrayList<STOffice> offices = new ArrayList<STOffice>();

	public static STOfficeCity decodeFromJSON(JSONObject jsonObj) {
		STOfficeCity info = new STOfficeCity();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.offices.clear();

			JSONArray arrOffices = jsonObj.getJSONArray("offices");
			for (int i = 0; i < arrOffices.length(); i++) {
				JSONObject json_office = arrOffices.getJSONObject(i);
				STOffice office = STOffice.decodeFromJSON(json_office);
				info.offices.add(office);
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
		try {
			JSONArray arrOffices = new JSONArray();
			for (int i = 0; i < offices.size(); i++) {
				STOffice office = offices.get(i);
				arrOffices.put(office.encodeToJSON());
			}

			result.put("offices", arrOffices.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
}
