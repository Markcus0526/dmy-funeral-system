package com.damytech.structure.custom;

import org.json.JSONObject;

/**
 * Created by DavidYin on 2015.05.22.
 */
public class STParentBirthNotify {
    public long uid = 0;
    public String tomb_no = "";
    public String desc = "";
    public String date = "";

    public static STParentBirthNotify decodeFromJSON(JSONObject jsonObj) {
        STParentBirthNotify info = new STParentBirthNotify();

        try { info.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
        try { info.tomb_no = jsonObj.getString("tomb_no"); } catch (Exception ex) { ex.printStackTrace(); }
        try { info.desc = jsonObj.getString("desc"); } catch (Exception ex) { ex.printStackTrace(); }
        try { info.date = jsonObj.getString("date"); } catch (Exception ex) { ex.printStackTrace(); }

        return info;
    }

    public JSONObject encodeToJSON() {
        JSONObject result = new JSONObject();

        try { result.put("uid", uid); } catch (Exception ex) { ex.printStackTrace(); }
        try { result.put("tomb_no", tomb_no); } catch (Exception ex) { ex.printStackTrace(); }
        try { result.put("desc", desc); } catch (Exception ex) { ex.printStackTrace(); }
        try { result.put("date", date); } catch (Exception ex) { ex.printStackTrace(); }

        return result;
    }
}
