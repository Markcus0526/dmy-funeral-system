package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 15:04
 * File Name : STDailyScore
 */

public class STDailyScore {
	public String name = "";
	public String agent = "";
	public double price = 0;
	public double actual = 0;
	public double employee_score = 0;
	public double agent_score = 0;
	public double daily_total = 0;

	public static STDailyScore decodeFromJSON(JSONObject jsonObj) {
		STDailyScore info = new STDailyScore();

		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.agent = jsonObj.getString("agent"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price = jsonObj.getDouble("price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.actual = jsonObj.getDouble("actual"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.employee_score = jsonObj.getDouble("employee_score"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.agent_score = jsonObj.getDouble("agent_score"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.daily_total = jsonObj.getDouble("daily_total"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("agent", agent); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price", price); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("actual", actual); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("employee_score", employee_score); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("agent_score", agent_score); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("daily_total", daily_total); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
