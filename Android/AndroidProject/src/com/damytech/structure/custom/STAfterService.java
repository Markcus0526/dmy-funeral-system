package com.damytech.structure.custom;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-04-10
 * Time : 17:41
 * File Name : STAfterService
 */
public class STAfterService {
	public ArrayList<STBuryService> bury_services = new ArrayList<STBuryService>();
	public ArrayList<STDeputyService> deputy_services = new ArrayList<STDeputyService>();

	public static STAfterService decodeFromJSON(JSONObject jsonObj) {
		STAfterService service = new STAfterService();

		try {
			service.bury_services.clear();

			JSONArray arrBeryServices = jsonObj.getJSONArray("bury_services");
			for (int i = 0; i < arrBeryServices.length(); i++) {
				JSONObject jsonBeryService = arrBeryServices.getJSONObject(i);
				STBuryService beryService = STBuryService.decodeFromJSON(jsonBeryService);
				service.bury_services.add(beryService);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		try {
			service.deputy_services.clear();

			JSONArray arrDeputyServices = jsonObj.getJSONArray("deputy_services");
			for (int i = 0; i < arrDeputyServices.length(); i++) {
				JSONObject jsonDeputyService = arrDeputyServices.getJSONObject(i);
				STDeputyService deputyService = STDeputyService.decodeFromJSON(jsonDeputyService);
				service.deputy_services.add(deputyService);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return service;
	}
}
