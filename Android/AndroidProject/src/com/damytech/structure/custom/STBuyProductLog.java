package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-21
 * Time : 18:34
 * File Name : STBuyProductLog
 */

public class STBuyProductLog {
	public long uid = 0;
	public String customer = "";
	public String phone = "";
	public String agent = "";
	public String reserve_date = "";
	public String service_type = "";
	public int state = 0;
	public String state_desc = "";
	public int is_read = 0;
	public ArrayList<STProduct> products = new ArrayList<STProduct>();

	public static STBuyProductLog decodeFromJSON(JSONObject jsonObj) {
		STBuyProductLog info = new STBuyProductLog();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.customer = jsonObj.getString("customer"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.phone = jsonObj.getString("phone"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.agent = jsonObj.getString("agent"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.reserve_date = jsonObj.getString("reserve_date"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.service_type = jsonObj.getString("service_type"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state = jsonObj.getInt("state"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.state_desc = jsonObj.getString("state_desc"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.is_read = jsonObj.getInt("is_read"); } catch (Exception ex) { ex.printStackTrace(); }
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
		try { result.put("customer", customer); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("phone", phone); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("agent", agent); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("reserve_date", reserve_date); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("service_type", service_type); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state", state); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("state_desc", state_desc); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("is_read", is_read); } catch (Exception ex) { ex.printStackTrace(); }
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
