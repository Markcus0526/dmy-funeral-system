package com.damytech.structure.custom;

import org.json.JSONObject;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 17:34
 * File Name : STBeryService
 */

public class STBuryService {
	public long uid = 0;
	public String title = "";
	public String splash_image_url = "";
	public String video_url = "";
	public String contents = "";
	public double price = 0;
	public String price_desc = "";

	public static STBuryService decodeFromJSON(JSONObject jsonObj) {
		STBuryService info = new STBuryService();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.title = jsonObj.getString("title"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.splash_image_url = jsonObj.getString("splash_image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.video_url = jsonObj.getString("video_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.contents = jsonObj.getString("contents"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price = jsonObj.getDouble("price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price_desc = jsonObj.getString("price_desc"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("title", title); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("splash_image_url", splash_image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("video_url", video_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("contents", contents); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price", price); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price_desc", price_desc); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
