package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-24
 * Time : 01:38
 * File Name : STEmpScore_Manager
 */


public class STEmpScore_Manager {
	public long user_id = 0;
	public String user_name = "";
	public ArrayList<STScore_Manager> scores = new ArrayList<STScore_Manager>();

	public static STEmpScore_Manager decodeFromJSON(JSONObject jsonObj) {
		STEmpScore_Manager info = new STEmpScore_Manager();

		try { info.user_id = jsonObj.getLong("user_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_name = jsonObj.getString("user_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.scores.clear();

			JSONArray arrJSONScores = jsonObj.getJSONArray("scores");
			for (int i = 0; i < arrJSONScores.length(); i++) {
				JSONObject json_score = arrJSONScores.getJSONObject(i);
				STScore_Manager score_info = STScore_Manager.decodeFromJSON(json_score);
				info.scores.add(score_info);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("user_id", user_id); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_name", user_name); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONScores = new JSONArray();
			for (int i = 0; i < scores.size(); i++) {
				STScore_Manager score_info = scores.get(i);
				arrJSONScores.put(score_info.encodeToJSON());
			}

			result.put("scores", arrJSONScores);
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
}
