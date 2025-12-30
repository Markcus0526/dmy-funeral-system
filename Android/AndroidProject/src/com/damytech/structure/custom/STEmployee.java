package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-14
 * Time : 23:05
 * File Name : STEmployee
 */

public class STEmployee {
	public long uid = 0;
	public String description = "";
	public String name = "";
	public String photo_url = "";
	public String phone = "";
	public String office = "";
	public String address = "";
	public String qq = "";
	public String wechat = "";


	public static STEmployee decodeFromJSON(JSONObject jsonObj) {
		STEmployee info = new STEmployee();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.description = jsonObj.getString("description"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.photo_url = jsonObj.getString("photo_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.phone = jsonObj.getString("phone"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.office = jsonObj.getString("office"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.address = jsonObj.getString("address"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.qq = jsonObj.getString("qq"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.wechat = jsonObj.getString("wechat"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}


	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("description", description); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("photo_url", photo_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("phone", phone); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("office", office); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("address", address); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("qq", qq); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("wechat", wechat); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
