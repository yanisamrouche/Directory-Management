<%@ include file="/WEB-INF/jsp/header.jsp"%>

<c:url var="persons" value="/profiles" />
<c:url var="groups" value="/groups" />
<c:url var="search" value="/result/find" />


	<div>
		<%@ include file="/WEB-INF/jsp/nav.jsp"%>
	</div>
	<div class="main">
		<div class="personnes">
			<a  href="${persons}">
				<span class="prs"><i class="fas fa-users"></i></span>
				<span class="prs">Personnes</span>
			</a>
		</div>
		<div class="groupes">
			<a href="${groups}">
				<span class="grp"><i class="fas fa-folder"></i></span>
				<span class="grp">Groupes</span>
			</a>
		</div>
	</div>

<%@ include file="/WEB-INF/jsp/footer.jsp"%>
