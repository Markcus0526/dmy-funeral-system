package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 10:01
 * File Name : STCustomerActivityNotification
 */

public class STActivity {
	public long uid = 0;
	public String activity_type = "";
	public String title = "";
	public String image_url = "";
	public String add_time = "";
	public String act_time = "";
	public String act_contents = "";
	public int is_oblation = 0;
	public int is_read = 0;

	public static STActivity decodeFromJSON(JSONObject jsonObj) {
		STActivity info = new STActivity();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.activity_type = jsonObj.getString("activity_type"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.title = jsonObj.getString("title"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.add_time = jsonObj.getString("add_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.act_time = jsonObj.getString("act_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.act_contents = jsonObj.getString("act_contents"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.is_oblation = jsonObj.getInt("is_oblation"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.is_read = jsonObj.getInt("is_read"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("activity_type", activity_type); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("title", title); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("add_time", add_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("act_time", act_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("act_contents", act_contents); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("is_oblation", is_oblation); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("is_read", is_read); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
