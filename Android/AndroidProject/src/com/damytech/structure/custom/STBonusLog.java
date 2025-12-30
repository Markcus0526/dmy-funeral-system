package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-19
 * Time : 11:55
 * File Name : STBonusLog
 */

public class STBonusLog {
	public long uid = 0;
	public String user_name = "";
	public String tomb_no = "";
	public String buy_time = "";
	public double bonus = 0;
	public String bonus_desc = "";

	public static STBonusLog decodeFromJSON(JSONObject jsonObj) {
		STBonusLog info = new STBonusLog();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_name = jsonObj.getString("user_name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.tomb_no = jsonObj.getString("tomb_no"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.buy_time = jsonObj.getString("buy_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.bonus = jsonObj.getDouble("bonus"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.bonus_desc = jsonObj.getString("bonus_desc"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_name", user_name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("tomb_no", tomb_no); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("buy_time", buy_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("bonus", bonus); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("bonus_desc", bonus_desc); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
