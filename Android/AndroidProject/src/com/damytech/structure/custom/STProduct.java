package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 10:03
 * File Name : STProduct
 */

public class STProduct {
	public long uid = 0;
	public int type = 0;
	public String type_desc = "";
	public String title = "";
	public String image_url = "";
	public int amount = 0;
	public String amount_desc = "";
	public String product_origin = "";
	public double price = 0;
	public String price_desc = "";
	public int max_amount = 0;
	public String max_amount_desc = "";

	public int is_acting = 0;
	public String act_start_time = "";
	public String act_end_time = "";

	public static STProduct decodeFromJSON(JSONObject jsonObj) {
		STProduct info = new STProduct();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.type = jsonObj.getInt("type"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.type_desc = jsonObj.getString("type_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.title = jsonObj.getString("title"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.product_origin = jsonObj.getString("product_origin"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.amount = jsonObj.getInt("amount"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.amount_desc = jsonObj.getString("amount_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price = jsonObj.getDouble("price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.price_desc = jsonObj.getString("price_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.max_amount = jsonObj.getInt("max_amount"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.max_amount_desc = jsonObj.getString("max_amount_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.is_acting = jsonObj.getInt("is_acting"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.act_start_time = jsonObj.getString("act_start_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.act_end_time = jsonObj.getString("act_end_time"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("type", type); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("type_desc", type_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("title", title); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("product_origin", product_origin); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("amount", amount); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("amount_desc", amount_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price", price); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("price_desc", price_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("max_amount", max_amount); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("max_amount_desc", max_amount_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("is_acting", is_acting); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("act_start_time", act_start_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("act_end_time", act_end_time); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
