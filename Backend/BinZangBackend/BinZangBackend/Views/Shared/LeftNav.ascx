<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="BinZangBackend.Models" %>
<% var role = UserModel.GetUserRoleInfo(); %>
<!-- BEGIN SIDEBAR -->
    <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
    <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
    <div class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <ul class="page-sidebar-menu" data-auto-scroll="true" data-slide-speed="200">
            <!-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element -->
            <li class="sidebar-toggler-wrapper">
                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                <div class="sidebar-toggler" style="margin-bottom:10px">
          
                </div>
                <!-- END SIDEBAR TOGGLER BUTTON -->
            </li>
            <!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->

            <li class="start <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Home") { %>active <% } %> ">
                <a href="<%=ViewData["rootUri"] %>Home/Index">
                <i class="icon-home"></i>
                <span class="title">首页</span>
                <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Home") { %><span class="selected"></span> <% } %>
                </a>
            </li>
            <li <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "ZoneInformation") { %>class='active' <% } %>>
                <a href="javascript:;">
                <i class="icon-pointer"></i>
                <span class="title">园区信息</span>
                <span class="arrow <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "ZoneInformation") { %>open<% } %>"></span>
                </a>
                <ul class="sub-menu">
                <%if (role != null && (role.Contains("TombSite")||role.Contains("TombService")||role.Contains("Sacrifice"))){%>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ZoneGoods") { %>class='active' <% } %>>
                        <a href="javascript:;">
                        <i class="fa fa-cart-plus"></i>
                        园区商品 
                        <span class="arrow <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ZoneGoods") { %>open<% } %>"></span>
                        </a>
                        <ul class="sub-menu">
                        
                        <%if (role != null && role.Contains("TombSite"))
                          { %>
                        <li <%if (ViewData["level3nav"] != null && ViewData["level3nav"] == "CemeteryManagement") { %>class='active' <% } %>><a href="<%=ViewData["rootUri"] %>ZoneInformation/CemeteryManagement">墓地类管理</a></li>
                        <%} %>
                         <%if (role != null && role.Contains("TombService"))
                          { %>
                        <li <%if (ViewData["level3nav"] != null && ViewData["level3nav"] == "ServiceManagement") { %>class='active' <% } %>><a href="<%=ViewData["rootUri"] %>ZoneInformation/ServiceManagement">服务类管理</a></li>
                        <%} %>
                         <%if (role != null && role.Contains("Sacrifice"))
                          { %>
                        <li <%if (ViewData["level3nav"] != null && ViewData["level3nav"] == "SacrificeManagement") { %>class='active' <% } %>><a href="<%=ViewData["rootUri"] %>ZoneInformation/SacrificeManagement">祭拜用品管理</a></li>
                        <%} %>
                        </ul>
                    </li>
                    <%} %>
                     <%if (role != null && role.Contains("Yitiaolong"))
                          { %>
                    <li <%if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ADragonService") { %>class='active' <% } %>>
                        <a href="<%=ViewData["rootUri"] %>ZoneInformation/ADragonService">
                         <i class="fa fa-yahoo"></i>
                        一条龙服务</a>
                    </li>
                    <%} %>
                    <%if (role != null && role.Contains("TombInfomation"))
                      {%>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "EditZoneInformation") { %>class='active' <% } %>>
                        <a href="<%=ViewData["rootUri"] %>ZoneInformation/CompanyProfile">
                        <i class="fa fa-pencil-square-o"></i>
                        园区信息修改 
                        
                        </a>
                    </li>
                    <%} %>
                          <%if (role != null && role.Contains("Office"))
                       { %>
                    <li <%if (ViewData["level2nav"] != null && ViewData["level2nav"] == "OfficeManagement") { %>class='active' <% } %>>
                        <a href="<%=ViewData["rootUri"] %>ZoneInformation/OfficeManagement">
                        <i class="fa fa-building"></i>
                        办事处管理</a>
                    </li>
                    <%} %>
                          <%if (role != null && role.Contains("TombActivity"))
                       { %>
                    <li <%if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ActivityManagement") { %>class='active' <% } %>>
                        <a href="<%=ViewData["rootUri"] %>ZoneInformation/ActivityManagement">
                        <i class="fa fa-indent"></i>
                        园区活动管理</a>
                    </li>
                    <%} %>
                          <%if (role != null && role.Contains("TombNodify"))
                       { %>
                    <li <%if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ActivityNotice") { %>class='active' <% } %>>
                        <a href="<%=ViewData["rootUri"] %>ZoneInformation/ActivityNotice">
                        <i class="fa fa-volume-up"></i>
                        园区通知管理</a>
                    </li>
                    <%} %>
                          <%if (role != null && role.Contains("TombManage"))
                            { %>
                    <li <%if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ZoneManage") { %>class='active' <% } %>>
                        <a href="<%=ViewData["rootUri"] %>ZoneInformation/ZoneManage">
                        <i class="fa fa-university"></i>
                        园区管理</a>
                    </li>
                    <%} %>
                </ul>
            </li>
            <li <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Res") { %>class='active' <% } %>>
                <a href="javascript:;">
                <i class="icon-envelope-open"></i>
                <span class="title">预约管理</span>
                <span class="arrow <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Res") { %>open<% } %>"></span>
                </a>
                <ul class="sub-menu">
                    <%if (role != null && role.Contains("ReserveVisit"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ViewsReserve") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>ViewsReserve/ViewReserve">
                        <i class="fa fa-server"></i>
                        参观预约管理</a>
                    </li>
                    <%} %>
                    <%if (role != null && role.Contains("ReserveLuozang"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "LuoZangReserve") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>LuoZangReserve/Index">
                        <i class="fa fa-phone-square"></i>
                        落葬仪式预约</a>
                    </li>
                    <%} %>
                    <%if (role != null && role.Contains("ReserveDaijibai"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "JiBaiReserve") { %>class='active' <% } %>>
                       <a href="<%= ViewData["rootUri"] %>JiBaiReserve/Index">
                       <i class="fa fa-user-times"></i>
                        代祭拜预约</a>
                    </li>
                    <%} %>
                    <%if (role != null && role.Contains("ReserveZijibai"))
                      { %>
                         <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ShangPinOrder") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>ShangPinOrder/Index" >
                        <i class="fa fa-user"></i>
                        自祭拜预约
                        </a>
                    </li>
                    <%} %>
                    <%if (role != null && role.Contains("ReserveTombSite"))
                      { %>
                     <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "LingMuOrder") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>LingMuOrder/Index" >
                        <i class="fa fa-list-alt"></i>
                        陵墓预约订单
                        </a>
                    </li>
                    <%} %>
                    <%if (role != null && role.Contains("ReserveNote"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "Remark") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>RemarkInfo/Index" >
                        <i class="fa fa-pencil-square-o"></i>
                      备注信息修改
                        </a>
                    </li>
                   <%} %>
                   <%-- <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "CallBack") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>CallBack/Index">
                        代寄拜回函发送
                        <i class="icon-envelope"></i>                        
                        </a>
                    </li>--%>
                </ul>
            </li>
            <li <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "SystemPerson") { %>class='active' <% } %>>
                <a href="javascript:;">
                <i class="icon-user"></i>
                <span class="title">系统用户管理</span>
                
                <span class="arrow <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "SystemPerson") { %>open<% } %>"></span>
                </a>
                <ul class="sub-menu">
                   
                     <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "Vacation") { %>class='active' <% } %>>
                        <a href="javascript:;">
                        <i class="fa fa-th"></i>
                        休假管理 
                        <span class="arrow <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "Vacation") { %>open<% } %>"></span>
                        </a>
                        <ul class="sub-menu">
                    <%if (role != null && role.Contains("LeaveStatistic"))
                      { %>
                        <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "Employee") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>VacationManage/Index">员工休假统计</a> </li>
                        <%} %>
                        <%if (role != null && role.Contains("ReserveNote"))
                      { %>
                        <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "VSet") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>VacationManage/VacationSet">休假设置</a> </li>
                          <%} %>
                        <%if (role != null && role.Contains("LeaveManage"))
                      { %>
                         <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "VEmployee") { %>class='active' <% } %>>
                         <a href="<%= ViewData["rootUri"] %>VacationManage/EmployeeVacation">员工休假管理</a> </li>
                           <%} %>

                        </ul>
                    </li>

                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ManagePerson") { %>class='active' <% } %>>
                        <a href="javascript:;">
                        <i class="fa fa-users"></i>
                        用户管理 
                        <span class="arrow <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ManagePerson") { %>open<% } %>"></span>
                        </a>
                        <ul class="sub-menu">
                        <%if (role != null && role.Contains("UserJiukehu"))
                      { %>
                        <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "OldCustom") { %>class='active' <% } %> ><a href="<%= ViewData["rootUri"] %>ManagePerson/OldCustom">
                        旧客户</a></li>
                         <%} %>
                        <%if (role != null && role.Contains("UserYuangong"))
                      { %>
                        <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "Staff") { %>class='active' <% } %>><a href="<%= ViewData["rootUri"] %>ManagePerson/Staff">
                        员工</a></li>
                           <%} %>
                        <%if (role != null && role.Contains("UserDaixiaoshang"))
                      { %>
                          <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "DaiXiaoShang") { %>class='active' <% } %> ><a href="<%= ViewData["rootUri"] %>ManagePerson/DaiXiaoShang">
                          代销商</a></li>
                           <%} %>
                        <%if (role != null && role.Contains("UserLingDao"))
                      { %>
                          <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "LingDao") { %>class='active' <% } %> ><a href="<%= ViewData["rootUri"] %>ManagePerson/LingDao">
                          领导</a></li>
                             <%} %>
                        <%if (role != null && role.Contains("UserZhuren"))
                      { %>
                           <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "BanShiChuZhuRen") { %>class='active' <% } %> ><a href="<%= ViewData["rootUri"] %>ManagePerson/BanShiChuZhuRen">
                          办事处主任</a></li>
                           <%} %>
                        <%if (role != null && role.Contains("UserHouTai"))
                      { %>
                          <li <% if (ViewData["level3nav"] != null && ViewData["level3nav"] == "HouTaiYongHu") { %>class='active' <% } %> ><a href="<%= ViewData["rootUri"] %>ManagePerson/HouTaiYongHu">
                          后台使用者</a></li>
                            <%} %>
                        </ul>
                    </li>
                </ul>
            </li>

            <!-- END FRONTEND THEME LINKS -->
            <%if (role != null && role.Contains("AchievementManage"))
            { %>
            <li <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "PerformanceManagement") { %>class='active' <% } %>>
                <a href="<%= ViewData["rootUri"] %>PerformanceManagement/PerformanceManagement">
                <i class="icon-pencil"></i>
                <span class="title">业绩管理</span>
                </a>
            </li>
              <%} %>
            <li <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "OtherFeature") { %>class='active' <% } %>>
                <a href="javascript:;">
                <i class="icon-puzzle"></i>
                <span class="title">其他</span>
                <span class="arrow  <% if (ViewData["level1nav"] != null && ViewData["level1nav"] == "Order") { %>open<% } %>" ></span>
                </a>
                <ul class="sub-menu">
                        <%if (role != null && role.Contains("OtherDiqu"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "DiQuManage") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/DiQuManage">
                        地区管理</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherYouxi"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "GameUpload") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/GameUpload">
                        游戏上传</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherYishizhu"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "BasicLife") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/BasicLife">
                        衣食住行管理</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherLvyou"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "ScenicSpots") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/ScenicSpots">
                        旅游景点管理</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherZhenjiangjin"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "TrueAwardCalculation") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/TrueAwardCalculation">
                        真奖金计算公式</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherJiajiangjin"))
                      { %>
                     <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "FalseAwardCalculation") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/FalseAwardCalculation">
                        假奖金计算公式</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherZerene"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "CoverDispatch") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/CoverDispatch">
                        责任额调度</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherXiugaimima"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "UpdatePassword") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/UpdatePassword">
                         修改密码</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherShujutiaozheng"))
                      { %>
                    <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "DataAdjust") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/DataAdjust">
                         数据调整</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherYuliutiaozheng"))
                      { %>
                     <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "VIP") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/VIP">
                         贵宾证管理</a>
                    </li>
                      <%} %>
                        <%if (role != null && role.Contains("OtherKaoshi"))
                      { %>
                     <li <% if (ViewData["level2nav"] != null && ViewData["level2nav"] == "TImg") { %>class='active' <% } %>>
                        <a href="<%= ViewData["rootUri"] %>OtherFeature/TestImg">
                         考试管理</a>
                    </li>
                      <%} %>

                
                </ul>
            </li>
           
         
        </ul>
    </div>