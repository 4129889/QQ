<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="com.tha103.newview.act.model.*"%>
<%@ page import="com.tha103.newview.act.service.*"%>
<%@ page import="com.tha103.newview.actcategory.model.*"%>
<%@ page import="com.tha103.newview.cityaddress.model.*"%>
<%@ page import="com.tha103.newview.publisher.model.*"%>
<%@ page import="com.tha103.newview.act.controller.*"%>
<%
Integer pubID = (Integer) session.getAttribute("pubID");
if(pubID == null){
	response.sendRedirect("/Backstage/Allpage-publisher/user/user-listAll.jsp");
	return;
}

ActDAO actDAO = new ActDAOHibernateImpl();
ActService actSvc = new ActServiceImpl(actDAO);
List<ActVO> list = actSvc.getActByPub(pubID);
// List<ActVO> list = actSvc.getAll();
pageContext.setAttribute("list", list);

List<ActCategory> categories = actSvc.getAllCategories();
pageContext.setAttribute("categories", categories);

List<CityAddress> city = actSvc.getAllCities();
pageContext.setAttribute("city", city);
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEW VIEW | Backstage</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/Backstage/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/Backstage/dist/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<jsp:include page="../template/nav.jsp" flush="true">
			<jsp:param name="name0" value="peter0" />
		</jsp:include>

		<jsp:include page="../template/aside.jsp" flush="true">
			<jsp:param name="name0" value="peter0" />
		</jsp:include>

		<!-- Content Wrapper. Contains page content -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>活動列表</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/Backstage/Allpage-publisher/pub-index.jsp">後台首頁</a></li>
								<li class="breadcrumb-item active">活動管理</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>
			<section class="content">
				<div class="container-fluid">
					<!-- <h2 class="text-center display-4">Enhanced Search</h2> -->
					<form action="enhanced-results.html">
						<div class="row">
							<div class="col-md-10 offset-md-1">
							
							
<!-- 								<div class="row"> -->
<!-- 									<div class="col-6"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>活動類別:</label> <select class="form-control" -->
<!-- 												style="width: 100%;"> -->
<!-- 												<option>脫口秀</option> -->
<!-- 												<option>演講</option> -->
<!-- 												<option>音樂劇</option> -->
<!-- 												<option>舞台劇</option> -->
<!-- 												<option>演唱會</option> -->
<!-- 											</select> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-3"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>日期排序：</label> <select class="form-control" -->
<!-- 												style="width: 100%;"> -->
<!-- 												<option>由新到舊</option> -->
<!-- 												<option>由舊到新</option> -->
<!-- 											</select> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-3"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>審核狀態：</label> <select class="form-control" -->
<!-- 												style="width: 100%;"> -->
<!-- 												<option>已通過</option> -->
<!-- 												<option>審核中</option> -->
<!-- 												<option>未通過</option> -->
<!-- 											</select> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->



<!-- 								<div class="form-group"> -->
<!-- 									<label>關鍵字搜尋:</label> -->
<!-- 									<div class="input-group input-group-lg"> -->
<!-- 										<input type="search" class="form-control form-control-lg" -->
<!-- 											placeholder="Type your keywords here" value=""> -->
<!-- 										<div class="input-group-append"> -->
<!-- 											<button type="submit" class="btn btn-lg btn-default"> -->
<!-- 												<i class="fa fa-search"></i> -->
<!-- 											</button> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
								<!-- /.form group -->
							</div>
						</div>
					</form>
				</div>
			</section>
			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<!-- /.row -->
					<div class="row">
						<div class="col-12">
							<div class="card">
								<!-- /.card-header -->
								<div class="card-body table-responsive p-0">
									<table class="table table-hover text-nowrap">
										<thead>
											<tr>
												<th>活動編號</th>
												<th>活動名稱</th>
												<th>活動價格</th>
												<th>活動類別</th>
												<th>活動日期</th>
												<th>活動時間</th>
												<th>活動縣市</th>
												<th style="text-align: center;">操作</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="actData" items="${list}">
											<tr>
												<td>${actData.actID}</td>
												<td>${actData.actName}</td>
												<td>${actData.actPrice}</td>
												<td>${actData.actCategory.actCategoryName}</td>
												<td>${actData.actDate}</td>
												<td>${actData.time}</td>
												<td>${actData.cityAddressID.cityName}</td>
												<td>
													<Form method="post" action="<%=request.getContextPath()%>/act/act.do">
														<button type="submit" class="btn btn-block btn-success btn-sm">修改</button>
														<input type="hidden" name="action" value="update" />
														<input type="hidden" name="actId" value="${actData.actID}" />
														
													</Form>
												</td>
												<td>
													<form method="post" action="<%=request.getContextPath()%>/act/act.do">
														<button type="submit" class="btn btn-block btn-danger btn-sm">刪除</button>
														<input type="hidden" name="action" value="delete" />
														<input type="hidden" name="actIDelete" value="${actData.actID}" />
													</Form>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>


		<!-- Content Wrapper. Contains page content -->

		<jsp:include page="../template/footer.jsp" flush="true">
			<jsp:param name="name0" value="peter0" />
		</jsp:include>

	</div>
	<!-- ./wrapper -->

	<!-- jQuery -->
	<script src="<%=request.getContextPath()%>/Backstage/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script src="<%=request.getContextPath()%>/Backstage/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="<%=request.getContextPath()%>/Backstage/dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="<%=request.getContextPath()%>/Backstage/dist/js/demo.js"></script>

</body>

</html>