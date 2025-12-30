package com.damytech.structure.custom;

import org.json.JSONObject;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 17:40
 * File Name : STDeputyService
 */

public class STDeputyService {
	public long uid = 0;
	public String image_url = "";
	public String title = "";
	public String contents = "";

	public static STDeputyService decodeFromJSON(JSONObject jsonObj) {
		STDeputyService info = new STDeputyService();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.title = jsonObj.getString("title"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.contents = jsonObj.getString("contents"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("title", title); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("contents", contents); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
