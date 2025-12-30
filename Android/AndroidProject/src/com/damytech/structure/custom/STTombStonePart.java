package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 02:13
 * File Name : STTombStonePart
 */
public class STTombStonePart {
	public long uid = 0;
	public String name = "";
	public ArrayList<STTombStoneRow> rows = new ArrayList<STTombStoneRow>();


	public static STTombStonePart decodeFromJSON(JSONObject jsonObj) {
		STTombStonePart part = new STTombStonePart();

		try { part.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { part.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONRows = jsonObj.getJSONArray("rows");
			for (int i = 0; i < arrJSONRows.length(); i++) {
				JSONObject jsonRow = arrJSONRows.getJSONObject(i);
				STTombStoneRow row = STTombStoneRow.decodeFromJSON(jsonRow);
				part.rows.add(row);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return part;
	}


	public JSONObject encodeToJSON() {
		JSONObject jsonObj = new JSONObject();

		try { jsonObj.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { jsonObj.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONRows = new JSONArray();
			for (int i = 0; i < rows.size(); i++) {
				JSONObject jsonRow = rows.get(i).encodeToJSON();
				arrJSONRows.put(jsonRow);
			}

			jsonObj.put("rows", arrJSONRows);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return jsonObj;
	}

}































