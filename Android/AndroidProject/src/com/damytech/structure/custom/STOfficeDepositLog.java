package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 17:48
 * File Name : STOfficeDeposit
 */

public class STOfficeDepositLog {
	public long uid = 0;
	public long office_id = 0;
	public String office_name = "";
	public double employee = 0;
	public double agent = 0;
	public double total = 0;

	public static STOfficeDepositLog decodeFromJSON(JSONObject jsonObj) {
		STOfficeDepositLog info = new STOfficeDepositLog();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.office_id = jsonObj.getLong("office_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.office_name = jsonObj.getString("office_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.employee = jsonObj.getDouble("employee"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.agent = jsonObj.getDouble("agent"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.total = jsonObj.getDouble("total"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("office_id", office_id); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("office_name", office_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("employee", employee); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("agent", agent); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("total", total); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
