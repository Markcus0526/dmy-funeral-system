using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections.Specialized;
using System.Security.Cryptography;
using System.Text;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Hosting;
using System.IO;
using System.Web.Security;

namespace BinZangBackend.Models
{
    public class DaiXiaoShang
    {
        public long id { get; set; }
        public String name { get; set; }
        public String realname { get; set; }
        public String phone { get; set; }
        public String office { get; set; }
        public String owner { get; set; }
        public int? duty { get; set; } 
    }
    public class LingDao
    {
        public long id { get; set; }
        public String name { get; set; }
        public String realname { get; set; }
        public String phone { get; set; }
        public String office { get; set; }
        public String types { get; set; }
        public int? duty { get; set; }
    }
    public class HouTaiYongHu
    {
        public long id { get; set; }
        public String name { get; set; } 
        public String realname { get; set; }
        public String phone { get; set; }
    }
    public class OldCustom
    {
        public long id { get; set; }
        public String name { get; set; }
        public String owner_name { get; set; }
        public String realname { get; set; }
        public String phone { get; set; }
    }
    public class StaffInfo
    {
        public long id { get; set; }
        public String name { get; set; }
        public String office { get; set; }
        public String realname { get; set; }
        public String duty { get; set; }
        public String phone { get; set; }
    }
    public class ClientTomb
    {
        public int price { get; set; }
        public String guanxi1 { get; set; }
        public String guanxi2 { get; set; }
        public String xingming1 { get; set; }
        public String xingming2 { get; set; }
        public String danchen1 { get; set; }
        public String danchen2 { get; set; }
        public String jiri1 { get; set; }
        public String jiri2 { get; set; }
    }
    public class ManagePersonModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public List<DaiXiaoShang> FindAllDaiXiaoShang(List<DaiXiaoShang> list, string name, string banshichu, string phone, string owner_name)
        {
            if (banshichu !="0")
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 7 && m.office_id == long.Parse(banshichu))
                                .Select(s => new DaiXiaoShang
                                {
                                    id = s.uid,
                                    name = s.name,
                                    realname = s.realname,
                                    phone = s.phone,
                                    office = db.offices.Where(h => h.deleted == 0 && h.uid == s.office_id).FirstOrDefault().name,
                                    owner = db.users.Where(k => k.deleted == 0 && k.uid == s.owner_id).FirstOrDefault().name,
                                    duty = s.planamount_permonth
                                })
                                .ToList();
            }
            else
            {
                list = db.users.Where(m => m.deleted == 0 && m.type == 7)
                                .Select(s => new DaiXiaoShang
                                {
                                    id = s.uid,
                                    name = s.name,
                                    realname = s.realname,
                                    phone = s.phone,
                                    office = db.offices.Where(h => h.deleted == 0 && h.uid == s.office_id).FirstOrDefault().name,
                                    owner = db.users.Where(k => k.deleted == 0 && k.uid == s.owner_id).FirstOrDefault().name,
                                    duty = s.planamount_permonth
                                })
                                .ToList();
            }
            if (name!=""&&name!=null)
            {
                list = list.Where(m => m.name.Contains(name)).ToList();
            }
            if (phone != "" && phone != null)
            {
                list = list.Where(m => m.phone.Contains(phone)).ToList();
            }
            if (owner_name != "" && owner_name != null)
            {
                list = list.Where(m => m.owner.Contains(owner_name)).ToList();
            }
            return list.OrderByDescending(m=>m.id).ToList();
        }


        public List<user> FindEmpByOffice(string office)
        {
            List<user> list = db.users.Where(m => m.deleted == 0&&m.type==6).ToList();
            if (office=="0")
            {
            }
            else
            {
                list = list.Where(m => m.office_id == long.Parse(office)).ToList();
            }
            return list;
        }
        public static string GetMD5Hash(string value)
        {
            MD5 md5Hasher = MD5.Create();
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(value));
            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }
            return sBuilder.ToString();
        }
        public string AddDaiXiaoShangInfo(string img, string name, string real_name, 
            string phone, string owner_name, string office, string weixin, string qqname ,string password)
        {
            string status = "";
            try
            {
                user userinfo = new user();
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.password = GetMD5Hash(password);
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.type = 7;
                userinfo.owner_id = long.Parse(owner_name);
                userinfo.createtime = DateTime.Now;
                userinfo.office_id = db.users.Where(m => m.deleted == 0 && m.uid == long.Parse(owner_name)).FirstOrDefault().office_id;
                db.users.InsertOnSubmit(userinfo);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;  
        }

        public user FindOneDaiXiaoShang(long id)
        {
            user info=db.users.Where(m=>m.deleted==0&&m.uid==id).FirstOrDefault();
            return info;
        }
        public String FindOneStaffByID(long id)
        {
            office info=db.offices.Where(m=>m.deleted==0&&m.uid==id).FirstOrDefault();
            return info.name;
        }
        public string EditDaiXiaoShangInfo(string id, string img, string name, string real_name, string phone, string owner_name, string office, string weixin, string qqname)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Where(m => m.deleted == 0 && m.uid == long.Parse(id)).FirstOrDefault();
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.type = 7;
                userinfo.owner_id = long.Parse(owner_name);
                userinfo.office_id = db.users.Where(m => m.deleted == 0 && m.uid == long.Parse(owner_name)).FirstOrDefault().office_id;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;  
        }

        internal string DeletedDaiXiaoShang(long id)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Where(m => m.deleted == 0 && m.uid ==id).FirstOrDefault();
                userinfo.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;  
        }

        internal List<LingDao> FindAllLingDao(string name, string type, string phone, List<LingDao> list)
        {
            List<user> infos = db.users.Where(m => m.deleted == 0 && (m.type == 1 || m.type == 2 || m.type == 3 )).ToList();
            if (name!=null&&name!="")
            {
                infos= infos.Where(m=>m.name.Contains(name)).ToList();
            }
             if (type!="0")
            {
                infos= infos.Where(m=>m.type==int.Parse(type)).ToList();
            }
             if (phone!=null&&phone!="")
            {
                infos= infos.Where(m=>m.phone.Contains(phone)).ToList();
            }
            for (int i = 0; i < infos.Count;i++ )
            {
                LingDao ling = new LingDao();
                ling.name = infos[i].name;
                ling.id = infos[i].uid;
                if (infos[i].office_id==null)
                {
                    ling.office = "总部";
                }
                else if (infos[i].office_id!=0)
                {
                    ling.office = db.offices.Where(m => m.deleted == 0 && m.uid == infos[i].office_id).FirstOrDefault().name;
                }
                
                ling.phone = infos[i].phone;
                ling.realname = infos[i].realname;
                ling.duty = infos[i].planamount_permonth;
                if (infos[i].type==1)
                {
                    ling.types = "董事长";
                }
                if (infos[i].type == 2)
                {
                    ling.types = "总经理";
                }
                if (infos[i].type == 3)
                {
                    ling.types = "副总经理";
                }
                /*if (infos[i].type == 4)
                {
                    ling.types = "办事处主任";
                }
                if (infos[i].type == 5)
                {
                    ling.types = "办事处副主任";
                }*/
                list.Add(ling);
            }
            return list;
        }

        internal string AddLingDaoInfo(string img, string name, string real_name, string phone, string office, string weixin, string qqname, string password, string type)
        {
            string status = "";
            try
            {
                user userinfo = new user();
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.password = GetMD5Hash(password); ;
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.type = byte.Parse(type);
                userinfo.createtime = DateTime.Now;
                if (office=="0")
                {

                }else{
                userinfo.office_id =long.Parse(office) ;
                }
               
                db.users.InsertOnSubmit(userinfo);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;  
        }

        internal List<LingDao> FindAllZhuRen(string name, string banshichu, string type, string phone, List<LingDao> list)
        {
            List<user> infos = db.users.Where(m => m.deleted == 0 && (m.type == 4 || m.type == 5)).ToList();
            if (name != null && name != "")
            {
                infos = infos.Where(m => m.name.Contains(name)).ToList();
            }
            if (type != "0")
            {
                infos = infos.Where(m => m.type == int.Parse(type)).ToList();
            }
            if (banshichu!="0")
            {
                infos = infos.Where(m => m.office_id == int.Parse(banshichu)).ToList();
            }
            if (phone != null && phone != "")
            {
                infos = infos.Where(m => m.phone.Contains(phone)).ToList();
            }
            for (int i = 0; i < infos.Count; i++)
            {
                LingDao ling = new LingDao();
                ling.name = infos[i].name;
                ling.id = infos[i].uid;
                if (infos[i].office_id == null)
                {
                    ling.office = "总部";
                }
                else if (infos[i].office_id != 0)
                {
                    ling.office = db.offices.Where(m => m.deleted == 0 && m.uid == infos[i].office_id).FirstOrDefault().name;
                }

                ling.phone = infos[i].phone;
                ling.realname = infos[i].realname;
                ling.duty = infos[i].planamount_permonth;
                if (infos[i].type == 4)
                {
                    ling.types = "办事处主任";
                }
                if (infos[i].type == 5)
                {
                    ling.types = "办事处副主任";
                }

                /*if (infos[i].type == 4)
                {
                    ling.types = "办事处主任";
                }
                if (infos[i].type == 5)
                {
                    ling.types = "办事处副主任";
                }*/
                list.Add(ling);
            }
            return list;
        }

        internal List<HouTaiYongHu> FindAllHouTaiYongHu(List<HouTaiYongHu> list)
        {
            List<user> infos = db.users.Where(m => m.deleted == 0 && m.type == 0).ToList();
            for (int i = 0; i < infos.Count; i++)
            {
                HouTaiYongHu ling = new HouTaiYongHu();
                ling.name = infos[i].name;
                ling.id = infos[i].uid;
                ling.phone = infos[i].phone;
                ling.realname = infos[i].realname;
                list.Add(ling);
            }
            return list;
        }

        internal List<OldCustom> FindAllOldCustom(List<OldCustom> list, string name, string phone)
        {
            List<client> infos = db.clients.Where(m => m.deleted == 0).ToList();
            if (name != null && name != "")
            {
                infos = infos.Where(m => m.name.Contains(name)).OrderByDescending(m => m.uid).ToList();
            }
            if (phone != null && phone != "")
            {
                infos = infos.Where(m => m.phone.Contains(phone)).OrderByDescending(m=>m.uid).ToList();
            }
            for (int i = 0; i < infos.Count; i++)
            {
                OldCustom ling = new OldCustom();
                ling.name = infos[i].name;
                ling.id = infos[i].uid;

                ling.phone = infos[i].phone;
                ling.realname = infos[i].realname;
                ling.owner_name = db.users.Where(m =>m.uid == infos[i].owner_id).FirstOrDefault().name;
                
                list.Add(ling);
            }
            return list;
        }

        internal List<StaffInfo> FindAllStaff(List<StaffInfo> list, string name, string phone, string banshichu)
        {
            List<user> infos = db.users.Where(m => m.deleted == 0&&m.type==6).ToList();
            if (name != null && name != "")
            {
                infos = infos.Where(m => m.name.Contains(name)).OrderByDescending(m=>m.uid).ToList();
            }
            if (phone != null && phone != "")
            {
                infos = infos.Where(m => m.phone.Contains(phone)).OrderByDescending(m => m.uid).ToList();
            }
            if (banshichu!="0")
            {
                infos = infos.Where(m => m.office_id == long.Parse(banshichu)).OrderByDescending(m => m.uid).ToList();
            }
            for (int i = 0; i < infos.Count; i++)
            {
                StaffInfo ling = new StaffInfo();
                ling.name = infos[i].name;
                ling.id = infos[i].uid;
                ling.duty = infos[i].planamount_permonth.ToString();
                ling.phone = infos[i].phone;
                ling.realname = infos[i].realname;
                ling.office = db.offices.Where(m => m.deleted == 0 && m.uid == infos[i].office_id).FirstOrDefault().name;

                list.Add(ling);
            }
            return list;
        }

        internal List<OldCustom> FindOldCustomById(List<OldCustom> list, String id)
        {
            List<OldCustom> clineinfo = new List<OldCustom>();
            clineinfo.AddRange(db.users.Where(m => m.deleted == 0 && m.owner_id == long.Parse(id))
                .Select(s => new OldCustom
                {
                    name = s.name,
                    id = s.uid,
                    phone = s.phone,
                    realname = s.realname,
                    owner_name = "代销商"
                }).ToList());
          
            clineinfo.AddRange(db.clients.Where(m => m.deleted == 0 && m.owner_id == long.Parse(id))
                .Select(s => new OldCustom
                {
                    name=s.name,
                    id=s.uid,
                    phone=s.phone,
                    realname=s.realname,
                    owner_name="旧客户"
                }).ToList());
            return clineinfo;
        }

        internal string AddBanShiChuInfo(string img, string name, string real_name, string phone, string banshichu, string weixin, string qqname, string password, string type, string duty)
        {
            string status = "";
            try
            {
                user userinfo = new user();
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.password = GetMD5Hash(password); ;
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.qq = qqname;
                userinfo.planamount_permonth = int.Parse(duty);
                userinfo.weixin = weixin;
                userinfo.type = byte.Parse(type);
                userinfo.createtime = DateTime.Now;
                userinfo.office_id = long.Parse(banshichu);
                db.users.InsertOnSubmit(userinfo);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string EditBanShiChuZhuRenInfo(string id, string img, string name, string real_name, string phone, string type, string banshichu, string weixin, string qqname,string duty)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.planamount_permonth = int.Parse(duty);
                userinfo.type = byte.Parse(type);
                userinfo.createtime = DateTime.Now;
                userinfo.office_id = long.Parse(banshichu);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string DeletedDaBanShiChuZhuRen(long id)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Single(m => m.deleted == 0 && m.uid ==id);
                userinfo.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status;
        }

        internal string EditLingDaoInfo(string id, string img, string name, string real_name, string phone, string type, string weixin, string qqname)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.type = byte.Parse(type);
                userinfo.createtime = DateTime.Now;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string DeletedDLingDao(long id)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Single(m => m.deleted == 0 && m.uid == id);
                userinfo.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status;
        }

        internal string AddStaffInfo(string img, string name, string real_name, string phone, string banshichu, string weixin, string qqname, string password, string duty)
        {
            string status = "";
            try
            {
                user userinfo = new user();
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.password = GetMD5Hash(password); ;
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.type = 6;
                userinfo.planamount_permonth = int.Parse(duty);
                userinfo.createtime = DateTime.Now;
                userinfo.office_id = long.Parse(banshichu);
                db.users.InsertOnSubmit(userinfo);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string EditStaffInfo(string id, string img, string name, string real_name, string phone, string office, string duty)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                userinfo.imgurl = img;
                userinfo.name = name;
                userinfo.phone = phone;
                userinfo.realname = real_name;
                userinfo.createtime = DateTime.Now;
                userinfo.planamount_permonth = int.Parse(duty);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string DeletedStaff(long id)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Single(m => m.deleted == 0 && m.uid == id);
                userinfo.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status;
        }

        internal string AddHouTaiYouHuInfo(string name, string real_name, string phone, string weixin, string qqname, string password, string role)
        {

            string status = "";
            try
            {
                admin_right right = new admin_right();
                right.role = role;
                right.createtime = DateTime.Now;
                right.deleted = 0;
                db.admin_rights.InsertOnSubmit(right);
                db.SubmitChanges();
                user userinfo = new user();
                userinfo.name = name;
                userinfo.realname = real_name;
                userinfo.phone = phone;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.adminright_id = right.uid;
                userinfo.imgurl = "Content/Images/default_img.jpg";
                userinfo.deleted = 0;
                userinfo.createtime = DateTime.Now;
                userinfo.password = GetMD5Hash(password); ;
                db.users.InsertOnSubmit(userinfo);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status; 
        }

        internal admin_right FindRightById(long p)
        {
            admin_right info = db.admin_rights.Where(m => m.deleted == 0 && m.uid == p).FirstOrDefault();
            return info;
        }

        internal string EditHouTaiYouHuInfo(string name, string real_name, string phone, string weixin, string qqname, string id, string role)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Where(m=>m.deleted==0&&m.uid==long.Parse(id)).FirstOrDefault();
                userinfo.name = name;
                userinfo.realname = real_name;
                userinfo.phone = phone;
                userinfo.qq = qqname;
                userinfo.weixin = weixin;
                userinfo.imgurl = "Content/Images/default_img.jpg";
                userinfo.deleted = 0;
                admin_right right = db.admin_rights.Where(m => m.deleted == 0 && m.uid == userinfo.adminright_id).FirstOrDefault();
                right.role = role;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status; 
        }

        internal string DeletedHouTaiYongHu(long id)
        {
            string status = "";
            try
            {
                user userinfo = db.users.Where(m => m.deleted == 0 && m.uid == id).FirstOrDefault();
                userinfo.deleted = 0;
                userinfo.imgurl = "Content/Images/default_img.jpg";
                userinfo.deleted = 0;
                admin_right right = db.admin_rights.Where(m => m.deleted == 0 && m.uid == userinfo.adminright_id).FirstOrDefault();
                right.deleted = 0;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status; 
        }

        internal string AddOldCustomInfo(string real_name, string phone, string tombnum, string tombjiage, string paiweinum, string paiweijiage, string qinrenguanxi1, String qinrenguanxi2, string qinrenname1, string qinrenname2, string qinrendajchen1, string qinrendanchen2, string qinrenjiri1, string qinrenjiri2, string office, string owner_name, string daixiao_name,string paiweichengjiao,string tombchengjiao)
        {
          
            string status = "";
            try
            {
                client info = new client();
                info.name = real_name;
                info.realname = real_name;
                info.password = GetMD5Hash("123456");
                info.imgurl = "Content/Images/default_img.jpg";
                info.phone = phone;
                if (daixiao_name=="0")
                {
                    info.owner_id = long.Parse(owner_name);
                } 
                else
                {
                    info.owner_id = long.Parse(daixiao_name);
                }
                
                db.clients.InsertOnSubmit(info);
                db.SubmitChanges();
                grave_site tomb = new grave_site();
                grave_tablet paiwei = new grave_tablet();
                if (tombnum != "0" && paiweinum != "0")
                {
                    tomb = db.grave_sites.Single(m => m.uid == long.Parse(tombnum));
                    tomb.client_id = info.uid;
                    paiwei = db.grave_tablets.Single(m => m.uid == long.Parse(paiweinum));
                    paiwei.client_id = info.uid;
                }
                if (tombnum != "0" && paiweinum == "0")
                {
                    tomb = db.grave_sites.Single(m => m.uid == long.Parse(tombnum));
                    tomb.client_id = info.uid;
                }
                if (tombnum == "0" && paiweinum != "0")
                {
                    paiwei = db.grave_tablets.Single(m => m.uid == long.Parse(paiweinum));
                    paiwei.client_id = info.uid;
                }
                
                if (qinrenname1 != "" && qinrenname1 != null)
                {
                    client_parent parent1 = new client_parent();
                    parent1.name = qinrenname1;
                    parent1.relation = qinrenguanxi1;
                    parent1.tombsite_id = tomb.uid;
                    parent1.client_id = info.uid;
                    parent1.deathday = DateTime.Parse(qinrenjiri1);
                    parent1.birthday = DateTime.Parse(qinrendajchen1);
                    db.client_parents.InsertOnSubmit(parent1);
                }
                if (qinrenname2 != "" && qinrenname2 != null)
                {
                    client_parent parent1 = new client_parent();
                    parent1.name = qinrenname2;
                    parent1.relation = qinrenguanxi2;
                    parent1.tombsite_id = tomb.uid;
                    parent1.client_id = info.uid;
                    parent1.deathday = DateTime.Parse(qinrenjiri2);
                    parent1.birthday = DateTime.Parse(qinrendanchen2);
                    db.client_parents.InsertOnSubmit(parent1);
                }
                db.SubmitChanges();
                if (tombnum != "0" && paiweinum != "0")
                {
                    tomb_purchase tp = new tomb_purchase();
                    tp.client_id = info.uid;
                    tp.deleted = 0;
                    tp.paid_price = Convert.ToInt32(tombjiage);
                    tp.price = Convert.ToInt32(tombchengjiao);
                    tp.paytime = DateTime.Now;
                    tp.tombsite_id = Convert.ToInt64(tombnum);
                    tp.tombtablet_id = Convert.ToInt64(paiweinum);
                    if (daixiao_name == "0")
                    {
                        tp.user_id = long.Parse(owner_name);
                    }
                    else
                    {
                        tp.user_id = long.Parse(daixiao_name);
                    }
                    db.tomb_purchases.InsertOnSubmit(tp);
                    db.SubmitChanges();
                    tomb_purchase tp2 = new tomb_purchase();
                    tp2.client_id = info.uid;
                    tp2.deleted = 0;
                    tp2.paid_price = Convert.ToInt32(paiweijiage);
                    tp2.price = Convert.ToInt32(paiweichengjiao);
                    tp2.paytime = DateTime.Now;
                    tp2.tombsite_id = Convert.ToInt64(tombnum);
                    tp2.tombtablet_id = Convert.ToInt64(paiweinum);
                    if (daixiao_name == "0")
                    {
                        tp2.user_id = long.Parse(owner_name);
                    }
                    else
                    {
                        tp2.user_id = long.Parse(daixiao_name);
                    }
                    db.tomb_purchases.InsertOnSubmit(tp2);
                    db.SubmitChanges();
                }
                if (tombnum != "0" && paiweinum == "0")
                {
                    tomb_purchase tp = new tomb_purchase();
                    tp.client_id = info.uid;
                    tp.deleted = 0;
                    tp.paid_price = Convert.ToInt32(tombjiage);
                    tp.price = Convert.ToInt32(tombchengjiao);
                    tp.paytime = DateTime.Now;
                    tp.tombsite_id = Convert.ToInt64(tombnum);
                    tp.tombtablet_id = Convert.ToInt64(paiweinum);
                    if (daixiao_name == "0")
                    {
                        tp.user_id = long.Parse(owner_name);
                    }
                    else
                    {
                        tp.user_id = long.Parse(daixiao_name);
                    }
                    db.tomb_purchases.InsertOnSubmit(tp);
                    db.SubmitChanges();
                }
                if (tombnum == "0" && paiweinum != "0")
                {
                    tomb_purchase tp = new tomb_purchase();
                    tp.client_id = info.uid;
                    tp.deleted = 0;
                    tp.paid_price = Convert.ToInt32(paiweijiage);
                    tp.price = Convert.ToInt32(paiweichengjiao);
                    tp.paytime = DateTime.Now;
                    tp.tombsite_id = Convert.ToInt64(tombnum);
                    tp.tombtablet_id = Convert.ToInt64(paiweinum);
                    if (daixiao_name == "0")
                    {
                        tp.user_id = long.Parse(owner_name);
                    }
                    else
                    {
                        tp.user_id = long.Parse(daixiao_name);
                    }
                    db.tomb_purchases.InsertOnSubmit(tp);
                    db.SubmitChanges();
                }
               
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "旧客户添加失败,请检查后重新操作";
            }
            return status; 
           
        }

        internal List<grave_site> FindTombList()
        {
            List<grave_site> list=new List<grave_site>();
           list = db.grave_sites.Where(m => m.deleted == 0 && (m.client_id == null || m.client_id==0)).ToList();
            return list;
        }

        internal List<grave_tablet> FindPaiweiList()
        {
            List<grave_tablet> list = new List<grave_tablet>();
            list = db.grave_tablets.Where(m => m.deleted == 0 && (m.client_id == null || m.client_id == 0)).ToList();
            return list;
        }

        internal List<user> FindOwnerList()
        {
            List<user> list = new List<user>();
            list = db.users.Where(m => m.deleted == 0 && m.type==6).ToList();
            return list;
        }

        internal ClientTomb FindPriceByTomb(string id)
        {
            ClientTomb clienttomb = new ClientTomb();
            grave_site tomb = db.grave_sites.Single(m => m.uid==long.Parse(id));
            List<client_parent> list = db.client_parents.Where(m => m.deleted == 0 && m.tombsite_id == long.Parse(id)).ToList();
            clienttomb.price = tomb.price;
            if (list.Count<1)
            {
                clienttomb.guanxi1 = "";
                clienttomb.guanxi2 = "";
                clienttomb.xingming1 = "";
                clienttomb.xingming2 = "";
                clienttomb.danchen1 = "";
                clienttomb.danchen2 = "";
                clienttomb.jiri1 = "";
                clienttomb.jiri2= "";
                
            }
            if (list.Count == 1)
            {
                clienttomb.guanxi1 = list[0].relation;
                clienttomb.guanxi2 = "";
                clienttomb.xingming1 = list[0].name;
                clienttomb.xingming2 = "";
                clienttomb.danchen1 = list[0].birthday.ToString();
                clienttomb.danchen2 = "";
                clienttomb.jiri1 =list[0].deathday.ToString();
                clienttomb.jiri2 = "";

            }
            if (list.Count ==2)
            {
                clienttomb.guanxi1 = list[0].relation;
                clienttomb.guanxi2 = list[1].relation;
                clienttomb.xingming1 = list[0].name;
                clienttomb.xingming2 = list[1].name;
                clienttomb.danchen1 = list[0].birthday.ToString();
                clienttomb.danchen2 = list[1].birthday.ToString();
                clienttomb.jiri1 = list[0].deathday.ToString();
                clienttomb.jiri2 = list[1].deathday.ToString();

            }

            return clienttomb;
        }

        internal grave_tablet FindPriceByPaiwei(string id)
        {
            grave_tablet paiwei = db.grave_tablets.Single(m =>m.uid == long.Parse(id));
            return paiwei;
        }

        internal client FindOneOldCustom(long id)
        {
            client tomb = db.clients.Single(m => m.uid == id);
            return tomb;  
        }

        internal List<grave_site> FindTombList1(long p)
        {
            List<grave_site> tomb = db.grave_sites.Where(m =>m.client_id!=null&& m.client_id == p).ToList();
            return tomb;  
        }

        internal List<grave_tablet> FindPaiweiList1(long p)
        {
            List<grave_tablet> paiwei = db.grave_tablets.Where(m => m.client_id != null).ToList();
            paiwei = paiwei.Where(m =>m.client_id == p).ToList();
            return paiwei;
        }

        internal List<client_parent> FindClientParrent(long p)
        {
            List<client_parent> info = db.client_parents.Where(m => m.deleted == 0 && m.tombsite_id == p).ToList();
            return info;
        }

        internal string DeletedOldCustom(long id)
        {
            string status = "";
            try
            {
                grave_tablet paiwei = db.grave_tablets.Where(m => m.deleted == 0 && m.client_id == id).FirstOrDefault();
                if (paiwei!=null)
                {
                    paiwei.client_id = null;
                    db.SubmitChanges();
                }
                grave_site tomb = db.grave_sites.Where(m => m.deleted == 0 && m.client_id == id).FirstOrDefault();
                if (tomb!=null)
                {
                    
                    tomb.client_id = null;
                    db.SubmitChanges();
                }
                
                List<client_parent> parent1 = db.client_parents.Where(m => m.deleted == 0 && m.client_id == id).ToList();
                if (parent1.Count>0)
                {
                    for (int i = 0; i < parent1.Count; i++)
                    {
                        client_parent parent2 = db.client_parents.Single(m => m.deleted == 0 && m.uid == parent1[i].uid);
                        parent2.deleted = 1;
                    }
                    db.SubmitChanges();
                }
              
                client clients = db.clients.Single(m => m.deleted == 0 && m.uid == id);
                clients.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status;  
        }

        internal string EditOldCustomInfo(string real_name, string id, string phone, string tombnum, string tombjiage, 
            string paiweinum, string paiweijiage, string qinrenguanxi1, String qinrenguanxi2, string qinrenname1, string qinrenname2, string qinrendanchen1, string qinrendanchen2, string qinrenjiri1, string qinrenjiri2, string office, string owner_name)
        {
            string status = "";
            try
            {
                client info = db.clients.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                info.name = real_name;
                info.realname = real_name;
                info.imgurl = "Content/Images/default_img.jpg";
                info.phone = phone;
                info.owner_id = long.Parse(owner_name);
                db.SubmitChanges();
                grave_site tomb = db.grave_sites.Where(m => m.deleted == 0 && m.uid == long.Parse(tombnum)).FirstOrDefault();
                List<client_parent> parentinfo = db.client_parents.Where(m => m.deleted == 0 && m.tombsite_id==tomb.uid).ToList();
               if (qinrenname1 != "" && qinrenname1 != null)
                    {
                        
                        if (parentinfo.Count < 1)
                        {
                            client_parent parent2 = new client_parent();
                            parent2.name = qinrenname1;
                            parent2.relation = qinrenguanxi1;
                            parent2.tombsite_id = tomb.uid;
                            parent2.client_id = info.uid;
                            parent2.deathday = DateTime.Parse(qinrenjiri1);
                            parent2.birthday = DateTime.Parse(qinrendanchen1);
                            db.client_parents.InsertOnSubmit(parent2);
                        }
                        else
                        {
                            client_parent parent2 = db.client_parents.Single(m => m.deleted == 0 && m.uid == parentinfo[0].uid);
                            parent2.name = qinrenname1;
                            parent2.relation = qinrenguanxi1;
                            parent2.tombsite_id = tomb.uid;
                            parent2.client_id = info.uid;
                            parent2.deathday = DateTime.Parse(qinrenjiri1);
                            parent2.birthday = DateTime.Parse(qinrendanchen1);
                        }
                    }
                    if (qinrenname2 != "" && qinrenname2 != null)
                    {
                        if (parentinfo.Count < 2)
                        {
                            client_parent parent1 = new client_parent();
                            parent1.name = qinrenname2;
                            parent1.relation = qinrenguanxi2;
                            parent1.tombsite_id = tomb.uid;
                            parent1.client_id = info.uid;
                            parent1.deathday = DateTime.Parse(qinrenjiri2);
                            parent1.birthday = DateTime.Parse(qinrendanchen2);
                            db.client_parents.InsertOnSubmit(parent1);
                        }
                        else
                        {
                            client_parent parent1 = db.client_parents.Single(m => m.deleted == 0 && m.uid == parentinfo[1].uid);
                            parent1.name = qinrenname2;
                            parent1.relation = qinrenguanxi2;
                            parent1.tombsite_id = tomb.uid;
                            parent1.client_id = info.uid;
                            parent1.deathday = DateTime.Parse(qinrenjiri2);
                            parent1.birthday = DateTime.Parse(qinrendanchen2);
                        }
                    }
                
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新操作";
            }
            return status;
        }

        internal String FindOfficeByid(long? id)
        {
            String offis = db.offices.Where(m => m.deleted == 0 && m.uid == (long)id).FirstOrDefault().name;
            return offis;
        }
    }
}
