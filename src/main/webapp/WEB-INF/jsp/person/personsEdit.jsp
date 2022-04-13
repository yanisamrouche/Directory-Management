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
<c:url var="search" value="/result/find" />
<c:url var="home" value="/" />
<c:url var="profiles" value="/profiles" />
<c:url var="log" value="/log" />

<html>
<head>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
    <title>Edit Profile</title>
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
    <div>
        <div>
            <div>
                <div class="edit-form">

                    <form:form method="POST" modelAttribute="person">

                        <form:errors path="*" cssClass="subtitle has-text-danger" element="p" />

                        <div>
                            <label>Prenom</label> <br>
                            <form:input class="control" path="firstname" />
                            <form:errors path="firstname" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Nom</label> <br>
                            <form:input class="control" path="name" />
                            <form:errors path="name" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Groupe</label> <br>
                            <form:select path="currentGroup.id" multiple="false" class="form-control">
                                <form:options items="${groupFormList}"/>
                            </form:select>
                            <form:errors path="currentGroup" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Date de naissance</label>
                            <form:input type="date" class="control" path="birthdate"/>
                            <form:errors path="birthdate" cssClass="help is-danger" element="p" />
                        </div>

                        <div>
                            <label>Email</label> <br>
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
                                <button  type="submit" class="btn-edit">Sauvegarder</button>
                            </div>
                        </div>

                    </form:form>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
