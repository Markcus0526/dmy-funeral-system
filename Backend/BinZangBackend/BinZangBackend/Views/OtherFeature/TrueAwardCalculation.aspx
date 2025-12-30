<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>


<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>真奖金计算公式
							</div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									个案奖金</a>
								</li>
								<li>
									<a href="#portlet_tab2_2" data-toggle="tab">
									领导奖金 </a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								<div class="tab-pane active" id="portlet_tab2_1">
                                <div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>个案奖金
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:900px; height:550px;" id="table1">
                       <tr>
                       <td align="right" style="width:200px;">最低签约价：</td>
                       <td align="center" style="width:200px;"><input id="zuidiqianyuejia"  style="width:180px; height:30px;"/></td>
                       <td>(单位:%)<button class="btn btn-success loading-btn" id="Button4" onclick="edittrueaward(0)" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td>
                       </tr>
                       <tr>
                       <td align="right" style="width:200px;">提成比例(墓地)：</td>
                       <td align="center" style="width:200px;"><input id="true_mudi_ticheng"  style="width:180px; height:30px;"/></td>
                       <td>(单位:%) (员工实际销售墓地时提成比例)  <button class="btn btn-success loading-btn" id="Button5" onclick="edittrueaward(1)" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">提成比例(祭品)：</td>
                       <td align="center" style="width:200px;"><input id="true_jipin_ticheng"   style="width:180px; height:30px;"/></td>
                       <td>(单位:%) (员工实际销售祭品时提成比例) <button class="btn btn-success loading-btn" id="Button6" onclick="edittrueaward(2)" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">营销比例：</td>
                       <td align="center" style="width:200px;"><input id="yingxiaobili"   style="width:180px; height:30px;"/></td>
                       <td> (单位:%) (通常为80%)<button class="btn btn-success loading-btn" id="Button7"onclick="edittrueaward(3)" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">总业绩比率:</td>
                       <td align="center" style="width:200px;"><input id="zongyejibili" style="width:180px; height:30px;"/></td>
                       <td> (单位:%)(通常为1%)<button class="btn btn-success loading-btn" id="Button8"onclick="edittrueaward(4)" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td></tr>
                       <tr>
                       <td align="right" style="width:200px;">税率：</td>
                       <td align="center" style="width:200px;"><input id="shuilv" style="width:180px; height:30px;"/></td>
                       <td> (单位:%) (通常为10%) <button class="btn btn-success loading-btn" id="Button9" onclick="edittrueaward(5)" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td>
                                                </tr>
                      </table>
                           
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
                        
								</div>
								<div class="tab-pane" id="portlet_tab2_2">
                                <div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>领导奖金
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:900px; height:50px;" id="table2">
                       <tr>
                       <td align="right" style="width:200px;">总业绩比率：</td>
                       <td align="center" style="width:200px;"><input id="lingdaobili"  style="width:180px; height:30px;"/></td>
                       <td> (单位:%)(通常为1%)<button class="btn btn-success loading-btn" id="Button3" onclick="edittrueaward(6)" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    修改
							                    </button></td>
                       </tr>
                      </table>
                           
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
								 
								</div>
					
                              
								</div>
							</div>
						</div>
					</div>

            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
         <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>
<script type="text/javascript">

    $(function () {
        findtrue();

    });
    function findtrue() {
    $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/FindTrueAward",
                success: function (data) {
                $("#true_jipin_ticheng").val(data.true_jipin_ticheng);
                $("#true_mudi_ticheng").val(data.true_mudi_ticheng);
                $("#zongyejibili").val(data.zongyejibili);
                $("#zuidiqianyuejia").val(data.zuidiqianyuejia);
                $("#yingxiaobili").val(data.yingxiaobili);
                $("#lingdaobili").val(data.lingdaobili);
                $("#shuilv").val(data.shuilv);
                }
            }); 
    }

      function edittrueaward(leixing){
     var param="";
     if (leixing==0) {
     param=  $("#zuidiqianyuejia").val();
     }
     if (leixing==2) {
       param=  $("#true_jipin_ticheng").val();
     }if (leixing==3) {
       param=  $("#yingxiaobili").val();
     }if (leixing==4) {
       param=  $("#zongyejibili").val();
     }if (leixing==1) {
       param=  $("#true_mudi_ticheng").val();
     }if (leixing==5) {
       param=  $("#shuilv").val();
     }if (leixing==6) {
       param=  $("#lingdaobili").val();
     }
         var false_mudi_ticheng =$("#false_mudi_ticheng").val();
          $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/EditTrueAward",
               
                data:{"param":param,"leixing":""+leixing},
                method:'post',
                success: function (data) {
                  if (data=="success") {
                toas1("修改成功");
                setTimeout(function(){
                location.href="<%= ViewData["rootUri"] %>OtherFeature/TrueAwardCalculation";
                },3000);
                
                }else{
                toas2(data);
                }
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
</script>

</asp:Content>
