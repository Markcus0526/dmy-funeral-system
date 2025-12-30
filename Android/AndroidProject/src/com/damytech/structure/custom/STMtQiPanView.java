package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-11
 * Time : 14:28
 * File Name : STMtQiPaView
 */

public class STMtQiPanView {
	public long uid = 0;
	public String title = "";
	public String image_url = "";
	public String address = "";
	public String phone = "";
	public String contents = "";
	public double lat = 0;
	public double lng = 0;

	public static STMtQiPanView decodeFromJSON(JSONObject jsonObj) {
		STMtQiPanView info = new STMtQiPanView();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.title = jsonObj.getString("title"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.address = jsonObj.getString("address"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.phone = jsonObj.getString("phone"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.contents = jsonObj.getString("contents"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.lat = jsonObj.getDouble("lat"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.lng = jsonObj.getDouble("lng"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("title", title); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("address", address); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("phone", phone); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("contents", contents); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("lat", lat); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("lng", lng); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
