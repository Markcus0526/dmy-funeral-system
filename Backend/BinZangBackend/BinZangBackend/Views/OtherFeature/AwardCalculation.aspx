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
								<i class="fa  fa-university"></i>奖金计算公式
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:700px; height:550px;">
                      <tr> 
                      <td align="right" style="width:200px;"> </td>
                      <td align="center" style="width:100px;">奖金分类：</td>
                      <td align="left" style="width:300px;"><select style=" width:200px; height:30px;">
                      <option value="0">个案奖金</option>
                      <option value="1">总业绩奖金</option>
                      <option value="2">领导奖金</option>
                      <option value="3">极品奖金计算</option>
                      </select> </td> 
                       </tr>
                       <tr>
                       <td align="right" style="width:200px;">最低签约价：</td>
                       <td align="center" style="width:100px;"><input id="androidurl" readonly="readonly" style="width:100px; height:30px;"/></td>
                       <td>(跟税率有关)</td>
                       </tr>
                       <tr>
                       <td align="right" style="width:200px;">售价：</td>
                       <td align="center" style="width:100px;"><input id="iosurl" readonly="readonly" style="width:100px; height:30px;"/></td>
                       <td>(计算奖金中最大可以填写的折扣数字 )</td></tr>
                       <tr>
                       <td align="right" style="width:200px;">提成比例：</td>
                       <td align="center" style="width:100px;"><input id="Text1" readonly="readonly"  style="width:100px; height:30px;"/></td>
                       <td>(奖金计算中的提成比例)</td></tr>
                       <tr>
                       <td align="right" style="width:200px;">提成比例(墓地)：</td>
                       <td align="center" style="width:100px;"><input id="Text2" readonly="readonly"  style="width:100px; height:30px;"/></td>
                       <td> (员工实际销售墓地时提成比例)  <button class="btn btn-success loading-btn" id="update2" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">提成比例(祭品)：</td>
                       <td align="center" style="width:100px;"><input id="Text3" readonly="readonly"  style="width:100px; height:30px;"/></td>
                       <td> (员工实际销售祭品时提成比例) <button class="btn btn-success loading-btn" id="update1" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">营销比例：</td>
                       <td align="center" style="width:100px;"><input id="Text4" readonly="readonly"  style="width:100px; height:30px;"/></td>
                       <td> (通常为80%)</td></tr>
                       <tr>
                       <td align="right" style="width:200px;">总业绩比率:</td>
                       <td align="center" style="width:100px;"><input id="Text5" readonly="readonly"  style="width:100px; height:30px;"/></td>
                       <td>(通常为1%)</td></tr>
                       <tr>
                       <td align="right" style="width:200px;">税率：</td>
                       <td align="center" style="width:100px;"><input id="Text7" readonly="readonly" style="width:100px; height:30px;"/></td>
                       <td> (通常为10%) <button class="btn btn-success loading-btn" id="update" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">公告价格：</td>
                       <td><input id="Text6" readonly="readonly" style="width:100px; height:30px;"/></td>
                       <td align="center" style="width:400px;">  <button class="btn btn-success loading-btn" id="allupdate" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    确认修改
							                    </button></td>  </tr>
                      </table>
                           
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
    $(function () {
        $("#update1").click(function () {
            $("#Text3").removeAttr("readonly");
            var cObj = document.getElementById("Text2");

            cObj.setAttribute("readOnly", 'true');
            var cObj2 = document.getElementById("Text7");
            cObj2.setAttribute("readOnly", 'true');
        });
        $("#update").click(function () {
            $("#Text7").removeAttr("readonly");
            var cObj1 = document.getElementById("Text2");
            cObj1.setAttribute("readOnly", 'true');
            var cObj2 = document.getElementById("Text3");
            cObj2.setAttribute("readOnly", 'true');
        });

        $("#update2").click(function () {
            $("#Text2").removeAttr("readonly");
            var cObj1 = document.getElementById("Text3");
            cObj1.setAttribute("readOnly", 'true');
            var cObj2 = document.getElementById("Text7");
            cObj2.setAttribute("readOnly", 'true');
        });
        $("#allupdate").click(function () {
            alert("所有绑定事件");

        });

    });
</script>

</asp:Content>
