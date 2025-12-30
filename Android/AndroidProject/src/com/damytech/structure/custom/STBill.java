package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;


/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-16
 * Time : 10:10
 * File Name : STBill
 */

public class STBill {
	public long uid = 0;
	public String name = "";
	public String type = "";
	public String buy_time = "";
	public String service_type = "";
	public double service_price = 0;
	public String service_price_desc = "";
	public String consume_time = "";
	public int state = 0;
	public String state_desc = "";
	public String remark = "";
	public double total_amount = 0;
	public String total_amount_desc = "";
	public ArrayList<STProduct> products = new ArrayList<STProduct>();


	public static STBill decodeFromJSON(JSONObject jsonObj) {
		STBill info = new STBill();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.type = jsonObj.getString("type"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.buy_time = jsonObj.getString("buy_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.service_type = jsonObj.getString("service_type"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.service_price = jsonObj.getDouble("service_price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.service_price_desc = jsonObj.getString("service_price_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.consume_time = jsonObj.getString("consume_time"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state = jsonObj.getInt("state"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state_desc = jsonObj.getString("state_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.remark = jsonObj.getString("remark"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.total_amount = jsonObj.getDouble("total_amount"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.total_amount_desc = jsonObj.getString("total_amount_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.products.clear();
			JSONArray arr_products = jsonObj.getJSONArray("products");
			for (int i = 0; i < arr_products.length(); i++) {
				JSONObject json_product = arr_products.getJSONObject(i);
				info.products.add(STProduct.decodeFromJSON(json_product));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("type", type); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("buy_time", buy_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("service_type", service_type); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("service_price", service_price); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("service_price_desc", service_price_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("consume_time", consume_time); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state", state); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state_desc", state_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("remark", remark); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("total_amount", total_amount); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("total_amount_desc", total_amount_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arr_products = new JSONArray();
			for (int i = 0; i < products.size(); i++) {
				STProduct emp_info = products.get(i);
				arr_products.put(emp_info.encodeToJSON());
			}

			result.put("products", arr_products.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
}
