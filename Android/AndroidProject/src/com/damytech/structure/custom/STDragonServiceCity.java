package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 16:13
 * File Name : STDragonServiceCity
 */
public class STDragonServiceCity {
	public long uid = 0;
	public String name = "";
	public ArrayList<STDragonServiceArea> areas = new ArrayList<STDragonServiceArea>();

	public static STDragonServiceCity decodeFromJSON(JSONObject jsonObj) {
		STDragonServiceCity info = new STDragonServiceCity();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.areas.clear();

			String szTemp = jsonObj.getString("areas");
			JSONArray arrAreas = new JSONArray(szTemp);
			for (int i = 0; i < arrAreas.length(); i++) {
				STDragonServiceArea product = STDragonServiceArea.decodeFromJSON(arrAreas.getJSONObject(i));
				info.areas.add(product);
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
			JSONArray arrAreas = new JSONArray();
			for (int i = 0; i < areas.size(); i++) {
				JSONObject item = areas.get(i).encodeToJSON();
				arrAreas.put(item);
			}

			result.put("areas", arrAreas.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}

}
