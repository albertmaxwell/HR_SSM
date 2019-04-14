<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>部门管理页面</title>

	<%--<script src="<%=request.getContextPath()%>/plug-in/element-ui/css/index.css"></script>
	<script src="<%=request.getContextPath()%>/plug-in/element-ui/css/elementui-ext.css"></script>
	<script src="<%=request.getContextPath()%>/plug-in/vue/vue.js"></script>
	<script src="<%=request.getContextPath()%>/plug-in/vue/vue-resource.js"></script>
	<script src="<%=request.getContextPath()%>/plug-in/element-ui/index.js"></script>--%>
</head>
<body>
<div class="hrms_con_container">
	<!-- 导航栏-->
	<%@ include file="./commom/head.jsp"%>
	<!-- 中间部分（左侧栏+表格内容） -->
	<div class="hrms_con_body">
		<!-- 左侧栏 -->
		<%@ include file="./commom/leftsidebar.jsp"%>
		<!-- 部门表格内容 -->
		<div class="con_info col-sm-10" style="position:relative; top:-15px;">
			<div style="width: 1270px" class="panel panel-success">
				<!-- 路径导航 -->
				<div  class="panel-heading">
					<ol  class="breadcrumb">
						<li><a style="font-weight: bolder;font-size: large" href="#">部门管理</a></li>
						<li style="font-weight: bolder;font-size: large" class="active">部门信息</li>
					</ol>
				</div>
				<%--<div>
					<el-button type="warning">警告按钮</el-button>
				</div>--%>
				<!-- Table -->
				<table class="table table-bordered table-hover" id="con_table">
					<thead>
					<th>合同ID</th>
					<th>合同编号</th>
					<th>部门标题</th>
					<th>省</th>
					<th>市</th>
					<th>区</th>
					<th>操作</th>
					</thead>
					<tbody>
					<c:forEach items="${conList}" var="con">
						<tr>
							<td>${con.contractsId}</td>
							<td>${con.contractsCode}</td>
							<td>${con.contractsTitle}</td>
							<td>${con.provincePid}</td>
							<td>${con.cityPid}</td>
							<td>${con.areaPid}</td>
							<td style="width: 150px">
								<a href="#" role="button" class="btn btn-primary con_edit_btn" data-toggle="modal" data-target=".con-update-modal">编辑</a>
								<a href="#" role="button" class="btn btn-danger con_delete_btn">删除</a>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>

				<div class="panel-body">
					<div class="table_items">
						当前第<span style="font-size: large;font-weight: bolder" class="badge">${curPageNo}</span>页，共有<span class="badge">${totalPages}</span>页，总记录数<span class="badge">${totalItems}</span>条。
					</div>
					<nav aria-label="Page navigation" class="pull-right">
						<ul class="pagination">
							<li><a style="font-size: large;font-weight: bolder" href="/hrms/contracts/getConList?pageNo=1">首页</a></li>
							<c:if test="${curPageNo==1}">
								<li class="disabled">
									<a href="#" aria-label="Previous" class="prePage">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${curPageNo!=1}">
								<li>
									<a href="#" aria-label="Previous" class="prePage">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:if>

							<c:forEach begin="1" end="${totalPages<5?totalPages:5}" step="1" var="itemPage">
								<c:if test="${curPageNo == itemPage}">
									<li class="active"><a href="/hrms/contracts/getConList?pageNo=${itemPage}">${itemPage}</a></li>
								</c:if>
								<c:if test="${curPageNo != itemPage}">
									<li><a href="/hrms/contracts/getConList?pageNo=${itemPage}">${itemPage}</a></li>
								</c:if>
							</c:forEach>

							<c:if test="${curPageNo==totalPages}">
								<li class="disabled" class="nextPage">
									<a href="#" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
							<c:if test="${curPageNo!=totalPages}">
								<li>
									<a href="#" aria-label="Next" class="nextPage">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:if>
							<li><a style="font-size: large;font-weight: bolder" href="/hrms/contracts/getConList?pageNo=${totalPages}">尾页</a></li>
						</ul>
					</nav>
				</div>
			</div><!-- /.panel panel-success -->
		</div><!-- /.con_info -->
	</div><!-- /.hrms_con_body -->

	<%@ include file="contractsAdd.jsp"%>
	<%@ include file="contractsUpdate.jsp"%>

	<!-- 尾部-->
	<%@ include file="./commom/foot.jsp"%>

</div><!-- /.hrms_con_container -->

<script type="text/javascript">

    var curPageNo = ${curPageNo};
    var totalPages = ${totalPages};
    //上一页
    $(".prePage").click(function () {
        if (curPageNo > 1){
            var pageNo = curPageNo - 1;
            $(this).attr("href", "/hrms/contracts/getConList?pageNo="+pageNo);
        }
    });
    //下一页
    $(".nextPage").click(function () {
        if (curPageNo < totalPages){
            var pageNo = curPageNo + 1;
            $(this).attr("href", "/hrms/contracts/getConList?pageNo="+pageNo);
        }
    });


    <!-- ==========================部门删除操作=================================== -->
    $(".con_delete_btn").click(function () {
        var delconId = $(this).parent().parent().find("td:eq(0)").text();
        var delconName = $(this).parent().parent().find("td:eq(1)").text();
        var curPageNo = ${curPageNo};
        if (confirm("确认删除【"+ delconName +"】的信息吗？")){
            $.ajax({
                url:"/hrms/contracts/delCon/"+delconId,
                type:"DELETE",
                success:function (result) {
                    if (result.code == 100){
                        alert("删除成功！");
                        window.location.href = "/hrms/contracts/getConList?pageNo="+curPageNo;
                    }else {
                        alert(result.extendInfo.del_con_error);
                    }
                }
            });
        }
    });
</script>
</body>
</html>
