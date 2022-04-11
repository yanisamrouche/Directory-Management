<%--
  Created by IntelliJ IDEA.
  User: acs
  Date: 10/04/2022
  Time: 04:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:url var="home" value="/" />

<c:url var="login" value="/log" />


<nav class="nav-bar">
    <div class="nav-title">
        <a  href="${home }">
             AMU-Annuaire
        </a>

    </div>


    <div class="nav-search" >
        <form action="${search}" id="searchForm" >
            <button class="btnSearchInput" type="button"><i class="fas fa-search"></i></button>
            <input  class="searchInput" type="search" placeholder="Rechercher..." aria-label="Search">
        </form>
    </div>

    <div class="nav-log">

                <c:choose>
                        <c:when test="${sessionScope.user.getPerson() == null}">
                            <a class="button is-light" href="${login}">
                                <span>Connexion</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${profiles}?id=${sessionScope.user.getPerson().getId()}">
                                <span class="icon"><i class="fas fa-user"></i></span>
                                <span>Mon profil</span>
                            </a>
                            <a href="${login}/out">
                                <span>Deconnexion</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
    </div>
    </div>
</nav>
