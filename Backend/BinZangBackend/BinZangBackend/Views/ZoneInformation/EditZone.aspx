<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="example t-vista">
   

        
                          <form class="form-horizontal" role="form" id="validation-form">
                            <table cellpadding="0" style="margin-top:20px;" cellspacing="0"width="93%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                        <label>园区名称：</label>
                                    </td>
                                    <td>
                                        
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px"> 
                                                         <div class="clearfix">                                             	  
                                                          <input id="zonename" type="text" class="zonename" name="zonename" value="<%=ViewBag.Zone.name %>"/>
                                                          </div>
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>园区图片：</label>

                                    </td>
                                    <td style="text-align:right;">
                                        <div style="margin-top:0px;margin-left:20px">
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td align="left">
                                                    <div class="form-group" style="margin-left:10px">
                                                    <div class="clearfix">
                                                        <div id="advertCarImg" class="form-group" style="width:160px; border:2px solid #BBB;">
                                                         <img src="<%=ViewData["rootUri"] %><%=ViewBag.Zone.img_url %>" id = "picture" height="150px" width="156px"/>	
                                                         <input type="hidden" id="img" class="img"  name="img" value="<% if (ViewBag.Zone.img_url != null) { %><%= ViewBag.Zone.img_url %><% } %>" />
                                                         </div>
                                                         </div>
                                                      </div>
                                                    </td>
                                                    <td style="text-align:left;">
                                                    <div class="form-group" style="margin-left:60px">
                                                        <input type="file" class="upfiles" id="uploadify" name="carImg2" />
                                                   </div>
                                                   <span style="color:red;margin-left:30px">*提示:请选择小于500kb的图片*</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">园区类型：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">
                                          <select class="select2" style="width:40%" id="zonetype" disabled=disabled name="zonetype" onchange="seyquyu(this.value)">
                                                <option value="0" >墓地园区</option>
                                                <option value="1" >牌位园区</option>
                                                <option value="2" >其他园区</option>
                                            </select>
                                      </div>
                                     </div>
                                    </td>
                                </tr>
                                 <tr id="quyu" style="display:none">
                                    <td style="text-align:right">
                                        <label style="width:100px">牌位园区添加：</label><br />
                                          <a class="btn btn-sm btn-success cancel" onclick="Addpw()"><i class="fa fa-plus"></i> 添加</a>&nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td>
                                    <div style="margin-left:10px;">
                                       <table id="pwstyle" style="width: 50%;text-align:center;margin-top:1px;">
                                            <tr>
                                                <th style="text-align:center">
                                                    区域名称
                                                </th>
                                                <th style="text-align:center">
                                                    区域排数
                                                </th>
                                                <th style="text-align:center">
                                                    区域列数
                                                </th>
                                                
                                            </tr>
           
                                        </table>
                                    </div>
                                     
                                    </td>
                                </tr>
                                 <tr id="mudipaishu">
                                    <td style="text-align:right">
                                        <label style="width:100px">排数：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">
                                           <input id="paishu" type="text" readonly class="paishu" name="paishu" value="<% if(ViewBag.Zone.row_count==null) {%> <% }else{%><%=ViewBag.Zone.row_count %><%} %>"/>
                                      </div>
                                     </div>
                                    </td>
                                </tr>
                                <tr id="mudilieshu">
                                    <td style="text-align:right;">
                                        <label>列数：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                    <div class="clearfix">
                                        <input id="lieshu" type="text" readonly class="lieshu" name="lieshu" value="<% if(ViewBag.Zone.column_count==null) {%> <% }else{%><%=ViewBag.Zone.column_count %><%} %>" /> 
                                        </div> 
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>园区介绍：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                    <div class="clearfix">
                                         <textarea id="contents" name="contents" style="width:400px;height:200px; resize:none;" rows="8"><%=ViewBag.Zone.description%></textarea>
                                        </div>
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>园区位置：</label>
                                    </td>
                                    <td >
                                    <div class="form-group" style="margin-left:10px">

                                        <div class="clearfix" style="">
                                        
    
                                         <div class="configurator" id="searchBox" >
                                            <div id="FurniDetailDiv" style="margin-top:0px;">        
                                                    
                                                        <img id="zoneimg" width="<%= ViewData["disWidth"] %>" height="<%= ViewData["disHeight"] %>" src="<%=ViewData["rootUri"] %>Content/img/qimg.jpg" /> 
                                                    
                                                    <br />        
                                            </div> 
                                          </div>
                                            <div style="margin-top:10px">
                                             <input id="xpos" readonly type="text" class="xpos" name="xpos" value="<%=ViewBag.Zone.xpos %>" /> 
                                             <input id="ypos" readonly type="text" class="ypos" name="ypos" value="<%=ViewBag.Zone.ypos %>" /> 
                                            </div>
                                       </div>
                                        
 
                                    </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan=2 style="text-align:center">
                                   <div style="margin-left:110px">
                  <input id="text1" readonly="readonly" style="margin-top:10px;text-align:center;width:95%;height:20px; border-style:none;display:none;margin-left:50px;color: Red" />
                </div> 
                                        <button class="btn btn-success loading-btn" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-check bigger-110"></i>
								保存
							</button>
                            &nbsp;
                                       <button id="sett" class="btn" type="reset" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-undo bigger-110"></i>
								重置
							</button>
                           
                                    </td>
                                </tr>
                            </table>
                            </form>
               
    

</div>

<div class="corner rc-bottomleft"></div>
<div class="corner rc-bottomright"></div>

<input type="hidden" id="disWidth" name="disWidth" value="<%= ViewData["disWidth"] %>" />
<input type="hidden" id="disHeight" name="disHeight" value="<%= ViewData["disHeight"] %>" />
<input type="hidden" id="disRatio" name="disRatio" value="<%= ViewData["disRatio"] %>" />
<script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
 <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
 <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
 <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script src="<%= ViewData["rootUri"] %>Content/js/GiftEdit.min.js" type="text/javascript"></script>
<script>
    var div_orgyy=div_orgY;
    var rootUri="<%=ViewData["rootUri"] %>";
    var pwname=new Array();
    var pwpai=new Array();
    var pwlie=new Array();
    var zname= "<%=ViewBag.Zone.name %>";
    var uid= "<%=ViewBag.Zone.uid %>";
    var nametype="<%=ViewBag.Zone.type %>";
    $("#zonetype option[value='"+nametype+"']").attr("selected", "selected"); 
      if(nametype==1)
      {
       $("#quyu").show();
        $("#mudipaishu").hide();
        $("#mudilieshu").hide();
        if(div_orgyy==626||div_orgyy==620)
        {
           if(document.uniqueID){ 
            div_orgY =563;
         }
	     else{
	        div_orgY =569;
	     }
          
        }
        else
        {
           div_orgY=div_orgyy;
        }
         Getpw(uid);
      }
       if(nametype==2)
      {
    
        $("#disWidth").val("<%=ViewData["disWidth2"] %>");
        $("#disHeight").val("<%=ViewData["disHeight2"] %>");
        $("#disRatio").val("<%=ViewData["disRatio2"] %>");
        $("#zoneimg").attr("src", "<%=ViewData["rootUri"] %>Content/img/qita.jpg");
        $("#mudipaishu").hide();
        $("#mudilieshu").hide();
        if(div_orgyy==626||div_orgyy==620)
        {
             
            if(document.uniqueID){ 
                div_orgY =542;
             }
	         else{
	            div_orgY =548;
	         }
        }
        else
        {
           div_orgY=div_orgyy;
        }
       
        onLoad();
       // onMarkObjDestroy(0);
       xPos = "<%=ViewBag.Zone.xpos %>";
        yPos = "<%=ViewBag.Zone.ypos %>";
        zname= "<%=ViewBag.Zone.name %>";
        uid= "<%=ViewBag.Zone.uid %>";
        rowAddFlag = false;
        rowAddIdx = 0;

        $("#xpos").val(xPos);
        $("#ypos").val(yPos);
        onMarkObjCreate(uid, zname, xPos,yPos, true);
        $("#draggable"+uid).draggable({
        start: function (event, ui) {
        },
        drag: function (event, ui) {
            xPos = (ui.position.left - img_orgX) * img_disRatio;
            yPos = (ui.position.top - img_orgY) * img_disRatio;
            $("#xpos").val(parseInt(xPos));
            $("#ypos").val(parseInt(yPos));
        },
        stop: function (event, ui) {
        }
    });
    
      }
      if(nametype==0){
          $("#quyu").hide();
           $("#mudipaishu").show();
           $("#mudilieshu").show();
           $("#pwstyle").append('<tr>'
                              +'<td><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" name="quyuname" style="width:120px"/></div></div></td>'
                              +'<td><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" name="pwpaishu" style="width:120px"/></div></div></td>'
                              +'<td style="text-align:center"><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" name="pwlieshu" style="width:120px"/></div></div></td>'                               
                              + '</tr>');
        if(document.uniqueID){ 
            div_orgyy =602;
         }
	     else{
	        div_orgyy =606;
	     }
      if(document.uniqueID){ 
            div_orgY =620;
         }
	     else{
	        div_orgY =626;
	     }
        onLoad();
       // onMarkObjDestroy(0);
        xPos = "<%=ViewBag.Zone.xpos %>";
        yPos = "<%=ViewBag.Zone.ypos %>";
        zname= "<%=ViewBag.Zone.name %>";
        uid= "<%=ViewBag.Zone.uid %>";
        rowAddFlag = false;
        rowAddIdx = 0;

        $("#xpos").val(xPos);
        $("#ypos").val(yPos);
    onMarkObjCreate(uid, zname, xPos,yPos, true);
    $("#draggable"+uid).draggable({
        start: function (event, ui) {
        },
        drag: function (event, ui) {
            xPos = (ui.position.left - img_orgX) * img_disRatio;
            yPos = (ui.position.top - img_orgY) * img_disRatio;
            $("#xpos").val(parseInt(xPos));
            $("#ypos").val(parseInt(yPos));
        },
        stop: function (event, ui) {
        }
    });
       
      }
   
     function Getpw(uid)
   {
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/Getpw",
                    dataType: "json",
                    data: {
                       
                        uid: uid
                    },
                    async:false,
                    success: function (data) {
                          if (data!=null) {    
                                  pwname=data[0];
                                  pwpai=data[1];
                                  pwlie=data[2];
                                                     var num; 
                                                   if(document.uniqueID){ 
                                                    num=38.1;
                                                  }
	                                                else{
	                                                num=39;
	                                              }
                                  for(var i=0;i<pwname.length;i++)
                                    {
                                        $("#pwstyle").append('<tr>'
                                                              +'<td><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" readonly name="quyuname" style="width:120px" value="'+pwname[i]+'"/></div></div></td>'
                                                              +'<td><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" readonly name="pwpaishu" style="width:120px" value="'+pwpai[i]+'"/></div></div></td>'
                                                              +'<td style="text-align:center"><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" name="pwlieshu" style="width:120px" value="'+pwlie[i]+'"/></div></div></td>'                               
                                                              + '</tr>');
                                       
                                                  
                                        div_orgY+=num;
                                        div_orgyy=div_orgY;
                                        onLoad();
                                       // onMarkObjDestroy(0);
                                       xPos = "<%=ViewBag.Zone.xpos %>";
                                       yPos = "<%=ViewBag.Zone.ypos %>";
                                        rowAddFlag = false;
                                        rowAddIdx = 0;

                                        $("#xpos").val(xPos);
                                        $("#ypos").val(yPos);
                                    onMarkObjCreate(uid, zname, xPos,yPos, true);
                                    $("#draggable"+uid).draggable({
                                        start: function (event, ui) {
                                        },
                                        drag: function (event, ui) {
                                            xPos = (ui.position.left - img_orgX) * img_disRatio;
                                            yPos = (ui.position.top - img_orgY) * img_disRatio;
                                            $("#xpos").val(parseInt(xPos));
                                            $("#ypos").val(parseInt(yPos));
                                        },
                                        stop: function (event, ui) {
                                        }
                                    });
                                                            }
                         
                       }
                       }
                });

    }
    
    
    function Addpw() {
       
         $("#pwstyle").append('<tr>'
                              +'<td><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" name="quyuname" style="width:120px"/></div></div></td>'
                              +'<td><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" name="pwpaishu" style="width:120px"/></div></div></td>'
                              +'<td style="text-align:center"><div class="form-group" style="margin-left:10px"><div class="clearfix"><input type="text" name="pwlieshu" style="width:120px"/></div></div></td>'                               
                              + '</tr>');
                   var num; 
                   if(document.uniqueID){ 
                    num=38.1;
                  }
	                else{
	                num=39;
	              }
        div_orgY+=num;
        div_orgyy=div_orgY;
        onLoad();
       // onMarkObjDestroy(0);
        xPos = "<%=ViewBag.Zone.xpos %>";
        yPos = "<%=ViewBag.Zone.ypos %>";

        rowAddFlag = false;
        rowAddIdx = 0;

        $("#xpos").val(xPos);
        $("#ypos").val(yPos);
    onMarkObjCreate(uid, zname, xPos,yPos, true);
    $("#draggable"+uid).draggable({
        start: function (event, ui) {
        },
        drag: function (event, ui) {
            xPos = (ui.position.left - img_orgX) * img_disRatio;
            yPos = (ui.position.top - img_orgY) * img_disRatio;
            $("#xpos").val(parseInt(xPos));
            $("#ypos").val(parseInt(yPos));
        },
        stop: function (event, ui) {
        }
    });
     }
     function seyquyu(id)
    {
      if(id==1)
      {
       $("#quyu").show();
        $("#mudipaishu").hide();
        $("#mudilieshu").hide();
                                     div_orgY=div_orgyy;
                                        onLoad();
                                       // onMarkObjDestroy(0);
                                       xPos = "<%=ViewBag.Zone.xpos %>";
                                       yPos = "<%=ViewBag.Zone.ypos %>";
                                        rowAddFlag = false;
                                        rowAddIdx = 0;

                                        $("#xpos").val(xPos);
                                        $("#ypos").val(yPos);
                                    onMarkObjCreate(uid, zname, xPos,yPos, true);
                                    $("#draggable"+uid).draggable({
                                        start: function (event, ui) {
                                        },
                                        drag: function (event, ui) {
                                            xPos = (ui.position.left - img_orgX) * img_disRatio;
                                            yPos = (ui.position.top - img_orgY) * img_disRatio;
                                            $("#xpos").val(parseInt(xPos));
                                            $("#ypos").val(parseInt(yPos));
                                        },
                                        stop: function (event, ui) {
                                        }
                                    });
       
      }
      if(id==2)
      {
    
        $("#disWidth").val("<%=ViewData["disWidth2"] %>");
        $("#disHeight").val("<%=ViewData["disHeight2"] %>");
        $("#disRatio").val("<%=ViewData["disRatio2"] %>");
        $("#zoneimg").attr("src", "<%=ViewData["rootUri"] %>Content/img/qita.jpg");
        $("#mudipaishu").hide();
        $("#mudilieshu").hide();
        if(div_orgyy==626||div_orgyy==620)
        {
             
            if(document.uniqueID){ 
                div_orgY =542;
             }
	         else{
	            div_orgY =548;
	         }
        }
        if(id==0)
        {
           div_orgY=div_orgyy;
        }
       
        onLoad();
       // onMarkObjDestroy(0);
       xPos = "<%=ViewBag.Zone.xpos %>";
        yPos = "<%=ViewBag.Zone.ypos %>";
        zname= "<%=ViewBag.Zone.name %>";
        uid= "<%=ViewBag.Zone.uid %>";
        rowAddFlag = false;
        rowAddIdx = 0;

        $("#xpos").val(xPos);
        $("#ypos").val(yPos);
        onMarkObjCreate(uid, zname, xPos,yPos, true);
        $("#draggable"+uid).draggable({
        start: function (event, ui) {
        },
        drag: function (event, ui) {
            xPos = (ui.position.left - img_orgX) * img_disRatio;
            yPos = (ui.position.top - img_orgY) * img_disRatio;
            $("#xpos").val(parseInt(xPos));
            $("#ypos").val(parseInt(yPos));
        },
        stop: function (event, ui) {
        }
    });
    
      }
      else{
           $("#quyu").hide();
           $("#mudipaishu").show();
           $("#mudilieshu").show();
           if(nametype==1)
           {
              if(pwname.length==1)
              {
                if(document.uniqueID){ 
                    div_orgY=div_orgY+21;
                  }
	                else{
	                div_orgY=div_orgY+19;
	              }
                
              }
              else
              {  
                var quyuname = document.getElementsByName("quyuname");
                if(document.uniqueID){ 
                   div_orgY=div_orgY-(quyuname.length-1)*39+21;
                  }
	                else{
	                div_orgY=div_orgY-(quyuname.length-1)*39+19;
	              }
                
              }
              
           }
           else
           {
              if(document.uniqueID){ 
                div_orgY =620;
              }
	         else{
	            div_orgY =626;
	          }
             
           }
        onLoad();
       // onMarkObjDestroy(0);
        xPos = "<%=ViewBag.Zone.xpos %>";
        yPos = "<%=ViewBag.Zone.ypos %>";

        rowAddFlag = false;
        rowAddIdx = 0;

        $("#xpos").val(xPos);
        $("#ypos").val(yPos);
    onMarkObjCreate(uid, zname, xPos,yPos, true);
    $("#draggable"+uid).draggable({
        start: function (event, ui) {
        },
        drag: function (event, ui) {
            xPos = (ui.position.left - img_orgX) * img_disRatio;
            yPos = (ui.position.top - img_orgY) * img_disRatio;
            $("#xpos").val(parseInt(xPos));
            $("#ypos").val(parseInt(yPos));
        },
        stop: function (event, ui) {
        }
    });
       
      }
    }
   
$(document).ready(function() {
 
 $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
    
            $('#uploadify').uploadify({
                'buttonText': "<i class='ace-icon fa fa-book'></i> &nbsp;选择图片",
                'queueSizeLimit': 999,  //设置上传队列中同时允许的上传文件数量，默认为999
                'uploadLimit': 999,   //设置允许上传的文件数量，默认为999
                'swf': rootUri + 'Content/js/uploadify/uploadify.swf',
                 //'auto': false,
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

				        toastr["error"]("超过文件上传大小限制（500kb）!", "温馨敬告");
                          }
                      },
                'uploader': rootUri + 'ZoneInformation/UploadifyActivityImage',
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
              jQuery(function ($) {
            $.validator.messages.remote = "这个办事处可能已经存在！";
	        $.validator.messages.required = "必须要填写";
            $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                zonename: {
	                    required: true
	                },
                    img: {
	                    required: true
	                },
                    zonetype: {
	                    required: true
	                },
                    paishu: {
	                    required: true
	                },
                    lieshu: {
	                    required: true
	                },
                    contents: {
	                    required: true
	                },
                    xpos: {
	                    required: true
	                },
                    xpos: {
	                    required: true
	                }

                    
	            },
	            highlight: function (e) {
	                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
	            },

	            success: function (e) {
	                $(e).closest('.form-group').removeClass('has-error'); //.addClass('has-info');
	                $(e).remove();
	            },

	            errorPlacement: function (error, element) {
	                if (element.is(':checkbox') || element.is(':radio')) {
	                    var controls = element.closest('div[class*="col-"]');
	                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
	                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
	                }
	                else if (element.is('.select2')) {
	                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
	                }
	                else if (element.is('.chosen-select')) {
	                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
	                }
	                else error.insertAfter(element.parent());
	            },

	            submitHandler: function (form) {
	                submitform();
	                return false;
	            },
	            invalidHandler: function (form) {
	               
	            }
          });
	        
    });
     function check1(){
           var img=$("#img").val();
                if (img!=null&&img!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请选择上传图片！");
                return false;
              }
      }
      function check3(id){
      if(id==1)
      {  
             var re = /^[1-9]+[0-9]*]*$/;
             var quyuname = document.getElementsByName("quyuname");
             var pwpaishu = document.getElementsByName("pwpaishu");
             var pwlieshu = document.getElementsByName("pwlieshu");
             var qn=0;
             var pps=0;
             var pls=0;
            for (var i = 0, j = quyuname.length; i < j; i++) {
                if (quyuname[i].value!=null&&quyuname[i].value!="") {
                   
                    qn+=parseInt(0);
                }
               if (quyuname[i].value==null||quyuname[i].value=="") {
                   
                    qn+=parseInt(1);
                 }
                 if (pwpaishu[i].value!=null&&pwpaishu[i].value!=""&&re.test(pwpaishu[i].value)) {
                   
                     pps+=parseInt(0);
                }
                 if (pwpaishu[i].value==null||pwpaishu[i].value==""||!re.test(pwpaishu[i].value)) {
                   
                     pps+=parseInt(1);
                }
                 if (pwlieshu[i].value!=null&&pwlieshu[i].value!=""&&re.test(pwlieshu[i].value)) {
                   
                    pls+=parseInt(0);
                }
                 if (pwlieshu[i].value==null||pwlieshu[i].value==""||!re.test(pwlieshu[i].value)) {
                   
                     pls+=parseInt(1);
                }
               }
          if(qn!=0)
          {
             document.getElementById("text1").style.display="block";
             $('#text1').val("请填写区域名称,注意格式！");
             return false;
          }
           if(pps!=0)
          {
              document.getElementById("text1").style.display="block";
              $('#text1').val("请注意填写区域排数，注意格式！");
              return false;
          }
           if(pls!=0)
          {
              document.getElementById("text1").style.display="block";
              $('#text1').val("请注意填写区域列数，注意格式！");
              return false;
          }
          else
          {
             document.getElementById("text1").style.display="none";
             return true;  
          }
           
      }
      if(id==2)
      {
        return true;
      }
      else
      {
          var re = /^[1-9]+[0-9]*]*$/;
             var paishu=$("#paishu").val();
              var lieshu=$("#lieshu").val();
              if (!re.test(paishu)){
               document.getElementById("text1").style.display="block";
                $('#text1').val("请输入标准排数！");
                return false;
              }
               if (!re.test(lieshu)){
               document.getElementById("text1").style.display="block";
                $('#text1').val("请输入标准列数！");
                return false;
              }
              else
              {
                 document.getElementById("text1").style.display="none";
                return true;
              }
      }
           
      }
        function submitform() {
             var quyuname = document.getElementsByName("quyuname");
             var pwpaishu = document.getElementsByName("pwpaishu");
             var pwlieshu = document.getElementsByName("pwlieshu");
             var quyushu="";
            for (var i = 0, j = quyuname.length; i < j; i++) {
                quyushu+=quyuname[i].value+":"+pwpaishu[i].value+":"+pwlieshu[i].value+",";
               }
           $("#zonetype").attr("disabled", false);
        if(check1()==true&&check3($("#zonetype").val())==true)
        {
			$.ajax({
				type: "POST",
				url: "<%= ViewData["rootUri"] %>ZoneInformation/UpdateZone/?quyushu="+quyushu+"&uid=<%=ViewBag.Zone.uid %>",
				dataType: "json",
				data: $('#validation-form').serialize(),
				success: function (data) {
				    if (data == true) {
                             $("#zonetype").attr("disabled", "disabled");
                            toas1();
                            setTimeout(function(){
                                window.location.href="<%= ViewData["rootUri"] %>ZoneInformation/ZoneManage";
                            }, 2500);

				    } else {
                        $("#zonetype").attr("disabled", "disabled");
				        toas2();
				    }
				},
				error: function (data) {
				    alert("Error: " + data.status);
				    $('.loading-btn').button('reset');
				}
			});
            }
        }
        function toas1() {
           toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
				        toastr["success"]("编辑成功!", "恭喜您");
        }
         function toas2() {
           toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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

				        toastr["error"]("编辑失败!", "温馨敬告");
        }
</script>
</asp:Content>




