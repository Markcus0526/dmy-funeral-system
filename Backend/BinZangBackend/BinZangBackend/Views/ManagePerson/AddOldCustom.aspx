<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
   <link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.css" /> 


<div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>添加旧客户
							</div>
							
						</div>
						<div class="portlet-body">
                          


                      <table style="width:auto; height:700px; margin-left:50px;">
                          <tr>
                         <td align="right"style="width:180px;">
                         旧客户姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input name="real_name"  id="real_name" onblur="check1()" style="width:180px;height:30px;" />
                         </td>
                           <td style="">
                         <input name="Text1" id="Text1"  onblur="check1()"  style="width:150px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:180px;">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;"><input name="phone" id="phone" onblur="check2()" style="width:180px;height:30px;"/></td>
                          <td style="width:200px;">
                         <input id="Text2"   style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>  <td style="width:200px;">
                         <input name="Text2" id="Text2"  style="width:150px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:180px;">
                         墓地编号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <select class="select2" id="tombnum" name="tombnum" onchange="changetomb(this.value)" >
                                     <option value="0">请选择</option>
                                <%
                                    for (int i = 0; i < ViewBag.tomblist.Count; i++)
                                    {%>
                                     <option value="<%=ViewBag.tomblist[i].uid %>">
                                         <%=ViewBag.tomblist[i].number%></option>
                                    <% }%>
                         </select>
                         </td>  
                          <td  align="right" style="width:80px;">
                        墓地价格&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                             <input id="tombjiage" name="tombjiage"  disabled="disabled" style="width:180px;height:30px;"/>
                         </td>
                         <td  align="right" style="width:80px;">
                        成交价格&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                             <input id="tombchengjiao" name="tombchengjiao" onblur="check4()"  style="width:180px;height:30px;"/>
                         </td>
                         <td style="width:150px;">
                         <input name="Text5" id="Text5"  onblur="check4()"  style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                          <td  align="right" style="width:150px; ">
                         排位编号&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                         <select class="select2" id="paiweinum" name="paiweinum"  onchange="changequnum(this.value)" >
                                       <option value="0">请选择</option>
                                <%
                                    for (int i = 0; i < ViewBag.paiweilist.Count; i++)
                                    {%>
                                            <option value="<%=ViewBag.paiweilist[i].uid %>">
                                                <%=ViewBag.paiweilist[i].number%></option>
                                            <% }%>
                         </select>
                         </td>  
                          <td  align="right" style="width:80px;">
                         排位价格&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                             <input id="paiweijiage"  name="paiweijiage" disabled="disabled"  style="width:180px;height:30px;"/>
                         </td>
                         <td  align="right" style="width:80px;">
                         成交价格&nbsp;:&nbsp;
                         </td>
                          <td style="width:150px;">
                             <input id="paiweichengjiao"  name="paiweichengjiao" onblur="check5()"  style="width:180px;height:30px;"/>
                         </td>
                         <td style="width:150px;">
                         <input name="Text4" id="Text4"  onblur="check5()"  style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                               <tr>
                          <td  align="right" style="width:150px; ">
                         亲属关系&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                         <input id="qinrenguanxi1"  name="qinrenguanxi1"    style="width:180px;height:30px;"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         亲属关系&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                             <input id="qinrenguanxi2" name="qinrenguanxi2"    style="width:180px;height:30px;"/>
                         </td>
                         </tr>
                           <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                         <input id="qinrenname1" name="qinrenname1"    style="width:180px;height:30px;"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                             <input id="qinrenname2" name="qinrenname2" style="width:180px;height:30px;"/>
                         </td>
                         </tr>
                            <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人诞辰&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                           <input class="date-picker" id="qinrendanchen1" name="qinrendanchen1" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" />
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人诞辰&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                              <input class="date-picker" id="qinrendanchen2" name="qinrendanchen2" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" />
                         </td>
                         </tr>
                           <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人忌日&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                         <input class="date-picker" id="qinrenjiri1" name="qinrenjiri1" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" />
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人忌日&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                             <input class="date-picker" id="qinrenjiri2" name="qinrenjiri2" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" />
                         </td>
                         </tr>
                          <tr>
                          <td  align="right" style="width:180px; ">
                         办事处&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                         <select class="select2" id="office" name="office"  onchange="setyname(this.value)"  style="width:180px;height:30px;">
                                <option value="0">请选择</option>
                                <%
                                    for (int i = 0; i < ViewBag.officelist.Count; i++)
                                    {%>
                                            <option value="<%=ViewBag.officelist[i].uid %>">
                                                <%=ViewBag.officelist[i].name%></option>
                                            <% }%>
                         </select>
                         </td>  
                          <td  align="right" style="width:80px;">
                         关联员工&nbsp;:&nbsp;
                         </td>
                         <td style="width:150px;">
                             <select class="select2" id="owner_name" name="owner_name" onchange="setdname(this.value)" onblur="check3()"  style="width:180px;height:30px;">
                                    <option value="0">请选择</option>
                                   
                             </select>
                         </td>
                         <td align="right" style="width:150px;">
                           代销商&nbsp;:&nbsp;
                         </td>
                         <td>
                             <select class="select2" id="daixiao_name" name="daixiao_name" onblur="check3()"  style="width:180px;height:30px;">
                                    <option value="0">无</option>
                                    
                             </select>
                         </td> 
                         <td>
                         <input name="Text3" id="Text3"    style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                      <td>
                         <input type="hidden" id="img" class="img"  name="img" value="Content/Images/default_img.jpg" />
                      </td>
                      <td align="right">
                            <button id="sett" class="btn btn-success" onclick="addscenic()" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								确定添加
							</button>
                      </td>
                      </tr>
                      </table>
                   
						</div>
					</div>
				</div>
	
    		</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.js"></script>
    <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>   
     <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.js"></script>
    <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
    var flag1=false;
     var flag2=false;
     function setyname(id)
{
    document.getElementById("owner_name").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>PerformanceManagement/GetallUser",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                         $("#owner_name").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   for (var s in data) {
                                    if (s == 0) {
                                        $("#owner_name").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    } else {
                                        $("#owner_name").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    }
                                }
                        $("#owner_name").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
                $("#owner_name").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                 $("#owner_name").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
            }
            setdname(0);
}
 function setdname(id)
{
    document.getElementById("daixiao_name").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>PerformanceManagement/GetallDUser",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                         $("#daixiao_name").append("<option value=" + "0" + ">" + "无" + "</option>");
                                   for (var s in data) {
                                    if (s == 0) {
                                        $("#daixiao_name").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    } else {
                                        $("#daixiao_name").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    }
                                }
                        $("#daixiao_name").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
                $("#daixiao_name").append("<option value=" + "0" + ">" + "无" + "</option>");
                 $("#daixiao_name").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
            }
}
     function check1(){
        var value=$("#real_name").val();
         if(value.length>50){
            document.getElementById("Text1").style.display="block";
            $('#Text1').val("输入的姓名不能多于50字");
            flag1 =false;
            }else  if(value.length<=0){
            document.getElementById("Text1").style.display="block";
            $('#Text1').val("姓名不能为空");
            flag1 =false;
            }else{
            document.getElementById("Text1").style.display="none";
            flag1 =true;
            }
     }
      function check2(){
      var value=$("#phone").val();
       if(value.length>20){
        document.getElementById("Text2").style.display="block";
        $('#Text2').val("输入的电话不能多于20字");
        flag2 =false;
        }else  if(value.length<=0){
        document.getElementById("Text2").style.display="block";
        $('#Text2').val("电话不能为空");
        flag2 =false;
        }else{
        document.getElementById("Text2").style.display="none";
        flag2 =true;
        }
     }
      function check3(){
      var value=$("#owner_name").val();
       if(value=="0"){
        document.getElementById("Text3").style.display="block";
        $('#Text3').val("请选择所属员工");
        return false;
        }else{
        document.getElementById("Text3").style.display="none";
         return true;
        }
     }
     function check4(){
       var mudiid=$("#tombnum").val();
      if(mudiid!=0)
      {
       var value=$("#tombchengjiao").val();
       var re = /^[1-9]+[0-9]*]*$/;
       if(value==""||!re.test(value)){
        document.getElementById("Text5").style.display="block";
        $('#Text5').val("*请输入成交价格,注意格式！");
        return false;
        }else{
        document.getElementById("Text5").style.display="none";
         return true;
        }
       }else{
       return true;
       }
     }
     function check5(){
      var paiweiid=$("#paiweinum").val();
      if(paiweiid!=0)
      {
         var value=$("#paiweichengjiao").val();
          var re = /^[1-9]+[0-9]*]*$/;
       if(value==""||!re.test(value)){
        document.getElementById("Text4").style.display="block";
        $('#Text4').val("*请输入成交价格,注意格式！");
        return false;
        }else{
        document.getElementById("Text4").style.display="none";
         return true;
        }
      }
      else{
         return true;
      }
     
     }
     function check6(){
      var paiweiid=$("#paiweinum").val();
      var mudiid=$("#tombnum").val();
      if(paiweiid==0&&mudiid==0)
      {
         toas3("请选择墓地或牌位！");
         return false;
      }
      else{
         return true;
      }
     
     }
    jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
        }
        initTable1();

    });
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
    });
    jQuery(function ($) {  
              $(".select2").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
        });

          function addscenic(){
          var qinrenguanxi1=$("#qinrenguanxi1").val();
          var qinrenguanxi2=$("#qinrenguanxi2").val();
          var qinrenname1=$("#qinrenname1").val();
          var qinrenname2=$("#qinrenname2").val();
          var qinrendanchen1=$("#qinrendanchen1").val();
          var qinrendanchen2=$("#qinrendanchen2").val();
          var qinrenjiri1=$("#qinrenjiri1").val();
          var qinrenjiri2=$("#qinrenjiri2").val();
          if (qinrenguanxi1!=""||qinrenname1!=""||qinrendanchen1!=""||qinrenjiri1!="") {
               if (qinrenguanxi1==""||qinrenname1==""||qinrendanchen1==""||qinrenjiri1=="") {
                 toas3("提交的第一个亲人的数据有不能为空的,请确认后再提交");
               return ;
               }
          }
           if (qinrenguanxi2!=""||qinrenname2!=""||qinrendanchen2!=""||qinrenjiri2!="") {
               if (qinrenguanxi2==""||qinrenname2==""||qinrendanchen2==""||qinrenjiri2=="") {
                 toas3("提交的第二个亲人的数据有不能为空的,请确认后再提交");
                 return ;
               }
          }
          if (flag1==true&&flag2==true&&check6()==true&&check3()==true&&check4()==true&&check5()==true)
          {
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/AddOldCustomInfo",
                 dataType: "json",
                data:{
                  real_name:$("#real_name").val(), 
                  phone:$("#phone").val(), 
                  tombnum:$("#tombnum").val(), 
                  tombjiage:$("#tombjiage").val(),
                  paiweinum:$("#paiweinum").val(),  
                  paiweijiage:$("#paiweijiage").val(),  
                  qinrenguanxi1:$("#qinrenguanxi1").val(),  
                  qinrenguanxi2:$("#qinrenguanxi2").val(),  
                  qinrenname1:$("#qinrenname1").val(),  
                  qinrenname2:$("#qinrenname2").val(),  
                  qinrendanchen1:$("#qinrendanchen1").val(),  
                  qinrendanchen2:$("#qinrendanchen2").val(),
                  qinrenjiri1:$("#qinrenjiri1").val(),  
                  qinrenjiri2:$("#qinrenjiri2").val(),  
                  office:$("#office").val(),  
                  owner_name:$("#owner_name").val(),  
                  daixiao_name:$("#daixiao_name").val(), 
                  paiweichengjiao:$("#paiweichengjiao").val(), 
                  tombchengjiao:$("#tombchengjiao").val()

                },
                success: function (data) {
                 if (data=="success")
                 {
                 toas1("添加成功");
                 setTimeout(function(){
                 location.href="<%= ViewData["rootUri"] %>ManagePerson/OldCustom";
                 },3000);
                  
                 }else
                 {
                 toas2(data);
                 }
                }
            });
             }
        
          } 
            function changetomb(value){
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/FindPriceByTomb",
                data:{"id":value},
                success: function (data) {
                   $("#tombjiage").val(data.price);
                }
            });
          } 
            function changequnum(value){
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/FindPriceByPaiwei",
                data:{"id":value},
                success: function (data) {
                   $("#paiweijiage").val(data);
                }
            });
          } 
      function toas1(massage) {
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
          toastr["success"](massage, "温馨提示");
      }
      function toas2(massage) {
          toastr.options = {
              "closeButton": false,
              "debug": true,
              "positionClass": "toast-bottom-left",
              "onclick": null,
              "showDuration": "3",
              "hideDuration": "3",
              "timeOut": "1500",
              "extendedTimeOut": "1000",
              "showEasing": "swing",
              "hideEasing": "linear",
              "showMethod": "fadeIn",
              "hideMethod": "fadeOut"
          };

          toastr["error"](massage, "温馨提示");
      }
         function toas3(massage) {
            toastr.options = {
                "closeButton": false,
                "debug": true,
                "positionClass": "toast-bottom-left",
                "onclick": null,
                "showDuration": "3",
                "hideDuration": "3",
                "timeOut": "1500",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            };

            toastr["warning"](massage, "温馨提示");
        }
</script>

</asp:Content>
