<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>部门管理页面</title>

</head>
<body>
<div class="hrms_dept_container">
    <!-- 导航栏-->
    <%@ include file="./commom/head.jsp"%>


    <!-- 中间部分（左侧栏+表格内容） -->
    <div class="hrms_dept_body" style="position:relative; top:-15px;">
        <!-- 左侧栏 -->
        <%@ include file="./commom/leftsidebar.jsp"%>

        <!-- 部门表格内容 -->
        <div  class="dept_info col-sm-10">
            <div style="width: 1270px" class="panel panel-success">
                <!-- 路径导航 -->
                <div class="panel-heading">
                    <ol class="breadcrumb">
                        <li><a href="#">部门管理</a></li>
                        <li class="active">部门信息</li>
                    </ol>
                </div>
                <div class="form-group">
                   <%-- <button onclick="checkData" style="font-weight: bold;font-size: large;width: 100px;background-color: #1b9af7;outline: none;border: none;color: #ffffff" for="add_inputName" class="col-sm-2 control-label">查询</button>--%>
                       <button  type="button" class="btn btn-primary con_update_btn">查询</button>
                      <a style="font-size: large;font-weight: bolder" href="/hrms/dept/getDeptList?pageNo=1"><button class="btn btn-primary ">重置</button></a>
                    <div class="col-sm-8" style="width: 200px">
                        <input  type="text" name="empName" class="form-control" id="add_checkName" placeholder="请输入要查询的字段">
                        <span id="helpBlock_add_inputName" class="help-block"></span>
                    </div>
                </div>
               <!-- Table -->
                <table class="table table-bordered table-hover" id="dept_table">
                    <thead>
                        <th>部门编号</th>
                        <th>部门名称</th>
                        <th>部门老大</th>
                        <th>操作</th>
                    </thead>
                    <tbody>
                        <c:forEach items="${departments}" var="dept">
                            <tr>
                                <td>${dept.deptId}</td>
                                <td>${dept.deptName}</td>
                                <td>${dept.deptLeader}</td>
                                <td style="width: 150px">
                                    <a href="#" role="button" class="btn btn-primary dept_edit_btn" data-toggle="modal" data-target=".dept-update-modal">编辑</a>
                                    <a href="#" role="button" class="btn btn-danger dept_delete_btn">删除</a>
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
                            <li><a style="font-size: large;font-weight: bolder" href="/hrms/dept/getDeptList?pageNo=1">首页</a></li>
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
                                    <li class="active"><a href="/hrms/dept/getDeptList?pageNo=${itemPage}">${itemPage}</a></li>
                                </c:if>
                                <c:if test="${curPageNo != itemPage}">
                                    <li><a href="/hrms/dept/getDeptList?pageNo=${itemPage}">${itemPage}</a></li>
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
                            <li><a style="font-size: large;font-weight: bolder" href="/hrms/dept/getDeptList?pageNo=${totalPages}">尾页</a></li>
                        </ul>
                    </nav>
                </div>
            </div><!-- /.panel panel-success -->
        </div><!-- /.dept_info -->
    </div><!-- /.hrms_dept_body -->

    <%@ include file="departmentAdd.jsp"%>
    <%@ include file="departmentUpdate.jsp"%>

    <!-- 尾部-->
    <%@ include file="./commom/foot.jsp"%>

</div><!-- /.hrms_dept_container -->

<script type="text/javascript">
    var curPageNo = ${curPageNo};
    var totalPages = ${totalPages};
    //上一页
    $(".prePage").click(function () {
         if (curPageNo > 1){
             var pageNo = curPageNo - 1;
             $(this).attr("href", "/hrms/dept/getDeptList?pageNo="+pageNo);
         }
    });
    //下一页
    $(".nextPage").click(function () {
        if (curPageNo < totalPages){
            var pageNo = curPageNo + 1;
            $(this).attr("href", "/hrms/dept/getDeptList?pageNo="+pageNo);
        }
    });


    <!-- ==========================部门删除操作=================================== -->
    $(".dept_delete_btn").click(function () {
        var delDeptId = $(this).parent().parent().find("td:eq(0)").text();
        var delDeptName = $(this).parent().parent().find("td:eq(1)").text();
        var curPageNo = ${curPageNo};
        if (confirm("确认删除【"+ delDeptName +"】的信息吗？")){
            $.ajax({
                url:"/hrms/dept/delDept/"+delDeptId,
                type:"DELETE",
                success:function (result) {
                    if (result.code == 100){
                        alert("删除成功！");
                        window.location.href = "/hrms/dept/getDeptList?pageNo="+curPageNo;
                    }else {
                        alert(result.extendInfo.del_dept_error);
                    }
                }
            });
        }
    });

    $(".con_update_btn").click(function () {

        var  checkValue= document.getElementById("add_checkName").value;
        window.location.href = "/hrms/dept/getCheckList?checkValue="+checkValue;

    });

</script>
</body>
</html>
