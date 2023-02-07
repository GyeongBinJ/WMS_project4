<%@ page language="Java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="kr">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Stock</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendors/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendors/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendors/jquery-bar-rating/css-stars.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendors/font-awesome/css/font-awesome.min.css" />
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo_1/style.css" />
    <!-- End layout styles -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/assets/images/favicon.png" />
 	<!-- jquery -->
	<script src="${pageContext.request.contextPath }/resources/assets/js/jquery-3.6.3.js"></script>
	<script type="text/javascript">
		let pageNum = 1;	
	
		$(function() {
			var jsonStrData = localStorage.getItem("param");
			
			$.ajax({
					type : "POST",
					url : "StockAjaxPro.st",
					dataType : "json", // 컨트롤러에서 응답받을 데이터 타입
					contentType : "application/json", // 컨트롤러로 전달할 요청 데이터 타입
					// 전송할 JSON 데이터를 하나의 문자열로 직접 결합하여 전송
					data : jsonStrData,
					success : function(data) {
							console.log(data)
							
							for(let stock of data) {
								let result = "<tr>"
											+ "<td name='stock_cd'><input type='text' name='stock_cd_arr' value='" + stock.stock_cd + "' readonly='readonly'></td>"
											+ "<td name='product_name'><input type='text' name='product_name_arr' value='" + stock.product_name + "' readonly='readonly'></td>"
											+ "<td name='size_des'><input type='text' name='size_des_arr' value='" + stock.size_des + "' readonly='readonly'></td>"
											+ "<td name='wh_area'><input type='text' name='wh_area_arr' value='" + stock.wh_area + "(" + stock.wh_name + ")" + "' readonly='readonly'></td>"
											+ "<td name='wh_loc_in_area'><input type='text' name='stock.wh_loc_in_area_arr' value='" + stock.wh_loc_in_area + "' readonly='readonly'></td>"
											+ "<td name='stock_qty'><input type='text' name='stock_qty_arr' value='" + stock.stock_qty + "' readonly='readonly'></td>"
											+ "<td><input type='text' name='control_qty_arr' onchange='qtyval(this)' value=0></td>"
											+ "<td class='moving_area'><input type='text' name='moving_stock_cd_arr'>&nbsp;<input type='button' class='btn btn-sm btn-outline-primary' value='위치선택'></td>"
											+ "<td><input type='text' name='moving_qty_arr' onchange='qtyval(this)' value=0></td>"
											+ "<td name='stock_qty_sum_arr'></td>"
											+ "<td class='remarks'><input type='text' name='remarks_arr'></td>"
											+ "</tr>";
								$("tbody").append(result);			
							}
					}
				});
			
// 			var jsonData = JSON.parse(jsonStrData);
// 			console.log(jsonData);
			
// 				for(let i = 0; i < $("input[name=control_qty_arr]").length; i++) {
// 					$("input[name=control_qty_arr]").eq(i).on("change", function() {
// 					if($("input[name=control_qty_arr]").eq(i).val() == null || $("input[name=control_qty_arr]").eq(i).val() == "") {
// 						$("input[name=control_qty_arr]").eq(i).val(0);
// // 						return false;
// 					} else if($("input[name=moving_stock_cd_arr]").eq(i).val() == null || $("input[name=moving_stock_cd_arr]").eq(i).val() == "") {
// 						$("input[name=moving_stock_cd_arr]").eq(i).val(0);
// // 						return false;
// 					} else if($("input[name=moving_qty_arr]").eq(i).val() == null || $("input[name=moving_qty_arr]").eq(i).val() == "") {
// 						$("input[name=moving_qty_arr]").eq(i).val(0);
// // 						return false;
// 					}
					
// 			});
// 				}

		});
// 			function qtyval(item) {
// // 				console.log(item.value);
// 				if(item.value == "") {
// 					item.value = 0;
// 				}
// 			}
	
	</script>
  </head>
  <body>
  
    <div class="container-scroller">
      <!-- 사이드바 -->
      <jsp:include page="../partials/sidebar_WMS.jsp"></jsp:include>
      <!-- 사이드바 -->
      
      <div class="container-fluid page-body-wrapper">
        <!-- 색상 커스텀 설정 -->
        <jsp:include page="../partials/settings-panel.jsp"></jsp:include>
        <!-- 색상 커스텀 설정 -->
        <!-- 상단 메뉴바 -->
      	<jsp:include page="../partials/navbar.jsp"></jsp:include>
        <!-- 상단 메뉴바  -->
        
        <!-- 본문 영역 -->
        <div class="main-panel">

		<!-- table 영역 -->
       <div class="col-lg-12 grid-margin stretch-card">
           <div class="card">
              	<div class="card-body">
                    <h4 class="card-title">재고 조정</h4>
                    <p class="card-description">Stock Control</p>
                    <div class="table-responsive">
		 <form action="StockControlPro.st">
                      <table class="table table-striped">
                        <thead>
                          <tr>
                          	<th>재고번호</th>
                            <th>품목명</th>
                            <th>규격</th>
                            <th>구역명(창고명)</th>
                            <th>위치</th>
                            <th>재고수량</th>
                            <th>조정수량</th>
                            <th>이동위치</th>
                            <th>이동수량</th>
                            <th>합계수량</th>
                            <th>적요</th>
                          </tr>
                        </thead>
                        
                      
                        <tbody>
                        
                       
                        </tbody>
                      </table>
                    </div>
			        <div class="template-demo" style="text-align: right;">
	           			<button type="submit" class="btn btn-primary btn-rounded btn-fw" onclick="">조정</button>
	           			<button type="reset" class="btn btn-primary btn-rounded btn-fw" onclick="">초기화</button>
           			</div>
          </form> 
				         <section id="pageList" style="text-align: center;"> <!-- 페이징 처리 영역 -->
				    
					     <!-- 만약, pageNum 파라미터가 비어있을 경우 pageNum 변수 선언 및 기본값 1로 설정 -->
						<c:choose>
							<c:when test="${empty param.pageNum }">
								<c:set var="pageNum" value="1" />
							</c:when>
							<c:otherwise>
								<c:set var="pageNum" value="${param.pageNum }" />
							</c:otherwise>
						</c:choose>
						
						<c:choose>
							<c:when test="${pageNum > 1}">
								<input type="button" class="btn btn-sm btn-outline-primary" value="이전" onclick="location.href='StockRevise.st?pageNum=${pageNum - 1}'">
							</c:when>
							<c:otherwise>
								<input type="button" class="btn btn-sm btn-outline-primary" value="이전">
							</c:otherwise>
						</c:choose>
							
						<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
							<c:choose>
								<c:when test="${pageNum eq i}">
									${i }
								</c:when>
								<c:otherwise>
									<a href="StockRevise.st?pageNum=${i }">${i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
				
						<c:choose>
							<c:when test="${pageNum < pageInfo.maxPage}">
								<input type="button" class="btn btn-sm btn-outline-primary" value="다음" onclick="location.href='StockRevise.st?pageNum=${pageNum + 1}'">
							</c:when>
							<c:otherwise>
								<input type="button" class="btn btn-sm btn-outline-primary" value="다음">
							</c:otherwise>
						</c:choose>
					</section>
               	</div>
             </div>
          </div>
        <!-- table 영역 -->
        </div>
        <!-- 본문 영역 --> 
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
		<footer class="footer">
          	<jsp:include page="../partials/footer.jsp"></jsp:include>
        </footer>
    
    <!-- plugins:js -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/jquery-bar-rating/jquery.barrating.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/chart.js/Chart.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/flot/jquery.flot.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/flot/jquery.flot.resize.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/flot/jquery.flot.categories.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/flot/jquery.flot.fillbetween.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/vendors/flot/jquery.flot.stack.js"></script>
    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/off-canvas.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/hoverable-collapse.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/misc.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/settings.js"></script>
    <script src="${pageContext.request.contextPath }/resources/assets/js/todolist.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page -->
    <script src="${pageContext.request.contextPath }/resources/assets/js/dashboard.js"></script>
    <!-- End custom js for this page -->
  </body>
</html>