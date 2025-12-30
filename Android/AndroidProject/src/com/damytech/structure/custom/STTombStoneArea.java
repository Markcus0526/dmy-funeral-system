package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 02:19
 * File Name : STTombStoneArea
 */

public class STTombStoneArea {
	public long uid = 0;
	public String name = "";
	public String image_url = "";
	public ArrayList<STTombStonePart> parts = new ArrayList<STTombStonePart>();


	public static STTombStoneArea decodeFromJSON(JSONObject jsonObj) {
		STTombStoneArea info = new STTombStoneArea();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray jsonParts = jsonObj.getJSONArray("parts");
			for (int i = 0; i < jsonParts.length(); i++) {
				JSONObject jsonPartInfo = jsonParts.getJSONObject(i);
				STTombStonePart part = STTombStonePart.decodeFromJSON(jsonPartInfo);
				info.parts.add(part);
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
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONParts = new JSONArray();
			for (int i = 0; i < parts.size(); i++) {
				JSONObject jsonPart = parts.get(i).encodeToJSON();
				arrJSONParts.put(jsonPart);
			}

			result.put("parts", arrJSONParts);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}

}
