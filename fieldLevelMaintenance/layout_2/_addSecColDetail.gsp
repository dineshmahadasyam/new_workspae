
<%@ page import="com.dell.diamond.fms.sfldl.FieldLevelSecurityTableEnum"%>
<%@page
	import="com.dell.diamond.fms.sfldl.enums.FieldLevelSecurityAccessEnum"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'secColMaster.label', default: 'Field Level Security Master')}" />
<title><g:message code="default.edit.label" args="[entityName]" /></title>
<style>
.topics table {
	margin-bottom: 0em
}

.topics tr {
	line-height: 0px;
	padding: 0;
	padding-left: 0;
	padding-right: 0
}

.topics td {
	line-height: 0px;
	padding: 0;
	padding-left: 0;
	padding-right: 0
}

.fieldcontain label {
	width: 30%;
}

.fieldcontain {
	margin-top: 0px
}
</style>
<g:set var="appContext" bean="grailsApplication" />
<script>
		function closeForm() {
			window.location.assign('<g:createLinkTo dir="/fieldLevelMaintenance/show"/>'+'?sfldlId=${sfldlId}&editType=DETAIL')			
		}
		function populateTableName(selectedValue, sfldlId, updateObjSuffix){
			var updateObj = "tableNameDivObj."+updateObjSuffix
			var appName = "${appContext.metadata['app.name']}";
			var selectedFunctionalArea=document.getElementById("newSecColDetail.0.functionalArea").value
			if(selectedValue) {
				jQuery.ajax(
						{
							type:'POST',
							data:{clazzName: selectedValue,selectedFunctionalArea:selectedFunctionalArea, sfldlId: sfldlId, idName: "newSecColDetail."+updateObjSuffix+".tableName" , disable: false}, 
							url:"/"+appName+"/fieldLevelMaintenance/ajaxRefreshTableNames",
							success:function(data){
								document.getElementById(updateObj).innerHTML = data;								
								document.getElementById("newSecColDetail.0.tableName").title = "The table that will have the restriction";
								document.getElementById("newSecColDetail.0.tableName").setAttribute("style", "width: 200px");
								document.getElementById("newSecColDetail.0.tableName").setAttribute("before", "checkLoggedIn('/fieldLevelMaintenance/ajaxRefreshColumnNames')");
								document.getElementById("newSecColDetail.0.tableName").setAttribute("onChange", onChange="populateColumnName(this.value, '${sfldlId }',  '0')");
								
								
							}					
						});
			}			
			}
		function populateColumnName(selectedValue, sfldlId, updateObjSuffix) {
			//alert  ("updateObj = " +updateObj)
			var updateObj = "columnNameDivObj."+updateObjSuffix
			//var updateObjValue = document.getElementById("newSecColDetail."+updateObjSuffix+".columnName").value
			var appName = "${appContext.metadata['app.name']}";		
			if(selectedValue) {
				jQuery.ajax(
						{
							type:'POST',
							data:{clazzName: selectedValue, sfldlId: sfldlId, idName: "newSecColDetail."+updateObjSuffix+".columnName" , disable: false}, 
							url:"/"+appName+"/fieldLevelMaintenance/ajaxRefreshColumnNames",
							success:function(data){
								//alert (data)
								//$("#"+updateObj).append(data)
								//alert(document.getElementById(updateObj))
								document.getElementById(updateObj).innerHTML = data;
								document.getElementById("newSecColDetail.0.columnName").title = "The column that will have the restriction";
							}					
						});
			}
		 }
				
			
		</script>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript"
	src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
</head>
<body>
	<a href="#edit-secColMaster" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><g:link class="list" action="show"
					params="${[sfldlId:request.getParameter('sfldlId'), editType :'MASTER']}">Master Record</g:link></li>
			<li><g:link class="list" action="show"
					params="${[sfldlId:request.getParameter('sfldlId'), editType :'DETAIL']}">Detail Records</g:link></li>
		</ul>
	</div>
	<div id="edit-secColMaster" class="content scaffold-edit" role="main">
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${secColMasterInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${secColMasterInstance}" var="error">
					<li
						<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
							error="${error}" /></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
		<g:if test="${errors}">
			<ul class="errors" role="alert">
				<g:each in="${errors}" var="error">
				<li> ${ error}</li>
				</g:each>
			</ul>
			</g:if>
			<g:if test="${messages}">
			<ul class="message" role="alert">
				<g:each in="${messages}" var="message">
				<li> ${ message}</li>
				</g:each>
			</ul>
			</g:if>
		<form method="post" action="saveNewSecColDetail" id="editForm">		
		<g:set var="i" value="0"/>
		<input type="hidden" name="newSecColDetail.${i}.sfldlId" value="${sfldlId }">
			<fieldset class="form">
				<div id="addSecColDetailClone" >
					<table class="report1" border="0" style="table-layout: fixed;">
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.functionalArea', 'error')} ">
									<label for="functionalArea"> <g:message
											code="secColDetail.functionalArea.label"
											default="Functional Area:" /> <span
										class="required-indicator">*</span>
									</label>
								</div>
							</td>
							<td class="tdFormElement" style="white-space: nowrap" colspan="2">
							<g:getCdoSelectBox cdoClassName="com.perotsystems.diamond.dao.cdo.SystemCodes"
											cdoAttributeWhere="systemCodeType" cdoAttributeWhereValue="FLS_FUNC_AREA"
											cdoAttributeSelect="systemCode"  cdoAttributeSelectDesc="systemCode"
											htmlElelmentId="newSecColDetail.${i}.functionalArea"
											languageId="0"
											blankValue="Functional Area"
											onchange="populateTableName(this.value ,'${sfldlId }','0')"
											defaultValue="${secColDetail?.functionalArea}" width="200px"
											title="The functional area"/>									
											</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div 
									class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.tableName', 'error')} ">
									<label for="tableName"> <g:message
											code="secColDetail.tableName.label" default="Table Name :" />
										<span class="required-indicator">*</span>
									</label>
								</div>
							</td>
							<td class="tdFormElement" style="white-space: nowrap" colspan="2">
							<%String selectedValue = secColDetail?.tableName ? (com.perotsystems.diamond.tools.build.cdo.Util.dbNameToJavaName (secColDetail?.tableName, true)+ com.dell.diamond.service.auth.SecurityService.SEC_COL_CLASS_NAME_SUFFIX) : "" %>
								<div id="tableNameDivObj.0">
								<g:if test="${secColDetail?.functionalArea}">
								<g:select style="width: 200px" name="newSecColDetail.0.tableName"
									from="${FieldLevelSecurityTableEnum.values() }"
									optionValue="tableName" optionKey="tableName"
									onChange="populateColumnName(this.value, '${sfldlId }',  '0')"
									noSelection="['':'-- Select a Table name--']" value="${secColDetail?.tableName }"
									title="The table that will have the restriction"/>
									</g:if>
									</div>
							</td>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.columnName', 'error')} ">
									<label for="columnNameName"> <g:message
											code="secColDetail.columnName.label" default="Column Name :" />
										<span class="required-indicator">*</span>
									</label>
								</div>
							</td>
							<td class="tdFormElement" style="white-space: nowrap" colspan="2">
								<div id="columnNameDivObj.0">
								<g:if test="${secColDetail?.tableName }">
									<g:secColDetailColumn  style="width: 200px;" clazzName="${selectedValue }" selectedValue="${secColDetail?.columnName }" idName="newSecColDetail.0.columnName"
									title="The column that will have the restriction"/>									
								</g:if>
								&nbsp;</div>
							</td>
						</tr>
						<tr>
							<td class="tdnoWrap" style="white-space: nowrap">
								<div
									class="fieldcontain ${hasErrors(bean: secColDetail, field: 'secColDetail.securityInd', 'error')} ">
									<label for="securityInd"> <g:message
											code="subscriberMember.securityInd.label"
											default="Security Indicator :" />

									</label>
								</div>
							</td>
							<td class="tdFormElement" style="white-space: nowrap" colspan="2">
								<g:select style="width: 200px" name="newSecColDetail.0.securityInd"
									from="${FieldLevelSecurityAccessEnum.values() }"
									optionKey="accessType" optionValue="description" 
									title="Enter the security restriction"/>
							</td>

						</tr>
						
					</table>
				</div>
			</fieldset>
			<fieldset class="buttons">
				<input type="submit" class="save" name="saveNewSecColDetail"
								value="Save Detail" onClick="saveNewSecColDetail()">
				<div style="align: right; display: inline">
					<input type="Reset" class="reset" value="Reset" /> <input
						type="button" class="close" value="Close" onClick="closeForm()" />
				</div>
			</fieldset>
		</form>
	</div>
</body>
</html>
