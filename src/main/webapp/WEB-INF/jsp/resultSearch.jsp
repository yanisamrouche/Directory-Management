<%--
  Created by IntelliJ IDEA.
  User: acs
  Date: 11/04/2022
  Time: 23:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:url var="viewP" value="/profiles" />
<c:url var="viewG" value="/groups" />


<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>Resultat de la recherche</title>
</head>
<body>
    <div>
        <%@ include file="/WEB-INF/jsp/nav.jsp"%>
    </div>

    <div>
        <div>

            <h1>
                <c:out value="${persons.size()+groupList.size()}" /> Resultats
            </h1>

            <c:forEach items="${persons}" var="person">
                <div class="card">
                    <a href="${viewP}?id=${person.getId()}">
                        <div class="card-content">
                            <p class="title is-5"><c:out value="${person.getName()}" /> <c:out value="${person.getFirstname()}" /> | <c:out value="${person.getCurrentGroup().getName()}" /></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
            <c:forEach items="${groupList}" var="group">
                <div class="card">
                    <a href="${viewG}?id=${group.getId()}">
                        <div class="card-content">
                            <p class="title is-5"><c:out value="${group.getName()}" /></p>
                        </div>
                    </a>
                </div>
            </c:forEach>

        </div>
    </div>
</body>
</html>
