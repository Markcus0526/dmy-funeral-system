package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 16:11
 * File Name : STDragonServiceArea
 */

public class STDragonServiceArea {
	public long uid = 0;
	public String name = "";
	public ArrayList<STDragonService> services = new ArrayList<STDragonService>();

	public static STDragonServiceArea decodeFromJSON(JSONObject jsonObj) {
		STDragonServiceArea info = new STDragonServiceArea();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.services.clear();

			String szTemp = jsonObj.getString("services");
			JSONArray arrServices = new JSONArray(szTemp);
			for (int i = 0; i < arrServices.length(); i++) {
				STDragonService product = STDragonService.decodeFromJSON(arrServices.getJSONObject(i));
				info.services.add(product);
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
			JSONArray arrServices = new JSONArray();
			for (int i = 0; i < services.size(); i++) {
				JSONObject item = services.get(i).encodeToJSON();
				arrServices.put(item);
			}

			result.put("services", arrServices.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
}
