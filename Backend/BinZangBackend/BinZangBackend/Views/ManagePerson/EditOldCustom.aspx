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
								<i class="fa  fa-university"></i>修改旧客户
							</div>
							
						</div>
						<div class="portlet-body">
                           <form class="form-horizontal" id="validation-form">
                      <table style="width:880px; height:700px; margin-left:50px;">
                      
                         
                          <tr>
                         <td align="right"style="width:180px;">
                         旧客户姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input id="real_name" name="real_name" style="width:180px;height:30px;" onblur="check1()" value="<%= ViewData["real_name"] %>"/>
                         <input name="id" style="width:180px;height:30px; display:none"  value="<%= ViewData["id"] %>"/>
                         </td>
                           <td style="width:200px;">
                         <input id="Text1"   style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:180px;">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;"><input id="phone" name="phone"    onblur="check2()" style="width:180px;height:30px;" value="<%= ViewData["phone"] %>"/></td>
                            <td style="width:200px;">
                         <input id="Text2"   style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:180px;">
                         墓地编号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <select class="select2" name="tombnum" onchange="changetomb(this.value)" >
                                <%
                                    for (int i = 0; i < ViewBag.tomblist.Count; i++)
                                    {%>
                                            <option value="<%=ViewBag.tomblist[i].uid %>">
                                                <%=ViewBag.tomblist[i].number%></option>
                                            <% }%>
                         </select>
                         </td>  
                          <td  align="right" style="width:80px;">
                        墓地目的价格&nbsp;:&nbsp;
                         </td>
                         <td style="width:100px;">
                             <input id="tombjiage"  disabled="disabled"  name="tombjiage"   style="width:180px;height:30px;"/>
                         </td>
                         </tr>
                         <tr>
                          <td  align="right" style="width:180px; ">
                         排位编号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <select class="select2"  name="paiweinum"  onchange="changequnum(this.value)" >
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
                         <td style="width:100px;">
                             <input id="paiweijiage" disabled="disabled" name="paiweijiage"    style="width:180px;height:30px;"/>
                         </td>
                         </tr>
                              <tr>
                          <td  align="right" style="width:180px; ">
                         亲属关系&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input id="qinrenguanxi1"  name="qinrenguanxi1"    style="width:180px;height:30px;" value="<%= ViewData["guanxi1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         亲属关系&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                             <input id="qinrenguanxi2" name="qinrenguanxi2"    style="width:180px;height:30px;" value="<%= ViewData["guanxi2"] %>"/>
                         </td>
                         </tr>
                           <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input id="qinrenname1"     name="qinrenname1"       style="width:180px;height:30px;" value="<%= ViewData["qname1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:100px;">
                             <input id="qinrenname2"  name="qinrenname2"       style="width:180px;height:30px;" value="<%= ViewData["qname2"] %>"/>
                         </td>
                         </tr>
                            <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人诞辰&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                           <input class="date-picker" id="qinrendanchen1" name="qinrendanchen1"    type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["danchen1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人诞辰&nbsp;:&nbsp;
                         </td>
                         <td style="width:100px;">
                              <input class="date-picker" id="qinrendanchen2" name="qinrendanchen2"    type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["danchen2"] %>"/>
                         </td>
                         </tr>
                           <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人忌日&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input class="date-picker" id="qinrenjiri1" name="qinrenjiri1"    type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["jiri1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人忌日&nbsp;:&nbsp;
                         </td>
                         <td style="width:100px;">
                             <input class="date-picker" id="qinrenjiri2" name="qinrenjiri2"    type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["jiri2"] %>"/>
                         </td>
                         </tr>
                                              <tr>
                          <td  align="right" style="width:180px; ">
                         办事处&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <select class="select2" name="office"  id="office" onchange="findemp(this.value)"     style="width:180px;height:30px;">
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
                         <td style="width:100px;">
                             <select class="select2" id="owner_name" name="owner_name"  onchange="check3()" style="width:180px;height:30px;">
                                 <option value="0">请选择</option>
                                 <%
                                     for (int i = 0; i < ViewBag.ownerlist.Count; i++)
                                     {%>
                                 <option value="<%=ViewBag.ownerlist[i].uid %>">
                                     <%=ViewBag.ownerlist[i].name%></option>
                                 <% }%>
                             </select>
                         </td>
                         <td style="width:120px;">
                           <input id="Text3"   style="width:120px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                      <td>
                         <input type="hidden" id="img" class="img"  name="img" value="Content/Images/default_img.jpg" />
                      </td>
                      <td align="right">
                            <button id="sett" class="btn btn-success loading-btn" type="reset" onclick="javascript:addscenic();" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
							    确认修改
							</button>
                      </td>
                      </tr>
                      </table>
                      </form>
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
     var flag3=false;
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
        flag3 =false;
        }else{
        document.getElementById("Text3").style.display="none";
        flag3 =true;
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
    var office="<%= ViewData["office"] %>";
    var owner_name="<%= ViewData["owner_name"] %>";
              $(".select2").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                     changetomb(<%=ViewBag.tomblist[0].uid %>);
                    changequnum(<%=ViewBag.paiweilist[0].uid %>);
                    $("#office").val(office);
                    $("#office").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                      $("#owner_name").val(owner_name);
                    $("#owner_name").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                    check1();
                    check2();
                    check3();
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
          if (flag1==true&&flag2==true&&flag3==true)
          {
          
               $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/EditOldCustomInfo",
                 dataType: "json",
                data:$('#validation-form').serialize(),
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
            }else{
            toas3("提交的数据有不能为空的,请确认后再提交");
            }
          }
               function findemp(value){
           document.getElementById("owner_name").length=0;
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/FindEmpByOffice",
                data:{"office":value},
                success: function (data) {
                   for (var s in data) {
                   $("#owner_name").append("<option value=" + data[s].uid + ">" + data[s].name + "</option>");
                   }
                      $("#owner_name").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                }
            });
          }      
            function changetomb(value){
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/FindPriceByTomb",
                data:{"id":value},
                success: function (data) {
                   $("#tombjiage").val(data.price);
                   $("#qinrenguanxi1").val(data.guanxi1);
                   $("#qinrenguanxi2").val(data.guanxi2);
                   $("#qinrenname1").val(data.xingming1);
                   $("#qinrenname2").val(data.xingming2);
                   $("#qinrendanchen1").val(data.danchen1);
                   $("#qinrendanchen2").val(data.danchen2);
                   $("#qinrenjiri1").val(data.jiri1);
                   $("#qinrenjiri2").val(data.jiri2);
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
