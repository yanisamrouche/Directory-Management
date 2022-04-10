<%--
  Created by IntelliJ IDEA.
  User: acs
  Date: 10/04/2022
  Time: 04:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:url var="home" value="/" />
<c:url var="profiles" value="/profiles" />
<c:url var="groups" value="/groups" />
<c:url var="login" value="/log" />

<nav class="navbar navbar-dark bg-dark" role="navigation" aria-label="main navigation">
    <div class="input-group">
        <!-- Collapse button -->
        <button class="navbar-toggler toggler-example purple darken-3" type="button" data-toggle="collapse"
                data-target="#navbarSupportedContent41" aria-controls="navbarSupportedContent41" aria-expanded="false"
                aria-label="Toggle navigation"><span class="white-text"><i class="fas fa-bars fa-1x"></i></span></button>

        <!-- Collapsible content -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent41">

            <!-- Links -->
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a  href="${profiles}">
                        <span class="icon is-medium"><i class="fas fa-users"></i></span>
                        <span>Personnes</span>
                    </a>						</li>
                <li class="nav-item">
                    <a href="${groups}">
                        <span class="icon is-medium"><i class="fas fa-folder"></i></span>
                        <span>Groupes</span>
                    </a>
                </li>
            </ul>

            <!-- Links -->
        </div>



    <div >
        <a  href="${home }">
            <h1 class="title">  AMU-Annuaire  </h1>
        </a>

    </div>
    <div >
        <form action="${search }" id="searchForm" class="input-group">
            <input class="form-control me-2" type="search" placeholder="Rechercher..." aria-label="Search">
            <button type="button" class="btn btn-secondary"><i class="fas fa-search"></i></button>
        </form>
    </div>



    <div id="navbarBasic" class="navbar-menu">


        <div class="navbar-end">
            <div>
                <div class="buttons">
                    <c:choose>
                        <c:when test="${sessionScope.user.getPerson() == null}">
                            <a class="button is-light" href="${login}">
                                <span class="icon"><i class="fas fa-sign-in-alt"></i></span>
                                <span>Connexion</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="button is-primary" href="${profiles}?id=${sessionScope.user.getPerson().getId()}">
                                <span class="icon"><i class="fas fa-user"></i></span>
                                <span>Mon profil</span>
                            </a>
                            <a class="button is-danger" href="${login}/out">
                                <span class="icon"><i class="fas fa-sign-out-alt"></i></span>
                                <span>Deconnexion</span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
        </div>


    </div>
    </div>
</nav>
