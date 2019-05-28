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

	<title>近6个月园区吞吐曲线</title>

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
			padding-top: 20px;
			width: 100%;
			height: 1000px;
			left: 1%;
			background-color: #26344e;
		}

		.input_box {
			display: flex;
			justify-content: center;
		}

		.selectConditions {
			/*搜索条件选择*/
			pading: 6px;
			widtg: 10%;
			width: 150px;
			margin: 1px;
		}

		body {
			background-color: rgb(8, 21, 62);
			color: crimson;
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
		<div style="width: 100px" class="panel panel-success">

			<div class="search">
				<div class="input_box">
					<div style="color:#fff;line-height:30px;">园区：</div>
					<input id="companyName" name="companyName" class="selectConditions" type="text"
						   onclick="(popupClick(this,'rrbc02', 'rrba14', 'companyNameHuo',selectCompanyBack))"
						   placeholder="请选择园区"/>&nbsp;&nbsp;
					<input id="companyNameView" style="display: none" name="companyNameView"/>&nbsp;&nbsp;
					<div style="color:#fff;line-height:30px;">类型：
						<select class="selectConditions" id="selectValue">
							<option value="all">全部</option>
							<option value="fg">废钢</option>
							<option value="ft">废铁</option>
						</select>
					</div>&nbsp;&nbsp;
					<div>
						<button class="btn btn-primary search_city" onclick="searchStrings()">搜索</button>
					</div>
				</div>

			</div>
			<div style="width: 100%;position:absolute;left:50px;top:60px;">
				<div style="float: left;width: 82%;">
					<div id="6Month" style="width: 100%;height: 500px;"></div>
				</div>
			</div>

</body>
<script>
    $(function () {
        search()//初步加载
    })
    //近12月货量增长图
    var dom12Month = document.getElementById("6Month");
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
            data: ['进货量', '出货量', '吞吐量'],
            y: 20,
            x: 150,
        },
        grid: {
            left: '5%',
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
                interval: 200,
                axisLabel: {
                    formatter: '{value} '
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

    //初始全部无条件查询
    function search() {

        var nowDate = new Date();
        var months = nowDate.getMonth() + 1;//当前月份
        var fullYears = nowDate.getFullYear();//当前年份

        var urlSearch = '/hrms/visualData/riseSearch';
        var dataFile = {'yardNumber': '', 'productType': '', 'months': '6', 'fullYears': fullYears};
        $.ajax({
            url: urlSearch,
            async: true,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(dataFile),
            scriptCharset: "UTF-8",
            success: function (data) {

                data = eval("(" + data + ")");
                setData(data.data);
                layer.close(index);
            },
            error: function (data) {
                console.log(data.data)
                layer.alert("请求服务器异常")
            }
        })
    }

    function searchStrings() {
        //产品类型
        var productType = $('#selectValue option:selected').val();
        //获取隐藏的公司编号
        var companyCodes = $("input[name='companyNameView']").val();
        var index = layer.load(0, {
            shade: [0.5, '#fff']
        });

        var urlSearch = '/hrms/visualData/riseSearch';
        var dataFile = {'yardNumber': companyCodes, 'productType': productType, 'months': '6', 'fullYears': fullYears};
        $.ajax({
            url: urlSearch,
            async: true,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(dataFile),
            scriptCharset: "UTF-8",
            success: function (data) {
                //dataJson格式转换
                data = eval("(" + data + ")");
                setData(data.data);
                layer.close(index);
            },
            error: function (data) {
                layer.alert("请求服务器异常")
            }
        })
    }

    function selectCompanyBack(result) {
        $("input[name='companyName']").val(result.selectedRow[0].rrbc02);
        $("input[name='companyNameView']").val(result.selectedRow[0].rrbc01);
    }


    //设置值
    function setData(data) {
        //近六月增长
        queryHap(data, true);
    }

    //吞吐柱状图查询
    function queryHap(obj, isMonth) {
        var monthData = [];
        var inData = [];
        var outData = [];
        var hapData = [];
        var yAxis = obj[0].yAxis;//行间距

        for (var i = 0; i < obj.length; i++) {
            monthData.push(obj[i].times);
            inData.push(obj[i].intoNumber);
            outData.push(obj[i].outToNumber);
            hapData.push(obj[i].intoOrOutNumber);
        }
        var charts = isMonth ? chart12Month : chart30Day;
        var options = charts.getOption();
        console.log(options);
        options.xAxis[0].data = monthData;
        options.yAxis[0].interval = yAxis;
        options.series[0].data = inData;
        options.series[1].data = outData;
        options.series[2].data = hapData;
        charts.hideLoading();
        charts.setOption(options, true);
    }


</script>

</html>