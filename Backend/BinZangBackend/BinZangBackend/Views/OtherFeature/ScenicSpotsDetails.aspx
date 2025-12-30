<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>旅游景点管理详情
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:580px; height:400px; margin-left:50px;">
                         <tr>
                         <td rowspan="3" style="width:220px;">
                           图片:
                           <div>
                           <image src="<%= ViewData["rootUri"] %><%= ViewData["imgurl"] %>" style=" width:150px; height:150px;"></image>
                           </div>
                         </td>
                         <td align="left"style="width:80px;">
                         景点名称:
                         </td>
                         <td style="width:200px;"> &nbsp;<%= ViewData["name"] %></td>
                         </tr>
                         <tr>
                         
                         <td align="left" style="width:80px;">
                         地址:
                         </td>
                         <td style="width:200px;">&nbsp;<%= ViewData["address"] %></td>
                         </tr>
                        <tr>
                         <td  align="left" style="width:80px;">
                         联系电话:
                         </td>
                         <td style="width:200px;">&nbsp;<%= ViewData["phone"] %></td>
                         </tr>
                        <tr style="width:300px;">
                         <td colspan="3">
                         景点介绍:
                         <div>
                         <textarea id="contents" style="width:550px;height:300px; resize:none;" rows="8" ></textarea>
                         </div>
                         </td>
                         
                         </tr>
                      <tr>
                      <td>
                      </td>
                      <td>
                      </td>
                      <td align="right">
                            <button id="sett" class="btn" type="reset" onclick="javascript:history.go(-1);" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返 回
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
<script>

  KindEditor.ready(function (K) {
        editor = K.create('#contents', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            readonlyMode:true,
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
                });
            }
        });
        
    });
    jQuery(document).ready(function () {
     $("#contents").val(unescape("<%=ViewData["html_content"] %>"));
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
        }
        initTable1();

    });
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
    });


</script>

</asp:Content>
