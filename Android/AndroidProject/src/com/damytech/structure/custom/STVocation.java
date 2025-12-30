package com.damytech.structure.custom;

import org.json.JSONObject;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 23:22
 * File Name : STVocation
 */

public class STVocation {
	public long uid = 0;
	public long user_id = 0;
	public String user_name = "";
	public String user_desc = "";
	public String date = "";
	public int reason = 0;
	public String reason_desc = "";
	public int state = 0;
	public String state_desc = "";

	public static STVocation decodeFromJSON(JSONObject jsonObj) {
		STVocation info = new STVocation();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_id = jsonObj.getLong("user_id"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_name = jsonObj.getString("user_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_desc = jsonObj.getString("user_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.date = jsonObj.getString("date"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.reason = jsonObj.getInt("reason"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.reason_desc = jsonObj.getString("reason_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state = jsonObj.getInt("state"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state_desc = jsonObj.getString("state_desc"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_id", user_id); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_name", user_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_desc", user_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("date", date); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("reason", reason); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("reason_desc", reason_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state", state); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state_desc", state_desc); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
