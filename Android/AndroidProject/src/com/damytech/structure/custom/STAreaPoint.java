package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 12:04
 * File Name : STAreaPoint
 */

public class STAreaPoint {
	public long uid = 0;
	public String name = "";
	public String contents = "";
	public double x_rate = 0;
	public double y_rate = 0;
	public int type = 0;
	public ArrayList<STProduct> products = new ArrayList<STProduct>();
	public String image_url = "";

	public static STAreaPoint decodeFromJSON(JSONObject jsonObj) {
		STAreaPoint info = new STAreaPoint();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.contents = jsonObj.getString("contents"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.x_rate = jsonObj.getDouble("x_rate"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.y_rate = jsonObj.getDouble("y_rate"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.type = jsonObj.getInt("type"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.products.clear();

			String szTemp = jsonObj.getString("products");
			JSONArray arrProducts = new JSONArray(szTemp);
			for (int i = 0; i < arrProducts.length(); i++) {
				STProduct product = STProduct.decodeFromJSON(arrProducts.getJSONObject(i));
				info.products.add(product);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }

		return info;
	}

	public JSONObject encodeToJSON() {
		JSONObject result = new JSONObject();

		try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("name", name); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("contents", contents); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("x_rate", x_rate); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("y_rate", y_rate); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("type", type); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrProducts = new JSONArray();
			for (int i = 0; i < products.size(); i++) {
				JSONObject item = products.get(i).encodeToJSON();
				arrProducts.put(item);
			}

			result.put("products", arrProducts.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }

		return result;
	}
}
