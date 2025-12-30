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
								<i class="fa  fa-university"></i>查看代销商
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:780px; height:500px; margin-left:50px;">
                         <tr>
                         <td rowspan="9" style="width:180px;">
                           代销商图片:
                            <div class="form-group">
                            <div id="advertCarImg" class="form-group" style="width:122px; border:2px solid #BBB;">
                                <img src="<%= ViewData["rootUri"] %><%= ViewData["img"] %>" id ="picture" height="120px" width="120px"/>	
                                <input type="hidden" id="img" class="img"  name="img" value="" />
                                </div>
                            </div>                     
                         </td>
                         <td align="right"style="width:80px;">
                         代销商姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                        <%= ViewData["real_name"] %>
                         </td>
                           <td style="width:200px;">
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <%= ViewData["phone"] %>
                         </td>
                          <td style="width:200px;">
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         Q Q&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                       <%= ViewData["qqname"] %>
                            </td>
                          <td style="width:200px;">
                         </td>
                         </tr><tr>
                         <td  align="right" style="width:80px;">
                           微 信&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <%= ViewData["weixin"] %>
                         </td>
                           <td style="width:200px;">
                         </td>
                         </tr>
                         <tr>
                         <td  align="right" style="width:80px;">
                           办事处&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <select id="banshichu" class="select2" disabled="disabled" onchange="findemp()" style=" width:200px; height:30px;" >
                                <option value="0">全部</option>
                                <%
                                    for (int i = 0; i < ViewBag.officelist.Count; i++)
                                    {%>
                                            <option value="<%=ViewBag.officelist[i].uid %>">
                                                <%=ViewBag.officelist[i].name %></option>
                                            <% }%>
                            </select></td>
                         </tr>
                         <tr>
                         <td  align="right" style="width:80px;">
                           员 工&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <select class="select2 " onkeyup="check5(this.value)" disabled="disabled"  style=" width:180px"   id="owner_name">

                            </select>
                            </td>
                          <td style="width:200px;">
                         </td>
                         </tr>
                         <tr>
                         <td  align="right" style="width:80px;">
                          登陆账号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <%= ViewData["name"] %>
                         </td>
                           <td style="width:200px;">
                         </td>
                         </tr>
                      <tr>
                      <td>
                      </td>
                      <td align="right">
                             <button id="sett" class="btn btn-success loading-btn" onclick="<%=ViewData["rootUri"] %>ManagePerson/DaiXiaoShang" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								返回
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
     <script src="<%= ViewData["rootUri"] %>Content/plugins/bootstrap-toastr/toastr.js"></script>
<script type="text/javascript">
 var offices="<%= ViewData["office"] %>";
 var owner="<%= ViewData["owner_name"] %>";
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
          
    });
    jQuery(function ($) {  

              $(".select2").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
        findemp();
        });


       
           function findemp(){
           document.getElementById("owner_name").length=0;
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/FindEmpByOffice",
                data:{"office":$("#banshichu").val()},
                success: function (data) {
                   for (var s in data) {
                   $("#owner_name").append("<option value=" + data[s].uid + ">" + data[s].name + "</option>");
                   }
                        $("#banshichu").val(parseInt(offices));
                        $("#owner_name").val(parseInt(owner));
                        $("#banshichu").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true});
                        $("#owner_name").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true});
                }
            });
          }
             
</script>

</asp:Content>
