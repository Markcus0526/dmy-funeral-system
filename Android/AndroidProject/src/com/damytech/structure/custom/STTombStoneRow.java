package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 02:03
 * File Name : STTombStoneRow
 */
public class STTombStoneRow {
	public long uid = 0;
	public ArrayList<STTombStoneIndex> indexes = new ArrayList<STTombStoneIndex>();

	public static STTombStoneRow decodeFromJSON(JSONObject jsonObj) {
		STTombStoneRow row = new STTombStoneRow();

		try { row.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONIndexes = jsonObj.getJSONArray("indexes");
			for (int i = 0; i < arrJSONIndexes.length(); i++) {
				JSONObject json_index = arrJSONIndexes.getJSONObject(i);
				STTombStoneIndex tombIndex = STTombStoneIndex.decodeFromJSON(json_index);
				row.indexes.add(tombIndex);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return row;
	}


	public JSONObject encodeToJSON() {
		JSONObject jsonObj = new JSONObject();

		try { jsonObj.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONIndexes = new JSONArray();
			for (int i = 0; i < indexes.size(); i++) {
				JSONObject jsonIndex = indexes.get(i).encodeToJSON();
				arrJSONIndexes.put(jsonIndex);
			}

			jsonObj.put("indexes", arrJSONIndexes);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return jsonObj;
	}

}














