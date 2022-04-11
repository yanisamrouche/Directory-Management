<%--
  Created by IntelliJ IDEA.
  User: acs
  Date: 11/04/2022
  Time: 18:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="view" value="/groups" />

<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>Edit Profile</title>
</head>
<body>
    <div>
        <%@ include file="/WEB-INF/jsp/nav.jsp"%>
    </div>
    <div>
        <div>
            <div>
                <div>

                    <form:form method="POST" modelAttribute="person">

                        <form:errors path="*" cssClass="subtitle has-text-danger" element="p" />

                        <div>
                            <label>Prenom</label>
                            <form:input class="control" path="firstname" />
                            <form:errors path="firstname" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Nom</label>
                            <form:input class="control" path="name" />
                            <form:errors path="name" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Groupe</label>
                            <form:select path="group.id" multiple="false" class="form-control">
                                <form:options items="${groupFormList}"/>
                            </form:select>
                            <form:errors path="group" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Date de naissance</label>
                            <form:input type="date" class="control" path="birthdate"/>
                            <form:errors path="birthdate" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Email</label>
                            <form:input class="control" path="email" />
                            <form:errors path="email" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Site web</label>
                            <form:input class="control" path="website" />
                            <form:errors path="website" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Mot de passe</label>
                            <form:input class="control" path="password" />
                            <form:errors path="password" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <div>
                                <button type="submit" class="button is-link">Sauvegarder</button>
                            </div>
                        </div>

                    </form:form>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
