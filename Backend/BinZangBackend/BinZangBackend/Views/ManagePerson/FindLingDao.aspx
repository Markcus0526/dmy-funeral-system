<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>  
                <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/kindeditor.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/lang/zh_CN.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.js"></script>
   <link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.css" /> 


<div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>查看领导
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:780px; height:500px; margin-left:50px;">
                         <tr>
                         <td rowspan="9" style="width:180px;">
                           领导图片:
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
                          <tr >
                         
                         <td align="right"style="width:180px;">
                         领导类别&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <select class="select2" disabled="disabled" style=" width:30px" id="type">
                        <option value="1">董事长</option>
                        <option value="2">总经理</option>
                        <option value="3">副总经理</option>
                        </select>
                         </td>
                           <td style="width:200px;">
                         <input id="Text9" readonly="readonly" style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
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
                             <a id="sett" class="btn btn-success loading-btn" href="<%=ViewData["rootUri"] %>ManagePerson/LingDao" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								返回
							</a>
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
 var type="<%= ViewData["type"] %>";
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
          
    });
    jQuery(function ($) {  

              $(".select2").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                        $("#type").val(parseInt(type));
                        $("#owner_name").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true});
               
            });
             
</script>

</asp:Content>
