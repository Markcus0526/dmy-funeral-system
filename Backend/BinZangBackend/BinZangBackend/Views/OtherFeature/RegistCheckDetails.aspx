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
								<i class="fa  fa-university"></i>注册用户审核详情
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:880px; height:400px;">
                      <tr>
                      <td align="right" style="width:100px;">客户姓名(墓主姓名):</td><td style="width:100px;">&nbsp;</td><td style="width:70px;"></td><td style="width:100px;"></td>   </tr>
                      <tr> <td align="right" >联系方式:</td><td>&nbsp;</td>  <td align="right">注册时间 :&nbsp;</td><td>&nbsp;</td>     </tr>
                       <tr><td align="right">购买墓位编号:</td><td>&nbsp;</td>  <td align="right">所属员工:</td> <td>&nbsp;</td>    </tr>
                       <tr><td align="right">已故亲人姓名:</td><td>&nbsp;</td>   </tr>
                       <tr><td align="right">已故亲人诞辰:</td><td>&nbsp;</td>   </tr>
                       <tr><td align="right">已故亲人祭日:</td><td>&nbsp;</td>   </tr>
                      </table>
						<div> 
                             <button class="btn btn-success loading-btn" id="sub" style="margin-top:10px;margin-left:710px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    通过审核
							                    </button>
                                                &nbsp;
                             <button id="sett" class="btn" type="reset" onclick="javascript:history.go(-1);" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    拒绝
							                    </button>
                        </div>
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
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
</script>

</asp:Content>
