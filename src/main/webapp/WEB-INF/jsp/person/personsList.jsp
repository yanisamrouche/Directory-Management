<%--
  Created by IntelliJ IDEA.
  User: acs
  Date: 10/04/2022
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<c:url var="view" value="/profiles" />
<%--<c:url var="findPerson" value="/person/find" />--%>
<%--<c:url var="edit" value="/groups/edit" />--%>
<<!doctype html>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>

    <title>Les personnes</title>

</head>
<body>
    <div class="hero-head">
        <%@ include file="/WEB-INF/jsp/nav.jsp"%>
    </div>

    <div>
        <h1>Personnes:</h1>
        <table style="border: 1px solid;">
            <tr style="border: 1px solid;">
                <th>Nom</th> <th>Prénom</th> <th>Groupe</th> <th> Lien </th>
            </tr>
        <c:forEach items="${persons}" var="person">

                    <tr>
                        <td> <c:out value="${person.getName()}" /> </td>
                        <td> <c:out value="${person.getFirstname()}" /> </td>
                        <td> <c:out value="${person.getCurrentGroup().getName()}" /> </td>
                        <td> <a href="${view}?id=${person.getId()}"> <i class="fas fa-eye"></i> </a></td>
                    </tr>
        </c:forEach>
        </table>

        <hr>
        <nav class="pagination is-centered" role="navigation" aria-label="pagination">
            <c:choose>
                <c:when test="${param.page != null && param.page != 0}">
                    <a href="${view}?page=${param.page == null || param.page == 0 ? 0 : param.page-1}" class="pagination-previous">Précédent</a>
                </c:when>

                <c:otherwise>
                    <a class="pagination-previous" disabled>Précédent</a>
                </c:otherwise>
            </c:choose>

            <a href="${view}?page=${param.page == null ? 1 : param.page+1}" class="pagination-next">Suivant</a>
        </nav>
    </div>







</body>
</html>
