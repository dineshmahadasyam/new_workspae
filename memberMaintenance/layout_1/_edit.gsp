<%@ page import="com.perotsystems.diamond.dao.MemberInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'memberMaster.label', default: 'Member Master')}" />
<title><g:message code="default.edit.label" args="[entityName]" /></title>
<script type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<style type="text/css">
#report changed {
	color: blue;
}

#report {
	border-collapse: collapse;
}

#report div {
	background: #C7DDEE
}

#report h4 {
	margin: 0px;
	padding: 0px;
}

#report img {
	float: right;
}

#report ul {
	margin: 10px 0 10px 40px;
	padding: 0px;
}

#report td {none repeat-x scroll center left;
	color: #000;
	padding: 2px 15px;
}

#report tr.hideme {
	background: #C7DDEE none repeat-x scroll center left;
	color: #000;
	padding: 7px 15px;
}

#report td.clickme td {
	background: #fffff repeat-x scroll center left;
	cursor: pointer;
}

#report div.arrow {
	background: transparent url(arrows.png) no-repeat scroll 0px -16px;
	width: 16px;
	height: 16px;
	display: block;
}

#report div.up {
	background-position: 0px 0px;
}

#tdFormElement td {
	align: left
}

#tdnoWrap td {
	white-space: nowrap
}
</style>

</head>
<body>
	<a href="#edit-memberMaster" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><g:link class="list" action="edit"
					params="${[memberDBId:request.getParameter('memberDBId'), subscriberID:request.getParameter("subscriberID"), groupEditType :'MASTER']}">Master Record</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[memberDBId:request.getParameter('memberDBId'), subscriberID:request.getParameter("subscriberID"), groupEditType :'DETAIL']}">Detail Records</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[memberDBId:request.getParameter('memberDBId'), subscriberID:request.getParameter("subscriberID"), groupEditType :'ADDRESS']}">Addresses</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[memberDBId:request.getParameter('memberDBId'), subscriberID:request.getParameter("subscriberID"), groupEditType :'BILLING']}">Billing</g:link></li>
		</ul>
		<ul>
		    <li><g:link class="list" action="edit"
					params="${[memberDBId:request.getParameter('memberDBId'), subscriberID:request.getParameter("subscriberID"), groupEditType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[memberDBId:request.getParameter('memberDBId'), subscriberID:request.getParameter("subscriberID"), groupEditType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
			<li><g:link class="list" action="edit"
					params="${[memberDBId:request.getParameter('memberDBId'), subscriberID:request.getParameter("subscriberID"), groupEditType :'MEMMC_LIS_INFO']}">MEMMC LIS Info</g:link></li>
		</ul>
	</div>
	<div id="edit-memberMaster" class="content scaffold-edit" role="main">
		<h1>
			<g:message code="default.edit.label" args="[entityName]" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${memberMasterInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${memberMasterInstance}" var="error">
					<li
						<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
							error="${error}" /></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
		<g:form action="update">
			<g:hiddenField name="id" value="${memberMasterInstance?.memberDBId}" />
			<g:if
				test="${request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType'))}">
				<fieldset class="memberMasterForm">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
				<fieldset class="premiumMasterForm">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'ADDRESS'.equals(request.getParameter('editType'))}">
				<fieldset class="groupAddressForm">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BILLING'.equals(request.getParameter('editType'))}">
				<fieldset class="memberBillingForm">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BENEFICIARY'.equals(request.getParameter('editType'))}">
				<fieldset class="memberBeneficiaryForm">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'MEMMC_LIS_INFO'.equals(request.getParameter('editType'))}">
				<fieldset class="memberLisForm">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BENEFICIARY_ALLOCATION'.equals(request.getParameter('editType'))}">
				<fieldset class="beneficiaryAllocation">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="update"
					value="${message(code: 'default.button.update.label', default: 'Update')}" />
			</fieldset>
		</g:form>
	</div>
</body>
</html>
