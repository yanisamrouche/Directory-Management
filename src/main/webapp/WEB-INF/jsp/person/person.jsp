<%--
  Created by IntelliJ IDEA.
  User: acs
  Date: 10/04/2022
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<c:url var="edit" value="/person/edit" />--%>

<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>${person.getName()}</title>
</head>
<body>
    <div>
        <%@ include file="/WEB-INF/jsp/nav.jsp"%>
    </div>
    <div class="personCard">
        <div class="card">
        <span class="userIcon"><i class="fas fa-user"></i></span>
        <p><c:out value="${person.getName()}" /> <c:out value="${person.getFirstname()}" /></p>
        <p><c:out value="${person.getCurrentGroup().getName()}" /></p>
        <c:if test="${sessionScope.user.getIsLogged()}">
            <p>
                <span><i class="fas fa-birthday-cake"></i></span>
                <fmt:parseDate pattern = "yyyy-MM-dd" value = "${person.getBirthdate()}" var="formatedDate"/>
                <fmt:formatDate pattern = "dd/MM/yyyy" value = "${formatedDate}" />
            </p>
            <p>
                <span><i class="fas fa-envelope"></i></span>
                <c:out value="${person.getEmail()}" />
            </p>
        </c:if>
        <p>
            <span><i class="fas fa-home"></i></span>
            <c:out value="${person.getWebsite()}" />
        </p>

        <c:if test="${sessionScope.user.getPerson().getId().equals(person.getId())}">
            <a href="${edit }?id=${sessionScope.user.getPerson().getId()}">
                <span><i class="fas fa-edit"></i></span>
                <span>Editer le profile</span>
            </a>
        </c:if>
        </div>
    </div>

</body>
</html>
