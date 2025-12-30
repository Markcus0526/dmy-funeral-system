package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 09:59
 * File Name : STRelative
 */

public class STRelative {
	public long uid = 0;
	public String name = "";
	public String relative = "";
	public String area_no = "";
	public String birthday = "";
	public String deathday = "";

	public static STRelative decodeFromJSON(JSONObject jsonObj) {
		STRelative info = new STRelative();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.relative = jsonObj.getString("relative"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.area_no = jsonObj.getString("area_no"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.birthday = jsonObj.getString("birthday"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.deathday = jsonObj.getString("deathday"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("relative", relative); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("area_no", area_no); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("birthday", birthday); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("deathday", deathday); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
