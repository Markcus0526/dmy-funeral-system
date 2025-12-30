package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 10:31
 * File Name : STAdvertImage
 */

public class STAdvertImage {
	public long uid = 0;
	public String image_url = "";

	public static STAdvertImage decodeFromJSON(JSONObject jsonObj) {
		STAdvertImage info = new STAdvertImage();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
