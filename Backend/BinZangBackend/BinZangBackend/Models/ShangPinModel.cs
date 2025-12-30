using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BinZangBackend.Models
{
    public class ShangPinInfo{
        //
        // GET: /Default1/
        public long uid { get; set; }
        public string name { get; set; }
        public int num { get; set; }
        public float price { get; set; }
        public float total { get; set; }
        public byte deleted { get; set; }
        public float shangpinzongjia { get; set; }
        

        

    }
    public class JiBaiOrderInfo
    {
        public long uid { get; set; }//服务预约的id
        public long client_id { get; set; }
        public string client_name { get; set; }
        public string client_phone { get; set; }
        public long? user_id { get; set; }
        public string user_name { get; set; }
        public DateTime reservetime { get; set; }
        public long service_id { get; set; }
        public string service_name { get; set; }
        public float yishi { get; set; }
        public DateTime createtime { get; set; }
        public byte status { get; set; }
        public string note { get; set; }
        public string reservetimestr { get; set; }
        public string isno { get; set; }



    }
    public class ShangPinModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public List<ShangPinInfo> GetShangPin(long sid){

            List<sacrifice_reserve> sr = db.sacrifice_reserves.Where(a=>a.servicereserve_id==sid).ToList();
            List<ShangPinInfo> splist = new List<ShangPinInfo>();
            for (int i = 0; i < sr.Count; i++) {
                sacrifice s = new sacrifice();
                s = db.sacrifices.Where(a => a.uid == sr[i].sacrifice_id).SingleOrDefault();
                ShangPinInfo sp = new ShangPinInfo();
                sp.name = s.name;
                sp.price = s.price;
                sp.num = sr[i].count;
                sp.total = sr[i].count * s.price;
                sp.uid = sr[i].uid;
                sp.deleted = sr[i].deleted;
                splist.Add(sp);
               
            
            }
            return splist;


        }
        public JqDataTableInfo ShangOrderTable(long sid)
        {
            List<ShangPinInfo> list = GetShangPin(sid);
            JqDataTableInfo jes = new JqDataTableInfo();
            jes.aaData = list;
            jes.iTotalRecords = list.Count;
            return jes;


        }

        public string Getcname(long sid)
        {
            List<LuoZangInfo> list = new LuoZangModel().GetLuoZang1();
            list = list.Where(a => a.uid == sid).ToList();
            return list[0].client_name;

        }
        public string GetAllTotal(long sid)
        {
           // List<LuoZangInfo> list = new LuoZangModel().GetLuoZang();
           // list = list.Where(a => a.uid == sid).ToList();
           // float yishi = list[0].yishi;
            float shang=0;
            float zong = 0;
            List<ShangPinInfo> list2 = GetShangPin(sid);
            for (int i = 0; i < list2.Count;i++ )
            {
                shang += list2[i].total;
            }
            zong =  shang;
            return zong + " 元";
            
        }
        public byte GetOrderType(long sid)
        {
            byte types = db.service_reserves.Where(a => a.uid == sid).FirstOrDefault().service_type;
            List<sacrifice_reserve> list = db.sacrifice_reserves.Where(a => a.servicereserve_id == sid).ToList();
            List<sacrifice_reserve> lsit1 = db.sacrifice_reserves.Where(a => a.deleted == 1).ToList();
            if (types == 0)
            {
                if (list.Count == lsit1.Count)
                {
                    return 0;
                }
                else
                {
                    return 1;


                }
            }
            else
            {
                return 0;

                
            }
           
           

        }
        //删除商品
        public string DelOrderBy(long uid ){
            string res = "ok";
            try
            {
                sacrifice_reserve sr = db.sacrifice_reserves.Where(a => a.uid == uid).SingleOrDefault();
                long shangid = sr.sacrifice_id;
                decimal price = db.sacrifices.Where(a => a.uid == shangid).FirstOrDefault().price;
                long sid = sr.servicereserve_id;
                service_reserve srr = db.service_reserves.Where(a => a.uid == sid).FirstOrDefault();
                if (srr.service_type == 0)
                {
                    sr.deleted = 1;
                    srr.total_price = srr.total_price - (price * sr.count);
              
                    db.SubmitChanges();
                }
                else
                {
                    if (srr.service_type==2)
                    {
                        //
                        if (srr.status == 2 || srr.status == 3)
                        {
                            res = "已发送回函或已读状态不可操作!";
                        }
                        else
                        {
                            sr.deleted = 1;
                            db.SubmitChanges();
                            List<sacrifice_reserve> list2 = db.sacrifice_reserves.Where(a => a.servicereserve_id == sid).ToList();
                            List<sacrifice_reserve> list3 = db.sacrifice_reserves.Where(a => a.servicereserve_id == sid && a.deleted == 1).ToList();
                            if (list2.Count == list3.Count)
                            {
                                srr.status = 1;
                                srr.total_price = 0;
                                db.SubmitChanges();
                            }
                            else
                            {

                            }

                        }
                    }
                    else { 
                    sr.deleted = 1;
                    db.SubmitChanges();
                    List<sacrifice_reserve> list = db.sacrifice_reserves.Where(a => a.servicereserve_id == sid).ToList();
                    List<sacrifice_reserve> list1 = db.sacrifice_reserves.Where(a => a.servicereserve_id == sid && a.deleted == 1).ToList();
                    if (list.Count == list1.Count)
                    {
                        srr.status = 1;
                        srr.total_price=0;
                        db.SubmitChanges();
                    }
                    else
                    {

                    }
                    }

                }
            }
            catch (System.Exception ex)
            {
                res = ex.ToString();
            }
          
            return res;


        }
        public List<JiBaiOrderInfo> GetJiBai()
        {
            List<JiBaiOrderInfo> list = new List<JiBaiOrderInfo>();
            var reslist = db.service_reserves.Where(a => a.deleted == 0&&a.service_type==1).Join(db.clients, sr => sr.client_id, c => c.uid, (sr, c) => new { sr1 = sr, c1 = c }).Join(db.users, sr2 => sr2.sr1.user_id, u => u.uid, (sr2, u) => new { sr3 = sr2, u = u }).Join(db.sacrifice_reserves, sr4 => sr4.sr3.sr1.uid, sre => sre.servicereserve_id, (sr4, sre) => new { sr5 = sr4, sre1 = sre }).Select(ord => new JiBaiOrderInfo
            {
                uid = ord.sr5.sr3.sr1.uid,
                client_id = ord.sr5.sr3.sr1.client_id,
                client_name = ord.sr5.sr3.c1.realname,
                client_phone = ord.sr5.sr3.c1.phone,
                user_id = (long)ord.sr5.sr3.sr1.user_id,
                user_name = ord.sr5.u.realname,
                reservetime = ord.sr5.sr3.sr1.reserve_time,
                status = ord.sr5.sr3.sr1.status,
                reservetimestr = ord.sr5.sr3.sr1.reserve_time.Year + "年" + ord.sr5.sr3.sr1.reserve_time.Month + "月" + ord.sr5.sr3.sr1.reserve_time.Day + "日" + " " + ord.sr5.sr3.sr1.reserve_time.Hour + "点" + ord.sr5.sr3.sr1.reserve_time.Minute+"分",
                isno = ord.sr5.sr3.sr1.status==1?"是":"否"


            }).ToList();

            list = reslist;




            return list;
        }
        public List<JiBaiOrderInfo> GetdDJiBai()
        {
            List<JiBaiOrderInfo> list = new List<JiBaiOrderInfo>();
            var reslist = db.service_reserves.Where(a => a.deleted == 0 && a.service_type == 2).Join(db.clients, sr => sr.client_id, c => c.uid, (sr, c) => new { sr1 = sr, c1 = c }).Join(db.users, sr2 => sr2.sr1.user_id, u => u.uid, (sr2, u) => new { sr3 = sr2, u = u }).Join(db.sacrifice_reserves, sr4 => sr4.sr3.sr1.uid, sre => sre.servicereserve_id, (sr4, sre) => new { sr5 = sr4, sre1 = sre }).Select(ord => new JiBaiOrderInfo
            {
                uid = ord.sr5.sr3.sr1.uid,
                client_id = ord.sr5.sr3.sr1.client_id,
                client_name = ord.sr5.sr3.c1.realname,
                client_phone = ord.sr5.sr3.c1.phone,
                user_id = ord.sr5.sr3.sr1.user_id,
                user_name = ord.sr5.u.realname,
                reservetime = ord.sr5.sr3.sr1.reserve_time,
                status = ord.sr5.sr3.sr1.status,
                reservetimestr = ord.sr5.sr3.sr1.reserve_time.Year + "年" + ord.sr5.sr3.sr1.reserve_time.Month + "月" + ord.sr5.sr3.sr1.reserve_time.Day + "日" + " " + ord.sr5.sr3.sr1.reserve_time.Hour + "点" + ord.sr5.sr3.sr1.reserve_time.Minute + "分",
                isno = ord.sr5.sr3.sr1.status==1?"是":"否"

            }).ToList();

            list = reslist;




            return list;
        }
        //祭拜预约的产讯
        public JqDataTableInfo GetJiBaiTable(string cname,string phone,string stime,string etime,string status)
        {
            JqDataTableInfo jq = new JqDataTableInfo();
            List<JiBaiOrderInfo> list = GetJiBai();
            if (cname!=""&&cname!=null)
            {
                list = list.Where(a => a.client_name.Contains(cname)).ToList();

            }
            if (phone!=null&&phone!="")
            {
                list = list.Where(a => a.client_phone.Contains(phone)).ToList();
            }
            if (stime!=null&&stime!="")
            {
                DateTime st = DateTime.Parse(stime);
                list = list.Where(a => a.reservetime > st).ToList();
                
            }
            if (etime!=null&&etime!="")
            {
                DateTime et = DateTime.Parse(etime);
                list = list.Where(a => a.reservetime < et).ToList();
            }
            if (status == "0")
            { list = new List<JiBaiOrderInfo>(); }
            if (status=="1")
            {
                list = list.Where(a => a.status == 0).ToList();
            }
            if (status=="2")
            {
                list = list.Where(a => a.status == 1).ToList();
            }
            if (status=="3")
            {
                list = list.Where(a => a.status == 0 || a.status == 1).ToList();
            }
  
            jq.aaData = list.OrderByDescending(m=>m.uid).ToList();
            jq.iTotalRecords = list.Count;
            return jq;

        }
        public JqDataTableInfo GetDJiBaiTable(string cname, string phone, string stime, string etime, string status)
        {
            JqDataTableInfo jq = new JqDataTableInfo();
            List<JiBaiOrderInfo> list = GetdDJiBai();
            if (cname != "" && cname != null)
            {
                list = list.Where(a => a.client_name.Contains(cname)).ToList();

            }
            if (phone != null && phone != "")
            {
                list = list.Where(a => a.client_phone.Contains(phone)).ToList();
            }
            if (stime != null && stime != "")
            {
                DateTime st = DateTime.Parse(stime);
                list = list.Where(a => a.reservetime > st).ToList();

            }
            if (etime != null && etime != "")
            {
                DateTime et = DateTime.Parse(etime);
                list = list.Where(a => a.reservetime < et).ToList();
            }
            if (status == "0")
            { list = new List<JiBaiOrderInfo>(); }
            if (status == "1")
            {
                list = list.Where(a => a.status == 0).ToList();
            }
            if (status == "2")
            {
                list = list.Where(a => a.status == 1).ToList();
            }
            if (status == "3")
            {
                list = list.Where(a => a.status == 0 || a.status == 1||a.status==2||a.status==3).ToList();
            }

            jq.aaData = list.OrderByDescending(m=>m.uid).ToList();
            jq.iTotalRecords = list.Count;
            return jq;

        }
        public List<JiBaiOrderInfo> GetDaiJi(string cname, string phone, string stime, string etime, string status)
        {
            List<JiBaiOrderInfo> list = GetdDJiBai();
            if (cname != "" && cname != null)
            {
                list = list.Where(a => a.client_name.Contains(cname)).ToList();

            }
            if (phone != null && phone != "")
            {
                list = list.Where(a => a.client_phone.Contains(phone)).ToList();
            }
            if (stime != null && stime != "")
            {
                DateTime st = DateTime.Parse(stime);
                list = list.Where(a => a.reservetime > st).ToList();

            }
            if (etime != null && etime != "")
            {
                DateTime et = DateTime.Parse(etime);
                list = list.Where(a => a.reservetime < et).ToList();
            }
            if (status == "0")
            { list = new List<JiBaiOrderInfo>(); }
            if (status == "1")
            {
                list = list.Where(a => a.status == 0).ToList();
            }
            if (status == "2")
            {
                list = list.Where(a => a.status == 1).ToList();
            }
            if (status == "3")
            {
                list = list.Where(a => a.status == 0 || a.status == 1 || a.status == 2 || a.status == 3).ToList();
            }
            return list;

        }
        public List<JiBaiOrderInfo> GetZiJi(string cname, string phone, string stime, string etime, string status)
        {
            List<JiBaiOrderInfo> list = GetJiBai();
            if (cname != "" && cname != null)
            {
                list = list.Where(a => a.client_name.Contains(cname)).ToList();

            }
            if (phone != null && phone != "")
            {
                list = list.Where(a => a.client_phone.Contains(phone)).ToList();
            }
            if (stime != null && stime != "")
            {
                DateTime st = DateTime.Parse(stime);
                list = list.Where(a => a.reservetime > st).ToList();

            }
            if (etime != null && etime != "")
            {
                DateTime et = DateTime.Parse(etime);
                list = list.Where(a => a.reservetime < et).ToList();
            }
            if (status == "0")
            { list = new List<JiBaiOrderInfo>(); }
            if (status == "1")
            {
                list = list.Where(a => a.status == 0).ToList();
            }
            if (status == "2")
            {
                list = list.Where(a => a.status == 1).ToList();
            }
            if (status == "3")
            {
                list = list.Where(a => a.status == 0 || a.status == 1 || a.status == 2 || a.status == 3).ToList();
            }
            return list;

        }
        public string DeleteJi(long uid)
        {
            string str = "ok";
            try
            {
                service_reserve sr = db.service_reserves.Where(a => a.uid == uid).SingleOrDefault();
                sr.status = 1;
                sr.total_price = 0;
                db.SubmitChanges();
                List<sacrifice_reserve> slist = db.sacrifice_reserves.Where(a => a.servicereserve_id == uid).ToList();
                for (int i = 0; i < slist.Count; i++)
                {
                    sacrifice_reserve srd = new sacrifice_reserve();
                    srd = db.sacrifice_reserves.Where(a => a.uid == slist[i].uid).SingleOrDefault();
                    srd.deleted = 1;
                    db.SubmitChanges();

                }
            }
            catch (System.Exception ex)
            {
                str = ex.ToString();
            }

            return str;

        }
        public string DeleteDJi(long uid)
        {
            string str = "ok";
            try
            {
                service_reserve sr = db.service_reserves.Where(a => a.uid == uid).SingleOrDefault();
                sr.status = 1;
                sr.total_price = 0;
                db.SubmitChanges();
                List<sacrifice_reserve> slist = db.sacrifice_reserves.Where(a => a.servicereserve_id == uid).ToList();
                for (int i = 0; i < slist.Count; i++)
                {
                    sacrifice_reserve srd = new sacrifice_reserve();
                    srd = db.sacrifice_reserves.Where(a => a.uid == slist[i].uid).SingleOrDefault();
                    srd.deleted = 1;
                    db.SubmitChanges();

                }
            }
            catch (System.Exception ex)
            {
                str = ex.ToString();
            }

            return str;

        }
        //根据时间导出行事历
        public List<ExportInfo> ExportJiBy(string extmie)
        {
            DateTime xt = DateTime.Parse(extmie);
            var list = db.service_reserves.Where(a => a.deleted == 0 &&a.service_type==2&& a.status == 0 && (a.reserve_time > xt && a.reserve_time < xt.AddHours(23).AddMinutes(59))).Join(db.clients, sr => sr.client_id, c => c.uid, (sr, c) => new { sr1 = sr, c1 = c }).Join(db.users, src => src.c1.owner_id, u => u.uid, (src, u) => new { src1 = src, u1 = u }).Select(ser => new ExportInfo
            {
                uid = ser.src1.sr1.uid,
                cname = ser.src1.c1.realname,
                stime = ser.src1.sr1.reserve_time.Year + "年" + ser.src1.sr1.reserve_time.Month + "月" + ser.src1.sr1.reserve_time.Day + "日 " + ser.src1.sr1.reserve_time.Hour + "点" + ser.src1.sr1.reserve_time.Minute + "分",
           
                fuwuren = ser.u1.realname


            }).ToList();
            List<ExportInfo> exlist = new List<ExportInfo>();

            exlist = list;
            for (int i = 0; i < exlist.Count; i++)
            {
                List<jipininfo> jlist = new List<jipininfo>();
                jlist = new  LuoZangModel().Getjipin(exlist[i].uid);
                string jname = "";
                for (int j = 0; j < jlist.Count; j++)
                {
                    jname += jlist[j].jname + ";";
                }
                exlist[i].jipins = jname;


            }
            return exlist;

        }
        public string GetJIHtml(List<ExportInfo> jlist)
        {
            string html = "";
            for (int i = 0; i < jlist.Count; i++)
            {
                html += "<tr>";
                html += "<td  colspan='2' rowspan='1' id='1' style='height:90px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'>" + "姓名：" + jlist[i].cname + " </td>";
                html += "<td  colspan='3 ' rowspan='1' id='2' style='height:90px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'>" + "日期：" + jlist[i].stime + " </td>";

                html += "<td  colspan='3 ' rowspan='1' id='report_time' style='height:90px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'>" + "祭品:" + jlist[i].jipins + "</td>";
                html += "<td  colspan='3 ' rowspan='1' id='report_time' style='height:90px;font-size:14;border-bottom: 1px solid #000000;border-right:0px solid red;text-align:center;'>" + "服务人：" + jlist[i].fuwuren + " </td>";
                html += "</tr>";
            }

            return html;
        }
        public string ModifyRemark(string hua,string gong,string sui,string qi)
        {
            string res = "ok";
            try
            {
                environ envhua = db.environs.Where(a => a.deleted == 0 && a.name == "goumai_xianhua_note").SingleOrDefault();
                if (envhua!=null)
                {
                    envhua.txt_value = hua;
                    db.SubmitChanges();
                }
                if (envhua==null)
                {
                    environ envhua1 = new environ();
                    envhua1.name = "goumai_xianhua_note";
                    envhua1.txt_value = hua;
                    envhua1.note = "这里是鲜花备注";
                    db.environs.InsertOnSubmit(envhua1);
                    db.SubmitChanges();
                }
                environ envgong = db.environs.Where(a => a.deleted == 0 && a.name == "goumai_gongfan_note").FirstOrDefault();
                if (envgong!=null)
                {
                    envgong.txt_value = gong;
                    db.SubmitChanges();
                }
                if (envgong==null)
                {
                    environ envgong1 = new environ();
                    envgong1.name = "goumai_gongfan_note";
                    envgong1.txt_value = gong;
                    envgong1.note = "这里是供饭备注";
                    db.environs.InsertOnSubmit(envgong1);
                    db.SubmitChanges();
                }
                environ envsui= db.environs.Where(a => a.deleted == 0 && a.name == "goumai_suizangpin_note").FirstOrDefault();
                if (envsui != null)
                {
                    envsui.txt_value = sui;
                    db.SubmitChanges();
                }
                if (envsui == null)
                {
                    environ envsui1 = new environ();
                    envsui1.name = "goumai_suizangpin_note";
                    envsui1.txt_value = sui;
                    envsui1.note = "这里是随葬品备注";
                    db.environs.InsertOnSubmit(envsui1);
                    db.SubmitChanges();
                }
                environ envqi = db.environs.Where(a => a.deleted == 0 && a.name == "goumai_qita_note").FirstOrDefault();
                if (envqi != null)
                {
                    envqi.txt_value = qi;
                    db.SubmitChanges();
                }
                if (envqi == null)
                {
                    environ envqi1 = new environ();
                    envqi1.name = "goumai_qita_note";
                    envqi1.txt_value = qi;
                    envqi1.note = "这里是其他备注";
                    db.environs.InsertOnSubmit(envqi1);
                    db.SubmitChanges();
                }
            }
            catch (System.Exception ex)
            {
            	
            }
            return res;
        }
      
    }
}
