<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="<%=request.getContextPath()%>/plug-in/layer/layer/layer.js"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<style type="text/css">
    .navigation_bar_font{
        font-size: large;
        font-weight: bolder;
        text-align: center;
    }

</style>
<div style="background-color: #26344b;height: 1200px" class="panel-group col-sm-2" id="hrms_sidebar_left" role="tablist" aria-multiselectable="true">
    <ul class="nav nav-pills nav-stacked emp_sidebar">
        <li role="presentation" class="active">
            <a href="#" data-toggle="collapse" data-target="#collapse_emp">
                <span class="navigation_bar_font" class="glyphicon glyphicon-user" aria-hidden="true">客户资料</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_emp">
                <li class="navigation_bar_font" role="presentation"><a href="#" class="emp_info"><span class="glyphicon glyphicon-user"></span><font style="color: #ffffff;padding-left: 13px">员工信息</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" role="button" class="emp_add_btn" data-toggle="modal" data-target=".emp-add-modal"><font color="#ffffff"><span class="glyphicon glyphicon-plus"></span><font style="color: #ffffff;padding-left: 13px">员工新增</font></font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" clasemp_add_btns="emp_clearall_btn"><font color="#ffffff"><span class="glyphicon glyphicon-minus"></span><font style="color: #ffffff;padding-left: 13px">员工清零</font></font></a></li>
            </ul>
        </li>
    </ul>
    <ul class="nav nav-pills nav-stacked dept_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_dept">
                <span class="navigation_bar_font" class="glyphicon glyphicon-cloud" aria-hidden="true">联系人集</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept">
                <li class="navigation_bar_font" role="presentation"><a href="#" class="dept_info"><span class="glyphicon glyphicon-user"></span><font style="color: #ffffff;padding-left: 13px">部门信息</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="dept_add_btn" data-toggle="modal" data-target=".dept-add-modal"><span class="glyphicon glyphicon-plus"></span><font style="color: #ffffff;padding-left: 10px">部门新增</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="dept_clearall_btn"><span class="glyphicon glyphicon-minus"></span><font style="color: #ffffff;padding-left: 10px">部门清零</font></a></li>
            </ul>
        </li>
    </ul>


    <ul class="nav nav-pills nav-stacked dept_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_dept">
                <span class="navigation_bar_font" class="glyphicon glyphicon-cloud" aria-hidden="true">合同管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_con">
                <li class="navigation_bar_font" role="presentation"><a href="#" class="contracts_info"><span class="glyphicon glyphicon-user"></span><font style="color: #ffffff;padding-left: 13px">合同信息</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="con_add_btn" data-toggle="modal" data-target=".con-add-modal"><span class="glyphicon glyphicon-plus"></span><font style="color: #ffffff;padding-left: 10px">新增合同</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="dept_visualData_btn"><span class="glyphicon glyphicon-minus"></span><font style="color: #ffffff;padding-left: 10px">数据统计</font></a></li>
            </ul>
        </li>
    </ul>


    <ul class="nav nav-pills nav-stacked dept_sidebar">
        <li role="presentation" class="active">
            <a href="#"  data-toggle="collapse" data-target="#collapse_dept">
                <span class="navigation_bar_font" class="glyphicon glyphicon-cloud" aria-hidden="true">权限管理</span>
            </a>
            <ul class="nav nav-pills nav-stacked" id="collapse_dept">
                <li class="navigation_bar_font" role="presentation"><a href="#" class="rights_manage"><span class="glyphicon glyphicon-user"></span><font style="color: #ffffff;padding-left: 13px">权限设置</font></a></li>
                <li class="navigation_bar_font" role="presentation"><a href="#" class="rights_add_btn" data-toggle="modal" data-target=".rights-add-modal"><span class="glyphicon glyphicon-plus"></span><font style="color: #ffffff;padding-left: 13px">用户添加</font></a></li>
            </ul>
        </li>
    </ul>


</div><!-- /.panel-group，#hrms_sidebar_left -->

<script type="text/javascript">
    //跳转到员工页面
    $(".emp_info").click(function () {
        $(this).attr("href", "/hrms/emp/getEmpList");
    });
    //跳转到部门页面
    $(".dept_info").click(function () {
        $(this).attr("href", "/hrms/dept/getDeptList");
    });
    //跳转到权限管理页面
    $(".rights_manage").click(function () {

        $(this).attr("href", "/hrms/rights/getRightsList");
    });
    //跳转到合同管理页面
    $(".contracts_info").click(function () {

        $(this).attr("href", "/hrms/contracts/getConList");
    });

    //合同数据可视化
    $(".dept_visualData_btn").click(function () {

        $(this).attr("href", "/hrms/contracts/getDataVisual");

    });
    //部门清零这个功能暂未实现
    $(".dept_clearall_btn").click(function () {
        layer.alert("对不起，您暂无权限进行操作！请先获取权限", {icon:5} );
        return false;
    });
</script>
</body>
</html>
