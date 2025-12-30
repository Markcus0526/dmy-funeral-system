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
								<i class="fa  fa-university"></i>修改后台用户
							</div>
							
						</div>
						<div class="portlet-body">
                         <form class="form-horizontal" id="validation-form">
                      <table style="width:780px; height:300px; margin-left:50px;">
                          <tr>
                         <td align="right"style="width:80px;">
                         超管姓名&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <input id="real_name" name="real_name"onblur="check1(this.value)" style="width:180px;height:30px;" />
                         </td>
                           <td style="width:200px;">
                         <input id="Text8" readonly="readonly" style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="phone" name="phone" onblur="check2(this.value)" style="width:180px;height:30px;"/></td>
                          <td style="width:200px;">
                         <input id="Text2" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         Q Q&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="qqname" name="qqname" style="width:180px;height:30px;"/></td>
                          <td style="width:200px;">
                         <input id="Text3" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                         <td  align="right" style="width:80px;">
                           微 信&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="weixin" name="weixin" style="width:180px;height:30px;"/></td>
                           <td style="width:200px;">
                         <input id="Text4" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                         <td id="td1" style=" display:none"></td>
                         <td  align="right" style="width:80px;">
                          登陆账号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<input id="name" name="name" onblur="check6(this.value)" style="width:180px;height:30px;"/></td>
                           <td style="width:200px;">
                         <input id="Text6" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                      <tr>
                      <td>
                      <input type="hidden" id="id" class="img"  name="id" value="<%=ViewData["id"] %>" />
                      </td>
                      <td align="right">
                          
                      </td>
                      </tr>
                      </table>
                     
                         <table id="listTable" class="table table-bordered table-hover dataTable " style="clear:right; width:890px; margin:0px; padding:0px;">
                        <tbody>
                            <tr>
                                <td rowspan="2" style="width:200px; text-align:center;">
									<label>
										<span class="lbl"> 园区信息管理</span>
									</label>
						        </td>
				            </tr>
							<tr>
							    <td>
									<input name="configuration" id="meta1-1" type="checkbox" class="ace indbtn li-1" data-id="1" value="TombSite" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("TombSite")) { %> checked <% } %> />
									<label class="lbl" for="meta1-1"> 墓地类管理</label>
                                    <input name="configuration" id="meta1-2" type="checkbox" class="ace indbtn li-1" data-id="1" value="TombService" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("TombService")) { %> checked <% } %> />
									<label class="lbl" for="meta1-2"> 服务类管理</label>
                                    <input name="configuration" id="meta1-3" type="checkbox" class="ace indbtn li-1" data-id="1" value="Sacrifice" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("Sacrifice")) { %> checked <% } %> />
									<label class="lbl" for="meta1-3">  祭拜用品管理</label>
                                    <input name="configuration" id="meta1-4" type="checkbox" class="ace indbtn li-1" data-id="1" value="Yitiaolong" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("Yitiaolong")) { %> checked <% } %> />
									<label class="lbl" for="meta1-4">一条龙服务</label>
                                    </br>
                                        </br>
                                    <input name="configuration" id="meta1-5" type="checkbox" class="ace indbtn li-1" data-id="1" value="TombInfomation" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("TombInfomation")) { %> checked <% } %> />
									<label class="lbl" for="meta1-5"> 园区信息修改</label>
                                     <input name="configuration" id="meta1-6" type="checkbox" class="ace indbtn li-1" data-id="1" value="Office" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("Office")) { %> checked <% } %> />
									<label class="lbl" for="meta1-6"> 办事处管理</label>
                                     <input name="configuration" id="meta1-7" type="checkbox" class="ace indbtn li-1" data-id="1" value="TombActivity" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("TombActivity")) { %> checked <% } %> />
									<label class="lbl" for="meta1-7"> 园区活动管理</label>
                                     <input name="configuration" id="meta1-8" type="checkbox" class="ace indbtn li-1" data-id="1" value="TombNodify" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("TombNodify")) { %> checked <% } %> />
									<label class="lbl" for="meta1-8"> 园区通知管理</label>
                                       <input name="configuration" id="meta1-9" type="checkbox" class="ace indbtn li-1" data-id="1" value="TombManage" 
                                        <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("TombManage")) { %> checked <% } %> />
									<label class="lbl" for="meta1-9"> 园区管理</label>
							    </td>
				            </tr>
                            <tr>
                                <td rowspan="2" style="width:200px; text-align:center;">
                                    <label>
									<span class="lbl">预约管理</span>
                                    </label>
						        </td>
				            </tr>
							<tr>
							    <td>
                                    <div style="float:left">
                                        <input name="configuration" id="meta2-1" type="checkbox" class="ace indbtn li-2" data-id="2" value="ReserveVisit" 
                                              <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("ReserveVisit")) { %> checked <% } %>/>
										<label class="lbl" for="meta2-1"> 参观预约管理</label>
                                        <input name="configuration" id="meta2-2" type="checkbox" class="ace indbtn li-2" data-id="2" value="ReserveLuozang" 
                                              <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("ReserveLuozang")) { %> checked <% } %>/>
										<label class="lbl" for="meta2-2"> 落葬仪式预约</label>
                                        <input name="configuration" id="meta2-3" type="checkbox" class="ace indbtn li-2" data-id="2" value="ReserveDaijibai" 
                                              <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("ReserveDaijibai")) { %> checked <% } %>/>
										<label class="lbl" for="meta2-3"> 代祭拜预约</label>
                                        </br>
                                        </br>
                                        <input name="configuration" id="meta2-4" type="checkbox" class="ace indbtn li-2" data-id="2" value="ReserveZijibai" 
                                              <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("ReserveZijibai")) { %> checked <% } %>/>
										<label class="lbl" for="meta2-4"> 自祭拜预约</label>
                                        <input name="configuration" id="meta2-5" type="checkbox" class="ace indbtn li-2" data-id="2" value="ReserveTombSite" 
                                              <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("ReserveTombSite")) { %> checked <% } %>/>
										<label class="lbl" for="meta2-5"> 陵墓预约订单</label>
                                        <input name="configuration" id="meta2-6" type="checkbox" class="ace indbtn li-2" data-id="2" value="ReserveNote" 
                                              <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("ReserveNote")) { %> checked <% } %>/>
										<label class="lbl" for="meta2-6"> 备注信息修改</label>
                                    </div>
							    </td>
				            </tr>
                            <tr>
                                <td rowspan="2" style="width:200px; text-align:center;">
									<label>
										<span class="lbl"> 系统用户管理</span>
									</label>
						        </td>
				            </tr>
							<tr>
							    <td>
                                    <div style="float:left">
									<input name="configuration" id="meta3-1" type="checkbox" class="ace indbtn li-3" data-id="3" value="LeaveStatistic" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("LeaveStatistic")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-1"> 员工休假统计</label>
                                    <input name="configuration" id="meta3-2" type="checkbox" class="ace indbtn li-3" data-id="3" value="LeaveSetting" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("LeaveSetting")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-2"> 休假设置</label>
                                    <input name="configuration" id="meta3-3" type="checkbox" class="ace indbtn li-3" data-id="3" value="LeaveManage" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("LeaveManage")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-3"> 员工休假管理</label>
                                    
									<input name="configuration" id="meta3-4" type="checkbox" class="ace indbtn li-3" data-id="3" value="UserJiukehu" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("UserJiukehu")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-4">旧客户用户管理</label>
                                    </br>
                                        </br>
                                    <input name="configuration" id="meta3-5" type="checkbox" class="ace indbtn li-3" data-id="3" value="UserYuangong" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("UserYuangong")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-5"> 员工用户管理</label>
                                    <input name="configuration" id="meta3-6" type="checkbox" class="ace indbtn li-3" data-id="3" value="UserDaixiaoshang" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("UserDaixiaoshang")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-6"> 代销商用户管理</label>
                             
									<input name="configuration" id="meta3-7" type="checkbox" class="ace indbtn li-3" data-id="3" value="UserZhuren" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("UserZhuren")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-7"> 办事处主任用户管理</label>
                                    <input name="configuration" id="meta3-8" type="checkbox" class="ace indbtn li-3" data-id="3" value="UserHouTai" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("UserHouTai")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-8"> 后台用户管理</label>
                                    <input name="configuration" id="meta3-9" type="checkbox" class="ace indbtn li-3" data-id="3" value="UserLingDao" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("UserLingDao")) { %> checked <% } %>/>
									<label class="lbl" for="meta3-9"> 领导用户管理</label>
                                    </div>
							    </td>
				            </tr>
						    <tr>
                                <td rowspan="3" style="width:200px; text-align:center;">
									<label>
										<span class="lbl"> 其他业务管理</span>
									</label>
						        </td>
				            </tr>
							<tr>
							    <td>
                                    <div style="float:left">
                                    <input name="configuration" id="meta4-1" type="checkbox" class="ace indbtn li-4" data-id="4" value="AchievementManage" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("AchievementManage")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-1"> 业绩管理</label>
                                    <input name="configuration" id="meta4-2" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherDiqu" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherDiqu")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-2"> 地区管理</label>
                                     <input name="configuration" id="meta4-3" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherYouxi" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherYouxi")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-3"> 游戏上传</label>
                                     <input name="configuration" id="meta4-4" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherYishizhu" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherYishizhu")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-4"> 衣食住行管理</label>
                                     <input name="configuration" id="meta4-5" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherLvyou" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherLvyou")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-5"> 旅游景点管理</label>
                                    <br />
                                    <br />
                                     <input name="configuration" id="meta4-6" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherZhenjiangjin" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherZhenjiangjin")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-6"> 真奖金计算公式</label>
                                     <input name="configuration" id="meta4-7" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherJiajiangjin" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherJiajiangjin")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-7"> 假奖金计算公式</label>
                                     <input name="configuration" id="meta4-8" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherZerene" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherZerene")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-8"> 责任额调度</label>
                                     <input name="configuration" id="meta4-9" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherXiugaimima" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherXiugaimima")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-9"> 修改密码</label>
                                      <br />
                                    <br />
                                     <input name="configuration" id="meta4-10" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherShujutiaozheng" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherShujutiaozheng")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-10"> 数据调整</label>
                                   
                                       <input name="configuration" id="meta4-11" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherYuliutiaozheng" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherYuliutiaozheng")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-11"> 贵宾证管理</label>
                                      <input name="configuration" id="Checkbox1" type="checkbox" class="ace indbtn li-4" data-id="4" value="OtherKaoshi" 
                                          <% if (ViewData["role"] != null && ViewData["role"].ToString().Split(',').Contains("OtherKaoshi")) { %> checked <% } %>/>
									<label class="lbl" for="meta4-11"> 考试管理</label>
                                    </div>
							    </td>
				            </tr>
                        </tbody>
                    </table>
                    </form>
                      <button id="sett" class="btn btn-success loading-btn" type="reset" onclick="javascript:addscenic();" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								确定添加
							</button>					
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
     var flag1=false;
     var flag2=false;
     var flag3=false;
     var flag4=false;
     var flag5=false;
     var flag6=false;
     var flag7=false;
     function check1(value){
     if(value.length>50){
        document.getElementById("Text8").style.display="block";
        $('#Text8').val("输入的字数不能多于50字");
        flag1 =false;
        }else  if(value.length<=0){
        document.getElementById("Text8").style.display="block";
        $('#Text8').val("输入不能为空");
        flag1 =false;
        }else{
        document.getElementById("Text8").style.display="none";
        flag1 =true;
        }
     }
      function check2(value){
       if(value.length>20){
        document.getElementById("Text2").style.display="block";
        $('#Text2').val("输入的字数不能多于20字");
        flag2 =false;
        }else  if(value.length<=0){
        document.getElementById("Text2").style.display="block";
        $('#Text2').val("输入不能为空");
        flag2 =false;
        }else{
        document.getElementById("Text2").style.display="none";
        flag2 =true;
        }
     }
      function check3(value){
       if(value.length>50){
        document.getElementById("Text3").style.display="block";
        $('#Text3').val("输入的字数不能多于50字");
        flag3 =false;
        }else  if(value.length<=0){
        document.getElementById("Text3").style.display="block";
        $('#Text3').val("输入不能为空");
        flag3 =false;
        }else{
        document.getElementById("Text3").style.display="none";
        flag3 =true;
        }
     }
      function check4(value){
       if(value.length>50){
        document.getElementById("Text4").style.display="block";
        $('#Text4').val("输入的字数不能多于50字");
        flag4 =false;
        }else  if(value.length<=0){
        document.getElementById("Text4").style.display="block";
        $('#Text4').val("输入不能为空");
        flag4 =false;
        }else{
        document.getElementById("Text4").style.display="none";
        flag4 =true;
        }
     }
      function check5(value){
       if($("#owner_name").val().length>50){
        document.getElementById("Text5").style.display="block";
        $('#Text5').val("输入的字数不能多于50字");
        flag5 =false;
        }else  if($("#owner_name").val().length<=0){
        document.getElementById("Text5").style.display="block";
        $('#Text5').val("输入不能为空");
        flag5 =false;
        }else{
        document.getElementById("Text5").style.display="none";
        flag5 =true;
        }
     }
      function check6(value){
       if(value.length>50){
        document.getElementById("Text6").style.display="block";
        $('#Text6').val("输入的字数不能多于50字");
        flag6 =false;
        }else  if(value.length<=0){
        document.getElementById("Text6").style.display="block";
        $('#Text6').val("输入不能为空");
        flag6 =false;
        }else{
        document.getElementById("Text6").style.display="none";
        flag6 =true;
        }
     }
      function check7(value){
       if(value.length>50){
        document.getElementById("Text7").style.display="block";
        $('#Text7').val("输入的字数不能多于50字");
        flag7 =false;
        }else  if(value.length<=0){
        document.getElementById("Text7").style.display="block";
        $('#Text7').val("输入不能为空");
        flag7 =false;
        }else{
        document.getElementById("Text7").style.display="none";
        flag7 =true;
        }
     }

    KindEditor.ready(function (K) {
        editor = K.create('#contents1', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
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
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
        }
        initTable1();

    });
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" }).on('change', function () { });
    });
    jQuery(function ($) {  
              $(".select2").css('width', '180px').select2({ minimumResultsForSearch: -1,allowClear:true });
                             $("#name").val("<%= ViewData["name"]%>");
                    $("#real_name").val("<%= ViewData["real_name"]%>");
                    $("#phone").val("<%= ViewData["phone"]%>");
                    $("#weixin").val("<%= ViewData["weixin"]%>");
                    $("#qqname").val("<%= ViewData["qqname"]%>");
                    check1("<%= ViewData["real_name"]%>");
                    check2("<%= ViewData["phone"]%>");
                    check6("<%= ViewData["name"]%>");
        });
     $(document).ready(function() {

            $('#uploadify1').uploadify({
                'buttonText': "选择活动图片",
                //'queueSizeLimit': 1,  //设置上传队列中同时允许的上传文件数量，默认为999
                //'uploadLimit': 1,   //设置允许上传的文件数量，默认为999
                'swf': '<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.swf',

	            'fileTypeExts': '*.jpg;*.png;*.jpeg',
	            'fileTypeDesc': 'Image Files (.jpg,.png,*.jpeg)',
	            'fileSizeLimit': '500KB',
                'onSelectError' : function (file, errorCode, errorMsg) {
                          if(errorCode=="-110")
                          {
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

				        toastr["error"]("超过文件上传大小限制（100kb）!", "温馨敬告");
                          }
                      },
                'uploader':'<%= ViewData["rootUri"] %>ManagePerson/UploadifyImageS',
                'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                    //alert('The file ' + file.name + ' finished processing.');
                },
                'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                    //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
                },
                'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件                                     
                    //alert('文件 ' + file.name + ' 已经上传成功，并返回 ' + response + ' 保存文件名称为 ' + data.SaveName);
                    data = data.replace(/\"/,"");
                    data = data.replace(/\"/,"");
                    $("#img").val(data);
                    $("#picture").attr("src", "<%= ViewData["rootUri"] %>"+ data);
                }
            });
          });

          function addscenic(){
        
          if (flag1==true&&flag2==true&&flag6==true)
            {
            $.ajax({
                url: "<%= ViewData["rootUri"] %>ManagePerson/EditHouTaiYouHuInfo",
                 dataType: "json",
                data:$('#validation-form').serialize(),
                success: function (data) {
                 if (data=="success")
                 {
                 toas1("添加成功");
                 setTimeout(function(){
                 location.href="<%= ViewData["rootUri"] %>ManagePerson/HouTaiYongHu";
                 },3000);
                  
                 }else
                 {
                 toas2(data);
                 }
                }
            });
            }else{
           toas3("验证数据不通过");
            }
            
        
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
