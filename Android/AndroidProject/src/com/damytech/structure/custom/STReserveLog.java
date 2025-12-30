package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-23
 * Time : 21:57
 * File Name : STReserveLog
 */

public class STReserveLog {
	public long uid = 0;
	public String customer_name = "";
	public String customer_phone = "";
	public String reserve_date = "";
	public int state = 0;
	public String state_desc = "";

	public static STReserveLog decodeFromJSON(JSONObject jsonObj) {
		STReserveLog info = new STReserveLog();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.customer_name = jsonObj.getString("customer_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.customer_phone = jsonObj.getString("customer_phone"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.reserve_date = jsonObj.getString("reserve_date"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state = jsonObj.getInt("state"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state_desc = jsonObj.getString("state_desc"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("customer_name", customer_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("customer_phone", customer_phone); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("reserve_date", reserve_date); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state", state); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state_desc", state_desc); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
