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
                           <form class="form-horizontal" id="validation-form">
                      <table style="width:780px; height:700px; margin-left:50px;">
                      
                         
                          <tr>
                         <td align="right"style="width:180px;">
                         旧客户姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input name="real_name" disabled="disabled"  style="width:180px;height:30px;"  value="<%= ViewData["real_name"] %>"/>
                         </td>
                           <td style="width:200px;">
                         <input name="Text8"   style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:180px;">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;"><input name="phone"  disabled="disabled" onblur="check2(this.value)" style="width:180px;height:30px;" value="<%= ViewData["phone"] %>"/></td>
                          <td style="width:200px;">
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
                             <input id="tombjiage"  disabled="disabled" name="tombjiage"   style="width:180px;height:30px;"/>
                         </td>
                         </tr>
                         <tr>
                          <td  align="right" style="width:180px; ">
                         排位编号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <select class="select2" name="paiweinum"  onchange="changequnum(this.value)" >
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
                             <input id="paiweijiage"  disabled="disabled"  name="paiweijiage"    style="width:180px;height:30px;"/>
                         </td>
                         </tr>
                         <tr>
                          <td  align="right" style="width:180px; ">
                         亲属关系&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input id="qinrenguanxi1"  name="qinrenguanxi1"   disabled="disabled"   style="width:180px;height:30px;" value="<%= ViewData["guanxi1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         亲属关系&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                             <input id="qinrenguanxi2" name="qinrenguanxi2"   disabled="disabled"   style="width:180px;height:30px;" value="<%= ViewData["guanxi2"] %>"/>
                         </td>
                         </tr>
                           <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input id="qinrenname1"  name="qinrenname1"    disabled="disabled"  style="width:180px;height:30px;" value="<%= ViewData["qname1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:100px;">
                             <input id="qinrenname2"    name="qinrenname2"   disabled="disabled"  style="width:180px;height:30px;" value="<%= ViewData["qname2"] %>"/>
                         </td>
                         </tr>
                            <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人诞辰&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                           <input class="date-picker" id="qinrendanchen1" name="qinrendanchen1"  disabled="disabled" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["danchen1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人诞辰&nbsp;:&nbsp;
                         </td>
                         <td style="width:100px;">
                              <input class="date-picker" id="qinrendanchen2" name="qinrendanchen2"  disabled="disabled" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["danchen2"] %>"/>
                         </td>
                         </tr>
                           <tr>
                          <td  align="right" style="width:180px; ">
                         已故亲人忌日&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <input class="date-picker" id="qinrenjiri1" name="qinrenjiri1"  disabled="disabled" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["jiri1"] %>"/>
                         </td>  
                          <td  align="right" style="width:80px;">
                         已故亲人忌日&nbsp;:&nbsp;
                         </td>
                         <td style="width:100px;">
                             <input class="date-picker" id="qinrenjiri2" name="qinrenjiri2"  disabled="disabled" type="text" data-date-format="yyyy-mm-dd"  style="width:180px;" value="<%= ViewData["jiri2"] %>"/>
                         </td>
                         </tr>
                                              <tr>
                          <td  align="right" style="width:180px; ">
                         办事处&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">
                         <select class="select2" id="office" name="office"  onchange="findemp(this.value)"  disabled="disabled"  style="width:180px;height:30px;">
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
                             <select class="select2" id="owner_name" name="owner_name"  disabled="disabled"  style="width:180px;height:30px;">
                                    <%
                                        for (int i = 0; i < ViewBag.ownerlist.Count; i++)
                                        {%>
                                                <option value="<%=ViewBag.ownerlist[i].uid %>">
                                                    <%=ViewBag.ownerlist[i].name%></option>
                                                <% }%>
                             </select>
                         </td>
                         </tr>
                      <td>
                         <input type="hidden" id="img" class="img"  name="img" value="Content/Images/default_img.jpg" />
                      </td>
                      <td align="right">
                            <button id="sett" class="btn btn-success loading-btn" type="reset" onclick="javascript:addscenic();" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								返回
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
<script>
  
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
                             $("#office").val(office);
                   $("#office").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                     changetomb(<%=ViewBag.tomblist[0].uid %>);
                    changequnum(<%=ViewBag.paiweilist[0].uid %>);
                          $("#owner_name").val(owner_name);
                    $("#owner_name").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
        });

          function addscenic(){
               location.href="<%= ViewData["rootUri"] %>ManagePerson/OldCustom";
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
