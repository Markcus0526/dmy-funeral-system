package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 10:17
 * File Name : STMonthlyScore
 */

public class STMonthlyScore {
	public long office_id = 0;
	public String office_name = "";
	public String order = "";
	public double agent = 0;
	public double employee = 0;
	public double self_rate = 0;
	public double response_value = 0;
	public double total = 0;
	public double success_rate = 0;
	public double office_income = 0;

	public static STMonthlyScore decodeFromJSON(JSONObject jsonObj) {
		STMonthlyScore info = new STMonthlyScore();

		try { info.office_id = jsonObj.getLong("office_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.office_name = jsonObj.getString("office_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.order = jsonObj.getString("order"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.agent = jsonObj.getDouble("agent"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.employee = jsonObj.getDouble("employee"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.self_rate = jsonObj.getDouble("self_rate"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.response_value = jsonObj.getDouble("response_value"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.total = jsonObj.getDouble("total"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.success_rate = jsonObj.getDouble("success_rate"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.office_income = jsonObj.getDouble("office_income"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("office_id", office_id); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("office_name", office_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("order", order); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("agent", agent); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("employee", employee); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("self_rate", self_rate); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("response_value", response_value); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("total", total); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("success_rate", success_rate); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("office_income", office_income); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
