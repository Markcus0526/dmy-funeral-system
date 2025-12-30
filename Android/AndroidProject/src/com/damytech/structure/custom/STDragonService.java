package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 16:10
 * File Name : STDragonService
 */

public class STDragonService {
	public long uid = 0;
	public String image_url = "";
	public String name = "";
	public String intro = "";
	public double price = 0;
	public String price_desc = "";
	public int user_agree_rate = 0;
	public String product_intro = "";
	public String service_contents = "";

	public static STDragonService decodeFromJSON(JSONObject jsonObj) {
		STDragonService info = new STDragonService();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.intro = jsonObj.getString("intro"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price = jsonObj.getDouble("price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price_desc = jsonObj.getString("price_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.user_agree_rate = jsonObj.getInt("user_agree_rate"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.product_intro = jsonObj.getString("product_intro"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.service_contents = jsonObj.getString("service_contents"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("intro", intro); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price", price); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price_desc", price_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("user_agree_rate", user_agree_rate); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("product_intro", product_intro); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("service_contents", service_contents); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
