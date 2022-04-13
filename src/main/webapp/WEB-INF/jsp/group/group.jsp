<%--
  Created by IntelliJ IDEA.
  User: abdes
  Date: 10/04/2022
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:url var="view" value="/profiles" />
<c:url var="home" value="/" />
<c:url var="log" value="/log" />
<c:url var="search" value="/result/find" />


<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>GroupList :: ${group.getName()}</title>
</head>
<body>
    <div>
<%--        <%@ include file="/WEB-INF/jsp/nav.jsp"%>--%>
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
                        <a href="${login}/out">
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
            <div>
                <div>
                    <p class="title"><c:out value="${group.getName()}" /></p>
                    <hr>
                    <p class="subtitle">Adhérents</p>
                    <div class="list is-hoverable">
                        <table style="border: 1px solid;">
                            <tr style="border: 1px solid;">
                                <th>Nom</th> <th>Prénom</th> <th> Profile </th>
                            </tr>
                            <c:forEach items="${group.getPersons()}" var="person">

                                <tr>
                                    <td> <c:out value="${person.getName()}" /> </td>
                                    <td> <c:out value="${person.getFirstname()}" /> </td>
                                    <td> <a href="${view}?id=${person.getId()}"> <i class="fas fa-eye"></i> </a></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
