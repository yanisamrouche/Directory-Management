<%--
  Created by IntelliJ IDEA.
  User: abdes
  Date: 11/04/2022
  Time: 09:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>


<c:url var="view" value="/groups" />
<c:url var="findGroups" value="/groups/find" />

<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>Boo'Book :: Recherche de groupes</title>
</head>
<body>
<section class="hero is-fullheight">
    <div class="hero-head">
        <%@ include file="/WEB-INF/jsp/nav.jsp"%>
    </div>

    <div class="hero-body">
        <div class="container">
            <h1 class="title is-1"><c:out value="${groupList.size()}" /> groupes trouvé:</h1>

            <c:forEach items="${groupList}" var="group">
                <div class="card">
                    <a href="${view}?id=${group.getId()}">
                        <div class="card-content">
                            <p class="title is-5"><c:out value="${group.getName()}" /></p>
                        </div>
                    </a>
                </div>
            </c:forEach>

        </div>
    </div>
</section>
</body>
</html>