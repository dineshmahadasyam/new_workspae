<%@ page import="com.dell.diamond.fms.sfldl.FieldLevelSecurityTableEnum"%>
<%@ page import="com.dell.diamond.fms.sfldl.enums.FieldLevelSecurityAccessEnum"%>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'secColMaster.label', default: 'Field Level Security Master')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="userMaintenance"/>
		
		<g:set var="appContext" bean="grailsApplication" />
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				jQuery.validator.setDefaults({
					ignore: ":hidden",
					debug: true			 
				});
						 
				$(function() {		
					$("#editForm").validate({
						onfocusout: false,
						submitHandler: function (form) {
							  if ($(form).valid()) 
			                      form.submit(); 
			                  return false; // prevent normal form posting
				        },
						errorLabelContainer: "#errorDisplay", 
						 wrapper: "li",		
										
						rules : {
							'newSecColDetail.0.functionalArea' : {
								required : true
							},
							'newSecColDetail.0.tableName' : {
								required : true
							},
							'newSecColDetail.0.columnName' : {
								required : true
							}
							
						},
						messages : {
							'newSecColDetail.0.functionalArea' : {
								required : "Please select Functional Area"
							},
							'newSecColDetail.0.tableName' : {
								required : "Please select Table Name"
							},
							'newSecColDetail.0.columnName' : {
								required : "Please select Column Name"
							},
						} 
						
					})
				});
			});
		</script>	
				
				
		<script>
			function closeForm() {
				window.location.assign('<g:createLinkTo dir="/fieldLevelMaintenance/show"/>'+'?sfldlId=${sfldlId}&editType=DETAIL')			
			}
			function populateTableName(selectedValue, sfldlId, updateObjSuffix){
				var updateObj = "tableNameDivObj."+updateObjSuffix;
				var appName = "${appContext.metadata['app.name']}";
				var selectedFunctionalArea=document.getElementById("newSecColDetail.0.functionalArea").value;
				if(selectedValue) {
					jQuery.ajax(
							{
								type:'POST',
								data:{clazzName: selectedValue,selectedFunctionalArea:selectedFunctionalArea, sfldlId: sfldlId, idName: "newSecColDetail."+updateObjSuffix+".tableName" , disable: false}, 
								url:"/"+appName+"/fieldLevelMaintenance/ajaxRefreshTableNames",
								success:function(data){
									document.getElementById(updateObj).innerHTML = data;
									document.getElementById("newSecColDetail.0.tableName").title = "The table that will have the restriction";
									//document.getElementById("newSecColDetail.0.tableName").setAttribute("style", "width: 200px");
									document.getElementById("newSecColDetail.0.tableName").setAttribute("class", "form-control");	
									document.getElementById("newSecColDetail.0.tableName").setAttribute("before", "checkLoggedIn('/fieldLevelMaintenance/ajaxRefreshColumnNames')");
									document.getElementById("newSecColDetail.0.tableName").setAttribute("onChange", onChange="populateColumnName(this.value, '${sfldlId }',  '0')");
								}					
							});
				}
				}
			function populateColumnName(selectedValue, sfldlId, updateObjSuffix) {
				var updateObj = "columnNameDivObj."+updateObjSuffix
				var appName = "${appContext.metadata['app.name']}";		
				if(selectedValue) {
					jQuery.ajax(
							{
								type:'POST',
								data:{clazzName: selectedValue, sfldlId: sfldlId, idName: "newSecColDetail."+updateObjSuffix+".columnName" , disable: false}, 
								url:"/"+appName+"/fieldLevelMaintenance/ajaxRefreshColumnNames",
								success:function(data){
									document.getElementById(updateObj).innerHTML = data;
									document.getElementById("newSecColDetail.0.columnName").title = "The column that will have the restriction";
									document.getElementById("newSecColDetail.0.columnName").setAttribute("class", "form-control");	
								}					
							});
				}
			 }
		</script>
	</head>

	<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
	    	<div class="fms_content_header_note">
	      		
	  		</div>
		  	<div class="fms_content_title">
	          	<h1>Add New Detail</h1>
	        </div>
		</div> 
		
		<%-- START - Tabs --%>
		<div id="fms_content_tabs">
			<ul>
				<li><g:link class="list" action="show" params="${[sfldlId:request.getParameter('sfldlId'), editType :'MASTER']}">Master Record</g:link></li>
				<li><g:link class="active" action="show" params="${[sfldlId:request.getParameter('sfldlId'), editType :'DETAIL']}">Detail Records</g:link></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>	
		<%-- END - Tabs --%>
	    <div class="right-corner" align="right">SFLDL</div>		
		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
		
		<!-- START - Error Messages: -->
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
				${ message}
				</g:each>
			</ul>
			</g:if>
		<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
		<!-- End - Error Messages: -->
		
			<div class="fms_required_legend fms_required">= required</div> 
	 	  	<div class="fms_form_border">
	    		<div class="fms_form_body fms_form_border">
					<div id="edit-secColMaster" class="content scaffold-edit" role="main">
					<form method="post" action="saveNewSecColDetail" id="editForm">		
						<g:set var="i" value="0"/>
						<input type="hidden" name="newSecColDetail.${i}.sfldlId" value="${sfldlId }">
						<!-- START - WIDGET: General Information -->
		    			<div id="widgetGeneral" class="fms_widget">
				 			<fieldset class="no_border">
		                  		<legend><h2>Add Field Level Security Detail</h2></legend>
		                  		<div class="fms_form_layout_2column">                  

		                    		<div class="fms_form_column fms_very_long_labels">
										<label id="functionalArea_label" for="functionalArea" class="control-label fms_required" >
											<g:message code="secColDetail.functionalArea.label" default="Functional Area:" />
										</label>
										<div class="fms_form_input">
											<g:getCdoSelectBox 
												className="form-control"
												cdoClassName="com.perotsystems.diamond.dao.cdo.SystemCodes"
												cdoAttributeWhere="systemCodeType" cdoAttributeWhereValue="FLS_FUNC_AREA"
												cdoAttributeSelect="systemCode"  cdoAttributeSelectDesc="systemCode"
												htmlElelmentId="newSecColDetail.${i}.functionalArea"
												languageId="0"
												blankValue="Functional Area"
												onchange="populateTableName(this.value ,'${sfldlId }','0')"
												defaultValue="${secColDetail?.functionalArea}"
												title="The functional area"/>		
		                                   	<div class="fms_form_error" id="functionalArea_error"></div>
		                              	</div>
		                              	
										<label id="securityInd_label" for="securityInd" class="control-label" >
											<g:message code="subscriberMember.securityInd.label" default="Security Indicator :" />
										</label>
										<div class="fms_form_input">
											<g:select class="form-control"
												name="newSecColDetail.0.securityInd"
												from="${FieldLevelSecurityAccessEnum.values() }"
												optionKey="accessType" optionValue="description" 
												title="Enter the security restriction"/>	
		                                   	<div class="fms_form_error" id="securityInd_error"></div>
										</div>		                                   	
									</div>
									<div class="fms_form_column fms_very_long_labels">
										
		                              	<label id="tableName_label" for="tableName" class="control-label fms_required" >
											<g:message code="secColDetail.tableName.label" default="Table Name :" />
										</label>										
										<%String selectedValue = secColDetail?.tableName ? (com.perotsystems.diamond.tools.build.cdo.Util.dbNameToJavaName (secColDetail?.tableName, true)+ com.dell.diamond.service.auth.SecurityService.SEC_COL_CLASS_NAME_SUFFIX) : "" %>
											<div id="tableNameDivObj.0" class="fms_form_input">
												<g:if test="${secColDetail?.functionalArea}">
													<g:select
														class="form-control"
														name="newSecColDetail.0.tableName"
														from="${FieldLevelSecurityTableEnum.values() }"
														optionValue="tableName" optionKey="tableName"
														onChange="populateColumnName(this.value, '${sfldlId }',  '0')"
														noSelection="['':'-- Select a Table name--']" 
														value="${secColDetail?.tableName }"
														title="The table that will have the restriction"/>												
													<div class="fms_form_error" id="tableName_error"></div>
												</g:if>
											</div>
		                                   	
										
										
										<label id="columnNameName_label" for="columnNameName" class="control-label fms_required" >
											<g:message code="secColDetail.columnName.label" default="Column Name :" />
										</label>
											<div id="columnNameDivObj.0" class="fms_form_input">
												<g:if test="${secColDetail?.tableName }">
													<g:secColDetailColumn clazzName="${selectedValue }" selectedValue="${secColDetail?.columnName }" idName="newSecColDetail.0.columnName"
													title="The column that will have the restriction"/>									
												</g:if>
											</div>
		                                   	<div class="fms_form_error" id="tableName_error"></div>
									</div>
									
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: General Information -->	
					
						<div class="fms_form_button">
							<input type="submit" class="btn btn-primary" name="saveNewSecColDetail" value="Save" onClick="saveNewSecColDetail()">
							<input type="button" class="btn btn-default" value="Reset" onClick="document.forms['editForm'].reset()"/>
							<input type="button" class="btn btn-default" value="Close" onClick="closeForm()"/>
		      			</div>	
			    </form>
			  </div>
			</div>
		  </div>
	   </div>	
    </div>
</html>