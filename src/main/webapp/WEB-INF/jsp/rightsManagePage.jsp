<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>权限页面</title>

</head>
<body>
<div class="hrms_rights_container">
	<!-- 导航栏-->
	<%@ include file="./commom/head.jsp"%>


	<!-- 中间部分（左侧栏+表格内容） -->
	<div class="hrms_rights_body">
		<!-- 左侧栏 -->
		<%@ include file="./commom/leftsidebar.jsp"%>

		<!-- 部门表格内容 -->
		<div class="rights_manage col-sm-10">
			<div class="panel panel-success">
				<!-- 路径导航 -->
				<div class="panel-heading">
					<ol class="breadcrumb">
						<li><a href="#">部门管理</a></li>
						<li class="active">部门信息</li>
					</ol>
				</div>
				<!-- Table -->
				<table class="table table-bordered table-hover" id="rights_table">
					<thead>
					<th>人员ID</th>
					<th>人员名称</th>
					<th>账号</th>
					<th>密码</th>
					<th>操作</th>
					</thead>
					<tbody>
					<c:forEach items="${rightsList}" var="rights">
						<tr>
							<td>${rights.rightsId}</td>
							<td>${rights.rightsName}</td>
							<td>${rights.rightsAccount}</td>
							<td>${rights.rightsPassword}</td>
							<td>
								<a href="#" role="button" class="btn btn-primary rights_edit_btn" data-toggle="modal" data-target=".rights-update-modal">编辑</a>
								<a href="#" role="button" class="btn btn-danger rights_delete_btn">删除</a>
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
							<li><a style="font-size: large;font-weight: bolder" href="/hrms/rights/getRightsList?pageNo=1">首页</a></li>
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
									<li class="active"><a href="/hrms/rights/getRightsList?pageNo=${itemPage}">${itemPage}</a></li>
								</c:if>
								<c:if test="${curPageNo != itemPage}">
									<li><a href="/hrms/rights/getRightsList?pageNo=${itemPage}">${itemPage}</a></li>
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
							<li><a style="font-size: large;font-weight: bolder" href="/hrms/rights/getRightsList?pageNo=${totalPages}">尾页</a></li>
						</ul>
					</nav>
				</div>
			</div><!-- /.panel panel-success -->
		</div><!-- /.rights_info -->
	</div><!-- /.hrms_rights_body -->

	<%@ include file="personRightsAdd.jsp"%>
	<%@ include file="personRightsUpdate.jsp"%>

	<!-- 尾部-->
	<%@ include file="./commom/foot.jsp"%>

</div><!-- /.hrms_rights_container -->

<script type="text/javascript">
    var curPageNo = ${curPageNo};
    var totalPages = ${totalPages};
    //上一页
    $(".prePage").click(function () {
        if (curPageNo > 1){
            var pageNo = curPageNo - 1;
            $(this).attr("href", "/hrms/rights/getRightsList?pageNo="+pageNo);
        }
    });
    //下一页
    $(".nextPage").click(function () {
        if (curPageNo < totalPages){
            var pageNo = curPageNo + 1;
            $(this).attr("href", "/hrms/rights/getRightsList?pageNo="+pageNo);
        }
    });


    <!-- ==========================部门删除操作=================================== -->
    $(".rights_delete_btn").click(function () {
        var rightsId = $(this).parent().parent().find("td:eq(0)").text();
        var delrightsName = $(this).parent().parent().find("td:eq(1)").text();
        var curPageNo = ${curPageNo};
        if (confirm("确认删除【"+ delrightsName +"】的信息吗？")){
            $.ajax({
                url:"/hrms/rights/delRights/"+rightsId,
                type:"DELETE",
                success:function (result) {
                    if (result.code == 100){
                        alert("删除成功！");
                        window.location.href = "/hrms/rights/getRightsList?pageNo="+curPageNo;
                    }else {
                        alert(result.extendInfo.del_rights_error);
                    }
                }
            });
        }
    });
</script>
</body>
</html>
