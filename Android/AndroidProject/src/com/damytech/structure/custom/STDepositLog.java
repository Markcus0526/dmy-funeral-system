package com.damytech.structure.custom;

import org.json.JSONObject;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-19
 * Time : 17:00
 * File Name : STDepositLog
 */

public class STDepositLog {
	public long uid = 0;
	public String start_time = "";
	public String end_time = "";
	public String name = "";
	public String tomb_no = "";
	public String receiver = "";
	public double price = 0;
	public String price_desc = "";

	public static STDepositLog decodeFromJSON(JSONObject jsonObj) {
		STDepositLog info = new STDepositLog();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.start_time = jsonObj.getString("start_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.end_time = jsonObj.getString("end_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.tomb_no = jsonObj.getString("tomb_no"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.receiver = jsonObj.getString("receiver"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price = jsonObj.getDouble("price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price_desc = jsonObj.getString("price_desc"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("start_time", start_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("end_time", end_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("tomb_no", tomb_no); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("receiver", receiver); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price", price); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price_desc", price_desc); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
