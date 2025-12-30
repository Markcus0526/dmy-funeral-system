package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 02:02
 * File Name : STTombStoneIndex
 */

public class STTombStoneIndex {
	public long uid = 0;
	public long tablet_id = 0;

	public static STTombStoneIndex decodeFromJSON(JSONObject jsonObj) {
		STTombStoneIndex index = new STTombStoneIndex();

		try { index.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { index.tablet_id = jsonObj.getLong("tablet_id"); } catch (Exception ex) { ex.printStackTrace(); }

		return index;
	}


	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("tablet_id", tablet_id); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}



















