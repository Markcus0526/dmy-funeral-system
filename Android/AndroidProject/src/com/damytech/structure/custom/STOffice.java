package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 22:03
 * File Name : STOffice
 */

public class STOffice {
	public long uid = 0;
	public String name = "";
	public String address = "";
	public String phone = "";
	public String image_url = "";
	public double lat = 0;
	public double lng = 0;
	public String chief = "";
	public String subchief = "";
	public ArrayList<STEmployee> employees = new ArrayList<STEmployee>();

	public static STOffice decodeFromJSON(JSONObject jsonObj) {
		STOffice info = new STOffice();

		try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.address = jsonObj.getString("address"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.phone = jsonObj.getString("phone"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.chief = jsonObj.getString("chief"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.subchief = jsonObj.getString("subchief"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.image_url = jsonObj.getString("image_url"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.lat = jsonObj.getDouble("lat"); } catch (Exception ex) { ex.printStackTrace(); }
		try { info.lng = jsonObj.getDouble("lng"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			info.employees.clear();

			JSONArray arr_json_emps = jsonObj.getJSONArray("employees");
			for (int i = 0; i < arr_json_emps.length(); i++) {
				STEmployee emp_info = STEmployee.decodeFromJSON(arr_json_emps.getJSONObject(i));
				info.employees.add(emp_info);
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
		try { result.put("address", address); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("phone", phone); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("chief", chief); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("subchief", subchief); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("image_url", image_url); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("lat", lat); } catch (Exception ex) { ex.printStackTrace(); }
		try { result.put("lng", lng); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arr_emps = new JSONArray();
			for (int i = 0; i < employees.size(); i++) {
				STEmployee emp_info = employees.get(i);
				arr_emps.put(emp_info.encodeToJSON());
			}

			result.put("employees", arr_emps.toString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
}
