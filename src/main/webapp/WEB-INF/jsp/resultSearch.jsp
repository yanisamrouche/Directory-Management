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
                <c:out value="${persons.size()+groupList.size()}" /> Resultat(s)
            </h1>



                <table>
                    <c:forEach items="${persons}" var="person">

                        <tr>
                            <td> <c:out value="${person.getName()}" /> </td>
                            <td> <c:out value="${person.getFirstname()}" /> </td>
                            <td> <c:out value="${person.getCurrentGroup().getName()}" /> </td>
                            <td> <a href="${viewP}?id=${person.getId()}"> <i class="fas fa-eye"></i> </a></td>
                        </tr>
                    </c:forEach>
                </table>
                <table>
                    <c:forEach items="${groupList}" var="group">
                        <tr>
                            <td> <c:out value="${group.getName()}" /> </td>
                            <td> <a href="${viewG}?id=${group.getId()}"> <i class="fas fa-eye"></i> </a></td>
                        </tr>
                    </c:forEach>
                </table>


        </div>
    </div>
</body>
</html>
