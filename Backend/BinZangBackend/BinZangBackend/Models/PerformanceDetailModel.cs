using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using JpushApiClient;

namespace BinZangBackend.Models
{
    public class DPerformance
    {
        public string dname { get; set; }
        public string dperformance { get; set; }
    }
    public class YPerformance
    {
        public string yyname { get; set; }
        public string dperformance { get; set; }
        public string yperformance { get; set; }
        public string ownsale { get; set; }
        public string cover { get; set; }
        public string allperformance { get; set; }
        public string reachratio { get; set; }
    }
    public class OfficePerformance
    {
        public string officename { get; set; }
        public string dperformance { get; set; }
        public string yperformance { get; set; }
        public string ownsale { get; set; }
        public string cover { get; set; }
        public string allperformance { get; set; }
        public string reachratio { get; set; }
        public string officesurplus { get; set; }
    }
    public class PerformanceModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public List<tomb_area> GetYuan()
        {
            return db.tomb_areas.Where(a => a.deleted == 0&&a.type==0).ToList();



        }
        public List<office> GetallOffice()
        {
            List<office> list = db.offices.Where(m => m.deleted == 0).ToList();
            return list;
        }
        public List<user> GetallUser(long uid)
        {
            List<user> list = db.users.Where(m => m.deleted == 0&&m.office_id==uid&&m.type==6).ToList();
            return list;
        }
        public List<user> GetallDUser(long uid)
        {
            List<user> list = db.users.Where(m => m.deleted == 0 &&m.type==7&&m.owner_id==uid).ToList();
            return list;
        }
        public JqDataTableInfo SerchdPerforance(long officename, long yname, long dname, string dstartime, string dendtime, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<user> list = new List<user>();
            List<DPerformance> dlist = new List<DPerformance>();
            if (officename == 0)
            {
                list = db.users.Where(m => m.deleted == 0 &&m.type==7).ToList();
                       
            }
            if (officename != 0 && yname==0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 7&&m.office_id==officename).ToList();
            }
            if (officename != 0 && yname != 0&&dname==0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 7 && m.office_id == officename&&m.owner_id==yname).ToList();
            }
            if (officename != 0 && yname != 0 && dname != 0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 7 && m.office_id == officename && m.owner_id == yname&&m.uid==dname).ToList();
            }
            
            foreach (user us in list)
            {
                List<tomb_purchase> tp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(dstartime)&& m.paytime <= Convert.ToDateTime(dendtime) && m.user_id == us.uid).ToList();
                int price=0;
                foreach (tomb_purchase tpc in tp)
                {
                    price += tpc.paid_price;
                }
                DPerformance dpf = new DPerformance();
                dpf.dname = us.realname;
                dpf.dperformance = price.ToString();
                dlist.Add(dpf);
            }
            res.aaData = dlist;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public JqDataTableInfo Serchdyperformance(long yofficename, long yyname, string ystarttime, string yendtime, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<user> list = new List<user>();
            List<YPerformance> dlist = new List<YPerformance>();
            if (yofficename == 0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 6).ToList();
            }
            if (yofficename != 0 && yyname == 0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 6 && m.office_id == yofficename).ToList();
            }
            if (yofficename != 0 && yyname != 0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 6 && m.office_id == yofficename && m.uid == yyname).ToList();
            }
            


            foreach (user us in list)
            {
                List<tomb_purchase> tp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ystarttime) && m.paytime <= Convert.ToDateTime(yendtime) && m.user_id == us.uid).ToList();
                //员工业绩
                int yprice = 0;
                foreach (tomb_purchase tpc in tp)
                {
                    yprice += tpc.paid_price;
                }
                //代销商业绩
                List<user> lu = db.users.Where(m => m.deleted == 0 & m.owner_id == us.uid).ToList();
                int dprice = 0;
                foreach (user dus in lu)
                {
                    List<tomb_purchase> dtp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ystarttime) && m.paytime <= Convert.ToDateTime(yendtime) && m.user_id == dus.uid).ToList();
                    foreach (tomb_purchase dpc in dtp)
                    {
                        dprice += dpc.paid_price;
                    }
                }
                //自营比例
                string ownsale="";
                if (yprice == 0 && dprice == 0)
                {
                    ownsale = "0";
                }
                else
                {
                    ownsale = Math.Round((double)yprice / ((double)yprice + (double)dprice)*100, 2).ToString(); 
                }
                
                //责任额
                int cover = Convert.ToInt32(us.planamount_permonth);
                //总业绩
                int allperformance = yprice + dprice;
                //达成比例
                string reach = Math.Round(((double)yprice + (double)dprice) / (double)us.planamount_permonth * 100, 2).ToString();
                YPerformance ypf = new YPerformance();
                ypf.allperformance = allperformance.ToString();
                ypf.cover = cover.ToString();
                ypf.dperformance = dprice.ToString();
                ypf.ownsale = ownsale;
                ypf.reachratio = reach;
                ypf.yperformance = yprice.ToString();
                ypf.yyname = us.realname;
                dlist.Add(ypf);
            }
            res.aaData = dlist;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public JqDataTableInfo SerchOfficeperformance(long offname, string ostarttime, string oendtime, int? sEcho)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<office> list = new List<office>();
            List<OfficePerformance> dlist = new List<OfficePerformance>();
            if (offname == 0)
            {
                list = db.offices.Where(m => m.deleted == 0 ).ToList();

            }
            if (offname != 0)
            {
                list = db.offices.Where(m => m.deleted == 0 && m.uid == offname).ToList();
            }


            foreach (office ous in list)
            {
                List<user> olu = db.users.Where(m => m.office_id == ous.uid).ToList();
                int yprice = 0;
                int dprice = 0;
                foreach (user us in olu)
                {
                    List<tomb_purchase> tp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ostarttime) && m.paytime <= Convert.ToDateTime(oendtime) && m.user_id == us.uid).ToList();
                    //员工业绩
                    
                    foreach (tomb_purchase tpc in tp)
                    {
                        yprice += tpc.paid_price;
                    }
                    //代销商业绩
                    List<user> lu = db.users.Where(m => m.deleted == 0 & m.owner_id == us.uid).ToList();
                   
                    foreach (user dus in lu)
                    {
                        List<tomb_purchase> dtp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ostarttime) && m.paytime <= Convert.ToDateTime(oendtime) && m.user_id == dus.uid).ToList();
                        foreach (tomb_purchase dpc in dtp)
                        {
                            dprice += dpc.paid_price;
                        }
                    }
                }
               
                //自营比例
                string ownsale = "";
                if (yprice == 0 && dprice == 0)
                {
                    ownsale = "0";
                }
                else
                {
                    ownsale = Math.Round((double)yprice / ((double)yprice + (double)dprice) * 100, 2).ToString();
                }

                //责任额
                int month = Convert.ToDateTime(ostarttime).Month;
                office offp = db.offices.Where(m => m.deleted == 0 && m.uid == ous.uid).FirstOrDefault();
                string[] offplan = offp.plan_amounts.Split(',');
                int cover = 0;
                if (offplan.Length > 1)
                {
                  cover = Convert.ToInt32(offplan[month - 1]);
                }
                else
                {
                    cover = 0;
                }
                
                //总业绩
                int allperformance = yprice + dprice;
                //达成比例
                string reach = "";
                if (cover == 0)
                {
                    reach = "0";
                }
                else
                {
                    reach = Math.Round(((double)yprice + (double)dprice) / (double)cover * 100, 2).ToString();
                }
                
                //办事处盈余累计
                   //提成
                bonus_coef bc = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "true_mudi_ticheng").FirstOrDefault();
                   //管销
                bonus_coef gbc = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "yingxiaobili").FirstOrDefault();
                   //税金
                bonus_coef sbc = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "shuilv").FirstOrDefault();
                string officesurplus = Math.Round(((double)allperformance * (double)bc.value * (100 - (double)gbc.value) * (double)sbc.value) / (100 * 100 * 100), 2).ToString();
                OfficePerformance ypf = new OfficePerformance();
                ypf.allperformance = allperformance.ToString();
                ypf.cover = cover.ToString();
                ypf.dperformance = dprice.ToString();
                ypf.ownsale = ownsale;
                ypf.reachratio = reach;
                ypf.yperformance = yprice.ToString();
                ypf.officename = ous.name;
                ypf.officesurplus = officesurplus;
                dlist.Add(ypf);
            }
            res.aaData = dlist;
            res.sEcho = sEcho;
            res.iTotalRecords = list.Count();
            return res;
        }
        public bool SendManageOffice()
        {
            bool success = false;
            try
            {
                List<office> list = new List<office>();

                list = db.offices.Where(m => m.deleted == 0).ToList();

                DateTime  timenow = DateTime.Today;

                foreach (office ous in list)
                {
                    List<user> olu = db.users.Where(m => m.office_id == ous.uid).ToList();
                    int yprice = 0;
                    int dprice = 0;
                    foreach (user us in olu)
                    {
                        List<tomb_purchase> tp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= timenow && m.paytime <= timenow.AddHours(24) && m.user_id == us.uid).ToList();
                        //员工业绩

                        foreach (tomb_purchase tpc in tp)
                        {
                            yprice += tpc.paid_price;
                        }
                        //代销商业绩
                        List<user> lu = db.users.Where(m => m.deleted == 0 & m.owner_id == us.uid).ToList();

                        foreach (user dus in lu)
                        {
                            List<tomb_purchase> dtp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= timenow && m.paytime <= timenow.AddHours(24) && m.user_id == dus.uid).ToList();
                            foreach (tomb_purchase dpc in dtp)
                            {
                                dprice += dpc.paid_price;
                            }
                        }
                    }

                    //总业绩
                    int allperformance = yprice + dprice;
                    user use = db.users.Where(m => m.deleted == 0 && m.type == 4 && m.realname == ous.chief).FirstOrDefault();
                    JPushApi.SendPushNotification(Convert.ToString(use.uid), "Performance\n" + ous.chief + ",您办事处今天业绩为" + allperformance.ToString()+"元!");
                }
                success = true;
            
            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public bool SendManageHead()
        {
            bool success = false;
            try
            {
                List<office> list = new List<office>();

                list = db.offices.Where(m => m.deleted == 0).ToList();
                DateTime timenow = DateTime.Today;
                int companyper = 0;
                foreach (office ous in list)
                {
                    List<user> olu = db.users.Where(m => m.office_id == ous.uid).ToList();
                    int yprice = 0;
                    int dprice = 0;
                    foreach (user us in olu)
                    {
                        List<tomb_purchase> tp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= timenow && m.paytime <= timenow.AddHours(24) && m.user_id == us.uid).ToList();
                        //员工业绩

                        foreach (tomb_purchase tpc in tp)
                        {
                            yprice += tpc.paid_price;
                        }
                        //代销商业绩
                        List<user> lu = db.users.Where(m => m.deleted == 0 & m.owner_id == us.uid).ToList();

                        foreach (user dus in lu)
                        {
                            List<tomb_purchase> dtp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= timenow && m.paytime <= timenow.AddHours(24) && m.user_id == dus.uid).ToList();
                            foreach (tomb_purchase dpc in dtp)
                            {
                                dprice += dpc.paid_price;
                            }
                        }
                    }


                    //总业绩
                    int allperformance = yprice + dprice;
                    companyper += allperformance;

                }

                List<user> headuser = db.users.Where(m => m.deleted == 0 && (m.type == 1 || m.type == 2 || m.type == 3)).ToList();
                foreach (user hus in headuser) 
                {
                    JPushApi.SendPushNotification(Convert.ToString(hus.uid), "Performance\n" + hus.realname + ",公司今天业绩为" + companyper.ToString() + "元!");
                }
                
                success = true;

            }
            catch (System.Exception ex)
            {
                success = false;
            }

            return success;
        }
        public List<OfficePerformance> SerchOfficeTOExcel(long offname, string ostarttime, string oendtime)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<office> list = new List<office>();
            List<OfficePerformance> dlist = new List<OfficePerformance>();
            if (offname == 0)
            {
                list = db.offices.Where(m => m.deleted == 0).ToList();

            }
            if (offname != 0)
            {
                list = db.offices.Where(m => m.deleted == 0 && m.uid == offname).ToList();
            }


            foreach (office ous in list)
            {
                List<user> olu = db.users.Where(m => m.office_id == ous.uid).ToList();
                int yprice = 0;
                int dprice = 0;
                foreach (user us in olu)
                {
                    List<tomb_purchase> tp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ostarttime) && m.paytime <= Convert.ToDateTime(oendtime) && m.user_id == us.uid).ToList();
                    //员工业绩

                    foreach (tomb_purchase tpc in tp)
                    {
                        yprice += tpc.paid_price; 

                    }
                    //代销商业绩
                    List<user> lu = db.users.Where(m => m.deleted == 0 & m.owner_id == us.uid).ToList();

                    foreach (user dus in lu)
                    {
                        List<tomb_purchase> dtp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ostarttime) && m.paytime <= Convert.ToDateTime(oendtime) && m.user_id == dus.uid).ToList();
                        foreach (tomb_purchase dpc in dtp)
                        {
                            dprice += dpc.paid_price;
                        }
                    }
                }

                //自营比例
                string ownsale = "";
                if (yprice == 0 && dprice == 0)
                {
                    ownsale = "0";
                }
                else
                {
                    ownsale = Math.Round((double)yprice / ((double)yprice + (double)dprice) * 100, 2).ToString();
                }

                //责任额
                int month = Convert.ToDateTime(ostarttime).Month;
                office offp = db.offices.Where(m => m.deleted == 0 && m.uid == ous.uid).FirstOrDefault();
                string[] offplan = offp.plan_amounts.Split(',');
                int cover = 0;
                if (offplan.Length > 1)
                {
                    cover = Convert.ToInt32(offplan[month - 1]);
                }
                else
                {
                    cover = 0;
                }
                //总业绩
                int allperformance = yprice + dprice;
                //达成比例
                string reach = "";
                if (cover == 0)
                {
                    reach = "0";
                }
                else
                {
                    reach = Math.Round(((double)yprice + (double)dprice) / (double)cover * 100, 2).ToString();
                }

                //办事处盈余累计
                //提成
                bonus_coef bc = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "true_mudi_ticheng").FirstOrDefault();
                //管销
                bonus_coef gbc = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "yingxiaobili").FirstOrDefault();
                //税金
                bonus_coef sbc = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "shuilv").FirstOrDefault();
                string officesurplus = Math.Round(((double)allperformance * (double)bc.value * (100 - (double)gbc.value) * (double)sbc.value) / (100 * 100 * 100), 2).ToString();
                OfficePerformance ypf = new OfficePerformance();
                ypf.allperformance = allperformance.ToString();
                ypf.cover = cover.ToString();
                ypf.dperformance = dprice.ToString();
                ypf.ownsale = ownsale;
                ypf.reachratio = reach;
                ypf.yperformance = yprice.ToString();
                ypf.officename = ous.name;
                ypf.officesurplus = officesurplus;
                dlist.Add(ypf);
            }
            return dlist;
        }
        public List<YPerformance> SerchYToExcel(long yofficename, long yyname, string ystarttime, string yendtime)
        {
            JqDataTableInfo res = new JqDataTableInfo();
            List<user> list = new List<user>();
            List<YPerformance> dlist = new List<YPerformance>();
            if (yofficename == 0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 6).ToList();

            }
            if (yofficename != 0 && yyname == 0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 6 && m.office_id == yofficename).ToList();
            }
            if (yofficename != 0 && yyname != 0)
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 6 && m.office_id == yofficename && m.uid == yyname).ToList();
            }


            foreach (user us in list)
            {
                List<tomb_purchase> tp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ystarttime) && m.paytime <= Convert.ToDateTime(yendtime) && m.user_id == us.uid).ToList();
                //员工业绩
                int yprice = 0;
                foreach (tomb_purchase tpc in tp)
                {
                    yprice += tpc.paid_price;
                }
                //代销商业绩
                List<user> lu = db.users.Where(m => m.deleted == 0 & m.owner_id == us.uid).ToList();
                int dprice = 0;
                foreach (user dus in lu)
                {
                    List<tomb_purchase> dtp = db.tomb_purchases.Where(m => m.deleted == 0 && m.paytime >= Convert.ToDateTime(ystarttime) && m.paytime <= Convert.ToDateTime(yendtime) && m.user_id == dus.uid).ToList();
                    foreach (tomb_purchase dpc in dtp)
                    {
                        dprice += dpc.paid_price;
                    }
                }
                //自营比例
                string ownsale = "";
                if (yprice == 0 && dprice == 0)
                {
                    ownsale = "0";
                }
                else
                {
                    ownsale = Math.Round((double)yprice / ((double)yprice + (double)dprice) * 100, 2).ToString();
                }

                //责任额
                int cover = Convert.ToInt32(us.planamount_permonth);
                //总业绩
                int allperformance = yprice + dprice;
                //达成比例
                string reach = Math.Round(((double)yprice + (double)dprice) / (double)us.planamount_permonth * 100, 2).ToString();
                YPerformance ypf = new YPerformance();
                ypf.allperformance = allperformance.ToString();
                ypf.cover = cover.ToString();
                ypf.dperformance = dprice.ToString();
                ypf.ownsale = ownsale;
                ypf.reachratio = reach;
                ypf.yperformance = yprice.ToString();
                ypf.yyname = us.realname;
                dlist.Add(ypf);
            }
            return dlist;
        }

        public string AddPerformance(string chengbanren, string chengphone, string buyname, string buyphone, string muqu, string pai, string hao, string guanxi1,
   string mozhe1,
   string shengri1,
   string jiri1,
   string guanxi2,
   string mozhe2,
   string shengri2,
   string jiri2,
   string buytime,
   string paijia,
   string chengjiaojia)
        {
            string res = "ok";
            user u = db.users.Where(a => a.realname == chengbanren && a.phone == chengphone && a.deleted == 0).SingleOrDefault();
            client c = db.clients.Where(a => a.realname == buyname && a.phone == buyphone && a.deleted == 0).SingleOrDefault();

            long mu = long.Parse(muqu);
            int paihao = int.Parse(pai);
            string num = hao;
            grave_site gr = db.grave_sites.Where(a => a.row_number == paihao && a.tombarea_id == mu && a.number == num && a.deleted == 0).SingleOrDefault();
            long muid = gr.uid;
            bool b = canbuy(buyname, buyphone, muid);
            if (b == true)
            {
                gr.client_id = c.uid;
                db.SubmitChanges();
                tomb_purchase tp = new tomb_purchase();
                tp.client_id = c.uid;
                tp.tombsite_id = gr.uid;
                tp.paid_price = int.Parse(chengjiaojia);
                tp.user_id = u.uid;
                tp.paytime = DateTime.Parse(buytime);
                tp.price = int.Parse(paijia);
                tp.deleted = 0;
                db.tomb_purchases.InsertOnSubmit(tp);
                db.SubmitChanges();
                if (guanxi1 != "" && mozhe1 != "" && shengri1 != "" && jiri1 != "")
                {
                    client_parent cp = new client_parent();
                    cp.client_id = c.uid;
                    cp.deathday = DateTime.Parse(jiri1);
                    cp.birthday = DateTime.Parse(shengri1);
                    cp.name = mozhe1;
                    cp.deleted = 0;
                    cp.relation = guanxi1;
                    cp.tombsite_id = gr.uid;
                    db.client_parents.InsertOnSubmit(cp);
                    db.SubmitChanges();


                }
                if (guanxi2 != "" && mozhe2 != "" && shengri2 != "" && jiri2 != "")
                {
                    client_parent cp = new client_parent();
                    cp.client_id = c.uid;
                    cp.deathday = DateTime.Parse(jiri2);
                    cp.birthday = DateTime.Parse(shengri2);
                    cp.name = mozhe2;
                    cp.deleted = 0;
                    cp.relation = guanxi2;
                    db.client_parents.InsertOnSubmit(cp);
                    db.SubmitChanges();


                }
            }
            else
            {
                res = "很抱歉，此墓位已经被他人购买或者预约保留，请核实或者选择其他墓位！";
            }
            return res;
        }
        public bool canbuy(string name, string phone, long muid)
        {
            environ e = new environ();
            e = db.environs.Where(a => a.name == "mudiyuliushijian").SingleOrDefault();
            int t = (int)e.value;
            bool b = true;
            grave_site gr = db.grave_sites.Where(a => a.uid == muid).FirstOrDefault();
            long? mcid = gr.client_id;
            tomb_reserve tr = db.tomb_reserves.Where(a => a.tombsite_id == muid && a.reserve_time.AddHours(t) > DateTime.Now && a.deleted == 0).FirstOrDefault();
            if (mcid == null)
            {
                if (tr == null)
                {//没有找到短期，看看有没有长期
                    deposit d = db.deposits.Where(a => a.tombsite_id == muid && a.endtime > DateTime.Now && a.deleted == 0).FirstOrDefault();
                    if (d == null)
                    {
                        b = true;
                    }
                    else
                    {//找到长期的 看看是不是他
                        if (d.name == name && d.phone == phone)
                        {
                            b = true;
                        }
                        else
                        {
                            b = false;
                        }

                    }
                }
                else
                {//找到短期
                    if (tr.phone == phone && tr.name == name)
                    {//看看短期的是不是他eeee
                        b = true;
                    }
                    else
                    {
                        b = false;
                    }

                }
            }
            else
            {
                b = false;
            }


            return b;
        }

    }
}
