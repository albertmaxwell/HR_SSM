<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">

	<script src="<%=request.getContextPath()%>/plug-in/laydate/laydate.js"></script>
	<script src="<%=request.getContextPath()%>/plug-in/echart/echarts.js"></script>
	<script src="<%=request.getContextPath()%>/plug-in/echart/map1/china.js"></script>

	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
	<script type="text/javascript"
			src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
	<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=2M2l4QVbHesgIQQpOGvHTudmt3mGXcrk"></script>
	<script type="text/javascript"
			src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
	<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>

	<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
	<script type="text/javascript" src="plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>

	<script src="<%=request.getContextPath()%>/plug-in/javascript/charts.public.js"></script>




	<title>城市地图吞吐量</title>

	<style>
		* {
			margin: 0;
			padding: 0;
		}

		body {
			position: relative;
		}

		.search {
			position: absolute;
			padding-top: 10px;
			padding-left: 1px;
			width: 100%;
			height: 1000px;/*整体比例*/
			background-color: rgb(8, 21, 62);
		}
		.input_box {
			display: flex;
			justify-content: center;
		}

		body {
			background-color: rgb(100, 21, 62);
			color: #fff;
		}
	</style>


</head>
<body>
  <div class="hrms_rights_container">
	<!-- 导航栏-->
	<%@ include file="./commom/head.jsp"%>

	<!-- 中间部分（左侧栏+表格内容） -->
	<div class="hrms_rights_body" style="position:relative; top:-15px;">
		<!-- 左侧栏 -->
		<%@ include file="./commom/leftsidebar.jsp"%>
	</div>

	  <!-- 部门表格内容 -->
	  <div class="rights_manage col-sm-10">
		  <div style="width: 1270px" class="panel panel-success">

			  <div class="search">
				  <div class="input_box">
					  <font style="color:#fff;line-height:30px;">开始时间：</font>
					  <input id="startDate" style="padding:6px;width:15%;" placeholder="yyyy-MM-dd" value="2018-01-01"
							 readonly="readonly"/>&nbsp;&nbsp;
					  <font style="color:#fff;line-height:30px;">结束时间：</font>
					  <input id="endDate" style="padding:6px;width:15%;" placeholder="yyyy-MM-dd" value="2019-12-31"
							 readonly="readonly"/>&nbsp;

					  <button class="btn btn-primary search_city" onClick="query()">搜索</button>
				  </div>
			  </div>

			  <div style="width: 100%;position:absolute;left:0;top:60px;">
				  <div style="float: left;width: 27%">
					  <div id="cityIn" style="width: 100%;height: 225px;"></div>
					  <div id="cityOut" style="width: 100%;height: 225px;"></div>
				  </div>
				  <div style="float: left;width: 40%">
					  <div id="china-map" style="width:100%;height:450px;"></div>
				  </div>
				  <div style="float: left;width: 32%;">
					  <div id="12Month" style="width: 100%;height: 250px;"></div>
					  <div id="product" style="width: 100%;height: 200px;"></div>
				  </div>
			  </div>


			  <div id="30Day" style="width: 98%; height: 300px;top: 500px;"></div>


			  </div>
			  </div>

</div>

<script type="text/javascript">

    var myChart = echarts.init(document.getElementById('china-map'));

    $(function () {
        laydate.render({
            elem: '#startDate' //指定元素
            , showBottom: false
        });
        laydate.render({
            elem: '#endDate' //指定元素
            , showBottom: false
        });
        setStartAndEndDate();
        query();
    });

    // 地图散点图数据
    var data = []

    function convertData(data) {
        var res = [];
        for (var i = 0; i < data.length; i++) {
            var geoCoord = geoCoordMap[data[i].name];
            if (!geoCoord) {
                var name = data[i].name.replace("市", "");
                geoCoord = geoCoordMap[name];
            }
            if (geoCoord) {
                res.push({
                    name: data[i].info,
                    value: geoCoord.concat(data[i].name)
                });
            }
        }
        console.log('convertData拼接数据：', res)
        return res;
    };
    // 地图散点图配置
    option = {
        backgroundColor: "#08153E",
        title: {
            text: '全国数据吞吐量统计表',
            subtext: '合同数据可视化展示',
            x: 'center',
            textStyle: {
                color: '#fff'

            }
        },
        geo: {
            map: 'china',
            // left: '10%',
            roam: true,
            zoom: '1.1',
            label: {
                normal: {
                    show: false,
                    color: 'orange'
                },
                emphasis: {
                    show: true,
                    color: 'orange',
                }
            },
            itemStyle: {
                normal: {
                    areaColor: '#74BAA2',
                    borderColor: '#111'
                },
                emphasis: {
                    areaColor: '#2a333d',
                    show: false,
                }
            }
        },
        series: [
            {
                type: 'scatter',
                coordinateSystem: 'geo',
                symbolSize: 6,
                data: convertData(data),
                label: {
                    normal: {
                        show: false
                    },
                    emphasis: {
                        show: false
                    }
                },
                itemStyle: {
                    emphasis: {
                        borderColor: '#fff',
                        borderWidth: 1
                    }
                }
            },
            {
                type: 'effectScatter',
                coordinateSystem: 'geo',
                data: convertData(data),
                symbolSize: 6,
                showEffectOn: 'render',
                rippleEffect: {
                    brushType: 'stroke'
                },
                hoverAnimation: true,
                label: {
                    normal: {
                        formatter: '{b}',
                        position: 'right',
                        show: true
                    }
                },
                itemStyle: {
                    normal: {
                        color: '#FFD700',
                        shadowBlur: 10,
                        shadowColor: '#333'
                    }
                },
                zlevel: 1
            },
        ]
    }

    myChart.setOption(option);


    //城市进货饼图
    var dom = document.getElementById("cityIn");
    var cityInChart = echarts.init(dom);
    var cityInOption = {
        title: {
            text: '城市园区进货量占比',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a}{b}: {c} ({d}%)"
        },
        series: [
            {
                name: '访问来源',
                type: 'pie',
                selectedMode: 'single',
                radius: [0, '30%'],

                label: {
                    normal: {
                        position: 'inner'
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data: []
            },
            {
                name: '',
                type: 'pie',
                radius: ['40%', '55%'],
                label: {
                    normal: {
                        //formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                        backgroundColor: '#eee',
                        borderColor: '#aaa',
                        borderWidth: 1,
                        borderRadius: 4,
                        rich: {
                            a: {
                                color: '#999',
                                lineHeight: 22,
                                align: 'center'
                            },
                            hr: {
                                borderColor: '#aaa',
                                width: '100%',
                                borderWidth: 0.5,
                                height: 0
                            },
                            b: {
                                fontSize: 16,
                                lineHeight: 33
                            },
                            per: {
                                color: '#eee',
                                backgroundColor: '#334455',
                                padding: [2, 4],
                                borderRadius: 2
                            }
                        }
                    }
                },
                data: []
            }
        ]
    };
    if (cityInOption && typeof cityInOption === "object") {
        //alert("sss");
        cityInChart.setOption(cityInOption, true);
    }


    //城市出货饼图
    var dom1 = document.getElementById("cityOut");
    var cityOutChart = echarts.init(dom1);
    var cityOutOption = {
        title: {
            text: '城市园区出货量占比',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a}{b}: {c} ({d}%)"
        },
        series: [
            {
                name: '访问来源',
                type: 'pie',
                selectedMode: 'single',
                radius: [0, '30%'],

                label: {
                    normal: {
                        position: 'inner'
                    }
                },
                labelLine: {
                    normal: {
                        show: false
                    }
                },
                data: []
            },
            {
                name: '',
                type: 'pie',
                radius: ['40%', '55%'],
                label: {
                    normal: {
                        //formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                        backgroundColor: '#eee',
                        borderColor: '#aaa',
                        borderWidth: 1,
                        borderRadius: 4,
                        rich: {
                            a: {
                                color: '#999',
                                lineHeight: 22,
                                align: 'center'
                            },
                            hr: {
                                borderColor: '#aaa',
                                width: '100%',
                                borderWidth: 0.5,
                                height: 0
                            },
                            b: {
                                fontSize: 16,
                                lineHeight: 33
                            },
                            per: {
                                color: '#eee',
                                backgroundColor: '#334455',
                                padding: [2, 4],
                                borderRadius: 2
                            }
                        }
                    }
                },
                data: []
            }
        ]
    };
    if (cityOutOption && typeof cityOutOption === "object") {
        //alert("sss");
        cityOutChart.setOption(cityOutOption, true);
    }


    //近12月货量增长图
    var dom12Month = document.getElementById("12Month");
    var chart12Month = echarts.init(dom12Month);
    var option12Month = {

        textStyle: {
            color: '#fff'
        },
        title: {
            text: '近 6 月总量增长',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                crossStyle: {
                    color: '#fff'
                }
            }
        },
        toolbox: {
            feature: {
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        legend: {
            y: 30,
            data: ['进货', '出货', '吞吐量']
        },
        grid: {
            left: '5%',
            right: '3%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                data: [],
                axisPointer: {
                    type: 'shadow'
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                name: '吨',
                min: 0,
                interval: 10000,
                axisLabel: {
                    formatter: '{value} 吨'
                }
            }
        ],
        series: [
            {
                name: '进货量',
                type: 'bar',
                data: []
            },
            {
                name: '出货量',
                type: 'bar',
                data: []
            },
            {
                name: '吞吐量',
                type: 'line',
                data: []
            }
        ]
    };
    if (option12Month && typeof option12Month === "object") {
        chart12Month.setOption(option12Month, true);
    }


    //产品类型图

    var productChart = echarts.init(document.getElementById("product"));
    var productOption = {
        title: {
            text: '产品类型分布占比图',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        series: [{
            name: '占比图',
            width: '91%',
            height: '70%',
            type: 'treemap',
            roam: false,
            data: []
        }]
    };

    if (productOption && typeof productOption === "object") {
        productChart.setOption(productOption, true);
    }


    //近30天日进出货总览图
    var chart30Day = echarts.init(document.getElementById("30Day"));
    var option30Day = {
        textStyle: {
            color: '#fff'
        },
        title: {
            text: '近30天货物吞吐情况',
            x: 'center',
            textStyle: {
                color: '#fff'
            }
        },
        grid: {
            left: '1%',
            right: '1%',
            bottom: '5%',
            containLabel: true
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross',
                crossStyle: {
                    color: '#fff'
                }
            }
        },
        toolbox: {
            feature: {
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        legend: {
            y: 30,
            data: ['进货', '出货', '吞吐量']
        },
        xAxis: [
            {
                type: 'category',
                data: [],
                axisPointer: {
                    type: 'shadow'
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
                name: '吨',
                min: 0,
                interval: 1000,
                axisLabel: {
                    formatter: '{value} 吨'
                }
            }
        ],
        series: [
            {
                name: '进货量',
                type: 'bar',
                data: []
            },
            {
                name: '出货量',
                type: 'bar',
                data: []
            },
            {
                name: '吞吐量',
                type: 'line',
                data: []
            }
        ]
    };
    if (option30Day && typeof option30Day === "object") {
        chart30Day.setOption(option30Day, true);
    }

    //查询
    function query() {

        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        $.ajax({
            url: "/hrms/visualData/cockpit", //请求路径
            async: true, //是否异步请求，默认为true
            type: "GET",
            data: {"startDate": startDate, "endDate": endDate},
            contentType: "application/x-www-form-urlencoded", //编码类型
            dataType: "json", //预处理服务端可能返回的数据类型
            scriptCharset: "UTF-8", //编码
            success: function (data) { //请求成功的回调函数
                if (true) {
                    setData(data.obj);

                }
                layer.close(index);
            }
        });
    }

    //设置值
    function setData(data) {
        //园区吞吐
        if (!!data.cockpitMapList) {
            cockpitHAndP(data.cockpitMapList);
        }

        //城市园区进货量
        if (!!data.cityGoodsIn) {
            cityGoodsInOrOut(data.cityGoodsIn, data.yqGoodsIn, true);
        }
        //城市园区出货量
        if (!!data.cityGoodsOut) {
            cityGoodsInOrOut(data.cityGoodsOut, data.yqGoodsOut, false);
        }

        //近六月增长
        if (!!data.sixTotalGrowth) {
            queryHap(data.sixTotalGrowth, true);
        }
        //近30天吞吐
        if (!!data.thirtyDayHuffAndPuff) {
            queryHap(data.thirtyDayHuffAndPuff, false);
        }

        //料件分布
        if (!!data.typeProportion) {
            queryTypeProportion(data.typeProportion);
        }
    }

    //园区吞吐
    function cockpitHAndP(obj) {
        var data = [];
        for (var i = 0; i < obj.length; i++) {
            var info = obj[i].city + "\n入：" + obj[i].enterNumber + "吨\n出：" + obj[i].outNumber + "吨";
            data.push({name: obj[i].city, info: info});
        }
        var charts = myChart;
        var options = charts.getOption();
        var resultData = convertData(data);
        options.series[0].data = resultData;
        options.series[1].data = resultData;
        charts.hideLoading(); //数据获取成功之后隐藏动画
        charts.setOption(options, true);
    }

    //城市园区进出货量
    function cityGoodsInOrOut(cityObj, yqObj, isIn) {
        var cityData = [];
        var yqData = [];
        for (var i = 0; i < cityObj.length; i++) {
            cityData.push({name: cityObj[i].name, value: cityObj[i].number});
        }
        for (var i = 0; i < yqObj.length; i++) {
            yqData.push({name: yqObj[i].name, value: yqObj[i].number});
        }

        var charts = isIn ? cityInChart : cityOutChart;
        var options = charts.getOption();
        var resultData = convertData(data);
        options.series[0].data = cityData;
        options.series[1].data = yqData;
        charts.hideLoading(); //数据获取成功之后隐藏动画
        charts.setOption(options, true);
    }

    //吞吐柱状图查询
    function queryHap(obj, isMonth) {
        var monthData = [];
        var inData = [];
        var outData = [];
        var hapData = [];

        for (var i = 0; i < obj.length; i++) {
            monthData.push(obj[i].time);
            inData.push(obj[i].enter);
            outData.push(obj[i].out);
            hapData.push(obj[i].hap);
        }

        var charts = isMonth ? chart12Month : chart30Day;
        var options = charts.getOption();
        var resultData = convertData(data);
        options.xAxis[0].data = monthData;
        options.series[0].data = inData;
        options.series[1].data = outData;
        options.series[2].data = hapData;
        charts.hideLoading(); //数据获取成功之后隐藏动画
        charts.setOption(options, true);
    }

    //料件分布
    function queryTypeProportion(obj) {
        var data = [];
        for (var i = 0; i < obj.length; i++) {
            data.push({name: obj[i].name, value: obj[i].value});
        }
        var charts = productChart;
        var options = charts.getOption();
        options.series[0].data = data;
        charts.hideLoading(); //数据获取成功之后隐藏动画
        charts.setOption(options, true);
    }

    //设置时间日期
    function setStartAndEndDate() {
        var date = new Date();
        var endMonth = parseInt((date.getMonth() + 1));
        endMonth = endMonth < 10 ? ("0" + endMonth) : endMonth;
        var endDate = date.getFullYear() + "-" + endMonth + "-" + date.getDate();
        date.setTime(date.getTime() - (1000 * 60 * 60 * 24 * 30 * 6));
        var startMonth = parseInt((date.getMonth() + 1));
        startMonth = startMonth < 10 ? ("0" + startMonth) : startMonth;
        var startDate = date.getFullYear() + "-" + startMonth + "-" + date.getDate();
        $("#startDate").val(startDate);
        $("#endDate").val(endDate);
    }

</script>
</body>
</html>
