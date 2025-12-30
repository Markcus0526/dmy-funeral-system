<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>墓地类商品
							</div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									墓地商品 </a>
								</li>
								<li style="display:none">
									<a href="#portlet_tab2_2" data-toggle="tab">
									牌位商品 </a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								
								<div class="tab-pane active" id="portlet_tab2_1">
									    <div class="row" style="margin-top:20px">
                                        <div class="col-xs-12">
                                            <div class="widget-box">
			                                    <div class="widget-body">
				                                    <div class="widget-main" style="border:1px solid #3B9C96">
                                                        <div class="searchbar" >
                                                            <form class="form-horizontal" role="form" id="validation-form" >
                                                                <!-- 第一行-->
                                                                <br />
                                                                <div class="form-group">  
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:0px" for="">园区</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" style="width:40%" id="zonename"  name="zonename" onchange="setpailie(this.value)">
                                                                               <option value="0" >全部</option>
                                                                               <%
                                                                                   for (int i = 0; i < ViewBag.zone.Count; i++)
                                                                              {   
                                                                                   %>
                                                                               <option value="<%=ViewBag.zone[i].uid %>" ><%=ViewBag.zone[i].name%></option>
                                                                               <% }%>
                                                                   </select> 
                    
						                
                                                                        </div>
				                                                    </div>  
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:70px" for="">排号</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">

                                                                         <select class="select2" style="width:40%" id="cpai"  name="cpai">
                                                                   <option value="0" >全部</option>
                                                                      </select> 
                      
                                                                        </div>
				                                                    </div> 
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:70px" for="">列号</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">

                                                                          <select class="select2" style="width:40%" id="clie"  name="clie" >
                                                                           <option value="0" >请选择</option>
                                                                          </select>
                      
                                                                        </div>
				                                                    </div>
                                                                        <div class="col-sm-1" style="margin-left:90px"">
						                                                    <a class="btn  btn-success" id="find" onclick="search_data()"><i class="fa fa-search"></i> 搜索</a>
                                  
                                                                    </div> 
                                                                    <div class="col-sm-1" style="margin-left:10px"">
						                                                                <a class="btn  btn-success" href="<%=ViewData["rootUri"] %>ZoneInformation/AddCemetery"><i class="fa fa-plus"></i> 增加</a>
                                  
                                                                                </div> 
                                                                     <div class="col-sm-1" style="margin-left:10px"">
						                                                                <a class="btn  btn-success" data-toggle="modal" href="#mudi"><i class="fa fa-pencil-square-o"></i> 批量编辑</a>
                                  
                                                                                </div> 
                                                                </div>
                                                  
                                                </form>
                                            </div>
                     
				                        </div>
			                        </div>
                                    </div>
			                        </div>
		                        </div>
                                    <div class="row" style="margin-top:10px">
				                                    <div class="col-md-12">
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <div class="portlet box green-haze">
						                                    <div class="portlet-title">
							                                    <div class="caption">
								                                    <i class="fa fa-server"></i>墓地类商品
							                                    </div>
							
						                                    </div>
						                                    <div class="portlet-body">
							                                    <table class="table table-striped table-bordered table-hover" id="sample_1" style="text-align:center">
							                                    <thead>
							                                    <tr>
								                                    <th style="text-align:center">
									                                    墓地编号 
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地价格
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地位置
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地图片
								                                    </th>
								                                    <th style="text-align:center">
									                                     购买状态
								                                    </th>
                                
								                                    <th style="text-align:center">
									                                     操作
								                                    </th>
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    
							                                    </tbody>
							                                    </table>
						                                    </div>
					                                    
					                                    <!-- END EXAMPLE TABLE PORTLET-->
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <!-- END EXAMPLE TABLE PORTLET-->
                                                        </div>
                                                        
				                                    </div>
                                                    
                                                    <div id="responsive" class="modal fade" tabindex="-1" data-width="760">
								                                    <div class="modal-header">
									                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                                    <h4 class="modal-title">墓地编辑</h4>
								                                    </div>
								                                    <div class="modal-body">
									                                    <div class="row">
										                                    <div class="col-md-6" style="margin-left:200px">
                                                                                    <input type="hidden" id="uid">
                                                                                    <input type="hidden" id="statusnum">
                                                                                    墓地状态<input class="form-control" readonly id="nstatus" type="text">
                                                                                    <div id="yanzheng">
                                                                                    预留人姓名<input class="form-control" id="yname" type="text" value="">
                                                                                    预留人电话<input class="form-control" id="yphone" type="text" value="">
                                                                                    <a class="btn  btn-success" onclick="yanzheng()" ><i class="fa fa-search"></i> 验证</a>
                                                                                    </div>
                                                                                    <div id="mstatus" style="width:150px;display:none">
												                                    状态更改&nbsp;<select class="select2" id="upstatus"  style="width:150px;" onchange="set(this.value)" >
                                                                                             <option value="0" >请选择</option> 
                                                                                            <option value="2" >已预订</option> 
                                                                                            <option value="4" >未售出</option>            
                                                                                      </select>
                                                                                    </div>
											                                      <div id="dingjin" style="display:none">
                                                                                      
                                                                                      <div id="baoliu">
                                                                                      <div id="info" style="display:none">
                                                                                              购买人名称<input class="form-control" id="bnames" type="text"/>
                                                                                              购买人电话<input class="form-control" id="bphone" type="text"/>
                                                                                              承办人姓名<input class="form-control" id="rname" type="text"/>
                                                                                              承办人电话<input class="form-control" id="rphone" type="text"/>
                                                                                              末者1：<input class="form-control" id="bmname1" type="text"/>
                                                                                              末者2：<input class="form-control" id="bmname2" type="text"/>
                                                                                              抚慰人1：<input class="form-control" id="bfname1" type="text"/>
                                                                                              抚慰人2：<input class="form-control" id="bfname2" type="text"/>
                                                                                      </div>
                                                                                              支付金额<input class="form-control" id="bprice" type="text" onblur="Getdays(this.value)"/>
                                                                                              保留天数<input class="form-control" readonly id="bdays" type="text" placeholder="输入金额判断保留天数" />
                                                                                              <input id="text1" readonly="readonly" style="margin-top:8px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:150px;color: Red" />
                                                                                      </div>
                                                                                   </div>
										
										                                    </div>
										                                    </div>
                                         
									                                    </div>
								
								                                    <div class="modal-footer" id="anniu">
									                                    <button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
									                                    <button type="button" class="btn blue" onclick="UpdateCemetery()">保存</button>
								                                    </div>
							                                    </div>
                            
	
    		                                  </div>
                               
								</div>
								<div class="tab-pane" id="portlet_tab2_2">
									  <div class="row" style="margin-top:20px">
                                        <div class="col-xs-12">
                                            <div class="widget-box">
			                                    <div class="widget-body">
				                                    <div class="widget-main" style="border:1px solid #3B9C96">
                                                        <div class="searchbar" >
                                                            <form class="form-horizontal" role="form" id="Form1" >
                                                                <!-- 第一行-->
                                                                <br />
                                                                <div class="form-group">  
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:0px" for="">园区</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                     <select class="select2" style="width:40%" id="vrzonename"  name="vrzonename" onchange="setqu(this.value)">
                                                                               <option value="0" >请选择</option>
                                                                               <%
                                                                                   for (int i = 0; i < ViewBag.vrzone.Count; i++)
                                                                              {   
                                                                                   %>
                                                                               <option value="<%=ViewBag.vrzone[i].uid %>" ><%=ViewBag.vrzone[i].name%></option>
                                                                               <% }%>
                                                                   </select> 
                    
						                
                                                                        </div>
				                                                    </div>  
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:70px" for="">区号</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">

                                                                          <select class="select2" id="qushu" style="width:150px" onchange="setpailiequ(this.value)">
                                                                                <option value="0" >请选择</option>            
                                                                          </select>
                      
                                                                        </div>
				                                                    </div>
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:70px" for="">排号</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">

                                                                          <select class="select2" id="vrpaishu" style="width:150px" >
                                                                                <option value="0" >请选择</option>            
                                                                          </select>
                      
                                                                        </div>
				                                                    </div> 
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:70px" for="">列号</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">

                                                                          <select class="select2" id="vrlieshu" style="width:150px" >
                                                                                <option value="0" >请选择</option>            
                                                                          </select>
                      
                                                                        </div>
				                                                    </div>
                                                                    </div>
                                                                    <div class="form-group">  
                                                                        <div class="col-sm-1" style="margin-left:10px"">
						                                                    <a class="btn  btn-success" id="A1" onclick="search_data1()"><i class="fa fa-search"></i> 搜索</a>
                                  
                                                                    </div> 
                                                                    <div class="col-sm-1" style="margin-left:10px"">
						                                                                <a class="btn  btn-success" href="<%=ViewData["rootUri"] %>ZoneInformation/AddVren"><i class="fa fa-plus"></i> 增加</a>
                                  
                                                                                </div> 
                                                                     <div class="col-sm-1" style="margin-left:10px"">
						                                                                <a class="btn  btn-success" data-toggle="modal" href="#muwei"><i class="fa fa-pencil-square-o"></i> 批量编辑</a>
                                  
                                                                                </div> 
                                                            </div>
                           
                                                </form>
                                            </div>
                     
				                        </div>
			                        </div>
                                    </div>
			                        </div>
		                        </div>
                                    <div class="row" style="margin-top:10px">
				                                    <div class="col-md-12">
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <div class="portlet box green-haze">
						                                    <div class="portlet-title">
							                                    <div class="caption">
								                                    <i class="fa fa-server"></i>牌位商品
							                                    </div>
							
						                                    </div>
						                                    <div class="portlet-body">
							                                    <table class="table table-striped table-bordered table-hover" id="sample_2" style="text-align:center">
							                                    <thead>
							                                    <tr>
								                                    <th style="text-align:center">
									                                    牌位编号 
								                                    </th>
								                                    <th style="text-align:center">
									                                     牌位价格
								                                    </th>
								                                    <th style="text-align:center">
									                                     牌位位置
								                                    </th>
								                                    <th style="text-align:center">
									                                     购买状态
								                                    </th>
                                
								                                    <th style="text-align:center">
									                                     操作
								                                    </th>
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    </tbody>
							                                    </table>
						                                    </div>
					                                    </div>
					                                    <!-- END EXAMPLE TABLE PORTLET-->
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <!-- END EXAMPLE TABLE PORTLET-->
				                                    </div>
                                                    <div id="paiwei" class="modal fade" tabindex="-1" data-width="760" >
								                                    <div class="modal-header">
									                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                                    <h4 class="modal-title">牌位编辑</h4>
								                                    </div>
								                                    <div class="modal-body">
									                                    <div class="row">
										                                    <div class="col-md-6" style="margin-left:200px">
                                                                                    <input type="hidden" id="pwuid">
                                                                                    <input type="hidden" id="pwstatusnum">
                                                                                    牌位状态<input class="form-control" readonly id="pwstatus" type="text">
                                                                                    <div id="pwyanzheng">
                                                                                    预留人姓名<input class="form-control" id="pwplanname" type="text" value="">
                                                                                    预留人电话<input class="form-control" id="pwplanphone" type="text" value="">
                                                                                    <a class="btn  btn-success" onclick="paiweiyanzheng()" ><i class="fa fa-search"></i> 验证</a>
                                                                                    </div>
                                                                                    <div id="pweditstatus" style="width:150px;display:none">
												                                    状态更改&nbsp;<select class="select2" id="pwupstatus"  style="width:150px;" onchange="set1(this.value)" >
                                                                                             <option value="0" >请选择</option> 
                                                                                            <option value="2" >已预订</option> 
                                                                                            <option value="4" >未售出</option>            
                                                                                      </select>
                                                                                    </div>
											                                      <div id="pwyudingdiv" style="display:none">
                                                                                      
                                                                                      <div id="pwbaoliu">
                                                                                      <div id="pwinfo" style="display:none">
                                                                                              购买人名称<input class="form-control" id="pwbnames" type="text"/>
                                                                                              购买人电话<input class="form-control" id="pwbphone" type="text"/>
                                                                                              承办人姓名<input class="form-control" id="pwrname" type="text"/>
                                                                                              承办人电话<input class="form-control" id="pwrphone" type="text"/>
                                                                                              末者1：<input class="form-control" id="pwbmname1" type="text"/>
                                                                                              末者2：<input class="form-control" id="pwbmname2" type="text"/>
                                                                                              抚慰人1：<input class="form-control" id="pwbfname1" type="text"/>
                                                                                              抚慰人2：<input class="form-control" id="pwbfname2" type="text"/>
                                                                                      </div>
                                                                                              支付金额<input class="form-control" id="pwbprice" type="text" onblur="paiweiGetdays(this.value)"/>
                                                                                              保留天数<input class="form-control" readonly id="pwbdays" type="text" placeholder="输入金额判断保留天数" />
                                                                                              <input id="text2" readonly="readonly" style="margin-top:8px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:150px;color: Red" />
                                                                                      </div>
                                                                                   </div>
										
										                                    </div>
										                                    </div>
                                         
									                                    </div>
								
								                                    <div class="modal-footer" id="pwanniu">
									                                    <button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
									                                    <button type="button" class="btn blue" onclick="UpdatePaiWei()">保存</button>
								                                    </div>
							                                    </div>
                            
	
    		                                    </div>
                                
                        
								</div>
                                
                                
							</div>
						
					</div>
					<!-- END ALERTS PORTLET-->
				</div>
                
   </div>

    

<div id="mudi" class="modal fade" tabindex="-1" data-width="760">
								                                    <div class="modal-header">
									                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                                    <h4 class="modal-title">价格编辑</h4>
								                                    </div>
								                                    <div class="modal-body">
									                                    <div class="row">
										                                    <div class="col-md-6" style="margin-left:200px">
                                                                                    园区&nbsp; <select class="select2" style="width:40%" id="zonename1"  name="zonename1" onchange="setpaiwei(this.value)">
                                                                               <option value="0" >请选择</option>
                                                                               <%
                                                                                   for (int i = 0; i < ViewBag.zone.Count; i++)
                                                                              {   
                                                                                   %>
                                                                               <option value="<%=ViewBag.zone[i].uid %>" ><%=ViewBag.zone[i].name%></option>
                                                                               <% }%>
                                                                   </select> 
                                                                                    <br />
                                                                                    <br />
                                                                                    &nbsp;&nbsp;&nbsp;排 &nbsp;<select class="select2" id="zpai" style="width:150px" >
                                                                                               <option value="0" >请选择</option>        
                                                                                      </select>
                                                                                    <br />
                                                                                    <br />
												                                    墓地价格<input class="form-control" id="mprice" type="text">
											                                        <br />
										                                    </div>
										                                    </div>
                                         
									                                    </div>
								
								                                    <div class="modal-footer">
									                                    <button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
									                                    <button type="button" onclick="UpdatePrice()" class="btn blue">保存</button>
								                                    </div>
							                                    </div>
      <div id="muwei" class="modal fade" tabindex="-1" data-width="760">
								                                    <div class="modal-header">
									                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                                    <h4 class="modal-title">价格编辑</h4>
								                                    </div>
								                                    <div class="modal-body">
									                                    <div class="row">
										                                    <div class="col-md-6" style="margin-left:200px">
                                                                            园区 &nbsp;<select class="select2" id="pwzone" style="width:150px" onchange="setpaiqu(this.value)" >
                                                                                       <option value="0" >请选择</option>
                                                                               <%
                                                                                   for (int i = 0; i < ViewBag.vrzone.Count; i++)
                                                                              {   
                                                                                   %>
                                                                               <option value="<%=ViewBag.vrzone[i].uid %>" ><%=ViewBag.vrzone[i].name%></option>
                                                                               <% }%>                
                                                                                      </select>
                                                                                    <br />
                                                                                    <br />
                                                                                    区号 &nbsp;<select class="select2" id="pwzonenum" style="width:150px" onchange="setpwpai(this.value)" >
                                                                                                 <option value="0" >请选择</option>       
                                                                                      </select>
                                                                                    <br />
                                                                                    <br />
                                                                                     排号 &nbsp;<select class="select2" id="pwpaishu" style="width:150px" >
                                                                                                   <option value="0" >请选择</option>     
                                                                                      </select>
                                                                                    <br />
                                                                                    <br />
												                                    牌位价格<input class="form-control" id="pwprice" type="text">
											                                        <br />
										
										                                    </div>
										                                    </div>
                                         
									                                    </div>
								
								                                    <div class="modal-footer">
									                                    <button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
									                                    <button type="button" class="btn blue" onclick="UpdatepwPrice()">保存</button>
								                                    </div>
							                                    </div>
<div class="corner rc-bottomleft"></div>
<div class="corner rc-bottomright"></div>
    <script src="../../assets/admin/pages/scripts/ui-extended-modals.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <script>

    function setqu(id)
{
    document.getElementById("qushu").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getpwqu",
                    data: { 
                       "quname": id
                       
                     },
                    method: 'post',
                    success: function (data) {
                                    $("#qushu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   for (var s in data) {
                                   
                                        $("#qushu").append("<option value=" + data[s]+ ">" + data[s] + "</option>");
                                   
                                }
                       
                        $("#qushu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
               
               $("#qushu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
              
               $("#qushu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
           }
           setpailiequ($("#qushu").val());
}
function setpailiequ(id)
{
    document.getElementById("vrpaishu").options.length = 0;
    document.getElementById("vrlieshu").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getpwqupai",
                    data: { 
                    "quname": id,
                    "zonename":$("#vrzonename").val()
                     },
                    method: 'post',
                    success: function (data) {
                      
                                   $("#vrpaishu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   $("#vrlieshu").append("<option value=" + "0" + ">" + "请选择" + "</option>");

                                   for (var i=1;i<=data[0];i++) {
                                    
                                        $("#vrpaishu").append("<option value=" + i + ">" + i + "排</option>");
                                    
                                   
                                   }
                                   for (var i=1;i<=data[1];i++) {
                                    
                                        $("#vrlieshu").append("<option value=" + i + ">" + i + "列</option>");
                                    
                                   
                                   }
                                   
                        $("#vrpaishu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                        $("#vrlieshu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                       }
                });
            } else {
               $("#vrpaishu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
               $("#vrlieshu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
              
               $("#vrpaishu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
               $("#vrlieshu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
              
           }
}
   function setpailie(id)
{
    document.getElementById("cpai").options.length = 0;
    document.getElementById("clie").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/GetOneZone",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                   $("#cpai").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   $("#clie").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   for (var i=1;i<=data.row_count;i++) {
                                    
                                        $("#cpai").append("<option value=" + i + ">" + i + "排</option>");
                                    
                                   
                                   }
                                   for (var i=1;i<=data.column_count;i++) {
                                    
                                        $("#clie").append("<option value=" + i + ">" + i + "列</option>");
                                    
                                   
                                   }
                        $("#cpai").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                        $("#clie").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
               $("#cpai").append("<option value=" + "0" + ">" + "请选择" + "</option>");
               $("#clie").append("<option value=" + "0" + ">" + "请选择" + "</option>");
               $("#cpai").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
               $("#clie").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
           }
}
function setpaiwei(id)
{
   
   document.getElementById("zpai").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/GetOneZone",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                   $("#zpai").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                  
                                   for (var i=1;i<=data.row_count;i++) {
                                    
                                        $("#zpai").append("<option value=" + i + ">" + i + "排</option>");
                                    
                                   
                                   }
                                   
                        $("#zpai").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
               $("#zpai").append("<option value=" + "0" + ">" + "请选择" + "</option>");
               
               $("#zpai").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
           }
}

    function setpaiqu(id)
{
    document.getElementById("pwzonenum").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getpwqu",
                    data: { 
                       "quname": id
                       
                     },
                    method: 'post',
                    success: function (data) {
                                    $("#pwzonenum").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   for (var s in data) {
                                   
                                        $("#pwzonenum").append("<option value=" + data[s]+ ">" + data[s] + "</option>");
                                   
                                }
                       
                        $("#pwzonenum").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
               
               $("#pwzonenum").append("<option value=" + "0" + ">" + "请选择" + "</option>");
              
               $("#pwzonenum").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
           }
           setpwpai($("#pwzonenum").val());
}
function setpwpai(id)
{
    document.getElementById("pwpaishu").options.length = 0;

            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getpwqupai",
                    data: { 
                    "quname": id,
                    "zonename":$("#pwzone").val()
                     },
                    method: 'post',
                    success: function (data) {
                      
                                   $("#pwpaishu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   

                                   for (var i=1;i<=data[0];i++) {
                                    
                                        $("#pwpaishu").append("<option value=" + i + ">" + i + "排</option>");
                                    
                                   
                                   }
                                  
                                   
                        $("#pwpaishu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                       
                       }
                });
            } else {
               $("#pwpaishu").append("<option value=" + "0" + ">" + "请选择" + "</option>");
              
               $("#pwpaishu").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
              
           }
}
    function set(id)
    {
      var statusnum=$("#statusnum").val();
      if(id==2)
      {
        if(statusnum!=2)
        {
          $("#anniu").show();
          $("#dingjin").show();
          if(statusnum==1)
            {
              $("#info").hide();
            }
            else
            {
              $("#info").show();
            }
        }
        else
        {
          $("#anniu").hide();
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
				            toastr["error"]("当前状态已经是预定状态!", "温馨敬告");
        }
        
            
      }
      else{
                $("#anniu").show();
              $("#dingjin").hide();
               
      }
    }
    function set1(id)
    {
      var statusnum=$("#pwstatusnum").val();
      if(id==2)
      {
        if(statusnum!=2)
        {
          $("#pwanniu").show();
          $("#pwyudingdiv").show();
          if(statusnum==1)
            {
              $("#pwinfo").hide();
            }
            else
            {
              $("#pwinfo").show();
            }
        }
        else
        {
          $("#pwanniu").hide();
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
				            toastr["error"]("当前状态已经是预定状态!", "温馨敬告");
        }
        
            
      }
      else{
                $("#pwanniu").show();
              $("#pwyudingdiv").hide();
               
      }
    }
    var rootUri = "<%= ViewData["rootUri"] %>";
    var oTable;
    var initTable1;
    var initTable2;
    var oTable2;
    jQuery(document).ready(function () {
     UIExtendedModals.init();
            $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
        //QuickSidebar.init(); // init quick sidebar
        initTable1 = function () {
            var table = $('#sample_1');

            oTable = table.dataTable({
                //"bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource": rootUri + "ZoneInformation/SerchCemmetery",
                "language": {
                    "aria": {
                        "sortAscending": ": activate to sort column ascending",
                        "sortDescending": ": activate to sort column descending"
                    },
                    "emptyTable": "没有相关数据",
                    "info": "显示 _START_ 到 _END_ 共 _TOTAL_ 条",
                    "infoEmpty": "没有相关数据",
                    "infoFiltered": "(共_MAX_ 条数据)",
                    "lengthMenu": "显示 _MENU_ 条",
                    "search": "快速搜索:",
                    "zeroRecords": "没有发现",
                    "sProcessing":"正在搜索......"
                },
                "aoColumns": [
					 {"mDataProp": "cnum","bSortable": false },	
                     {"mDataProp": "price","bSortable": false },
                     {"mDataProp": "zonename","bSortable": false },
                     {"mDataProp": "imgurl","bSortable": false },
                     {"mDataProp": "status","bSortable": false },
                     {"mDataProp": "id","bSortable": false }
				],
                "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"zonename":$("#zonename").val(), "cpai":$("#cpai").val(),"clie":$("#clie").val()} ,
                                           "success": fnCallback
                                     });
                      },
                "order": [
                [0, 'asc']
            ],

                "lengthMenu": [
                [10, 15, 20, -1],
                [10, 15, 20, "All"] // change per page values here
            ],
                "pageLength": 10,

                "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable
            "columnDefs": [
				        {
				            "targets" : 0,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return '<br/><br/>'+data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 1,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return '<br/><br/>'+data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 2,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return '<br/><br/>'+data;
                                
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 3,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return '<img src="'+rootUri+data+'" style="width:100;height:100px;">';
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 4,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                if(data==null)
                                {
                                  return '<br/><br/>未售出';
                                }
                                else
                                {
                                  return '<br/><br/>已售出';
                                }
				            }
				            //sClass: 'center'
				        },
				        {
				            "targets": 5,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
                                  if(row.status==null)
                                  {
                                   return  '<br/><br/><a class="btn btn-success btn-sm" data-toggle="modal" onclick="EditCemetery(' + data + ')" style="font-size:13px">' +
                                    '编辑</a>';
                                  }
                                  else{
                                   return "";
                                  }
                                
                               
				                
				            }
				            //sClass: 'center'
				        }
                    ],
              
            });

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable2 = function () {
            var table = $('#sample_2');

            oTable2 = table.dataTable({
                //"bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource": rootUri + "ZoneInformation/SerchVren",
                "language": {
                    "aria": {
                        "sortAscending": ": activate to sort column ascending",
                        "sortDescending": ": activate to sort column descending"
                    },
                    "emptyTable": "没有相关数据",
                    "info": "显示 _START_ 到 _END_ 共 _TOTAL_ 条",
                    "infoEmpty": "没有相关数据",
                    "infoFiltered": "(共_MAX_ 条数据)",
                    "lengthMenu": "显示 _MENU_ 条",
                    "search": "快速搜索:",
                    "zeroRecords": "没有发现",
                    "sProcessing":"正在搜索......"
                },
                "aoColumns": [
					 {"mDataProp": "cnum","bSortable": false },	
                     {"mDataProp": "price","bSortable": false },
                     {"mDataProp": "zonename","bSortable": false },
                     {"mDataProp": "status","bSortable": false },
                     {"mDataProp": "id","bSortable": false }
				],
                "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"vrzonename":$("#vrzonename").val(), "vrpaishu":$("#vrpaishu").val(),"vrlieshu":$("#vrlieshu").val(),"qushu":$("#qushu").val()} ,
                                           "success": fnCallback
                                     });
                      },
                "order": [
                [0, 'asc']
            ],

                "lengthMenu": [
                [10, 15, 20, -1],
                [10, 15, 20, "All"] // change per page values here
            ],
                "pageLength": 10,

                "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable
            "columnDefs": [
				        {
				            "targets" : 0,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 1,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 2,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return data;
                                
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 3,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                if(data==null)
                                {
                                  return '未售出';
                                }
                                else
                                {
                                  return '已售出';
                                }
				            }
				            //sClass: 'center'
				        },
				        {
				            "targets": 4,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
                                  if(row.status==null)
                                  {
                                   return  '<a class="btn btn-success btn-sm" data-toggle="modal" onclick="Editpaiwei(' + data + ')" style="font-size:13px">' +
                                    '编辑</a>';
                                  }
                                  else{
                                   return "";
                                  }
                                
                               
				                
				            }
				            //sClass: 'center'
				        }
                    ],
              
            });

            var tableWrapper = $('#sample_2_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
        initTable2();   
    });
    function check1(){
           var re = /^[1-9]+[0-9]*]*$/;
           var price=$("#mprice").val();
              if (re.test(price)&&price!="") {
               
               return true;
              }
              else{
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
				            toastr["error"]("请输入标准金额!", "温馨敬告");
                return false;
              }
      }
     function UpdatePrice()
  {

     if(check1()==true)
   {
       if($("#zonename1").val()!=0&&$("#zpai").val()!=0)
       {
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/UpdatePrice",
                    dataType: "json",
                    data: {
                       zonename1:$("#zonename1").val(),
                       zpai:$("#zpai").val(),
                       mprice: $("#mprice").val()
                    },
                    success: function (str) {
                          if (str==true) {    
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
				            toastr["success"]("修改成功!", "恭喜您");
                             
                             setTimeout(function () {
                                   oTable.fnDestroy();  
                                   initTable1();
                                   $('#mudi').modal('hide');
                              }, 2500);
                            }
                         else{
                        
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

				            toastr["error"]("操作失败,没有找到要更改的墓地!", "温馨敬告");
                        
                         }
                       }
                });

          }
          else
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

				            toastr["error"]("请选择要修改的园区和排数!", "温馨敬告");
      }
      }
      
    }
    function EditCemetery(id)
  {
                                $("#mstatus").hide();
                                $("#anniu").hide();
                                $("#yanzheng").hide();
                                 $("#dingjin").hide();
                                $("#mstatus option[value='0']").attr("selected", "selected");
                                 
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/EditCemetery",
                    dataType: "json",
                    data: {
                      uid:id
                    },
                    success: function (data) {
                          if (data!=null) { 
                            $('#responsive').modal('show');
                            $("#statusnum").val(data[0]);
                              if(data[0]==1)
                              {
                                $("#nstatus").val("预约");
                                $("#mstatus").hide();
                                $("#anniu").hide();
                                $("#yanzheng").show();
                                $("#uid").val(data[1]);
                              }
                              if(data[0]==2)
                              {
                                 $("#nstatus").val("预订");
                                 $("#mstatus").hide();
                                 $("#anniu").hide();
                                 $("#yanzheng").show();
                                  $("#uid").val(data[1]);
                              }
                              if(data[0]==3)
                              {
                                  $("#nstatus").val("已售出");
                                   $("#uid").val(data[1]);
                              }
                              if(data[0]==4)
                              {
                                  $("#nstatus").val("未售出");
                                  $("#mstatus").show();
                                  $("#anniu").show();
                                  $("#yanzheng").hide();
                                  $("#uid").val(data[1]);
                              }
                         }        
                         else{
                        
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

				            toastr["error"]("操作失败,没有找到要更改的墓地!", "温馨敬告");
                        
                         }
                       }
                });
      
    }
     function yanzheng()
  {
                               
                                 
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/yanzheng",
                    dataType: "json",
                    data: {
                      uid: $("#uid").val(),
                      yname:$("#yname").val(),
                      yphone:$("#yphone").val()
                    },
                    success: function (str) {
                          if (str==true) { 
                            //$('#responsive').modal('show');
                               $("#mstatus").show();
                               $("#anniu").show();
                               $("#yanzheng").hide();
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
				            toastr["success"]("验证成功!", "恭喜您");
                         }        
                         else{
                        
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

				            toastr["error"]("验证失败", "温馨敬告");
                        
                         }
                       }
                });
      
    }
    function  Getdays(id)
    {
        var re = /^[1-9]+[0-9]*]*$/;
           
         if (re.test(id)) {
             
          $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/Getdays",
                    dataType: "json",
                    data: {
                      price: id,
                      
                    },
                    success: function (data) {
                          if (data!=0) { 
                        
                               $("#bdays").val(data);
                         }        
                         else{
                        
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

				            toastr["error"]("请重新输入金额", "温馨敬告");
                        
                         }
                       }
                });
                
                
                
       }
       else
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

				            toastr["error"]("请输入标准金额！", "温馨敬告");
       }
    }
    function check2(){
                     
                     
                      var statusnum=$("#statusnum").val();
                      
                      var upstatus=$("#upstatus").val();
            if(statusnum==1&&upstatus==2)
            {
                      var bprice=$("#bprice").val();
                      var bdays=$("#bdays").val();
              if (bprice!=null&&bprice!=""&&bdays!=null&&bdays!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("基本的预订信息不能为空！");
                return false;
              }
            }
            if(statusnum!=1&&upstatus==2)
            {
                      var uid= $("#uid").val();
                      var bname=$("#bnames").val();
                      var bphone= $("#bphone").val();
                      var rname=$("#rname").val();
                      var rphone=$("#rphone").val();
                      var bmname1= $("#bmname1").val();
                      var bmname2=$("#bmname2").val();
                      var bfname1= $("#bfname1").val();
                      var bfname2=$("#bfname2").val();
                      var bprice=$("#bprice").val();
                      var bdays=$("#bdays").val();
              if (bprice!=null&&bprice!=""&&bdays!=null&&bdays!=""&&bname!=null&&bname!=""&&bphone!=null&&bphone!=""&&rname!=null&&rname!=""&&rphone!=null&&rphone!=""&&bmname1!=null&&bmname1!=""&&bmname2!=null&&bmname2!=""&&bfname1!=null&&bfname1!=""&&bfname2!=null&&bfname2!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("基本的预订信息不能为空！");
                return false;
              }
            }
             if(upstatus==0)
            {

               document.getElementById("text1").style.display="block";
                $('#text1').val("基本的预订信息不能为空！");
                return false;
            }
             if(upstatus==4)
            {

               document.getElementById("text1").style.display="none";
               return true;
            }
                
                
      }
     
    function UpdateCemetery()
    {
        if(check2()==true)
        {
          $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/UpdateCemetery",
                    dataType: "json",
                    data: {
                      uid: $("#uid").val(),
                      statusnum:$("#statusnum").val(),
                      bname:$("#bnames").val(),
                      bphone: $("#bphone").val(),
                      rname:$("#rname").val(),
                      rphone:$("#rphone").val(),
                      bmname1: $("#bmname1").val(),
                      bmname2:$("#bmname2").val(),
                      bfname1:$("#bfname1").val(),
                      bfname2:$("#bfname2").val(),
                      bprice:$("#bprice").val(),
                      bdays:$("#bdays").val(),
                      upstatus:$("#upstatus").val()
                    },
                    success: function (data) {
                          if (data==1) { 
                            //$('#responsive').modal('show');
                               $("#mstatus").show();
                               $("#anniu").show();
                               $("#yanzheng").hide();
                                $('#responsive').modal('hide');
                                 
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
				            toastr["success"]("操作成功!", "恭喜您");
                             setTimeout(function () {
                                   oTable.fnDestroy();  
                                   initTable1();
                              }, 2500);
                         }        
                         if(data==0){
                        
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

				            toastr["error"]("操作失败", "温馨敬告");
                        
                         }
                         if(data==2){
                        
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

				            toastr["error"]("预留已经过期！", "温馨敬告");
                        
                         }
                         if(data==3){
                        
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

				            toastr["error"]("没有找到承办人！", "温馨敬告");
                        
                         }
                       }
                });
           }
    }
     function Editpaiwei(id)
  {
                                $("#pweditstatus").hide();
                                $("#pwanniu").hide();
                                $("#pwyanzheng").hide();
                                $("#pwyudingdiv").hide();
                                $("#pwupstatus option[value='0']").attr("selected", "selected");
                                 
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/EditPaiWei",
                    dataType: "json",
                    data: {
                      uid:id
                    },
                    success: function (data) {
                          if (data!=null) { 
                            $('#paiwei').modal('show');
                            $("#pwstatusnum").val(data[0]);
                              if(data[0]==1)
                              {
                                $("#pwstatus").val("预约");
                                $("#pweditstatus").hide();
                                $("#pwanniu").hide();
                                $("#pwyanzheng").show();
                                $("#pwuid").val(data[1]);
                              }
                              if(data[0]==2)
                              {
                                 $("#pwstatus").val("预订");
                                 $("#pweditstatus").hide();
                                 $("#pwanniu").hide();
                                 $("#pwyanzheng").show();
                                  $("#pwuid").val(data[1]);
                              }
                              if(data[0]==3)
                              {
                                  $("#pwstatus").val("已售出");
                                   $("#pwuid").val(data[1]);
                              }
                              if(data[0]==4)
                              {
                                  $("#pwstatus").val("未售出");
                                  $("#pweditstatus").show();
                                  $("#pwanniu").show();
                                  $("#pwyanzheng").hide();
                                  $("#pwuid").val(data[1]);
                              }
                         }        
                         else{
                        
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

				            toastr["error"]("操作失败,没有找到要更改的墓地!", "温馨敬告");
                        
                         }
                       }
                });
      
    }
     function paiweiyanzheng()
  {
                               
                                 
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/yanzheng",
                    dataType: "json",
                    data: {
                      uid: $("#pwuid").val(),
                      yname:$("#pwplanname").val(),
                      yphone:$("#pwplanphone").val()
                    },
                    success: function (str) {
                          if (str==true) { 
                            //$('#responsive').modal('show');
                               $("#pweditstatus").show();
                               $("#pwanniu").show();
                               $("#pwyanzheng").hide();
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
				            toastr["success"]("验证成功!", "恭喜您");
                         }        
                         else{
                        
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

				            toastr["error"]("验证失败", "温馨敬告");
                        
                         }
                       }
                });
      
    }
    function  paiweiGetdays(id)
    {
        var re = /^[1-9]+[0-9]*]*$/;
           
         if (re.test(id)) {
             
          $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/Getdays",
                    dataType: "json",
                    data: {
                      price: id
                      
                    },
                    success: function (data) {
                          if (data!=0) { 
                        
                               $("#pwbdays").val(data);
                         }        
                         else{
                        
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

				            toastr["error"]("请重新输入金额", "温馨敬告");
                        
                         }
                       }
                });
                
                
                
       }
       else
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

				            toastr["error"]("请输入标准金额！", "温馨敬告");
       }
    }
    function check5(){
           var re = /^[1-9]+[0-9]*]*$/;
           var price=$("#pwprice").val();
              if (re.test(price)&&price!="") {
               
               return true;
              }
              else{
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
				            toastr["error"]("请输入标准金额!", "温馨敬告");
                return false;
              }
      }
     function UpdatepwPrice()
  {

     if(check5()==true)
   {
       if($("#pwzone").val()!=0&&$("#pwzonenum").val()!=0&&$("#pwpaishu").val()!=0)
       {
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/UpdatePwPrice",
                    dataType: "json",
                    data: {
                       pwzone:$("#pwzone").val(),
                       pwzonenum:$("#pwzonenum").val(),
                       pwpaishu:$("#pwpaishu").val(),
                       pwprice: $("#pwprice").val()

                    },
                    success: function (str) {
                          if (str==true) {    
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
				            toastr["success"]("修改成功!", "恭喜您");
                             
                             setTimeout(function () {
                                   oTable2.fnDestroy();  
                                   initTable2();
                                   $('#muwei').modal('hide');
                              }, 2500);
                            }
                         else{
                        
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

				            toastr["error"]("操作失败,没有找到要更改的牌位!", "温馨敬告");
                        
                         }
                       }
                });

          }
          else
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

				            toastr["error"]("请选择要修改的园区和排数!", "温馨敬告");
      }
      }
      
    }
    function check6(){
                     
                     
                      var statusnum=$("#pwstatusnum").val();
                      
                      var upstatus=$("#pwupstatus").val();
            if(statusnum==1&&upstatus==2)
            {
                      var bprice=$("#pwbprice").val();
                      var bdays=$("#pwbdays").val();
              if (bprice!=null&&bprice!=""&&bdays!=null&&bdays!="") {
               document.getElementById("text2").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text2').val("基本的预订信息不能为空！");
                return false;
              }
            }
            if(statusnum!=1&&upstatus==2)
            {
                      var uid= $("#pwuid").val();
                      var bname=$("#pwbnames").val();
                      var bphone= $("#pwbphone").val();
                      var rname=$("#pwrname").val();
                      var rphone=$("#pwrphone").val();
                      var bmname1= $("#pwbmname1").val();
                      var bmname2=$("#pwbmname2").val();
                      var bfname1= $("#pwbfname1").val();
                      var bfname2=$("#pwbfname2").val();
                      var bprice=$("#pwbprice").val();
                      var bdays=$("#pwbdays").val();
              if (bprice!=null&&bprice!=""&&bdays!=null&&bdays!=""&&bname!=null&&bname!=""&&bphone!=null&&bphone!=""&&rname!=null&&rname!=""&&rphone!=null&&rphone!=""&&bmname1!=null&&bmname1!=""&&bmname2!=null&&bmname2!=""&&bfname1!=null&&bfname1!=""&&bfname2!=null&&bfname2!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text2").style.display="block";
                $('#text2').val("基本的预订信息不能为空！");
                return false;
              }
            }
             if(upstatus==0)
            {

               document.getElementById("text2").style.display="block";
                $('#text2').val("基本的预订信息不能为空！");
                return false;
            }
             if(upstatus==4)
            {

               document.getElementById("text2").style.display="none";
               return true;
            }
                
                
      }
     
    function UpdatePaiWei()
    {
        if(check6()==true)
        {
          $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/UpdatePaiWei",
                    dataType: "json",
                    data: {
                      uid: $("#pwuid").val(),
                      statusnum:$("#pwstatusnum").val(),
                      bname:$("#pwbnames").val(),
                      bphone: $("#pwbphone").val(),
                      rname:$("#pwrname").val(),
                      rphone:$("#pwrphone").val(),
                      bmname1: $("#pwbmname1").val(),
                      bmname2:$("#pwbmname2").val(),
                      bfname1:$("#pwbfname1").val(),
                      bfname2:$("#pwbfname2").val(),
                      bprice:$("#pwbprice").val(),
                      bdays:$("#pwbdays").val(),
                      upstatus:$("#pwupstatus").val()
                    },
                    success: function (data) {
                          if (data==1) { 
                            //$('#responsive').modal('show');
                               $("#pweditstatus").show();
                               $("#pwanniu").show();
                               $("#pwyanzheng").hide();
                                $('#paiwei').modal('hide');
                                 
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
				            toastr["success"]("操作成功!", "恭喜您");
                             setTimeout(function () {
                                   oTable2.fnDestroy();  
                                   initTable2();
                              }, 2500);
                         }        
                         if(data==0){
                        
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

				            toastr["error"]("操作失败", "温馨敬告");
                        
                         }
                         if(data==2){
                        
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

				            toastr["error"]("预留已经过期！", "温馨敬告");
                        
                         }
                         if(data==3){
                        
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

				            toastr["error"]("没有找到承办人！", "温馨敬告");
                        
                         }
                       }
                });
           }
    }
    function search_data() {
         oTable.fnDestroy();  
            initTable1();

           
            }
   function search_data1() {
         oTable2.fnDestroy();  
            initTable2();

           
    }
    </script>


</asp:Content>


    

    