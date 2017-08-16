<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
var left = 
{
	openFn : function(id) {
		var before = $("#"+id).attr("class");	
		//alert(before);

	 	if(before.match('open')){
	 		before = before.slice(0,-5);
	 		//alert(before);
	 		$("#"+id).attr("class", before);
	 		
	 	}else {
	 		$("#"+id).attr("class", before+" open");
	 	}
	},
	
	pageSubmitFn : function(pageName, action) {
		
		//alert();
		$("#pageName").val(pageName);
		$("#frm").attr("action", action); 
		
		$("#frm").submit();
		
	} ,
	
	findMainMenuFn : function() {
		
		//alert("excute findMainMenuFn");
		ajaxCl.ajaxCallFn({url: "mainMenuList.do", FCGubun: "F"});
	}
}

var ajaxCl = 
{
	ajaxCallFn : function(options) {
		
		var settings = {
				
				url: "mainMenuList.do",
				FCGubun: "F"
		}
		
		settings = $.extend({}, settings, options); 
		
		$.ajax({
			
			type		: "POST", 
			url			: settings.url,
			async		: false, 
			beforeSend 	: function(xhr) {
				
			},
			success		: function(result) {
				//alert("ajax success");
				var jsonRes = JSON.parse(result);
				
				$.each(jsonRes, function (i, item) {
					
					//alert(typeof item.depth);
					
					if(item.collapseYn == "Y"){
						
						var splitArry 	= item.menuClass.split("#"); 
						var strMenu 	= "";
						
						strMenu += "<li id='" + item.menuNm + "Id' class='has_submenu " + splitArry[0] + "'>" 
									+ "<a href='#' onclick='javascript:left.openFn(\"" + item.menuNm +  "Id\")'>"
									+ "<i class='" + splitArry[1] + "'></i>" 										
									+ item.menuNm 
									+ "<span class='pull-right'><i class='fa fa-angle-right'></i></span></a>"
									+ "<ul>";  
									
									$.each(jsonRes, function (j, item2) {
										if(item2.parentId == item.menuId){
						
											strMenu += "<li><a href='#' onclick='javascript:left.pageSubmitFn(\"menu" + item2.menuId + "\",\"" + item2.menuUrl + "\")'>"
											+ "<p>" + item2.menuNm + "</p>" 
											+ "</a></li>";	
										}	
									}); 
									
						strMenu += "</ul></li>";
						alert(strMenu);
						
						$("#naviListId").append(strMenu); 	 
						
					}else if(item.depth == 1){
						
						var splitArry 	= item.menuClass.split("#"); 
						var strMenu 	= "";
						
						strMenu += "<li class='" + splitArry[0] + "'>" 
									+ "<a href='#' onclick='javascript:left.pageSubmitFn(\"menu" + item.menuId + "\",\"" + item.menuUrl + "\")'>"
									+ "<i class='" + splitArry[1] + "'></i>" 										
									+ item.menuNm
									+ "</a></li>"; 
	                 	
						alert(strMenu);
	                 	$("#naviListId").append(strMenu); 	   	
	                 	
					}
						
				});
			},
			error		: function() {
				
				alert("main menu 조회시 Error 발생");
			}
		})
	}			
}


$(document).ready(function(){
	
	left.findMainMenuFn();
}); 
</script>

<form id="frm" name="frm">
	<input type="hidden" id="pageName"  name="pageName" />
</form>


<!-- Sidebar -->
<div class="sidebar">
	<div class="sidebar-dropdown">
		<a href="#">Navigation</a>
	</div>
	<div class="sidebar-inner">
		<!-- Search form -->
		<div class="sidebar-widget">
			<form>
				<input type="text" class="form-control" placeholder="Search">
			</form>
		</div>
		<!--- Sidebar navigation -->
		<!-- If the main navigation has sub navigation, then add the class "has_submenu" to "li" of main navigation. -->
		<ul class="navi" id="naviListId">
			
			<!-- 
			<li class="nred">
				<a href="">
					<i class="fa fa-desktop"></i> Dashboard
				</a>
			</li>
			
			<li class="has_submenu nlightblue">
				<a href="#">
					<i class="fa fa-th"></i> Widgets 
					<span class="pull-right">
						<i class="fa fa-angle-right"></i>
					</span>
				</a>
				<ul>
					<li><a href="">Widgets #1</a></li>
					<li><a href="">Widgets #2</a></li>
				</ul>
			</li>
			  
			<li class="ngreen">
				<a href="charts.html">
					<i class="fa fa-bar-chart-o"></i> Charts
				</a>
			</li>
			
			<li class="norange">
				<a href="ui.html">
					<i class="fa fa-sitemap"></i> UI Elements
				</a>
			</li>
			
			<li class="has_submenu nviolet">
				<a href="#">
					<i class="fa fa-file-o"></i> Pages #1 
					<span class="pull-right">
						<i class="fa fa-angle-right"></i>
					</span>
				</a>
				<ul>
					<li><a href="calendar.html">Calendar</a></li>
					<li><a href="post.html">Make Post</a></li>
					<li><a href="login.html">Login</a></li>
					<li><a href="register.html">Register</a></li>
					<li><a href="statement.html">Statement</a></li>
					<li><a href="error-log.html">Error Log</a></li>
					<li><a href="support.html">Support</a></li>
				</ul>
			</li>
			
			<li class="has_submenu nblue">
				<a href="#"> 
					<i class="fa fa-file-o"></i> Pages #2 
					<span class="pull-right">
						<i class="fa fa-angle-right"></i>
					</span>
				</a>
				<ul>
					<li><a href="error.html">Error</a></li>
					<li><a href="gallery.html">Gallery</a></li>
					<li><a href="grid.html">Grid</a></li>
					<li><a href="invoice.html">Invoice</a></li>	
					<li><a href="media.html">Media</a></li>
					<li><a href="profile.html">Profile</a></li>
				</ul>
			</li>
			<li class="nred">
				<a href="forms.html">
					<i class="fa fa-list"></i> Forms
				</a>
			</li>
			<li class="nlightblue">
				<a href="tables.html">
					<i class="fa fa-table"></i> Tables
				</a>
			</li> --> 
		</ul>
		<!--/ Sidebar navigation -->

		<!-- Date -->
		<div class="sidebar-widget">
			<div id="todaydate"></div>
		</div>
	</div>
</div>