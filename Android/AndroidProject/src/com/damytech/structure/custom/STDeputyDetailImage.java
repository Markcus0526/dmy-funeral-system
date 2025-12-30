package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 10:22
 * File Name : STDeputyDetailImage
 */
public class STDeputyDetailImage {
	public String image_url = "";


	public static STDeputyDetailImage decodeFromJSON(JSONObject jsonObj) {
		STDeputyDetailImage img_info = new STDeputyDetailImage();
		try { img_info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		return img_info;
	}


	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		return result;
	}
}
