<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<spring:url value="/resources/images/banner-graphic.png" var="banner"/>
<img width="100%" src="${banner}"/>


<div class="navbar navbar-default" style="width: 100%;">
     <ul class="nav nav-pills">
         <li style="width: 100px;"><a href="<spring:url value="/" htmlEscape="true" />">
         	<span class="glyphicon glyphicon-home"></span>
             Home</a>
         </li>
         <li style="width: 130px;"><a href="#"><i
                 class="glyphicon glyphicon-search"></i> Find owners</a></li>
         <li style="width: 140px;">
         	<a href="#">
         	<span class="glyphicon glyphicon-th-list"></span> Veterinarians</a>
         </li>
		 <li style="width: 90px;">
         	&nbsp;
         </li>
         <li style="width: 80px;">
         	&nbsp;
         </li>
         
     </ul>
</div>
