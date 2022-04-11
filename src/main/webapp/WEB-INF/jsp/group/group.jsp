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

<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>GroupList :: ${group.getName()}</title>
</head>
<body>
    <div>
<%--        <%@ include file="/WEB-INF/jsp/nav.jsp"%>--%>
    </div>
    <div >
        <div>
            <div>
                <div>
                    <p class="title"><c:out value="${group.getName()}" /></p>
                    <hr>
                    <p class="subtitle">Adhérents</p>
                    <div class="list is-hoverable">
                        <c:forEach items="${group.getPersons()}" var="person">
                            <a class="list-item" href="${view}?id=${person.getId()}"><c:out value="${person.getName()}" /> <c:out value="${person.getFirstname()}" /></a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
