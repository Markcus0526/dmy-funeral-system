package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 19:01
 * File Name : STAgentScore_Mgr
 */

public class STAgentScore_Mgr {
	public long user_id = 0;
	public String user_name = "";
	public double score = 0;

	public static STAgentScore_Mgr decodeFromJSON(JSONObject jsonObj) {
		STAgentScore_Mgr info = new STAgentScore_Mgr();

		try { info.user_id = jsonObj.getLong("user_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_name = jsonObj.getString("user_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.score = jsonObj.getDouble("score"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("user_id", user_id); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_name", user_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("score", score); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
