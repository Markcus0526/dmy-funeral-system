package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 15:59
 * File Name : STPersonalScore_Boss
 */

public class STPersonalScore_Boss {
	public long office_id = 0;
	public String office_name = "";
	public long user_id = 0;
	public String user_name = "";
	public double score = 0;

	public static STPersonalScore_Boss decodeFromJSON(JSONObject jsonObj) {
		STPersonalScore_Boss info = new STPersonalScore_Boss();

		try { info.office_id = jsonObj.getLong("office_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.office_name = jsonObj.getString("office_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_id = jsonObj.getLong("user_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_name = jsonObj.getString("user_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.score = jsonObj.getDouble("score"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("office_id", office_id); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("office_name", office_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_id", user_id); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_name", user_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("score", score); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
