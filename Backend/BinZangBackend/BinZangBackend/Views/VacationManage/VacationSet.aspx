<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>Index</title>
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
        <script src="../../Scripts/ex.js" type="text/javascript"></script>

        <style type="text/css">
            div{ word-wrap: break-word; word-break: normal;}
            .dhx_scheduler_month .dhx_marked_timespan
            {
                display: block;
            }
            .holiday
            {
                cursor: not-allowed;
            }
          .setting_event
            {
                font-size: 12px;
                color: #663399;
                height: 50px;
                font-weight: bold;
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
              /*送签*/  
            .dhx_month_day_send_signed .dhx_month_body{  
                background-color:rgb(0, 255, 10);  
            }  
              
            /*出签*/  
            .dhx_month_day_out_signed .dhx_month_body{  
                background-color:rgb(6, 230, 250);  
            }  
        </style>
        <script type="text/javascript">
	function show_minical(){
		if (scheduler.isCalendarVisible())
			scheduler.destroyCalendar();
		else
			scheduler.renderCalendar({
				position:"dhx_minical_icon",
				date:scheduler._date,
				navigation:true,
				handler:function(date,calendar){
					scheduler.setCurrentView(date);
					scheduler.destroyCalendar()
				}
			});
	}
	    function init() {
	      //scheduler.config.lightbox_recurring = "series";
            scheduler.config.time_step = 60;
          //  scheduler.config.separate_short_events = true;
           // scheduler.config.first_hour = 8;//设置时间下拉框的时间范围的开始时间
          // scheduler.config.last_hour = 17;//设置时间下拉框的时间范围的结束时间
  //  scheduler.config.limit_time_select = true;//时间下拉的时间范围在8-17
        //scheduler.config.displayed_event_color="#red";//时间的颜色
	    scheduler.config.xml_date = "%Y-%m-%d %H:%i";
            scheduler.config.start_on_monday = false;
            scheduler.config.auto_end_date = true;
            scheduler.config.show_loading = true;
              scheduler.config.active_link_view = "month";
            scheduler.config.details_on_create = true;
            scheduler.config.prevent_cache = true;
            scheduler.config.drag_create = false;
	        scheduler.locale.labels.timeline_tab = "时间表";
	        scheduler.locale.labels.section_custom = "Section";
	        scheduler.config.dblclick_create = false;
	        scheduler.config.details_on_dblclick = false;
    //scheduler.config.show_quick_info = true;

	 
     
	        scheduler.init('scheduler_here', null, "month");
	        var s = null;
            s= Getevns();
	       scheduler.parse(s, "json");
	       //  scheduler.addEvent(s);
      






} 
  
    
	
        </script>
    </head>
    <body onload="init();">
        <div style="border: 2px solid #3B9C96; margin-top: 50px">
            <div style="width: 20%; float: right; border-left:2px solid #3B9C96; height:600px">
                <div>
                <h3 style=" color:#3B9C96; font-weight:bold; margin-left:35%">休假设置</h3>
                </div>
                <br />
                   <div class="btn-group btn-group-circle" data-toggle="buttons" style="  margin-left:20%; margin-bottom:1%">
             
														<label class="btn btn-success btn-sm active">
														<input type="radio" class="toggle" name="canl" value="0" checked="checked"> 可以 </label>
														<label class="btn btn-success btn-sm">
														<input type="radio" class="toggle"  name="canl" value="1"> 不可以</label>
					</div>
                <br />
                <div>
                  <label  style="  margin-left:5%"> 办事处：</label>
                  <select class="select2" id="banshichu" onchange="banselect(this.value)">   
                    <% for (int i = 0; i < ViewBag.vlist.Count; i++)
                        {  %>
                             <option value="<%=ViewBag.vlist[i].uid %>"><%=ViewBag.vlist[i].name %></option>
                        <% }%>
                    </select>
                </div>
                <br />
                <div>
                    <label style="  margin-left:5%">开始时间：</label>
                        <input class="date-picker" id="st" name="endtime" type="text" data-date-format="yyyy-mm-dd"  style="width:140px;" />
                                          
                </div>
                        <br />
                <div>
                    <label style="  margin-left:5%"> 结束时间：</label>
                    <input class="date-picker" id="et" name="endtime" type="text" data-date-format="yyyy-mm-dd"  style="width:140px;" />
                </div>
                <br />
             

                <div>
                    <label style="  margin-left:5%">休假人数：</label>
                    <input id="lnum"  placeholder="请输入整数"/></div>
                <br />
                <div>
                    <label style="  margin-left:5%">禁止理由：</label>
                    <textarea id="because" rows="3"></textarea></div>
                    <br />
                <div> <a id="searchdata" class="btn btn-sm btn-success" onclick="AddSet()" style="margin-left:40%"><i class="fa fa-search"></i>保存</a>
                </div>
            </div>
            <a id="A1" class="btn btn-sm btn-info" onclick='exportScheduler("pdf")' ><i class="fa fa-file-pdf-o"></i>导出PDF</a>
         
        <div id="scheduler_here" class="dhx_cal_container" style="width: 80%; height:700px;
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

    function banselect(k){
    //alert("init");
   
		
window.location.href="Index1?banid="+k;
   

    }
     function Getevns(){
       var rootUri ="<%= ViewData["rootUri"] %>";
      var e="";
      //document.getElementById("pai").options.length = 1;
     var banid = $('#banshichu').val();
          $.ajax({

                            url: rootUri + "VacationManage/SearchSet",
                            data: {
                                "banid": banid

                            },
                            async:false,
                          dataType:'json', 
                            type: "post",
                            success: function (message) {
                             var  evns = "";
                             var  subevns = "";
                              evns += "[	";

                           for (var  i = 0; i < parseInt(message.length); i++)
                             {
                              
                                if (subevns != "")
                                         {
                                      subevns += ",";

                                     }
                                 subevns += "{start_date:\"" + message[i].start_date + "\", end_date:\"" + message[i].end_date + "\", text:\"" + message[i].text + "\",id:"+message[i].id+"}";


                             }
                                    evns += subevns;
                                      evns += "]";
                                     // alert("sss");
                                  e= evns;
                          
                            }



                        }); 
                        //alert(e);
                        return e;
      


     }
        function AddSet() {
          var rootUri ="<%= ViewData["rootUri"] %>";
            var type;
            var maxperson = $('#lnum').val();
            var excuse = $('#because').val();
            var st = $('#st').val();
            var et = $('#et').val();
            var banid = $('#banshichu').val();
            var obj = document.getElementsByName("canl");  //这个是以标签的name来取控件
                 for(i=0; i<obj.length;i++){

                   if(obj[i].checked){ 
                     type=  obj[i].value; 
                   } 
                }
                //第一层if判断开始结束时间
                if (st == "" || et == "") {
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
                                toastr["error"]("开始与结束时间必须全部输入，请检查！");
                } else {
                //的二层判断是否可以休假
                    if (type == 0) {
                        //如果可以 那么最大休假人数就必须天
                        if (maxperson == "" || isNaN(maxperson) || excuse != "") {
                            //休假人数每天或者填错了
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
                                 toastr["error"]("最大休假人数填写不正确或者误输入了禁止理由，请检查！");
                    }
                    else {
                        //天了
                        //alert("can");
                        $.ajax({

                            url: rootUri + "VacationManage/CanVacation",
                            data: {
                                "type": type,
                                "st":st,
                                "et":et,
                                "banid":banid,
                                "maxperson":maxperson,
           
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
                                if (message == "ok") {
                                    toastr["success"]("操作成功！");
                                } else { toastr["error"](message); }
                                setTimeout(' window.location.reload()', 3000);
                            }



                        });  


                    }

                } else {

                    if (excuse == "" || maxperson != "") {
                        //不能休假理由了
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
                                toastr["error"]("没有输入禁止理由或者误输入了最大休假人数，请检查！");
                    }
                    else {
                        //天了
                           $.ajax({

                            url: rootUri + "VacationManage/CanNotVacation",
                            data: {
                                "type": type,
                                "st":st,
                                "et":et,
                                "banid":banid,
                                "excuse":excuse,
           
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
                                if (message == "ok") {
                                    toastr["success"]("操作成功！");
                                } else { toastr["error"](message); }
                                setTimeout(' window.location.reload()', 3000);
                            }



                        });  
                    }

                    }
                  }
          


        }
        jQuery(function ($) {
                      Getevns();
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
        jQuery(document).ready(function () { $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 }); });
        function exportScheduler(type) {
            var format = "A3";
            var orient = "landscape";
            var zoom = 1;
            if (type == "pdf")
                scheduler.exportToPDF({
                    format: format,
                    orientation: orient,
                    zoom: zoom
                });
            else
                scheduler.exportToPNG({
                    format: format,
                    orientation: orient,
                    zoom: zoom
                });
        }
       
        /*

        function getls(){

        var ls = <%=ViewData["ls"] %>;


        return ls;
        }
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
        //删除
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
