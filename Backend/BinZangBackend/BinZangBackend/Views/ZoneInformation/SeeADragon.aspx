<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div style="width:700px;margin-left:200px;border:1px solid #CCC;margin-top:20px">
                             <form class="form-horizontal" role="form" id="validation-form">
                            <table cellpadding="0" style="margin-top:20px;" cellspacing="0"width="93%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                        <label>公司名称：</label>
                                    </td>
                                    <td>
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px">
                                                            <div class="clearfix">                                               	  
                                                          <input id="cname" type="text" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly<%} %> value="<%= ViewBag.adragon.name %>" class="cname" name="cname"/>
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
                                        <label>公司图片：</label>

                                    </td>
                                    <td style="text-align:right;">
                                        <div style="margin-top:0px;margin-left:20px">
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td align="left">
                                                    <div class="form-group" style="margin-left:10px">
                                                       <div class="clearfix">  
                                                        <div id="advertCarImg" class="form-group" style="width:160px; border:2px solid #BBB;">
                                                         <img src="<%=ViewData["rootUri"] %><%=ViewBag.adragon.img_url %>" id = "picture" height="150px" width="156px"/>	
                                                         <input type="hidden" id="img" class="img"  name="img" value="<% if (ViewBag.adragon.img_url != null) { %><%= ViewBag.adragon.img_url %><% } %>" />
                                                         </div>
                                                         </div>
                                                      </div>
                                                    </td>
                                                    <td style="text-align:left;">
                                                     <%if( Convert.ToInt32(ViewData["makeid"])==2) {%>
                                                    <div class="form-group" style="margin-left:60px">
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
                                        <label style="width:100px">套服价格：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                        <div class="clearfix"> 
                                           <input id="price" name="price" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly<%} %> value="<%= ViewBag.adragon.price %>" type="text" style="width:100px"  />元 
                                           </div>
                                      </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">客户认同度：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                        <div class="clearfix"> 
                                           <input id="approve" name="approve" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly <%} %> value="<%= ViewBag.adragon.recognition_degree %>" type="text" placeholder="请输入小于100的认同度" /> 
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
                                        <input id="phone" name="phone" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly <%} %> value="<%= ViewBag.adragon.phone %>" type="text"  />  
                                        <div class="clearfix"> 
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>城市：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                       <div class="clearfix"> 
                                        <select class="select2" style="width:40%" id="chengshi" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> disabled=disabled<%} %>  name="chhengshi" onchange="setarea(this.value)">
                                           <%
                                               for (int i = 0; i < ViewBag.chengshi1.Count; i++)
                                          {   
                                               %>
                                           <option value="<%=ViewBag.chengshi1[i].uid %>" ><%=ViewBag.chengshi1[i].name%></option>
                                           <% }%>
                               </select> 
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
                                        <select class="select2" style="width:40%" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> disabled=disabled<%} %> id="area"  name="area">
                                           
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
                                           <input type="text" id="suggestId" style="width:172px" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly <%} %> value="<%= ViewBag.adragon.address %>" name="suggestId">
                                          <%-- <span for="suggestId" class="help-block"></span>--%>
                                        
				                   
                                    
						                <a class="btn btn-sm  btn-success" id="positioning" onclick=""><i class="fa fa-search"></i> 搜索</a>
                                       
                                        </div>
                                      
                                    </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                     <span style="color:red;margin-left:135px">注意：这个只是模糊定位，准确位置请地图上标注!</span> 
                                    <div id="l-map" style="height:200px;border:1px solid #CCC;margin-left:120px"></div>
                                    <div id="r-result" style="margin-left:120px">
                                        <input type="text" readonly id="lng" name="lng" value="<%= ViewBag.adragon.longitude %>">
                                        <input type="text" readonly id="lat" value="<%= ViewBag.adragon.latitude %>" name="lat">
                                    </div>
                                    </td>
                                
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>服务内容：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px;margin-top:10px">
                                       <div class="clearfix"> 
                                       <textarea id="contents" class="contents" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly<%} %>  name="contents" style="width:350px;height:100px;" rows="8"><%= ViewBag.adragon.service_content%></textarea>
                                    </div>
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>公司简介：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-left:10px">
                                        <div class="clearfix"> 
                                       <textarea id="cdetail" class="cdetail" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly <%} %>  name="cdetail" style="width:350px;height:100px;" rows="8"><%= ViewBag.adragon.description%></textarea>
                                    </div>
                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                
                                    <td style="text-align:right;">
                                        <label>商品介绍：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-top:0px;margin-left:10px">
                                     <div class="clearfix"> 
                                      <textarea id="productdetail" class="productdetail" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%> readonly <%} %>  name="productdetail" style="width:350px;height:200px;" rows="8"><%= ViewBag.adragon.product_description%></textarea>
                                   
                                   </div>
                                    </div>
                                   </td>
                                </tr>
                                <tr>
                                    <td colspan=2 style="text-align:center">
                                    
                                    <input id="text1" readonly="readonly" style="margin-top:-8px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:200px;color: Red" />
                                         <%if( Convert.ToInt32(ViewData["makeid"])==2) {%>
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
                             
                              <button id="" class="btn" onclick="javascript:history.go(-1);" style="margin-top:10px;margin-left:10px">
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
  <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>    
  <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo"></script>
  <script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&amp;ak=6KiyBQlVGmvUvo5kH3FwGlIo&amp;services=&amp;t=20150330161927"></script>
  <script type="text/javascript" src="<%=ViewData["rootUri"] %>Content/js/baidumap.js"></script>
<script>
var rootUri="<%=ViewData["rootUri"] %>";
 var quyu="<%= ViewBag.adragon.quyu_id %>";
 var area="<%= ViewData["chengshi"]%>";
 $("#chengshi option[value='"+area+"']").attr("selected", "selected"); 
  setarea(area);
$(document).ready(function() {
    $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
   
     var orgAddr = "<%= ViewBag.adragon.address %>";
          // $("#address").val(orgAddr);
            if (orgAddr != null && orgAddr != "") {
                var orglng = "<%= ViewBag.adragon.longitude %>";
                var orglat = "<%= ViewBag.adragon.latitude %>";
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
function setarea(id)
{
    document.getElementById("area").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getarea",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                         $("#area").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                                   for (var s in data) {
                                    if (data[s].uid == quyu) {
                                        $("#area").append("<option value=" + data[s].uid + " selected='selected'>" + data[s].name + "</option>");
                                    } else {
                                        $("#area").append("<option value=" + data[s].uid + ">" + data[s].name + "</option>");
                                    }
                                }
                        $("#area").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
                $("#area").append("<option value=" + "0" + ">" + "请选择" + "</option>");
                 $("#area").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
            }
}

      jQuery(function ($) {
            $.validator.messages.remote = "这个办事处可能已经存在！";
	        $.validator.messages.required = "必须要填写";
            $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                cname: {
	                    required: true
	                },
                    img: {
	                    required: true
	                },
                    price: {
	                    required: true
	                },
                    approve: {
	                    required: true
	                },
                    phone: {
	                    required: true
	                },
                    contents: {
	                    required: true
	                },
                    cdetail: {
	                    required: true
	                },
                    productdetail: {
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
      function check4(){
           var area=$("#area").val();
                if (area!=0&&area!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请选择地区！");
                return false;
              }
      }
       function check2(){
           var re = /^[1-9]+[0-9]*]*$/;
           var price=$("#price").val();
                if (re.test(price)) {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请输入整数金额！");
                return false;
              }
      }
       function check3(){
            var reg=/^-?\d+(\.\d*)?$/; //正则表达式
           var approve=$("#approve").val();
                if (reg.test(approve)&&approve<=100) {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请输入标准的认同度！");
                return false;
              }
      }
        function submitform() {
        if(check1()==true&&check2()==true&&check3()==true&&check4()==true)
        {
			$.ajax({
				type: "POST",
				url: "<%= ViewData["rootUri"] %>ZoneInformation/UpdateADragon/?uid=<%= ViewBag.adragon.uid %>",
				dataType: "json",
				data: $('#validation-form').serialize(),
				success: function (data) {
				    if (data == true) {
                            toas1();
                            setTimeout(function(){
                                window.location.href="<%= ViewData["rootUri"] %>ZoneInformation/ADragonService";
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
