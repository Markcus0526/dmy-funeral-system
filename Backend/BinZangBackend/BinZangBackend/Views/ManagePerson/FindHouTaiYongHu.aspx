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
								<i class="fa  fa-university"></i>查看后台用户
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
                         <%= ViewData["real_name"]%>
                         </td>
                           <td style="width:200px;">
                         <input id="Text8" readonly="readonly" style="width:180px;height:30px; border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <%= ViewData["phone"]%></td>
                          <td style="width:200px;">
                         <input id="Text2" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                        <tr>
                         <td  align="right" style="width:80px;">
                         Q Q&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <%= ViewData["qqname"]%></td>
                          <td style="width:200px;">
                         <input id="Text3" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                         <td  align="right" style="width:80px;">
                           微 信&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;
                         <%= ViewData["weixin"]%></td>
                           <td style="width:200px;">
                         <input id="Text4" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                         <tr>
                         <td id="td1" style=" display:none"></td>
                         <td  align="right" style="width:80px;">
                          登陆账号&nbsp;:&nbsp;
                         </td>
                         <td style="width:200px;">&nbsp;<%= ViewData["name"]%></td>
                           <td style="width:200px;">
                         <input id="Text6" readonly="readonly" style="width:180px;height:30px;border:0px solid #ffffff; color:Red; display: none"/>
                         </td>
                         </tr>
                      <tr>
                      <td>
                      <input type="hidden" id="img" class="img"  name="img" value="Content/Images/default_img.jpg" />
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
                                    </div>
							    </td>
				            </tr>
                        </tbody>
                    </table>
                    </form>
                      <a id="sett" class="btn btn-success loading-btn" type="reset" onclick="javascript:history.go(-1);"style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								返回
							</a>					
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
   
</script>

</asp:Content>
