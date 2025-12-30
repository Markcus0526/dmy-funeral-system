<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/jqplot1250/jquery.jqplot.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css" />
    <div class="row" style=" min-width:1000px">
        <div class="col-md-12">
            <!-- BEGIN EXAMPLE TABLE PORTLET-->
         <div style=" height:50px; margin-top:4%; border:1px solid #3B9C96">
                        <div style="margin-top:1%; margin-left:1%">
                <label>
                    办事处：</label><select class="select2" id="banshichu">   
                    <% for (int i = 0; i < ViewBag.vlist.Count; i++)
                        {  %>
                             <option value="<%=ViewBag.vlist[i].uid %>"><%=ViewBag.vlist[i].name %></option>
                                            <% }%></select>
                                            <label style="margin-left:1%"> 员工姓名：</label><input id="ename" style=" height:28px"/><label style="margin-left: 2%">联系电话：</label><input id="phone" style=" height:28px"/>
                
     <a id="searchdata" class="btn btn-sm btn-success" onclick="searchinfo()" style="margin-left: 2%"><i class="fa fa-search"></i>搜索</a>
            </div>
    </div>
             <div id="chart" style="width:100%; margin-top: 4%;"> </div>
             <div style="width:100%; margin-left: 78%;margin-top:5%" id="l"></div>
                 
            </div>
            <!-- END EXAMPLE TABLE PORTLET-->
            <!-- BEGIN EXAMPLE TABLE PORTLET-->
            <!-- END EXAMPLE TABLE PORTLET-->

    </div>
     <script src="../../Content/jqplot1250/excanvas.js" type="text/javascript"></script>
    <script src="../../Content/jqplot1250/jquery.jqplot.js" type="text/javascript"></script>
   
    <script src="../../Content/jqplot1250/plugins/jqplot.barRenderer.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/jqplot1250/plugins/jqplot.pointLabels.js"></script>
    <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/jqplot1250/plugins/jqplot.categoryAxisRenderer.js"></script>
     <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>


    <script type="text/javascript">
    function searchinfo(){
             var rootUri ="<%= ViewData["rootUri"] %>";
             var ename = $("#ename").val();
             var line1 = [ ];
             var line2 = [ ];
             var line3 = [ ];
             var phone = $("#phone").val();
             var banshichu =$("#banshichu").val();

    if (ename==""||phone=="") {
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
                    toastr["error"]("姓名与联系方式均不能为空！");

    }else{
    $.ajax({
            url :rootUri+"VacationManage/VacationStatic",
				data:{"employeename":ename,"phone":phone,"banid":banshichu},
				dataType : "json",
				method:'post',
				success: function (jsonObject) {
               
               if(jsonObject==false)
               {   var newP = $('#total');
                   newP.remove();
                   $('#l').append('<label  style=" color:#9933CC; font-weight:bold; font-size:medium" id="total">该员工可能不存在！</label>');
				
               }
               else{
                 var newP = $('#total');
   if(newP.length > 0){
      newP.remove();  }
                $('#l').append('<label  style=" color:#9933CC; font-weight:bold; font-size:medium" id="total">'+'该员工今年累计休假:'+jsonObject[0].total+'次'+'</label>');
				for(var t=0;t<parseInt(jsonObject.length);t++){
                              if (jsonObject[t].type==0) {
                                                        if (jsonObject[t].mon==1) {
                                                        line1.push(["一月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==2) {
                                                         line1.push(["二月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==3) {
                                                         line1.push(["三月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==4) {
                                                         line1.push(["四月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==5) {
                                                         line1.push(["五月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==6) {
                                                         line1.push(["六月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==7) {
                                                         line1.push(["七月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==8) {
                                                         line1.push(["八月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==9) {
                                                         line1.push(["九月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==10) {
                                                         line1.push(["十月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==11) {
                                                         line1.push(["十一月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==12) {
                                                         line1.push(["十二月",jsonObject[t].num]);
                                                        }
                              }
                              if (jsonObject[t].type==1) {
                                                        if (jsonObject[t].mon==1) {
                                                        line2.push(["一月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==2) {
                                                         line2.push(["二月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==3) {
                                                         line2.push(["三月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==4) {
                                                         line2.push(["四月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==5) {
                                                         line2.push(["五月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==6) {
                                                         line2.push(["六月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==7) {
                                                         line2.push(["七月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==8) {
                                                         line2.push(["八月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==9) {
                                                         line2.push(["九月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==10) {
                                                         line2.push(["十月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==11) {
                                                         line2.push(["十一月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==12) {
                                                         line2.push(["十二月",jsonObject[t].num]);
                                                        }
                              }
                              if (jsonObject[t].type==2) {
                                                       if (jsonObject[t].mon==1) {
                                                        line3.push(["一月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==2) {
                                                         line3.push(["二月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==3) {
                                                         line3.push(["三月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==4) {
                                                         line3.push(["四月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==5) {
                                                         line3.push(["五月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==6) {
                                                         line3.push(["六月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==7) {
                                                         line3.push(["七月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==8) {
                                                         line3.push(["八月",jsonObject[t].num]);
                                                        }if (jsonObject[t].mon==9) {
                                                         line3.push(["九月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==10) {
                                                         line3.push(["十月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==11) {
                                                         line3.push(["十一月",jsonObject[t].num]);
                                                        }
                                                        if (jsonObject[t].mon==12) {
                                                         line3.push(["十二月",jsonObject[t].num]);
                                                        }
                              }
             
             
                }//for
                       //--最简
            plot = $.jqplot('chart', [line1,line2,line3], {
                    title: {
            text:'员工出勤统计',  //设置当前图的标题
            show: true,//设置当前图的标题是否显示
    },
           
                seriesDefaults: {
                 seriesColors: [ "#4bb2c5", "#c5b47f", "#EAA228", "#579575", "#839557", "#958c12", 
                                       "#953579", "#4b5de4", "#d8b83f", "#ff5800", "#0085cc"], 
                    renderer: $.jqplot.BarRenderer, //使用柱状图表示
                    rendererOptions: {
                        barMargin: 15, //柱状体组之间间隔
                        barWidth:20,//柱的宽度
              
                       
                    },
                     pointLabels: {  //数据点文本设置,需要页面引用jqplot.pointLabels.js  
                show: true,  //是否固定显示数值  
                formatString: "%d",  //格式  
                location: "ne"   //位置  
            }
             
                },
                 legend:{  
                            show:true,  
                            placement:'inside', // 图例位于图表外部，placement默认值为insideGrid，等价于inside，还可取值outside，等价于outsideGrid  
                            location: 'ne',
                            labels : ['正常休假', '病假', '事假'],
                            fontSize:'16px',
                           
                      }, 
                  axesDefaults: {
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
               tickOptions: {
                     fontFamily: 'Tahoma',
                     angle:-50,
                   fontSize: '16px'
                }
             },
         
                 axes: {
                    xaxis: {
                        
                    label: "月份", //指定X轴的说明文字
                             pad: 0 ,//指定X轴的缩放因子，当这个值大于1后我们的图表会缩放
                        renderer: $.jqplot.CategoryAxisRenderer,
                       
                       
                        //x轴绘制方式
                    },
                       yaxis: {
                        min:0,
                        max:32,
                        label: "休假次数", //指定Y轴的说明文字
                          
                   autoscale: true,
                 
                     
               },
                     x2axis: {
                     renderer:$.jqplot.CategoryAxisRenderer, //指定X轴显示分类
                   
                },
         
                },
                
   series: [{
                           showLine: true,
                           //lineWidth: 4, //指定折线的宽度
                         color:'#66CC00' //指定折线的样式
                     },
                 {  //指定折线的宽度
                     showLine: true,
                     //lineWidth: 4, //指定是否显示线条
                    color:  '#FF0033 '  //size设置每个节点的大小
                 },{  showLine: true,
                      //   lineWidth: 2, //指定折线的宽度
                        color: '#0099CC' //指定折线的样式
                     },

                 ]


            }).replot();

               }
	           

                }//success
            

    });//ajax
    }
    }
    jQuery(function ($) {
              $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
        });
     $(function () {

           
   var line1 = [ ];
                    
          
      line1.push(["一月",0]);
      line1.push(["二月",0]);
       line1.push(["三月",0]);
      line1.push(["四月",0]);
       line1.push(["五月",0]);
      line1.push(["六月",0]);
       line1.push(["七月",0]);
      line1.push(["八月",0]);
       line1.push(["九月",0]);
      line1.push(["十月",0]);
       line1.push(["十一月",0]);
        line1.push(["十二月",0]);
   
        
 
         
         
       
       
    
         

         
  
         
            

            //--最简
            plot = $.jqplot('chart', [line1,line1,line1], {
                    title: {
            text:'员工出勤统计',  //设置当前图的标题
            show: true,//设置当前图的标题是否显示
    },
           
                seriesDefaults: {
                 seriesColors: [ "#4bb2c5", "#c5b47f", "#EAA228", "#579575", "#839557", "#958c12", 
                                       "#953579", "#4b5de4", "#d8b83f", "#ff5800", "#0085cc"], 
                    renderer: $.jqplot.BarRenderer, //使用柱状图表示
                    rendererOptions: {
                        barMargin: 15, //柱状体组之间间隔
                        barWidth:20,//柱的宽度
              
                       
                    },
                     pointLabels: {  //数据点文本设置,需要页面引用jqplot.pointLabels.js  
                show: true,  //是否固定显示数值  
                formatString: "%d",  //格式  
                location: "ne"   //位置  
            }
             
                },
                 legend:{  
                            show:true,  
                            placement:'inside', // 图例位于图表外部，placement默认值为insideGrid，等价于inside，还可取值outside，等价于outsideGrid  
                            location: 'ne',
                            labels : ['正常休假', '病假', '事假'],
                            fontSize:'16px',
                           
                      }, 
                  axesDefaults: {
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
               tickOptions: {
                     fontFamily: 'Tahoma',
                     angle:-50,
                   fontSize: '16px'
                }
             },
         
                 axes: {
                    xaxis: {
                        
                    label: "月份", //指定X轴的说明文字
                             pad: 0 ,//指定X轴的缩放因子，当这个值大于1后我们的图表会缩放
                        renderer: $.jqplot.CategoryAxisRenderer,
                       
                       
                        //x轴绘制方式
                    },
                       yaxis: {
                        min:0,
                        max:32,
                        label: "休假次数", //指定Y轴的说明文字
                          
                   autoscale: true,
                 
                     
               },
                     x2axis: {
                     renderer:$.jqplot.CategoryAxisRenderer, //指定X轴显示分类
                   
                },
         
                },
                
   series: [{
                           showLine: true,
                           //lineWidth: 4, //指定折线的宽度
                         color:'#66CC00' //指定折线的样式
                     },
                 {  //指定折线的宽度
                     showLine: true,
                     //lineWidth: 4, //指定是否显示线条
                    color:  '#FF0033 '  //size设置每个节点的大小
                 },{  showLine: true,
                      //   lineWidth: 2, //指定折线的宽度
                        color: '#0099CC' //指定折线的样式
                     },

                 ]


            }).replot();
            /*
            //--双柱状图
            plot1 = $.jqplot('chart1', [line1, line2], {
                seriesDefaults: {
                    renderer: $.jqplot.BarRenderer, //使用柱状图表示
                    rendererOptions: {
                        barMargin: 35
                        //柱状体组之间间隔
                    }
                }
            });

            //--添加横坐标分类
            plot2 = $.jqplot('chart2', [line1, line2], {
                seriesDefaults: {
                    renderer: $.jqplot.BarRenderer, //使用柱状图表示
                    rendererOptions: {
                        barMargin: 10
                        //柱状体组之间间隔
                    }
                },
                axes: {
                    xaxis: {
                        ticks: ['区域1', '区域2', '区域3', '区域4'],
                        renderer: $.jqplot.CategoryAxisRenderer
                        //x轴绘制方式
                    }
                }
            });
            */

        });
    
    </script>
</asp:Content>
