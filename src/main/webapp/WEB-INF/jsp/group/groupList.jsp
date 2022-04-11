<%--
  Created by IntelliJ IDEA.
  User: abdes
  Date: 11/04/2022
  Time: 09:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:url var="view" value="/groups" />
<!DOCTYPE html>



<%--c:url var="findGroups" value="/groups/find" /--%>

<html>
<head>
  <%@ include file="/WEB-INF/jsp/header.jsp"%>
  <title>Liste des groupes</title>
</head>
<body>
  <div class="hero-head">
    <%--%@ include file="/WEB-INF/jsp/nav.jsp"%--%>
  </div class="hero-head">
  <div class="hero-body">
    <div class="container">
      <h1 class="title is-1">Groupes:</h1>

      <c:forEach items="${groupList}" var="group">
        <div class="card">
          <a href="${view}?id=${group.getId()}">
            <div class="card-content">
              <p class="title is-5"><c:out value="${group.getName()}" /></p>
            </div>
          </a>
        </div>
      </c:forEach>

      <hr>
      <nav class="pagination is-centered" role="navigation" aria-label="pagination">
        <a href="${view}?page=${param.page == null || param.page == 0 ? 0 : param.page-1}" class="pagination-previous">Précédent</a>
        <a href="${view}?page=${param.page == null ? 1 : param.page+1}" class="pagination-next">Suivant</a>
      </nav>
    </div>
  </div>
</body>
</html>