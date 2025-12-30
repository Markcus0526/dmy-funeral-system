package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 16:39
 * File Name : STTombKnowledge
 */

public class STTombKnowledge {
	public String buy_tomb_flow = "";
	public String precaution = "";
	public String bury_custom = "";
	public String bury_news_url = "";

	public static STTombKnowledge decodeFromJSON(JSONObject jsonObj) {
		STTombKnowledge info = new STTombKnowledge();

		try { info.buy_tomb_flow = jsonObj.getString("buy_tomb_flow"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.precaution = jsonObj.getString("precaution"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.bury_custom = jsonObj.getString("bury_custom"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.bury_news_url = jsonObj.getString("bury_news_url"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("buy_tomb_flow", buy_tomb_flow); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("precaution", precaution); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("bury_custom", bury_custom); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("bury_news_url", bury_news_url); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
