<%--
  Created by IntelliJ IDEA.
  User: acs
  Date: 11/04/2022
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<c:url var="log" value="/log" />
<%--<c:url var="forget" value="/log/forgetpassword" />--%>

<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>Connexion</title>
</head>
<body>

    <div>
        <%@ include file="/WEB-INF/jsp/nav.jsp"%>
    </div>
    <div>
        <div>
            <h1>Connexion</h1>
            <div>
                <div>
                    <form action="${log}" method="POST">
                        <c:if test ="${sessionScope.user.getConnectionError() == true}">
                            <p>Email ou mot de passe invalide</p>
                        </c:if>
                        <div>
                            <p>
                                <input class="input" type="email" placeholder="Email" name="email" required>
                                <span class="icon is-small is-left"><i class="fas fa-envelope"></i>
                            </span>
                            </p>
                        </div>
                        <div>
                            <p>
                                <input class="input" type="password" placeholder="Mot de passe" name="password" required>
                                <span class="icon is-small is-left">
                              <i class="fas fa-lock"></i>
                            </span>
                            </p>
                        </div>
                        <div>
                            <p>
                                <button>Se connecter</button>
                            </p>
                        </div>
                    </form>
                    <a class="button is-text is-small" href="${forget }">mot de passe oublié ?</a>
                    <hr>
                </div>
            </div>
        </div>
    </div>
</body>
</html>