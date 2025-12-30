package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 16:44
 * File Name : STAgent
 */

public class STAgent {
	public long uid = 0;
	public String name = "";
	public String phone = "";
	public double month_score = 0;
	public String month_score_desc = "";
	public double halfyear_score = 0;
	public String halfyear_score_desc = "";
	public double year_score = 0;
	public String year_score_desc = "";

	public static STAgent decodeFromJSON(JSONObject jsonObj) {
		STAgent info = new STAgent();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.phone = jsonObj.getString("phone"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.month_score = jsonObj.getDouble("month_score"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.month_score_desc = jsonObj.getString("month_score_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.halfyear_score = jsonObj.getDouble("halfyear_score"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.halfyear_score_desc = jsonObj.getString("halfyear_score_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.year_score = jsonObj.getDouble("year_score"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.year_score_desc = jsonObj.getString("year_score_desc"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("phone", phone); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("month_score", month_score); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("month_score_desc", month_score_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("halfyear_score", halfyear_score); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("halfyear_score_desc", halfyear_score_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("year_score", year_score); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("year_score_desc", year_score_desc); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
