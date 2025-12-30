package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-24
 * Time : 01:37
 * File Name : STScore_Manager
 */

public class STScore_Manager {
	public int month = 0;
	public double agent = 0;
	public double employee = 0;
	public double self_rate = 0;
	public double response_value = 0;
	public double monthly_total = 0;
	public double success_rate = 0;

	public static STScore_Manager decodeFromJSON(JSONObject jsonObj) {
		STScore_Manager info = new STScore_Manager();

		try { info.month = jsonObj.getInt("month"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.agent = jsonObj.getDouble("agent"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.employee = jsonObj.getDouble("employee"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.self_rate = jsonObj.getDouble("self_rate"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.response_value = jsonObj.getDouble("response_value"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.monthly_total = jsonObj.getDouble("monthly_total"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.success_rate = jsonObj.getDouble("success_rate"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("month", month); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("agent", agent); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("employee", employee); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("self_rate", self_rate); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("response_value", response_value); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("monthly_total", monthly_total); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("success_rate", success_rate); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
