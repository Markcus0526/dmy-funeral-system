package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-20
 * Time : 11:36
 * File Name : STTomb
 */

public class STTomb {
	public long uid = 0;
	public String image_url = "";
	public String tomb_no = "";
	public int area = 0;
	public int row = 0;
	public int col = 0;
	public String desc = "";
	public double price = 0;
	public String price_desc = "";
	public int state = 0;
	public String state_desc = "";

	public static STTomb decodeFromJSON(JSONObject jsonObj) {
		STTomb info = new STTomb();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.tomb_no = jsonObj.getString("tomb_no"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.area = jsonObj.getInt("area"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.row = jsonObj.getInt("row"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.col = jsonObj.getInt("col"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.desc = jsonObj.getString("desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price = jsonObj.getDouble("price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price_desc = jsonObj.getString("price_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state = jsonObj.getInt("state"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state_desc = jsonObj.getString("state_desc"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("tomb_no", tomb_no); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("row", row); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("col", col); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("desc", desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price", price); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price_desc", price_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state", state); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state_desc", state_desc); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
