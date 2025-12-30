<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div class="row ">
	<div class="col-xs-12">
<div style="width:700px;margin-left:200px;border:1px solid #CCC;margin-top:20px">
                             <form class="form-horizontal" role="form" id="validation-form">
                            <table cellpadding="0" style="margin-top:20px;" cellspacing="0"width="93%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                        <label>办事处名称：</label>
                                    </td>
                                    <td>
                                        
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px"> 
                                                         <div class="clearfix">                                             	  
                                                          <input id="officename" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly<%} %> type="text" class="officename" name="officename" value="<%=ViewBag.office.name %>"/>
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
                                        <label>办事处图片：</label>

                                    </td>
                                    <td style="text-align:right;">
                                        <div style="margin-top:0px;margin-eft:20px">
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td align="left">
                                                    <div class="form-group" style="margin-left:10px">
                                                    <div class="clearfix">
                                                        <div id="advertCarImg" class="form-group" style="width:160px; border:2px solid #BBB;">
                                                         <img src="<%=ViewData["rootUri"] %><%=ViewBag.office.imgurl %>" id = "picture" height="150px" width="156px"/>	
                                                         <input type="hidden" id="img" class="img"  name="img" value="<% if (ViewBag.office.imgurl != null) { %><%= ViewBag.office.imgurl %><% } %>" />
                                                         </div>
                                                         </div>
                                                      </div>
                                                    </td>
                                                    <td style="text-align:left;">
                                                    <%if( Convert.ToInt32(ViewData["makeid"])==2) {%><div class="form-group" style="margin-left:60px">
                                                        <input type="file" class="upfiles" id="uploadify" name="carImg2" />
                                                   </div>
                                                   <span style="color:red;margin-left:30px">*提示:请选择小于500kb的图片*</span>
                                                   <%} %>
                                                    
                                                   
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">办事处主任：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">
                                           <input id="officehead" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%>readonly<%} %> type="text" class="officehead" name="officehead" value="<%=ViewBag.office.chief %>"  /> 
                                      </div>
                                     </div>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">副主任：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">
                                           <input id="subchief" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%>readonly<%} %> type="text" class="subchief" name="subchief" value="<%=ViewBag.office.subchief %>"/>
                                      </div>
                                     </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>电话：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                    <div class="clearfix">
                                        <input id="phone" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%>readonly<%} %> type="text" class="phone" name="phone" value="<%=ViewBag.office.phone %>" /> 
                                        </div> 
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>地区：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                    <div class="clearfix">
                                     <select class="select2" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%>disabled=disabled<%} %> style="width:40%" id="area"  name="area">
                                           <%
                                               for (int i = 0; i < ViewBag.chengshi.Count; i++)
                                          {   
                                               %>
                                           <option value="<%=ViewBag.chengshi[i].uid %>" ><%=ViewBag.chengshi[i].name%></option>
                                           <% }%>
                               </select>
                                        </div>
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>地址：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                     
                                        <div class="clearfix" style="">
                                           <input type="text" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%>readonly<%} %> id="suggestId" style="width:172px" value="<%=ViewBag.office.address %>" name="suggestId">
                                       
				                   
                                    
						                <a class="btn btn-sm  btn-success cancel" id="positioning"  onclick=""><i class="fa fa-search"></i> 搜索</a>
                                       
                                         </div>
                                     
                                    </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    
                                     <span style="color:red;margin-left:135px">注意：这个只是模糊定位，准确位置请地图上标注!</span> 
                                    <div id="l-map" style="height:200px;border:1px solid #CCC;margin-left:120px"></div>
                                     <div class="form-group" style="margin-top:7px;margin-left:120px">
                                     <div class="clearfix">

                                    <div id="r-result" style="margin-left:0px">
                                        <input type="text" readonly id="lng" name="lng" value="<%=ViewBag.office.longitude %>">
                                        <input type="text" readonly id="lat" value="<%=ViewBag.office.latitude %>" name="lat">
                                    </div>
                                    </div>
                                    </div>
                                    
                                    </td>
                                
                                </tr>
                                
                                <tr>
                                    <td colspan=2 style="text-align:center">
                                   <div style="margin-left:110px">
                  <input id="text1" readonly="readonly" style="margin-top:10px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:50px;color: Red" />
                </div>             <%if( Convert.ToInt32(ViewData["makeid"])==2) {%>
                                        <button class="btn btn-success loading-btn" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-check bigger-110"></i>
								保存
							</button>
                           
                            &nbsp;
                                       <button id="sett" class="btn" type="reset" onclick="reset()" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-undo bigger-110"></i>
								重置
							</button>
                            <%} if (Convert.ToInt32(ViewData["makeid"]) == 1)
                                     {%>
                             
                              <button id="" class="btn" type="reset" onclick="javascript:history.go(-1);" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                             <%} %>
                                    </td>
                                </tr>
                            </table>
                            </form>
                             <br />
                        </div>
 </div>
 </div>
<script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>                        
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo&amp;services=&amp;t=20150330161927"></script>
 <script type="text/javascript" src="<%=ViewData["rootUri"] %>Content/js/baidumap.js"></script>
<script>
var rootUri="<%=ViewData["rootUri"] %>";
var chengshi="<%=ViewBag.office.chengshi_id %>";
$("#area option[value='"+chengshi+"']").attr("selected", "selected"); 
$(document).ready(function() {
    $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });    
     var orgAddr = "<%=ViewBag.office.address %>";
          // $("#address").val(orgAddr);
            if (orgAddr != null && orgAddr != "") {
                var orglng = "<%=ViewBag.office.longitude %>";
                var orglat = "<%=ViewBag.office.latitude %>";
                var orgmark = new BMap.Point(orglng, orglat);
                baidu_map(orgmark);
            } else {
                baidu_map();
            }
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
	                officename: {
	                    required: true
	                },
                    img: {
	                    required: true
	                },
                    officehead: {
	                    required: true
	                },
                    subchief: {
	                    required: true
	                },
                    phone: {
	                    required: true
	                },
                    area: { 
                        required: true
	                },
                    suggestId: {
	                    required: true
	                },
	                lng: {
                        required: true
	                },
                    lat: {
                      required: true

                    },                  
                    contents: {
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
        function submitform() {
        if(check1()==true)
        {
			$.ajax({
				type: "POST",
				url: "<%= ViewData["rootUri"] %>ZoneInformation/UpdateOffice/?uid=<%=ViewBag.office.uid %>",
				dataType: "json",
				data: $('#validation-form').serialize(),
				success: function (data) {
				    if (data == true) {
                            toas1();
                            setTimeout(function(){
                                window.location.href="<%= ViewData["rootUri"] %>ZoneInformation/OfficeManagement";
                            }, 2500);

				    } else {
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
				        toastr["success"]("修改成功!", "恭喜您");
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

				        toastr["error"]("修改失败!", "温馨敬告");
        }
</script>

</asp:Content>
