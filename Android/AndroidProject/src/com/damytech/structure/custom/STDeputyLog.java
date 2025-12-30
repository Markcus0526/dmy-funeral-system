package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 10:14
 * File Name : STDeputyLog
 */


public class STDeputyLog {
	public long uid = 0;
	public String time = "";
	public String image_url = "";
	public String service_people = "";
	public ArrayList<STDeputyDetailImage> detail_images = new ArrayList<STDeputyDetailImage>();


	public static STDeputyLog decodeFromJSON(JSONObject jsonObj) {
		STDeputyLog info = new STDeputyLog();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.time = jsonObj.getString("time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.service_people = jsonObj.getString("service_people"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.detail_images.clear();

			JSONArray arr_images = jsonObj.getJSONArray("detail_images");
			for (int i = 0; i < arr_images.length(); i++) {
				JSONObject json_img = arr_images.getJSONObject(i);
				info.detail_images.add(STDeputyDetailImage.decodeFromJSON(json_img));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return info;
	}


	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("time", time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("service_people", service_people); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrImages = new JSONArray();
			for (int i = 0; i < detail_images.size(); i++) {
				STDeputyDetailImage image = detail_images.get(i);
				arrImages.put(image.encodeToJSON());
			}

			result.put("detail_images", arrImages.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
}
