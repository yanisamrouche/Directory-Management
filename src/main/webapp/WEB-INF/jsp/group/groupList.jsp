<%--
  Created by IntelliJ IDEA.
  User: abdes
  Date: 11/04/2022
  Time: 09:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:url var="view" value="/groups" />
<c:url var="home" value="/" />
<c:url var="search" value="/result/find" />
<c:url var="log" value="/log" />
<c:url var="profiles" value="/profiles" />


<%--c:url var="findGroups" value="/groups/find" /--%>

<html>
<head>
  <%@ include file="/WEB-INF/jsp/header.jsp"%>
  <title>Liste des groupes</title>
</head>
<body>
  <div>
<%--    <%@ include file="/WEB-INF/jsp/nav.jsp"%>--%>
  <nav class="nav-bar">
    <div class="nav-title">
      <a  href="${home }">
        AMU-Annuaire
      </a>
    </div>


    <div class="nav-search" >
      <form action="${search}" id="searchForm" >
        <button class="btnSearchInput" type="button"><i class="fas fa-search"></i></button>
        <input  class="searchInput" type="search" placeholder="Rechercher..." aria-label="Search" name="name">
      </form>
    </div>

    <div class="nav-log">

      <c:choose>
        <c:when test="${sessionScope.user.getPerson() == null}">
          <div class="connexion">
            <a class="button is-light" href="${log}">
              <span>Connexion</span>
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="profile">
            <a href="${profiles}?id=${sessionScope.user.getPerson().getId()}">
              <span class="icon"><i class="fas fa-user"></i></span>
              <span>Mon profil</span>
            </a>
          </div>
          <div class="deconnexion">
            <a href="${log}/out">
              <span>Deconnexion</span>
            </a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </nav>

  </div>
  <div >
    <div>
      <h1 class="title">Groupes</h1>
<%--      <h3 class="subtitle">Nombre de groupes : ${groupList.size()}</h3>--%>
      <table style="border: 1px solid;">
        <tr style="border: 1px solid;">
          <th>Nom</th> <th> Lien </th>
        </tr>
        <c:forEach items="${groupList}" var="group">

          <tr>
            <td> <c:out value="${group.getName()}" /> </td>
            <td> <a href="${view}?id=${group.getId()}"> <i class="fas fa-eye"></i> </a></td>
          </tr>
        </c:forEach>
      </table>

      <hr>
      <nav class="pagination is-centered" role="navigation" aria-label="pagination">
        <a href="${view}?page=${param.page == null || param.page == 0 ? 0 : param.page-1}" class="pagination-previous"><i id="left-arrow" class="fas fa-arrow-left"></i></a>
        <a href="${view}?page=${param.page == null ? 1 : param.page+1}" class="pagination-next"><i id="right-arrow" class="fas fa-arrow-right"></i></a>
      </nav>
    </div>
  </div>
</body>
</html>