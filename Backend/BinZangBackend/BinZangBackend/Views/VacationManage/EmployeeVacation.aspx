<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>员工休假管理</title>
        <script src="/Scripts/dhtmlxscheduler.js" type="text/javascript"></script>
       <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css" />
        <link href="../../Scripts/dhtmlxscheduler_flat.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../../Scripts/ext/dhtmlxscheduler_key_nav.js"></script>
        <script src="/Scripts/ext/dhtmlxscheduler_limit.js" type="text/javascript"></script>
        <script src="/Scripts/ext/dhtmlxscheduler_timeline.js" type="text/javascript" charset="utf-8"></script>
        <script src="/Scripts/ext/dhtmlxscheduler_collision.js" type="text/javascript"></script>
        <script src="/Scripts/ext/dhtmlxscheduler_minical.js" type="text/javascript"></script>
        <script src="/Scripts/locale/locale_cn.js" type="text/javascript"></script>
        <script src="/Scripts/locale/recurring/locale_recurring_cn.js" type="text/javascript"></script>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
   

        <style type="text/css">
            .dhx_scheduler_month .dhx_marked_timespan
            {
                display: block;
            }
            .holiday
            {
                cursor: not-allowed;
            }
        </style>
        <style media="screen">
            html, body
            {
                margin: 0px;
                padding: 0px;
               height: 100%;
            }
            
            .dhx_cal_event_clear.常规保养
            {
                color: orange !important;
            }
            .red_section
            {
                background-color: red;
                opacity: 0.25;
                filter: alpha(opacity=25);
            }
            .yellow_section
            {
                background-color: #ffa749;
                opacity: 0.25;
                filter: alpha(opacity=25);
            }
            .green_section
            {
                background-color: #12be00;
                opacity: 0.25;
                filter: alpha(opacity=25);
            }
            .blue_section
            {
                background-color: #2babf5;
                opacity: 0.27;
                filter: alpha(opacity=27);
            }
            .pink_section
            {
                background-color: #CC0033;
                opacity: 0.30;
                filter: alpha(opacity=30);
            }
            .dark_blue_section
            {
                background-color: #999999;
                opacity: 0.40;
                filter: alpha(opacity=40);
            }
            .dots_section
            {
                background-image: url(data/imgs/dots.png);
            }
            .fat_lines_section
            {
                background-image: url(data/imgs/fat_lines.png);
            }
            .medium_lines_section
            {
                background-image: url(data/imgs/medium_lines.png);
            }
            .small_lines_section
            {
                background-image: url(data/imgs/small_lines.png);
            }
            #round
            {
                -moz-border-radius: 5px; /* Gecko browsers */
                -webkit-border-radius: 5px; /* Webkit browsers */
                border-radius: 5px; /* W3C syntax */
            }
        </style>
        <script type="text/javascript">
            function show_minical() {
                if (scheduler.isCalendarVisible())
                    scheduler.destroyCalendar();
                else
                    scheduler.renderCalendar({
                        position: "dhx_minical_icon",
                        date: scheduler._date,
                        navigation: true,
                        handler: function (date, calendar) {
                            scheduler.setCurrentView(date);
                            scheduler.destroyCalendar()
                        }
                    });
            }
            function init() {
                //scheduler.config.lightbox_recurring = "series";
                scheduler.config.time_step = 60;
                scheduler.config.separate_short_events = true;
                scheduler.config.first_hour = 8; //设置时间下拉框的时间范围的开始时间
                scheduler.config.last_hour = 17; //设置时间下拉框的时间范围的结束时间
                scheduler.config.limit_time_select = true; //时间下拉的时间范围在8-17
                //scheduler.config.displayed_event_color="#red";//时间的颜色
                scheduler.config.xml_date = "%Y-%m-%d %H:%i";
                scheduler.config.start_on_monday = false;
                scheduler.config.auto_end_date = true;
                scheduler.config.show_loading = true;
                scheduler.config.active_link_view = "month";
                scheduler.config.details_on_create = true;
                scheduler.config.prevent_cache = true;
                scheduler.config.drag_create = false;
               
                scheduler.locale.labels.section_custom = "Section";
                scheduler.locale.labels.section_ename = "员工姓名";
                scheduler.locale.labels.section_because = "休假类型";
                scheduler.locale.labels.section_ban = "办事处";
                scheduler.config.show_quick_info = true;
           
             

         
                //===============
                //Configuration
                //===============




         
                var bx = [

                { key: 0, label: "离休" },
                { key: 1, label: "病假" },
                { key: 2, label: "事假" },




            ];
            var ban=getban();



                scheduler.config.lightbox.sections = [
                  { name: "because", height: 34, width: 80, type: "select", options: bx, map_to: "bx_id" },
                  { name: "ban", height: 34, type: "select", options: ban, map_to: "ban_id" },
                  { name: "ename", height: 34, type: "textarea", focus: true, map_to: "ename" },


              ];
             

                //  for (var j = a; j< 13;j++ ) {
                //  for (var k = 0; k < 31; k++) {
                // scheduler.addMarkedTimespan({ start_date: new Date(y, j, k, 0), end_date: new Date(y, j, k, 24), css: "dark_blue_section", type: "dhx_time_block",
                //  });
                // } 
                //  }


                scheduler.init('scheduler_here',null, "month");
                var b = "";
                b=  Getevn();
                scheduler.parse(b, "json");
                //scheduler.setLoadMode("timeline");

                //scheduler.load(rootUri + "CMReserveManage/Data");
                // scheduler.parse(a,"json");
                // var a = lid();
                // scheduler.parse(a, "json");

                //   }

                // scheduler.templates.event_class="";

                scheduler.attachEvent("onBeforeEventDelete", function (event_id, event_object) {
                    //删除日程程序   
                    //提交程序  

                    DelVacation(event_id);

                });
                scheduler.attachEvent("onEventChanged", function (event_id, event_object) {
                    var rid = event_id;
                    var xiutype = event_object.bx_id;
                    var banid = event_object.ban_id;
                    var ename = event_object.ename;
                    var sdatestr = event_object.start_date.toLocaleString();
                    var edatestr = event_object.end_date.toLocaleString();

                    var data = {
                    "uid":rid,
                        "xiutype": xiutype,
                        "banid": banid,
                        "ename": ename,
                        "sdatestr": sdatestr,
                        "edatestr": edatestr

                    };
                    VacationChange(data);


                });
                scheduler.attachEvent("onEventCollision", function (event_id) {
                    //If event collision exists, alert using error Input of lightbox.


                    return true;
                });
                scheduler.attachEvent("onEventAdded", function (event_id, event_object) {
                    var xiutype = event_object.bx_id;
                    var banid = event_object.ban_id;
                    var ename = event_object.ename;
                    var sdatestr = event_object.start_date.toLocaleString();
                    var edatestr = event_object.end_date.toLocaleString();

                    var data = {
                        "xiutype": xiutype,
                        "banid": banid,
                        "ename": ename,
                        "sdatestr": sdatestr,
                        "edatestr": edatestr

                    };


                    AddVacation(data);






                }

);
            } 
  
    
	
        </script>
    </head>
    <body onload="init();">
        <div style="border: 2px solid #3B9C96; margin-top: 50px">
  
           
        <div id="scheduler_here" class="dhx_cal_container" style="width: 100%; height:700px;
            font-size: 12px">
            <div class="dhx_cal_navline">
                <div class="dhx_cal_prev_button">
                    &nbsp;</div>
                <div class="dhx_cal_next_button">
                    &nbsp;</div>
                <div class="dhx_cal_date">
                </div>
         
            </div>
            <div class="dhx_cal_header">
            </div>
            <div class="dhx_cal_data">
            </div>
        </div>
        </div>
    </body>
    </html>


    <script type="text/javascript">
        jQuery(document).ready(function () { $(".select2").css('width', '100px').select2({ minimumResultsForSearch: -1 }); });
        

       function AddVacation(data)
       {
         var rootUri ="<%= ViewData["rootUri"] %>";
         var xiutype = data.xiutype;
         var banid = data.banid;
                       var ename = data.ename;
                        var sdatestr=data.sdatestr;
                        var edatestr = data.edatestr;
         if (data.ename==""||data.remark=="") {
         toastr.options = {
                        "closeButton": false,
                        "debug": true,
                        "positionClass": "toast-bottom-right",
                        "onclick": null,
                        "showDuration": "3",
                        "hideDuration": "3",
                        "timeOut": "2000",
                        "extendedTimeOut": "2000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
                    toastr["error"]("姓名与休假理由均不能为空！");
                    setTimeout(' window.location.reload()',3000);
           }
          else
          {
             $.ajax({

                 url: rootUri + "VacationManage/AddEmployeeVacation",
                        data:{"xiutype": xiutype,
                        "banid": banid,
                        "ename": ename,
                        "sdatestr": sdatestr,
                        "edatestr": edatestr},
                        type: "post",
                        success: function (message) {

                      toastr.options = {
                            "closeButton": false,
                            "debug": true,
                            "positionClass": "toast-bottom-left",
                            "onclick": null,
                            "showDuration": "3",
                            "hideDuration": "3",
                            "timeOut": "2000",
                            "extendedTimeOut": "2000",
                            "showEasing": "swing",
                            "hideEasing": "linear",
                            "showMethod": "fadeIn",
                            "hideMethod": "fadeOut"
                        };
                        if (message == "ok") {
                            toastr["success"]("操作成功！");
                        } else { toastr["error"](message); }
                          setTimeout(' window.location.reload()',3000);
                        }



                    }); 
          }
       

       }
       function VacationChange(data)
       {
         var rootUri ="<%= ViewData["rootUri"] %>";
         var uid = data.uid;
         var xiutype = data.xiutype;
         var banid = data.banid;
                       var ename = data.ename;
                        var sdatestr=data.sdatestr;
                        var edatestr = data.edatestr;
         if (data.ename==""||data.remark=="") {
         toastr.options = {
                        "closeButton": false,
                        "debug": true,
                        "positionClass": "toast-bottom-right",
                        "onclick": null,
                        "showDuration": "3",
                        "hideDuration": "3",
                        "timeOut": "2000",
                        "extendedTimeOut": "2000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    };
                    toastr["error"]("姓名与休假理由均不能为空！");
                    setTimeout(' window.location.reload()',3000);
           }
          else
          {
             $.ajax({

                 url: rootUri + "VacationManage/ChangeEmployeeVacation",
                        data:{
                        "uid":uid,
                        "xiutype": xiutype,
                        "banid": banid,
                        "ename": ename,
                        "sdatestr": sdatestr,
                        "edatestr": edatestr},
                        type: "post",
                        success: function (message) {

                      toastr.options = {
                            "closeButton": false,
                            "debug": true,
                            "positionClass": "toast-bottom-left",
                            "onclick": null,
                            "showDuration": "3",
                            "hideDuration": "3",
                            "timeOut": "2000",
                            "extendedTimeOut": "2000",
                            "showEasing": "swing",
                            "hideEasing": "linear",
                            "showMethod": "fadeIn",
                            "hideMethod": "fadeOut"
                        };
                        if (message == "ok") {
                            toastr["success"]("操作成功！");
                        } else { toastr["error"](message); }
                          setTimeout(' window.location.reload()',3000);
                        }



                    }); 
          }
       

       }
        function DelVacation(vid){
        var rootUri ="<%= ViewData["rootUri"] %>";
          $.ajax({

                 url: rootUri + "VacationManage/DeletedVacation",
                        data:{  "vid":vid  },
                        type: "post",
                        success: function (message) {

                      toastr.options = {
                            "closeButton": false,
                            "debug": true,
                            "positionClass": "toast-bottom-left",
                            "onclick": null,
                            "showDuration": "3",
                            "hideDuration": "3",
                            "timeOut": "2000",
                            "extendedTimeOut": "2000",
                            "showEasing": "swing",
                            "hideEasing": "linear",
                            "showMethod": "fadeIn",
                            "hideMethod": "fadeOut"
                        };
                        if (message == "ok") {
                            toastr["success"]("操作成功！");
                        } else { toastr["error"](message); }
                          setTimeout(' window.location.reload()',3000);
                        }



                    });


        }
        function getban(){

        var ls = <%=ViewData["ban"] %>;
       // alert(ls)


        return ls;
        }
        function Getevn(){

        
        var w = <%=ViewData["vevent"]  %>;
      // alert(w)


        return w;
        }
         /*
        function getle(){
        var le = <%=ViewData["le"] %>;


        return le;
        }
        function getrv(){



        return <%=ViewData["rv"] %>
        }
        function getrs(){



        return <%=ViewData["rs"] %>*1
        }
        function getre(){



        return <%=ViewData["re"] %>

        }

 
        //改变
        function changedata(data){


        $.ajax({

        url: rootUri + "CMReserveManage/ChangeReserve",
        data: {
        "rid":data.rid,
        "bx_id": data.bx_id,
        "section_id":data.section_id,
        "xiu_id":data.xiu_id,
        "yu_id":data.yu_id,
        "reservecar":data.reservecar,
                        
        "remark":data.remark,
        "sdatestr":data.sdatestr,
        "edatestr":data.edatestr
        },
        type: "post",
        success: function (message) {

        toastr.options = {
        "closeButton": false,
        "debug": true,
        "positionClass": "toast-bottom-left",
        "onclick": null,
        "showDuration": "3",
        "hideDuration": "3",
        "timeOut": "2000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
        };
        if (message == "操作成功！") {
        toastr["success"](message);
        } else { toastr["error"](message); }
        setTimeout(' window.location.reload()',3000);
        }



        });  
   

       

        }
        *删除
        function del(id){

        $.ajax({

        url: rootUri + "CMReserveManage/DelReserve",
        data: {
        "rid": id,
                        
        },
        type: "post",
        success: function (message) {

        toastr.options = {
        "closeButton": false,
        "debug": true,
        "positionClass": "toast-bottom-left",
        "onclick": null,
        "showDuration": "3",
        "hideDuration": "3",
        "timeOut": "2000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
        };
        if (message == "删除成功！") {
        toastr["success"](message);
        } else { toastr["error"](message); }
        setTimeout(' window.location.reload()',3000);
        }



        });  

        }
        function gets(){
         
        var sections1 =  <%=ViewData["RList"]%>;
            


        return sections1;
         
         
         
        }
        function getx(){
         
        var x =  <%=ViewData["WList"]%>;
            
    
       
        return x;
         
         
         
        }
        function lid(){
        var e =  <%=ViewData["e"]%>;
         
          
       
        return e;


        }
        //验证车号是否存在
        function iscarnum(reservecar){
        var k="";
        $.ajax({

        url: rootUri + "CMReserveManage/IsCar",
        data: {
        "num":reservecar
        },
        type: "post",
        async: false,
        success: function (message) {
        if (message=="ok") {
        k="ok";
        }
                      
          
        }



        });  
        if (k!="") {
        return true;
        }else{
        return false;
        }
                


        }


        function add(data){

        var can =""
        if (data.reservecar=="") {
        toastr.options = {
        "closeButton": false,
        "debug": true,
        "positionClass": "toast-bottom-left",
        "onclick": null,
        "showDuration": "3",
        "hideDuration": "3",
        "timeOut": "2000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
        };
        toastr["error"]("请输入手机号！");
        //setTimeout(' window.location.reload();', 3000) 

        }else if (iscarnum(data.reservecar)==true) {
        can ="a";
        ;

        }else{
        toastr.options = {
        "closeButton": false,
        "debug": true,
        "positionClass": "toast-bottom-left",
        "onclick": null,
        "showDuration": "3",
        "hideDuration": "3",
        "timeOut": "2000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
        };
        toastr["error"]("用户不存在！");
        setTimeout(' window.location.reload();', 3000) 
        }
        if (can!="") {
        $.ajax({

        url: rootUri + "CMReserveManage/AddReserve",
        data: {
        "bx_id": data.bx_id,
        "section_id":data.section_id,
        "xiu_id":data.xiu_id,
        "yu_id":data.yu_id,
        "reservecar":data.reservecar,
                
        "remark":data.remark,
        "sdatestr":data.sdatestr,
        "edatestr":data.edatestr
        },
        type: "post",
        success: function (message) {

        toastr.options = {
        "closeButton": false,
        "debug": true,
        "positionClass": "toast-bottom-left",
        "onclick": null,
        "showDuration": "3",
        "hideDuration": "3",
        "timeOut": "2000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
        };
        if (message == "日程安排插入成功!") {
        toastr["success"](message);
        } else { toastr["error"](message); }
                           
        setTimeout(' window.location.reload();', 3000) 
        }



        });  
        }else{

        }





               


        }*/
    </script>

</asp:Content>
