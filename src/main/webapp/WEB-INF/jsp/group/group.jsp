<%--
  Created by IntelliJ IDEA.
  User: abdes
  Date: 10/04/2022
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>



<c:url var="view" value="/profiles" />

<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>GroupList :: ${group.getName()}</title>
</head>
<body>
<section>
    <div>
        <%--%@ include file="/WEB-INF/jsp/nav.jsp"%--%>
    </div>
    <div >
        <div class="container">
            <div class="card">
                <div class="card-content">
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
</section>
</body>
</html>
