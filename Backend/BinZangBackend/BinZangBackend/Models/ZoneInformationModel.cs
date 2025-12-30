using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using JpushApiClient;
namespace BinZangBackend.Models
{
    public class Activity
    {
        public string activityname { get; set; }
        public long id { get; set; }
        public string activityurl { get; set; }
       // public string activitycontent { get; set; }
        
    }
    public class Notice
    {
        public string noticename { get; set; }
        public long id { get; set; }
        public string imgurl { get; set; }
        public byte noticetype { get; set; }
        // public string activitycontent { get; set; }

    }
    public class Office
    {
        public string officename { get; set; }
        public long id { get; set; }
        public string imgurl { get; set; }
        public string chengshi { get; set; }
        public string address { get; set; }
        public string phone { get; set; }
        // public string activitycontent { get; set; }

    }
    public class ADragon
    {
        public string cname { get; set; }
        public long id { get; set; }
        public string imgurl { get; set; }
        public Decimal approve { get; set; }
        public string address { get; set; }
        public string price { get; set; }
        // public string activitycontent { get; set; }

    }
    public class Sacrifice
    {
        public string pname { get; set; }
        public long id { get; set; }
        public string imgurl { get; set; }
        public byte ptype { get; set; }
       // public string address { get; set; }
        public string price { get; set; }
        // public string activitycontent { get; set; }

    }
    public class Cemetery
    {
        public string cnum { get; set; }
        public long id { get; set; }
        public string imgurl { get; set; }
        public string zonename { get; set; }
        public string status { get; set; }
        // public string address { get; set; }
        public string price { get; set; }
        // public string activitycontent { get; set; }

    }
    public class Vren
    {
        public string cnum { get; set; }
        public long id { get; set; }
        public string zonename { get; set; }
        public string status { get; set; }
        // public string address { get; set; }
        public string price { get; set; }
        // public string activitycontent { get; set; }

    }
    public class Zone
    {
        public string zonename { get; set; }
        public long id { get; set; }
        public string img_url { get; set; }
        public string zonetype { get; set; }

    }
    public class ZoneInformation
    {
        BinZangDataContext db = new BinZangDataContext();
        public bool UpdateProfile(String introduce,string img,string phone)
        {
            bool success = false;
            try
            {
                information inform = db.informations.Where(m => m.name == "gongsijianjie" && m.deleted == 0).FirstOrDefault();
                if (inform == null)
                {
                    information inform1 = new information();
                    inform1.deleted = 0;
                    inform1.name = "gongsijianjie";
                    inform1.note = "公司简介";
                    inform1.html_content = introduce;
                    db.informations.InsertOnSubmit(inform1);
                    db.SubmitChanges();
                    success = true;
                }
                if (inform != null)
                {

                    inform.deleted = 0;
                    inform.name = "gongsijianjie";
                    inform.note = "公司简介";
                    inform.html_content = introduce;
                    db.SubmitChanges();
                    success = true;
                }
                link_url lu = db.link_urls.Where(m => m.name == "gongsijianjie" && m.deleted == 0).FirstOrDefault();
                if (lu == null)
                {
                    link_url lu1 = new link_url();
                    lu1.deleted = 0;
                    lu1.name = "gongsijianjie";
                    lu1.note = "公司简介";
                    lu1.url = img;
                    db.link_urls.InsertOnSubmit(lu1);
                    db.SubmitChanges();
                    success = true;
                }
                if (lu != null)
                {

                    lu.deleted = 0;
                    lu.name = "gongsijianjie";
                    lu.note = "公司简介";
                    lu.url= img;
                    db.SubmitChanges();
                    success = true;
                }
                environ env = db.environs.Where(m => m.name == "fuwurexian" && m.deleted == 0).FirstOrDefault();
                if (env == null)
                {
                    environ env1 = new environ();
                    env1.deleted = 0;
                    env1.name = "fuwurexian";
                    env1.note = "服务热线";
                    env1.txt_value = phone;
                    db.environs.InsertOnSubmit(env1);
                    db.SubmitChanges();
                    success = true;
                }
                if (env != null)
                {

                    env.deleted = 0;
                    env.name = "fuwurexian";
                    env.note = "服务热线";
                    env.txt_value = phone;
                    db.SubmitChanges();
                    success = true;
                }
            }
            catch (System.Exception ex)
            {
                success = false;
            }
            
            return success;
        }
        public bool UpdateFlow(String introduce)
        {
            bool success = false;
            information inform = db.informations.Where(m => m.name == "goumuliucheng"&&m.deleted==0).FirstOrDefault();
            if (inform == null)
            {
                information inform1 = new information();
                inform1.deleted = 0;
                inform1.name = "goumuliucheng";
                inform1.note = "购墓流程";
                inform1.html_content = introduce;
                db.informations.InsertOnSubmit(inform1);
                db.SubmitChanges();
                success = true;
            }
            if (inform != null)
            {

                inform.deleted = 0;
                inform.name = "goumuliucheng";
                inform.note = "购墓流程";
                inform.html_content = introduce;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public bool UpdateDaiJiBai(String introduce)
        {
            bool success = false;
            information inform = db.informations.Where(m => m.name == "daijibai" && m.deleted == 0).FirstOrDefault();
            if (inform == null)
            {
                information inform1 = new information();
                inform1.deleted = 0;
                inform1.name = "daijibai";
                inform1.note = "代祭拜";
                inform1.html_content = introduce;
                db.informations.InsertOnSubmit(inform1);
                db.SubmitChanges();
                success = true;
            }
            if (inform != null)
            {

                inform.deleted = 0;
                inform.name = "daijibai";
                inform.note = "代祭拜";
                inform.html_content = introduce;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public bool UpdateJiPinDaiGou(String introduce)
        {
            bool success = false;
            information inform = db.informations.Where(m => m.name == "jipindaigou" && m.deleted == 0).FirstOrDefault();
            if (inform == null)
            {
                information inform1 = new information();
                inform1.deleted = 0;
                inform1.name = "jipindaigou";
                inform1.note = "祭品代购";
                inform1.html_content = introduce;
                db.informations.InsertOnSubmit(inform1);
                db.SubmitChanges();
                success = true;
            }
            if (inform != null)
            {

                inform.deleted = 0;
                inform.name = "jipindaigou";
                inform.note = "祭品代购";
                inform.html_content = introduce;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public information Getonexisu(long uid)
        {
            information ifm = db.informations.Where(m => m.uid == uid).FirstOrDefault();
            return ifm;
        }
       
        public tomb_service Getoneluozang(long uid)
        {
            tomb_service list = db.tomb_services.Where(m => m.uid == uid).FirstOrDefault();
            return list;
        }
        public bool UpdateMatters(String introduce)
        {
            bool success = false;
            information inform = db.informations.Where(m => m.name == "goumuzhuyishixiang"&&m.deleted==0).FirstOrDefault();
            if (inform == null)
            {
                information inform1 = new information();
                inform1.deleted = 0;
                inform1.name = "goumuzhuyishixiang";
                inform1.note = "注意事项";
                inform1.html_content = introduce;
                db.informations.InsertOnSubmit(inform1);
                db.SubmitChanges();
                success = true;
            }
            if (inform != null)
            {

                inform.deleted = 0;
                inform.name = "goumuzhuyishixiang";
                inform.note = "注意事项";
                inform.html_content = introduce;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public List<information> GetAllXisu()
        {
            List<information> list = new List<information>();
            list = db.informations.Where(m => m.name == "luozangxisu"&&m.deleted==0).ToList();
            return list;
        }
        public List<tomb_service> GetAllLuo()
        {
            List<tomb_service> list = new List<tomb_service>();
            list = db.tomb_services.Where(m => m.deleted == 0&&m.type==0).ToList();
            return list;
        }
        public bool UpdateXisu(long id,string xisuname,String introduce)
        {
            bool success = false;
            if (id == 0)
            {
                information inform1 = new information();
                inform1.deleted = 0;
                inform1.name = "luozangxisu";
                inform1.note = xisuname;
                inform1.html_content = introduce;
                db.informations.InsertOnSubmit(inform1);
                db.SubmitChanges();
                success = true;
            }
            if (id != 0)
            {
                information inform = db.informations.Where(m => m.uid == id&&m.deleted==0).FirstOrDefault();
                inform.deleted = 0;
                inform.name = "luozangxisu";
                inform.note = xisuname;
                inform.html_content = introduce;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public string GetContents(string matters)
        {
            information inform = db.informations.Where(m => m.name == matters&&m.deleted==0).FirstOrDefault();
            string ma = "";
            if (inform != null)
            {
                ma=inform.html_content;
            }
            return ma;
        }
        public string Getcompany(string matters)
        {
            link_url inform = db.link_urls.Where(m => m.name == matters && m.deleted == 0).FirstOrDefault();
            string ma = null;
            if (inform != null)
            {
                ma = inform.url;
            }
            return ma;
        }
        public string GetEnviron(string matters)
        {
            environ inform = db.environs.Where(m => m.name == matters && m.deleted == 0).FirstOrDefault();
            string ma = "";
            if (inform != null)
            {
                ma = inform.txt_value;
            }
            return ma;
        }
        //新闻链接
        public bool LuozangLink(String link)
        {
            bool success = false;
            link_url lul = db.link_urls.Where(m => m.name == "luozangshishi"&&m.deleted==0).FirstOrDefault();
            if (lul == null)
            {
                link_url lu = new link_url();
                lu.deleted = 0;
                lu.name = "luozangshishi";
                lu.note = "落葬实事";
                lu.url = link;
                db.link_urls.InsertOnSubmit(lu);
                db.SubmitChanges();
                success = true;
            }
            if (lul != null)
            {

                lul.deleted = 0;
                lul.name = "luozangshishi";
                lul.note = "落葬实事";
                lul.url = link;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        //活动添加
        public bool InsertActivity(string activityname, string imageurl, string introduce)
        {
            bool success = false;
            scenery scen = new scenery();
            scen.createtime = DateTime.Now;
            scen.deleted = 0;
          //  scen.description = "";

            scen.html_content = introduce;
            scen.imgurl = imageurl;
            scen.name = activityname;
            db.sceneries.InsertOnSubmit(scen);
            db.SubmitChanges();
            success = true;
            return success;
        }
        public bool UpdateActivity(long uid,string activityname, string imageurl, string introduce)
        {
            bool success = false;
            scenery scen = db.sceneries.Where(m => m.uid == uid).FirstOrDefault() ;
            scen.html_content = introduce;
            scen.imgurl = imageurl;
            scen.name = activityname;
            db.SubmitChanges();
            success = true;
            return success;
        }
        //活动查询
        public JqDataTableInfo SerchActivity(string activityname, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<Activity> list = new List<Activity>();
            list = db.sceneries.Where(m => m.deleted == 0 && m.name.Contains(activityname))
                       .Select(al1 => new Activity
                       {
                          activityurl=al1.imgurl,
                          activityname=al1.name,
                          id = al1.uid
                          //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m=>m.id).ToList();
            res.aaData = list;
            res.sEcho =sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public JqDataTableInfo SerchNotice(string notename, string notetype, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<Notice> list = new List<Notice>();
            if (Convert.ToInt32(notetype) == 4)
            {
                list = db.tomb_activities.Where(m => m.deleted == 0 && m.title.Contains(notename))
                         .Select(al1 => new Notice
                         {
                             imgurl = al1.img_url,
                             noticename = al1.title,
                             noticetype=al1.category,
                             id = al1.uid
                             //activitycontent=al1.html_content

                         }
                         ).OrderByDescending(m => m.id).ToList();
            }
            if (Convert.ToInt32(notetype) != 4)
            {
                list = db.tomb_activities.Where(m => m.deleted == 0 && m.category == Convert.ToByte(notetype) && m.title.Contains(notename))
                         .Select(al1 => new Notice
                         {
                             imgurl = al1.img_url,
                             noticename = al1.title,
                             noticetype = al1.category,
                             id = al1.uid
                             //activitycontent=al1.html_content

                         }
                         ).OrderByDescending(m => m.id).ToList();
            }
            res.aaData = list;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        //删除活动
        public bool DelActivity(long uid)
        {
            bool success = false;
            scenery scen = db.sceneries.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            if (scen != null)
            {
                scen.deleted = 1;
                
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public bool DelOffice(long uid)
        {
            bool success = false;
            office scen = db.offices.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            if (scen != null)
            {
                scen.deleted = 1;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public bool DelNotice(long uid)
        {
            bool success = false;
            tomb_activity scen = db.tomb_activities.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            if (scen != null)
            {
                scen.deleted = 1;
               
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public scenery SeeScenery(long uid)
        {
            scenery scen = db.sceneries.Where(m => m.uid == uid&&m.deleted==0).FirstOrDefault();
            return scen;
        }
        public tomb_activity SeeNotice(long uid)
        {
            tomb_activity scen = db.tomb_activities.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            return scen;
        }
        public bool InsertNote(string notename, string imgurl, string activitytype, string starttime, string endtime, string introduce)
        {
            List<client> clist = db.clients.Where(a => a.deleted == 0).ToList();
            List<user> ulist = db.users.Where(a => a.deleted == 0).ToList();
            List<user> newulist = ulist.Where(a => a.deleted == 0 && a.type != 7).ToList();
            bool success = false;
            if (Convert.ToInt32(activitytype) != 3)
            {
                tomb_activity ta = new tomb_activity();
                ta.category = Convert.ToByte(activitytype);
                ta.contents = introduce;
                ta.deleted = 0;
                ta.title = notename;
                ta.img_url = imgurl;
                ta.createtime = DateTime.Now;
                db.tomb_activities.InsertOnSubmit(ta);
                db.SubmitChanges();
            
                if (activitytype=="0")
                {
                    for (int j = 0; j < clist.Count;j++ )
                    {
                        JPushApi.SendPushNotification(Convert.ToString(clist[j].uid+100000), "Activity\n有新的活动通知！");
                    }
                    for (int i = 0; i < ulist.Count;i++ )
                    {
                        JPushApi.SendPushNotification(Convert.ToString(ulist[i].uid), "Activity\n有新的活动通知！");
                    }
                    //所有人
                }
                if (activitytype=="2")
                {
                    for (int k = 0; k < newulist.Count;k++ )
                    {
                        JPushApi.SendPushNotification(Convert.ToString(newulist[k].uid), "Activity\n有新的活动通知！");

                    }
                    //员工领导
                }
                if (activitytype=="1")
                {
                    //员工领导
                    for (int k = 0; k < newulist.Count; k++)
                    {
                        JPushApi.SendPushNotification(Convert.ToString(newulist[k].uid), "Activity\n有新的活动通知！");

                    }
                }
                success = true;
            }
            if (Convert.ToInt32(activitytype) == 3)
            {
                tomb_activity ta = new tomb_activity();
                ta.category = Convert.ToByte(activitytype);
                ta.contents = introduce;
                ta.deleted = 0;
                ta.title = notename;
                ta.img_url = imgurl;
                ta.starttime = Convert.ToDateTime(starttime);
                ta.endtime = Convert.ToDateTime(endtime);
                ta.createtime = DateTime.Now;
                db.tomb_activities.InsertOnSubmit(ta);
                db.SubmitChanges();
                //所有人
                for (int j = 0; j < clist.Count; j++)
                {
                    JPushApi.SendPushNotification(Convert.ToString(clist[j].uid + 100000), "Activity\n有新的活动通知！");
                }
                for (int i = 0; i < ulist.Count; i++)
                {
                    JPushApi.SendPushNotification(Convert.ToString(ulist[i].uid), "Activity\n有新的活动通知！");
                }
                success = true;
            }
           
            return success;
        }
        public bool UpdateNote(long uid,string notename, string imgurl, string activitytype, string starttime, string endtime, string introduce)
        {
            bool success = false;
            if (Convert.ToInt32(activitytype) != 3)
            {
                tomb_activity ta = db.tomb_activities.Where(m=>m.deleted==0&&m.uid==uid).FirstOrDefault();
                ta.category = Convert.ToByte(activitytype);
                ta.contents = introduce;
                ta.title = notename;
                ta.img_url = imgurl;
                db.SubmitChanges();
                success = true;
            }
            if (Convert.ToInt32(activitytype) == 3)
            {
                tomb_activity ta = db.tomb_activities.Where(m => m.deleted == 0 && m.uid == uid).FirstOrDefault();
                ta.category = Convert.ToByte(activitytype);
                ta.contents = introduce;
                ta.title = notename;
                ta.img_url = imgurl;
                ta.starttime = Convert.ToDateTime(starttime);
                ta.endtime = Convert.ToDateTime(endtime);
                db.SubmitChanges();
                success = true;
            }

            return success;
        }
        public bool GetSamePoint(String dongjing, string beiwei)
        {
            bool success = false;
            try
            {
                List<office> p = db.offices.Where(m => m.deleted == 0 && m.longitude == Convert.ToDecimal(dongjing) && m.latitude == Convert.ToDecimal(beiwei)).ToList();
                if (p.Count == 0)
                {
                    success = true;
                }
            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public bool GetADrgonSamePoint(String dongjing, string beiwei)
        {
            bool success = false;
            try
            {
                List<yitiaolong> p = db.yitiaolongs.Where(m => m.deleted == 0 && m.longitude == Convert.ToDecimal(dongjing) && m.latitude == Convert.ToDecimal(beiwei)).ToList();
                if (p.Count == 0)
                {
                    success = true;
                }
            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public bool InserOffice(string officename, string img, string officehead, string subchief, string phone, string area, string suggestid, string lng, string lat)
        {
            bool success = false;
            try
            {
                office of = new office();
                of.address = suggestid;
                of.chengshi_id = Convert.ToInt64(area);
                of.deleted = 0;
                of.imgurl = img;
                of.latitude = Convert.ToDecimal(lat);
                of.longitude = Convert.ToDecimal(lng);
                of.name = officename;
                of.phone = phone;
                of.plan_amounts = "";
                of.subchief = subchief;
                of.chief = officehead;
                db.offices.InsertOnSubmit(of);
                db.SubmitChanges();
                success = true;
            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public bool UpdateOffice(long uid,string officename, string img, string officehead, string subchief, string phone, string area, string suggestid, string lng, string lat)
        {
            bool success = false;
            try
            {
                office of = db.offices.Where(m=>m.uid==uid).FirstOrDefault();
                of.address = suggestid;
                of.chengshi_id = Convert.ToInt64(area);
                of.imgurl = img;
                of.latitude = Convert.ToDecimal(lat);
                of.longitude = Convert.ToDecimal(lng);
                of.name = officename;
                of.phone = phone;
                of.subchief = subchief;
                of.chief = officehead;
                db.SubmitChanges();
                success = true;
            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public List<chengshi> GetAllChengshi()
        {
            List<chengshi> cs = db.chengshis.Where(m => m.deleted == 0).ToList();
            return cs;
        }
        public JqDataTableInfo SerchOffice(string officename, long area, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<Office> list = new List<Office>();
            if (area == 0)
            {
                list = db.offices.Where(m => m.deleted == 0 && m.name.Contains(officename))
                       .Join(db.chengshis, m1 => m1.chengshi_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                       .Select(al1 => new Office
                       {
                            officename =al1.m2.name,
                            id =al1.m2.uid,
                            imgurl =al1.m2.imgurl,
                            chengshi = al1.empt.name,
                            address =al1.m2.address,
                            phone = al1.m2.phone
                           //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            if (area != 0)
            {
                list = db.offices.Where(m => m.deleted == 0&&m.chengshi_id==area && m.name.Contains(officename))
                       .Join(db.chengshis, m1 => m1.chengshi_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                       .Select(al1 => new Office
                       {
                           officename = al1.m2.name,
                           id = al1.m2.uid,
                           imgurl = al1.m2.imgurl,
                           chengshi = al1.empt.name,
                           address = al1.m2.address,
                           phone = al1.m2.phone
                           //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            res.aaData = list;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public office GetOneOffice(int makeid, long uid)
        {
            office of = db.offices.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            return of;
        }
        public sacrifice GetOnesacrifice(int makeid, long uid)
        {
            sacrifice of = db.sacrifices.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            return of;
        }
        public quyu Getquyu(long uid)
        {
            quyu of = db.quyus.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            return of;
        }
        public yitiaolong GetOneADragon(int makeid, long uid)
        {
            yitiaolong of = db.yitiaolongs.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            return of;
        }
        public List<quyu> Getarea(long uid)
        {
            List<quyu> list = db.quyus.Where(m => m.chengshi_id == uid && m.deleted == 0).ToList();
            return list;
        }
        public bool InserADragon(string canme, string img, string price,string approve, string phone, string area, string suggestId, string lng, string lat, string contents, string cdetail, string productdetail)
        {
            bool success = false;
            try
            {
                yitiaolong of = new yitiaolong();
                of.createtime = DateTime.Now;
                of.quyu_id = Convert.ToInt64(area);
                of.deleted = 0;
                of.img_url = img;
                of.latitude = Convert.ToDecimal(lat);
                of.longitude = Convert.ToDecimal(lng);
                of.name = canme;
                of.phone = phone;
                of.address = suggestId;
                of.price = Convert.ToInt32(price);
                of.service_content = contents;
                of.description = cdetail;
                of.product_description = productdetail;
                of.recognition_degree = Convert.ToDecimal(approve);
                db.yitiaolongs.InsertOnSubmit(of);
                db.SubmitChanges();
                success = true;
            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public JqDataTableInfo SerchADagon(string cname, long chengshi, long area, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<ADragon> list = new List<ADragon>();
            if (chengshi == 0)
            {
                list = db.yitiaolongs.Where(m => m.deleted == 0 && m.name.Contains(cname))
                       .Join(db.quyus, m1 => m1.quyu_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                       .Select(al1 => new ADragon
                       {
                           cname = al1.m2.name,
                           id = al1.m2.uid,
                           imgurl = al1.m2.img_url,
                           approve = Convert.ToDecimal(al1.m2.recognition_degree),
                           address = al1.m2.address,
                           price = al1.m2.price.ToString()
                           //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m=> m.approve).ToList();
            }
            if (chengshi != 0 && area==0)
            {
                list = db.yitiaolongs.Where(m => m.deleted == 0 && m.name.Contains(cname))
                         .Join(db.quyus, m1 => m1.quyu_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                         .Where(m=>m.empt.chengshi_id==chengshi)
                         .Select(al1 => new ADragon
                         {
                             cname = al1.m2.name,
                             id = al1.m2.uid,
                             imgurl = al1.m2.img_url,
                             approve = Convert.ToDecimal(al1.m2.recognition_degree),
                             address = al1.m2.address,
                             price = al1.m2.price.ToString()
                             //activitycontent=al1.html_content

                         }
                         ).OrderByDescending(m => m.approve).ToList();
            }
            if (chengshi != 0 && area != 0)
            {
                list = db.yitiaolongs.Where(m => m.deleted == 0 && m.name.Contains(cname))
                         .Join(db.quyus, m1 => m1.quyu_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                         .Where(m => m.empt.uid == area)
                         .Select(al1 => new ADragon
                         {
                             cname = al1.m2.name,
                             id = al1.m2.uid,
                             imgurl = al1.m2.img_url,
                             approve = Convert.ToDecimal(al1.m2.recognition_degree),
                             address = al1.m2.address,
                             price = al1.m2.price.ToString()
                             //activitycontent=al1.html_content

                         }
                         ).OrderByDescending(m => m.approve).ToList();
            }
            res.aaData = list;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public bool DelADragon(long uid)
        {
            bool success = false;
            yitiaolong scen = db.yitiaolongs.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            if (scen != null)
            {
                scen.deleted = 1;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public bool UpdateADragon(long uid,string canme, string img, string price, string approve, string phone, string area, string suggestId, string lng, string lat, string contents, string cdetail, string productdetail)
        {
            bool success = false;
            try
            {
                yitiaolong of = db.yitiaolongs.Where(m=>m.uid==uid&&m.deleted==0).FirstOrDefault();
                of.quyu_id = Convert.ToInt64(area);
                of.img_url = img;
                of.latitude = Convert.ToDecimal(lat);
                of.longitude = Convert.ToDecimal(lng);
                of.name = canme;
                of.phone = phone;
                of.address = suggestId;
                of.price = Convert.ToInt32(price);
                of.service_content = contents;
                of.description = cdetail;
                of.product_description = productdetail;
                of.recognition_degree = Convert.ToDecimal(approve);
                db.SubmitChanges();
                success = true;
            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public bool Operateluozang(string sname, string uid, int price, string img, string img2, string servicedetail)
        {
            bool success = false;
            try
            {
                if (uid == "" || uid == null)
                {
                    tomb_service ts=new tomb_service();
                    ts.deleted=0;
                    ts.description=servicedetail;
                    ts.imgurl=img2;
                    ts.name=sname;
                    ts.price=price;
                    ts.type=0;
                    ts.videourl=img;
                    db.tomb_services.InsertOnSubmit(ts);
                    db.SubmitChanges();
                    success=true;
                }
                if (uid != "" && uid != null)
                {
                    tomb_service ts =db.tomb_services.Where(m=>m.uid==Convert.ToInt64(uid)&&m.deleted==0).FirstOrDefault();

                    ts.description=servicedetail;
                    ts.imgurl=img2;
                    ts.name=sname;
                    ts.price=price;
                    ts.videourl=img;
                    db.SubmitChanges();
                    success=true;
                }
            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public List<tomb_activity> GetAllfahui()
        {
            List<tomb_activity> ta = db.tomb_activities.Where(m =>m.category==3&& m.deleted == 0).ToList();
            return ta;
        }
        public bool InserSacrifice(string pname, string img, string price, string ptype, long fahuiactivity, string pdetail)
        {
            bool success = false;
            try
            {
                sacrifice sa = new sacrifice();
                sa.createtime = DateTime.Now;
                sa.deleted = 0;
                sa.description = pdetail;
                sa.imgurl = img;
                sa.name = pname;
                sa.price = Convert.ToInt32(price);
                if (Convert.ToInt32(ptype) == 4)
                {
                    sa.tombactivity_id = fahuiactivity;
                }
                sa.type = Convert.ToByte(ptype);
                db.sacrifices.InsertOnSubmit(sa);
                db.SubmitChanges();
                success = true;

            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public bool UpdateSacrifice(long uid,string pname, string img, string price, string ptype, long fahuiactivity, string pdetail)
        {
            bool success = false;
            try
            {
                sacrifice sa =db.sacrifices.Where(m=>m.uid==uid).FirstOrDefault();
                sa.description = pdetail;
                sa.imgurl = img;
                sa.name = pname;
                sa.price = Convert.ToInt32(price);
                if (Convert.ToInt32(ptype) == 4)
                {
                    sa.tombactivity_id = fahuiactivity;
                }
                sa.type = Convert.ToByte(ptype);
                db.SubmitChanges();
                success = true;

            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public JqDataTableInfo SerchSacrifice(string pname, string price, string ptype, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<Sacrifice> list = new List<Sacrifice>();
            List<Byte> b = new List<Byte>();
            if(Convert.ToInt32(ptype) == 5)
            {
                b.Add(0);
                b.Add(1);
                b.Add(2);
                b.Add(3);
                b.Add(4);
            }
            else
            {
                b.Add(Convert.ToByte(ptype));
            }
            if (price == "0")
            {
                list = db.sacrifices.Where(m => m.deleted == 0 && m.name.Contains(pname)&&b.Contains(m.type))
                       .Select(al1 => new Sacrifice
                       {
                           pname = al1.name,
                           id = al1.uid,
                           imgurl = al1.imgurl,
                           ptype=al1.type,
                           price = al1.price.ToString()
                           //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            if (price == "500")
            {
                list = db.sacrifices.Where(m => m.deleted == 0 && m.name.Contains(pname) && b.Contains(m.type)&&m.price>=500)
                      .Select(al1 => new Sacrifice
                      {
                          pname = al1.name,
                          id = al1.uid,
                          imgurl = al1.imgurl,
                          ptype = al1.type,
                          price = al1.price.ToString()
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (price != "0" && price != "500")
            {
                string[] st=price.Split(',');
                int stp = Convert.ToInt32(st[0]);
                int enp = Convert.ToInt32(st[1]);
                list = db.sacrifices.Where(m => m.deleted == 0 && m.name.Contains(pname) && b.Contains(m.type) && m.price >= stp&&m.price<=enp)
                       .Select(al1 => new Sacrifice
                       {
                           pname = al1.name,
                           id = al1.uid,
                           imgurl = al1.imgurl,
                           ptype = al1.type,
                           price = al1.price.ToString()
                           //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            res.aaData = list;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }

       

        public bool DelSacrifice(long uid)
        {
            bool success = false;
            sacrifice scen = db.sacrifices.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            if (scen != null)
            {
                scen.deleted = 1;
                db.SubmitChanges();
                success = true;
            }
            return success;
        }
        public List<tomb_area> GetAllzone()
        {
            List<tomb_area> cs = db.tomb_areas.Where(m => m.deleted == 0&&m.type==0).ToList();
            return cs;
        }
        public List<tomb_area> GetAllVrenzone()
        {
            List<tomb_area> cs = db.tomb_areas.Where(m => m.deleted == 0 && m.type == 1).ToList();
            return cs;
        }
        public tomb_area GetOneZone(long uid)
        {
            tomb_area cs = db.tomb_areas.Where(m => m.deleted == 0&&m.uid==uid).FirstOrDefault();
            return cs;
        }
        public bool InserCemetery(long zonename, string img, string price, string ctype, int cpai, int clie, string cnum)
        {
            bool success = false;
            try
            {
                grave_site sa = new grave_site();
                sa.createtime = DateTime.Now;
                sa.deleted = 0;
                sa.number=cnum;
                sa.price = Convert.ToInt32(price);
                sa.tombarea_id = zonename;
                sa.row_number = cpai;
                sa.column_number = clie;
                sa.gravestone_type = ctype;
                sa.gravestone_imgurl = img;
                db.grave_sites.InsertOnSubmit(sa);
                db.SubmitChanges();
                success = true;

            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public JqDataTableInfo SerchCemmetery(long zonename, int cpai, int clie, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<Cemetery> list = new List<Cemetery>();

            if (zonename == 0)
            {
                list = db.grave_sites.Where(m => m.deleted == 0 )
                       .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                       .Where(m=>m.empt.deleted==0)
                       .Select(al1 => new Cemetery
                       {
                           cnum = al1.m2.number,
                           id = al1.m2.uid,
                           imgurl = al1.m2.gravestone_imgurl,
                           price = al1.m2.price.ToString(),
                           status=al1.m2.client_id.ToString(),
                           zonename = al1.empt.name
                           //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            if (zonename != 0 && cpai == 0 && clie==0)
            {
                list = db.grave_sites.Where(m => m.deleted == 0 && m.tombarea_id == zonename)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Cemetery
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          imgurl = al1.m2.gravestone_imgurl,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (zonename != 0 && cpai != 0 && clie == 0)
            {
                list = db.grave_sites.Where(m => m.deleted == 0 && m.tombarea_id == zonename&&m.row_number==cpai)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Cemetery
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          imgurl = al1.m2.gravestone_imgurl,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (zonename != 0 && cpai == 0 && clie != 0)
            {
                list = db.grave_sites.Where(m => m.deleted == 0 && m.tombarea_id == zonename && m.column_number == clie)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Cemetery
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          imgurl = al1.m2.gravestone_imgurl,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (zonename != 0 && cpai != 0 && clie != 0)
            {
                list = db.grave_sites.Where(m => m.deleted == 0 && m.tombarea_id == zonename && m.row_number == cpai&&m.column_number==clie)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Cemetery
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          imgurl = al1.m2.gravestone_imgurl,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            res.aaData = list;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public bool UpdatePrice(long zonename1, int zpai, int mprice)
        {
            bool success = false;
            try
            {
                List<grave_site> list=db.grave_sites.Where(m=>m.tombarea_id==zonename1&&m.row_number==zpai&&m.deleted==0).ToList();
                foreach(grave_site a in list)
                {
                    a.price=mprice;
                    db.SubmitChanges();
                    
                }
                success = true;
            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public int EditCemetery(long uid)
        {
            int status = 0;
            grave_site gs = db.grave_sites.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
            if (gs.client_id == null)
            {
                environ env = db.environs.Where(m => m.name == "mudiyuliushijian" && m.deleted == 0).FirstOrDefault();
                List<tomb_reserve> tr = db.tomb_reserves.Where(m => m.tombsite_id == uid && m.deleted == 0 && m.reserve_time.AddHours(Convert.ToDouble(env.value)) >= DateTime.Now).ToList();
                if (tr.Count > 0)
                {
                    status = 1;
                }
                List<deposit> dep = db.deposits.Where(m => m.tombsite_id == uid && m.deleted == 0 && m.endtime>= DateTime.Now).ToList();
                if (dep.Count > 0)
                {
                    status = 2;
                }
                if (tr.Count == 0 && dep.Count == 0)
                {
                    status = 4;
                }
            }
            if (gs.client_id != null)
            {
                status = 3;
            }
            return status;
        }
        public bool yanzheng(long uid, string yname, string yphone)
        {
            bool success = false;
            try
            {
                environ env = db.environs.Where(m => m.name == "mudiyuliushijian" && m.deleted == 0).FirstOrDefault();
                List<deposit> dep = db.deposits.Where(m => m.endtime >= DateTime.Now && m.deleted == 0 && m.tombsite_id == uid && m.name == yname && m.phone == yphone).ToList();
                List<tomb_reserve> tr = db.tomb_reserves.Where(m => m.tombsite_id == uid && m.deleted == 0 && m.reserve_time.AddHours(Convert.ToDouble(env.value)) >= DateTime.Now && m.name == yname && m.phone == yphone).ToList();
                if(dep.Count>0||tr.Count>0)
                {
                    success = true;
                }
            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public int Getdays(int price)
        {
            int days = 0;
            deposit_type dt = db.deposit_types.Where(m => m.deleted == 0 &&( price >= m.min_price && price < m.max_price)).FirstOrDefault();
            if (dt != null)
            {
                days = dt.period;
            }
            return days;
        }
        public int UpdateCemetery(long uid, int statusnum, string bname, string bphone, string rname, string rphone, string bmname1, string bmname2, string bfname1, string bfname2, string bprice, string bdays, int upstatus)
        {
            int success = 0;
            try
            {
                if (statusnum == 1 && upstatus == 2)
                {
                    environ env = db.environs.Where(m => m.name == "mudiyuliushijian" && m.deleted == 0).FirstOrDefault();
                    tomb_reserve tr = db.tomb_reserves.Where(m => m.deleted == 0 && m.tombsite_id == uid && m.reserve_time.AddHours(Convert.ToDouble(env.value)) >= DateTime.Now).FirstOrDefault();
                    if (tr == null)
                    {
                        success = 2;
                    }
                    else
                    {
                        deposit dep = new deposit();
                        dep.deleted = 0;
                        dep.endtime = DateTime.Now.AddDays(Convert.ToInt32(bdays));
                        dep.name = tr.name;
                        dep.phone = tr.phone;
                        dep.paytime = DateTime.Now;
                        dep.price = Convert.ToInt32(bprice);
                        dep.receiver_id = tr.user_id;
                        dep.tombsite_id = uid;
                        dep.deadperson1 = tr.deadperson1;
                        dep.deadperson2 = tr.deadperson2;
                        dep.sootheperson1 = tr.sootheperson1;
                        dep.sootheperson2 = tr.sootheperson2;
                        db.deposits.InsertOnSubmit(dep);
                        db.SubmitChanges();
                        tr.deleted =1;
                        db.SubmitChanges();
                        success = 1;
                    }
                }
                if (statusnum != 1 && upstatus == 2)
                {
                    user us = db.users.Where(m => m.realname == rname && m.phone == rphone && m.deleted == 0).FirstOrDefault();
                    if (us == null)
                    {
                        success = 3;
                    }
                        deposit dep = new deposit();
                        dep.deleted = 0;
                        dep.endtime = DateTime.Now.AddDays(Convert.ToInt32(bdays));
                        dep.name = bname;
                        dep.phone = bphone;
                        dep.paytime = DateTime.Now;
                        dep.price = Convert.ToInt32(bprice);
                        dep.receiver_id = us.uid;
                        dep.tombsite_id = uid;
                        dep.deadperson1 = bmname1;
                        dep.deadperson2 = bmname2;
                        dep.sootheperson1 = bfname1;
                        dep.sootheperson2 = bfname2;
                        db.deposits.InsertOnSubmit(dep);
                        db.SubmitChanges();
                        
                        success = 1;
                    
                }
                if (upstatus == 4)
                {
                    if (statusnum == 1)
                    {
                        environ env = db.environs.Where(m => m.name == "mudiyuliushijian" && m.deleted == 0).FirstOrDefault();
                        tomb_reserve tr = db.tomb_reserves.Where(m => m.deleted == 0 && m.tombsite_id == uid && m.reserve_time.AddHours(Convert.ToDouble(env.value)) >= DateTime.Now).FirstOrDefault();
                        if (tr != null)
                        {
                            tr.deleted = 1;
                            db.SubmitChanges();
                            success = 1;
                        }
                        else
                        {
                            success = 1;
                        }
                    }
                    if (statusnum == 2)
                    {
                        deposit tr = db.deposits.Where(m => m.deleted == 0 && m.tombsite_id == uid && m.endtime >= DateTime.Now).FirstOrDefault();
                        if (tr != null)
                        {
                            tr.deleted = 1;
                            db.SubmitChanges();
                            success = 1;
                        }
                        else
                        {
                            success = 1;
                        }
                    }

                }
            }
            catch (System.Exception ex)
            {
                success = 0;
            }
            return success;
        }
        public bool InserZone(string zonename, string img, string zonetype, string paishu, string lieshu, string quyushu, string contents, double xpos, double ypos)
        {
            bool success = false;
            try
            {
                if (zonetype == "0")
                {
                    tomb_area ta = new tomb_area();
                    ta.deleted = 0;
                    ta.description = contents;
                    ta.img_url = img;
                    ta.name = zonename;
                    ta.row_count = Convert.ToInt32(paishu);
                    ta.type = Convert.ToByte(zonetype);
                    ta.xpos = Convert.ToInt32(xpos);
                    ta.ypos = Convert.ToInt32(ypos);
                    ta.column_count = Convert.ToInt32(lieshu);
                    db.tomb_areas.InsertOnSubmit(ta);
                    db.SubmitChanges();
                    success = true;
                }
                if (zonetype == "1")
                {
                    tomb_area ta = new tomb_area();
                    ta.deleted = 0;
                    ta.description = contents;
                    ta.img_url = img;
                    ta.name = zonename;
                    ta.type = Convert.ToByte(zonetype);
                    ta.xpos = Convert.ToInt32(xpos);
                    ta.ypos = Convert.ToInt32(ypos);

                    ta.area_size = quyushu;
                   // ta.area_count = Convert.ToInt32(quyushu);

                    db.tomb_areas.InsertOnSubmit(ta);
                    db.SubmitChanges();
                    success = true;
                }
                if (zonetype == "2")
                {
                    tomb_area ta = new tomb_area();
                    ta.deleted = 0;
                    ta.description = contents;
                    ta.img_url = img;
                    ta.name = zonename;
                    ta.type = Convert.ToByte(zonetype);
                    ta.xpos = Convert.ToInt32(xpos);
                    ta.ypos = Convert.ToInt32(ypos);
                    db.tomb_areas.InsertOnSubmit(ta);
                    db.SubmitChanges();
                    success = true;
                }
            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public JqDataTableInfo SerchZone(string zonename, string zonetype, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<Zone> list = new List<Zone>();

            if (zonetype == "3")
            {
                list = db.tomb_areas.Where(m => m.deleted == 0 && m.name.Contains(zonename))
                       .Select(al1 => new Zone
                       {
                           zonename = al1.name,
                           id = al1.uid,
                           img_url = al1.img_url,
                           zonetype = al1.type.ToString()
                          

                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            if (zonetype != "3")
            {
                list = db.tomb_areas.Where(m => m.deleted == 0 && m.name.Contains(zonename)&&m.type==Convert.ToByte(zonetype))
                       .Select(al1 => new Zone
                       {
                           zonename = al1.name,
                           id = al1.uid,
                           img_url = al1.img_url,
                           zonetype = al1.type.ToString()


                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            res.aaData = list;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public bool DelZone(long uid)
        {
            bool success = false;
            try
            {
                tomb_area ta = db.tomb_areas.Where(m => m.deleted == 0 && m.uid == uid).FirstOrDefault();
                ta.deleted = 1;
                db.SubmitChanges();
                success = true;
            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public tomb_area GetZone(long uid)
        {
            tomb_area ta = db.tomb_areas.Where(m => m.deleted == 0 && m.uid == uid).FirstOrDefault();
            return ta;
        }
        public bool UpdateZone(long uid, string zonename, string img, string zonetype, string paishu, string lieshu, string quyushu, string contents, double xpos, double ypos)
        {
            bool success = false;
            try
            {
                if (zonetype == "0")
                {
                    tomb_area ta = db.tomb_areas.Where(m=>m.deleted==0&&m.uid==uid).FirstOrDefault();
                    ta.description = contents;
                    ta.img_url = img;
                    ta.name = zonename;
                    ta.row_count = Convert.ToInt32(paishu);
                    ta.type = Convert.ToByte(zonetype);
                    ta.xpos = Convert.ToInt32(xpos);
                    ta.ypos = Convert.ToInt32(ypos);
                    ta.column_count = Convert.ToInt32(lieshu);
                    db.SubmitChanges();
                    success = true;
                }
                if (zonetype == "1")
                {
                    tomb_area ta = db.tomb_areas.Where(m => m.deleted == 0 && m.uid == uid).FirstOrDefault();
                    ta.description = contents;
                    ta.img_url = img;
                    ta.name = zonename;
                    ta.type = Convert.ToByte(zonetype);
                    ta.xpos = Convert.ToInt32(xpos);
                    ta.ypos = Convert.ToInt32(ypos);
                    ta.area_size = quyushu;

                    //ta.area_count = Convert.ToInt32(quyushu);

                    db.SubmitChanges();
                    success = true;
                }
                if (zonetype == "2")
                {
                    tomb_area ta = db.tomb_areas.Where(m => m.deleted == 0 && m.uid == uid).FirstOrDefault();
                    ta.description = contents;
                    ta.img_url = img;
                    ta.name = zonename;
                    ta.type = Convert.ToByte(zonetype);
                    ta.xpos = Convert.ToInt32(xpos);
                    ta.ypos = Convert.ToInt32(ypos);
                    db.SubmitChanges();
                    success = true;
                }
            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public bool InserVren(long zonename, string img, string price, string quyu, int cpai, int clie, string cnum)
        {
            bool success = false;
            try
            {
                grave_tablet sa = new grave_tablet();
                sa.createtime = DateTime.Now;
                sa.deleted = 0;
                sa.number = cnum;
                sa.price = Convert.ToInt32(price);
                sa.tombarea_id = zonename;
                sa.row_number = cpai;
                sa.column_number = clie;
                sa.area_number = quyu;
                db.grave_tablets.InsertOnSubmit(sa);
                db.SubmitChanges();
                success = true;

            }
            catch (System.Exception ex)
            {
                success = false;
            }
            return success;
        }
        public JqDataTableInfo SerchVren(long vrzonename, int vrpaishu, int vrlieshu, string qushu, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<Vren> list = new List<Vren>();

            if (vrzonename == 0)
            {
                list = db.grave_tablets.Where(m => m.deleted == 0)
                       .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                       .Select(al1 => new Vren
                       {
                           cnum = al1.m2.number,
                           id = al1.m2.uid,
                           price = al1.m2.price.ToString(),
                           status = al1.m2.client_id.ToString(),
                           zonename = al1.empt.name
                           //activitycontent=al1.html_content

                       }
                       ).OrderByDescending(m => m.id).ToList();
            }
            if (vrzonename != 0 &&qushu=="0")
            {
                list = db.grave_tablets.Where(m => m.deleted == 0 && m.tombarea_id == vrzonename)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Vren
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (vrzonename != 0 && vrpaishu != 0 && vrlieshu == 0 && qushu == "0")
            {
                list = db.grave_tablets.Where(m => m.deleted == 0 && m.tombarea_id == vrzonename && m.row_number == vrpaishu)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Vren
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (vrzonename != 0 && vrpaishu != 0 && vrlieshu != 0 && qushu != "0")
            {
                list = db.grave_tablets.Where(m => m.deleted == 0 && m.tombarea_id == vrzonename && m.row_number == vrpaishu && m.column_number == vrlieshu && m.area_number == qushu)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Vren
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (vrzonename != 0 && vrpaishu == 0 && vrlieshu == 0 && qushu != "0")
            {
                list = db.grave_tablets.Where(m => m.deleted == 0 && m.tombarea_id == vrzonename &&  m.area_number == qushu)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Vren
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (vrzonename != 0 && vrpaishu != 0 && vrlieshu == 0 && qushu != "0")
            {
                list = db.grave_tablets.Where(m => m.deleted == 0 && m.tombarea_id == vrzonename && m.row_number == vrpaishu && m.area_number == qushu)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Vren
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            if (vrzonename != 0 && vrpaishu == 0 && vrlieshu != 0 && qushu != "0")
            {
                list = db.grave_tablets.Where(m => m.deleted == 0 && m.tombarea_id == vrzonename && m.column_number == vrlieshu && m.area_number == qushu)
                      .Join(db.tomb_areas, m1 => m1.tombarea_id, emp => emp.uid, (m1, emp) => new { m2 = m1, empt = emp })
                      .Select(al1 => new Vren
                      {
                          cnum = al1.m2.number,
                          id = al1.m2.uid,
                          price = al1.m2.price.ToString(),
                          status = al1.m2.client_id.ToString(),
                          zonename = al1.empt.name
                          //activitycontent=al1.html_content

                      }
                      ).OrderByDescending(m => m.id).ToList();
            }
            res.aaData = list;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
       public link_url GetluozangLink()
       {
           link_url lu = new link_url();
           lu = db.link_urls.Where(m => m.name == "luozangshishi").FirstOrDefault();
           return lu;

       }
       public int EditPaiWei(long uid)
       {
           int status = 0;
           grave_tablet gs = db.grave_tablets.Where(m => m.uid == uid && m.deleted == 0).FirstOrDefault();
           if (gs.client_id == null)
           {
               environ env = db.environs.Where(m => m.name == "mudiyuliushijian" && m.deleted == 0).FirstOrDefault();
               List<tomb_reserve> tr = db.tomb_reserves.Where(m => m.tombtablet_id == uid && m.deleted == 0 && m.reserve_time.AddHours(Convert.ToDouble(env.value)) >= DateTime.Now).ToList();
               if (tr.Count > 0)
               {
                   status = 1;
               }
               List<deposit> dep = db.deposits.Where(m => m.tombtablet_id == uid && m.deleted == 0 && m.endtime >= DateTime.Now).ToList();
               if (dep.Count > 0)
               {
                   status = 2;
               }
               if (tr.Count == 0 && dep.Count == 0)
               {
                   status = 4;
               }
           }
           if (gs.client_id != null)
           {
               status = 3;
           }
           return status;
       }
       public bool UpdatePwPrice(long pwzone, string  pwzonenum, int pwpaishu, int pwprice)
       {
           bool success = false;
           try
           {
               List<grave_tablet> list = db.grave_tablets.Where(m => m.tombarea_id == pwzone && m.row_number == pwpaishu&&m.area_number==pwzonenum && m.deleted == 0).ToList();
               foreach (grave_tablet a in list)
               {
                   a.price = pwprice;
                   db.SubmitChanges();

               }
               success = true;
           }
           catch (System.Exception ex)
           {
               success = false;
           }
           return success;
       }
       public int UpdatePaiWei(long uid, int statusnum, string bname, string bphone, string rname, string rphone, string bmname1, string bmname2, string bfname1, string bfname2, string bprice, string bdays, int upstatus)
       {
           int success = 0;
           try
           {
               if (statusnum == 1 && upstatus == 2)
               {
                   environ env = db.environs.Where(m => m.name == "mudiyuliushijian" && m.deleted == 0).FirstOrDefault();
                   tomb_reserve tr = db.tomb_reserves.Where(m => m.deleted == 0 && m.tombtablet_id == uid && m.reserve_time.AddHours(Convert.ToDouble(env.value)) >= DateTime.Now).FirstOrDefault();
                   if (tr == null)
                   {
                       success = 2;
                   }
                   else
                   {
                       deposit dep = new deposit();
                       dep.deleted = 0;
                       dep.endtime = DateTime.Now.AddDays(Convert.ToInt32(bdays));
                       dep.name = tr.name;
                       dep.phone = tr.phone;
                       dep.paytime = DateTime.Now;
                       dep.price = Convert.ToInt32(bprice);
                       dep.receiver_id = tr.user_id;
                       dep.tombsite_id = uid;
                       dep.deadperson1 = tr.deadperson1;
                       dep.deadperson2 = tr.deadperson2;
                       dep.sootheperson1 = tr.sootheperson1;
                       dep.sootheperson2 = tr.sootheperson2;
                       db.deposits.InsertOnSubmit(dep);
                       db.SubmitChanges();
                       tr.deleted = 1;
                       db.SubmitChanges();
                       success = 1;
                   }
               }
               if (statusnum != 1 && upstatus == 2)
               {
                   user us = db.users.Where(m => m.realname == rname && m.phone == rphone && m.deleted == 0).FirstOrDefault();
                   if (us == null)
                   {
                       success = 3;
                   }
                   deposit dep = new deposit();
                   dep.deleted = 0;
                   dep.endtime = DateTime.Now.AddDays(Convert.ToInt32(bdays));
                   dep.name = bname;
                   dep.phone = bphone;
                   dep.paytime = DateTime.Now;
                   dep.price = Convert.ToInt32(bprice);
                   dep.receiver_id = us.uid;
                   dep.tombtablet_id = uid;
                   dep.deadperson1 = bmname1;
                   dep.deadperson2 = bmname2;
                   dep.sootheperson1 = bfname1;
                   dep.sootheperson2 = bfname2;
                   db.deposits.InsertOnSubmit(dep);
                   db.SubmitChanges();

                   success = 1;

               }
               if (upstatus == 4)
               {
                   if (statusnum == 1)
                   {
                       environ env = db.environs.Where(m => m.name == "mudiyuliushijian" && m.deleted == 0).FirstOrDefault();
                       tomb_reserve tr = db.tomb_reserves.Where(m => m.deleted == 0 && m.tombtablet_id == uid && m.reserve_time.AddHours(Convert.ToDouble(env.value)) >= DateTime.Now).FirstOrDefault();
                       if (tr != null)
                       {
                           tr.deleted = 1;
                           db.SubmitChanges();
                           success = 1;
                       }
                       else
                       {
                           success = 1;
                       }
                   }
                   if (statusnum == 2)
                   {
                       deposit tr = db.deposits.Where(m => m.deleted == 0 && m.tombtablet_id == uid && m.endtime >= DateTime.Now).FirstOrDefault();
                       if (tr != null)
                       {
                           tr.deleted = 1;
                           db.SubmitChanges();
                           success = 1;
                       }
                       else
                       {
                           success = 1;
                       }
                   }

               }
           }
           catch (System.Exception ex)
           {
               success = 0;
           }
           return success;
       }
       public List<string> Getpwqu(long quname)
       {
           List<string> list = new List<string>();
           tomb_area talist = db.tomb_areas.Where(m => m.uid == quname && m.deleted == 0).FirstOrDefault();
           
               string[] areasize = talist.area_size.Split(',');
               for (int i = 0; i < areasize.Length - 1; i++)
               {
                   list.Add(areasize[i].Split(':')[0]);
               }
               return list;
        }
        public List<int> Getpwqupai(string quname, long zonename)
       {
           List<int> list = new List<int>();
           tomb_area talist = db.tomb_areas.Where(m => m.uid == zonename && m.deleted == 0).FirstOrDefault();

           string[] areasize = talist.area_size.Split(',');
           for (int i = 0; i < areasize.Length - 1; i++)
           {
               if (areasize[i].Split(':')[0] == quname)
               {
                   list.Add(Convert.ToInt32(areasize[i].Split(':')[1]));
                   list.Add(Convert.ToInt32(areasize[i].Split(':')[2]));
               }
           }
           return list;
       }
    }
    
}
