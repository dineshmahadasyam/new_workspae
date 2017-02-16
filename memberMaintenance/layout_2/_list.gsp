<%@ page import="com.dell.diamond.service.auth.SecurityService" %>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>
<g:set var="showMember" value="" />
<g:checkURIAuthorization uri="/memberMaintenance/show">
	<g:set var="showMember" value="true" />
</g:checkURIAuthorization>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
	
<g:set var="appContext" bean="grailsApplication"/>


<title>Search Member Master Records</title>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script language="javascript">

	
	/*	function clearSearchCriteria() {
			document.getElementById('idSubscriberID').value = '';
			document.getElementById('idSystemID').value = '';
			document.getElementById('idFirstName').value = '';
			document.getElementById('idlastName').value = '';
		}*/
		function clearSearchCriteria() {
			var elements = document.getElementsByTagName("input");
			var firstText = true;
			for (var ii=0; ii < elements.length; ii++) {
			  if (elements[ii].type == "text") {
			    elements[ii].value = "";
			    if (firstText) {
				    firstText = false;
			    	elements[ii].focus();
			    	var clear_btn = document.getElementById('Create_id')
			    	if(clear_btn!= null)
			    	{
			    	clear_btn.style.display="none"
			    	var membr_maintaince_meaage_div = document.getElementById("membr_maintance_message_id")
		  	        if(membr_maintaince_meaage_div !=null)
		  	        {
		  	        var membr_maintaince_meaage_div_value_1 = document.getElementById("membr_maintance_message_id").innerHTML
		  	             if(membr_maintaince_meaage_div_value_1!=null)
		  	             {
		  	        	 membr_maintaince_meaage_div.style.display="none"
		  	             }
		  	        }
			    	}
			    	else
			    	{
			    	var membr_maintaince_meaage_div_1 = document.getElementById("membr_maintance_message_id")			    	
			    	if(membr_maintaince_meaage_div_1 !=null){			    				    	
				    	var membr_maintaince_meaage_div_value_1 = document.getElementById("membr_maintance_message_id").innerHTML
				    	membr_maintaince_meaage_div_1.style.display="none"
					    }
			    	}
			    	
				 }
			  }
			  if (elements[ii].type == "radio") {
				    elements[ii].checked = false;
			  }
			}
			var elements = document.getElementsByTagName("select");
			for (var ii=0; ii < elements.length; ii++) {
			    elements[ii].selectedIndex = 0;
			}
		}
		function setFirstElementFocus() {
			//alert ("requesting Focus")
			var firstText = true;
			var elements = document.getElementsByTagName("input");
			for (var ii=0; ii < elements.length; ii++) {
				  if (elements[ii].type == "text") {
				    if (firstText) {
					    firstText = false;
				    	elements[ii].focus();
				    	//break;
					 }
				  }
			}
		}

		function createMember() {
			var createMemberID = "${params.subscriberID}";
			var appName = "${appContext.metadata['app.name']}";
			window.location.assign("/"+appName+"/memberMaintenance/create?subscriberID="
							+ createMemberID + "&editType=MASTER");
		}

		function autoGenMember() {
			var parameter1 = "${parameter1}";
			var generateAutoSubId = "${generateAutoSubId}"
			var appName = "${appContext.metadata['app.name']}";
			if(parameter1)
			{
				window.location.assign("/"+appName+"/memberMaintenance/create?generateAutoSubId="
						+ generateAutoSubId + "&editType=MASTER");
			}
			
		}
		
</script>

<script type="text/javascript">
	function checkForSearchCritera(){
		var elements = document.getElementsByTagName("input");
		var searchCriteria = false;
		
		for (var ii=0; ii < elements.length; ii++) {
		  if (elements[ii].type == "text") {
		    if(elements[ii].value){
			    searchCriteria = true;
			    }
		  }
		}

		var selects = document.getElementsByTagName("select");
		for (var ii=0; ii < selects.length; ii++) {
		  if (selects[ii]) {
		    if(selects[ii].value != ""){
			    searchCriteria = true;
			}
		  }
		}
			
		  if(searchCriteria == false){
			alert ("Please enter search criteria to find Members.");
		  }
		  
		  return searchCriteria;
		
	}

	$(function($){
		
		   $("#idSocialSecurityNumber").mask("?999-99-9999");
		   
		   $("#idissuerSubscriberId").alphanum({
				allow 		: '-_',
				allowSpace  : false
			});
			
		   $("#idSubscriberID").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});

		   $("#idFirstName").alphanum({
			    allowSpace  : false
			});

		   $("#idlastName").alphanum({
			  	allow 		: '\'',
			    allowSpace  : false
			});
			
		   $("#idSystemID").alphanum({
			   	allow 		: '-_',
				allowSpace  : false
			});

		   $("#idstreet").alphanum({
			    allow 		: '-_#.',
			    allowSpace  : true
			});

		   $("#idcity").alphanum({
			    allowSpace  : true
			});
			
		})
		
			  
</script>

<style type='text/css' media='screen'>
#list-memberMaster #criteria_member {
	padding-left: 200px;
}

#list-memberMaster #criteria_member Input {
	width: 180px;
	height: 20px;
	text-align: left;
}

#list-memberMaster #criteria_member Img {
	height: 40px;
	width: 40px;
	text-align: left;
}

.load {
	-moz-box-shadow: inset -1px 1px 7px 0px #ffffff;
	-webkit-box-shadow: inset -1px 1px 7px 0px #ffffff;
	box-shadow: inset -1px 1px 7px 0px #ffffff;
	background-color: #ededed;
	-moz-border-radius: 15px;
	-webkit-border-radius: 15px;
	border-radius: 10px;
	border: 1px solid #999999;
	display: inline-block;
	color: #404040;
	font-family: arial;
	font-size: 16px;
	font-weight: normal;
	padding: 5px 24px;
	text-decoration: none;
	text-shadow: 1px 0px 13px #ffffff;
}

.load:hover {
	background-color: #dfdfdf;
}

.load:active {
	position: relative;
	top: 1px;
}

.magnifying {
	-moz-box-shadow: inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
	box-shadow: inset 0px 1px 0px 0px #ffffff;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed
		), color-stop(1, #dfdfdf));
	background: -moz-linear-gradient(center top, #ededed 5%, #dfdfdf 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed',
		endColorstr='#dfdfdf');
	background-color: #ededed;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	border: 1px solid #b8b2b8;
	display: inline-block;
	color: #777777;
	font-family: arial;
	font-size: 15px;
	font-weight: bold;
	padding: 0px 0px;
	text-decoration: none;
	text-shadow: 1px 1px 0px #ffffff;
	margin-top: 10px;
}

.magnifying:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #dfdfdf
		), color-stop(1, #ededed));
	background: -moz-linear-gradient(center top, #dfdfdf 5%, #ededed 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf',
		endColorstr='#ededed');
	background-color: #dfdfdf;
}

.magnifying:active {
	position: relative;
	top: 1px;
}

.innerbackground {
	background: rgb(0, 102, 204); /* Old browsers */
	/* IE9 SVG, needs conditional override of 'filter' to 'none' */
	background:
		url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzAwNjZjYyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjI3JSIgc3RvcC1jb2xvcj0iIzI5ODlkOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjUyJSIgc3RvcC1jb2xvcj0iIzIwN2NjYSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9Ijc4JSIgc3RvcC1jb2xvcj0iIzI5ODlkOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM3ZGI5ZTgiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
	background: -moz-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(0,
		102, 204, 1)), color-stop(27%, rgba(41, 137, 216, 1)),
		color-stop(52%, rgba(32, 124, 202, 1)),
		color-stop(78%, rgba(41, 137, 216, 1)),
		color-stop(100%, rgba(125, 185, 232, 1))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%);
	/* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%);
	/* Opera 11.10+ */
	background: -ms-linear-gradient(top, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* IE10+ */
	background: linear-gradient(to bottom, rgba(0, 102, 204, 1) 0%,
		rgba(41, 137, 216, 1) 27%, rgba(32, 124, 202, 1) 52%,
		rgba(41, 137, 216, 1) 78%, rgba(125, 185, 232, 1) 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient(         startColorstr='#0066cc',
		endColorstr='#7db9e8', GradientType=0); /* IE6-8 */
	border-radius: 7px;
}
</style>


<!-- Style Includes -->
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">

<!-- JavaScript Includes -->
<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>


</head>
<body>
	<div id="list-memberMaster" class="content scaffold-list" role="main" style="width:100%; overflow:scroll;">
		<g:if test="${flash.message}">
			<div class="message" role="status" id="membr_maintance_message_id">
				${flash.message}
			</div>
		</g:if>
		<br> <br>
		<form name="searchForm" action="/${appContext.metadata['app.name']}/memberMaintenance/list">
			<input type="hidden" name="searchRef" value="searchForm">
			<table>
				<tr>
					<td>
						<table border="1" >
							<tr>
								<td>
									<table>
										<tr>
											<g:if test="${showMember}">
												<td class="innerbackground" colspan="4"
													style="color: #FFFFFF; text-align: center; border-radius:15px;"><b>Member
														Maintenance</b></td>
											</g:if>
											<g:else>
												<td class="innerbackground" colspan="4"
													style="color: #FFFFFF; text-align: center"><b>Member
														Search</b></td>
											</g:else>
										</tr>
										<tr>
											<td><b>Issuer Subscriber Id : </b></td>
										<td><input type="text" name="issuerSubscriberId"
												id="idissuerSubscriberId" value="${params.issuerSubscriberId}"
												maxlength="50" > &nbsp;</td>	
												
											<td><b>Subscriber Id : </b></td>
											<td><input autofocus="autofocus" type="text" name="subscriberID"
												id="idSubscriberID" value="${params.subscriberID}"
												maxlength="50" > &nbsp;</td>																	
										</tr>
										<tr>
											<td><b>First Name : </b></td>
											<td><input type="text" name="firstName" id="idFirstName"
												maxlength="35" value="${params.firstName}"> &nbsp;</td>
											<td><b>Last Name : </b></td>
											<td><input type="text" name="lastName" id="idlastName"
												maxlength="60" value="${params.lastName}"> &nbsp;</td>

										</tr>
										<tr>
											<td><b>Date of Birth : </b></td>
											<td>		<%-- 				
												<g:datePicker name="dob" 
													id="idDob"
													precision="day" 
													value="${params.dob}" 
													noSelection="['':'']" 
													relativeYears="[-100..5]" 
													default="none"/>		
													&nbsp;--%>
													
												<input type="text" id="dobId"
													name="dob" value="${params.dob}"
													onclick='javascript: dobId.value = ""'
													readOnly="true"
													onKeypress='javascript: dobId.value = ""'
													maxlength="25"/>&nbsp;&nbsp;<img
													src="${resource(dir: 'images', file: 'cal/cal.gif')}"
													onclick="javascript:NewCssCal('dobId','MMddyyyy')"
													style="cursor: pointer" />
													
											</td>

										<td><b>System Id : </b></td>
											<td><input type="text" name="systemId" id="idSystemID"
												maxlength="12" value="${params.systemId}"> &nbsp;</td>

										</tr>
										<tr>
										<td><b>Address 1 : </b></td>
											<td><input type="text" name="street" id="idstreet"
												maxlength="60" value="${params.street}"> &nbsp;</td>
										<td><b>City : </b></td>
											<td><input type="text" name="city" id="idcity"
												maxlength="30" value="${params.city}"> &nbsp;</td>
										</tr>
										<tr>
											<td><b>SSN : </b></td>
											<td><input type="text" name="socialSecurityNumber" id="idSocialSecurityNumber" 
												maxlength="11" value="${params.socialSecurityNumber}"> &nbsp;</td>

										</tr>
										<tr id="search_button">
											<td colspan="2"><input type="submit" value="Search"
												class="load" onClick="return checkForSearchCritera()"> <g:if
													test="${create && params.subscriberID}">
													<g:checkURIAuthorization uri="/memberMaintenance/create">
													<input style="font-size:13px;"  type="button" class="load" id="Create_id"
														value="Create a Member - ${params.subscriberID}"
														onClick="createMember()" />
													</g:checkURIAuthorization>
												</g:if>
												<g:elseif
													test="${parameter1=='Y'}">													
													<input type="button" class="load" id="Create_id"
														value="Auto Assign Member ID"
														onClick="autoGenMember()" />													
												</g:elseif>
											</td>
											<td colspan="2" style="text-align: right">
												<div style="align: right">
													<input type="button" class="load" value="Reset"
														onClick="document.forms['searchForm'].reset();setFirstElementFocus()"> <input
														type="button" class="load" value="Clear"
														onClick="clearSearchCriteria()">
												</div>
											</td>
										</tr>
									</table>

								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

		</form>
	<g:if test="${ memberMasterTotal >0}">
		<div id="list-memberMaster" class="content scaffold-list" role="main"  style="width:100%; overflow-x: scroll; font-size:13px;">
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Number of members found for the
			search criteria -
			${memberMasterTotal}
			<br> <br>

			<table style="font-size:13px;">
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>
									<table>
										<thead>
											<tr>
												<g:sortableColumn property="subscriberID" style="padding-left:15px;"
													title="${message(code: 'simpleMember.subscriberID.label', default: 'Subscriber Id')}"
													params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												<g:if test="${showMember}">
													<g:sortableColumn property="personNumber"
														title="${message(code: 'simpleMember.getPersonNumber.label', default: 'P/N')}"
														params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												</g:if>
												<g:else>
														<g:sortableColumn property="personNumber"
														title="${message(code: 'simpleMember.getPersonNumber.label', default: 'Subs/Memb')}"
														params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												</g:else>
												<g:sortableColumn property="diamondID"
													title="${message(code: 'simpleMember.diamondID.label', default: 'System Id')}"
													params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="firstName"
													title="${message(code: 'simpleMember.firstName.label', default: 'First Name')}"
													params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="lastName"
													title="${message(code: 'simpleMember.lastName.label', default: 'Last Name')}"
													params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="gender"
													title="${message(code: 'simpleMember.gender.label', default: 'Gender')}"
													params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="dob"
													title="${message(code: 'simpleMember.dob.label', default: 'Date of Birth')}"
													params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
													<th class="sortable">Dashboard</th>
												<g:sortableColumn property="socialSecurityNumber"
													title="${message(code: 'simpleMember.socialSecurityNumber.label', default: 'SSN')}"
													params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
												<th class="sortable">Address 1</th>
												<th class="sortable">City</th>
												<th class="sortable">Date Created</th>
											</tr>
										</thead>
										<tbody>
											<g:each in="${memberMasterList}" status="i"
												var="memberMasterInstance">
												<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

													<td style="height: 20px; overflow: hidden;">
														<div title="${memberMasterInstance.subscriberID}">
															<g:if test="${showMember}">
																<g:link action="show"
																	id="${memberMasterInstance.subscriberID}"
																	params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																	${fieldValue(bean: memberMasterInstance, field: "subscriberID")}
																</g:link>
															</g:if>
															<g:else>
																${fieldValue(bean: memberMasterInstance, field: "subscriberID")}
															</g:else>
														</div>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<div title="${memberMasterInstance.personNumber}">
														<g:if test="${showMember}">
															<g:link action="show"
																id="${memberMasterInstance.subscriberID}"
																params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																${fieldValue(bean: memberMasterInstance, field: "personNumber")}
															</g:link>
														</g:if>
															<g:else>
																${fieldValue(bean: memberMasterInstance, field: "personNumber")}
															</g:else>
														</div>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<div title="${memberMasterInstance.diamondID}">
														<g:if test="${showMember}">
															<g:link action="show"
																id="${memberMasterInstance.subscriberID}"
																params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																${fieldValue(bean: memberMasterInstance, field: "diamondID")}
															</g:link>
															</g:if>
															<g:else>
																${fieldValue(bean: memberMasterInstance, field: "diamondID")}
															</g:else>
														</div>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<div title="${memberMasterInstance.firstName}">
														<g:if test="${showMember}">
															<g:link action="show"
																id="${memberMasterInstance.subscriberID}"
																params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																${fieldValue(bean: memberMasterInstance, field: "firstName")}
															</g:link>
														</g:if>
														<g:else>
															${fieldValue(bean: memberMasterInstance, field: "firstName")}
														</g:else>
														</div>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<div title="${memberMasterInstance.lastName}">
														<g:if test="${showMember}">
															<g:link action="show"
																id="${memberMasterInstance.subscriberID}"
																params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																${fieldValue(bean: memberMasterInstance, field: "lastName")}
															</g:link>
														</g:if>
														<g:else>
															${fieldValue(bean: memberMasterInstance, field: "lastName")}
														</g:else>
														</div>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<div title="${memberMasterInstance.gender}">
														<g:if test="${showMember}">
															<g:link action="show"
																id="${memberMasterInstance.subscriberID}"
																params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																${fieldValue(bean: memberMasterInstance, field: "gender")}
															</g:link>
														</g:if>
														<g:else>
															${fieldValue(bean: memberMasterInstance, field: "gender")}
														</g:else>
														</div>
													</td>
													<td style="height: 20px; overflow: hidden;">
													<g:if test="${showMember}">
														<g:link	action="show" id="${memberMasterInstance.subscriberID}"
																params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																<g:if test="${memberMasterInstance?.dob}">
																	<g:formatDate format="MM/dd/yyyy"
																		date="${memberMasterInstance.dob}" />
																</g:if>
														</g:link>
													</g:if>
													<g:else>
														<g:if test="${memberMasterInstance?.dob}">
																	<g:formatDate format="MM/dd/yyyy"
																		date="${memberMasterInstance.dob}" />
														</g:if>
													</g:else>
													</td>
														<td style="height: 20px; overflow: hidden;">
															<g:link
																	action="memberDashboard1" id="${memberMasterInstance.subscriberID}"
																	params="${[subscriberId: memberMasterInstance.subscriberID, personNumber: memberMasterInstance.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">
																	<img width="20" height="20" src="${resource(dir: 'images', file: 'support_icon.png')}">
															</g:link> 
														</td>
													<td style="height: 20px; overflow: hidden;white-space: nowrap;">
														<div title="${memberMasterInstance.socialSecurityNumber}" >
														<g:if test="${showMember}">
															<g:link action="show"
																id="${memberMasterInstance.subscriberID}"
																params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																<%--g:if test="${memberMasterInstance?.socialSecurityNumber?.length() == 9}">${memberMasterInstance?.socialSecurityNumber.with {length()? getAt(0..2):''}}-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt(3..4):''}}-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt( -Math.min(4,length())..-1):''}}</g:if--%>
																<g:if test="${memberMasterInstance?.socialSecurityNumber?.length() == 9}">***-**-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt( -Math.min(4,length())..-1):''}}</g:if>
																<g:else></g:else>
															</g:link>
														</g:if>
														<g:else>
															<%--g:if test="${memberMasterInstance?.socialSecurityNumber?.length() == 9}">${memberMasterInstance?.socialSecurityNumber.with {length()? getAt(0..2):''}}-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt(3..4):''}}-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt( -Math.min(4,length())..-1):''}}</g:if--%>
															<g:if test="${memberMasterInstance?.socialSecurityNumber?.length() == 9}">***-**-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt( -Math.min(4,length())..-1):''}}</g:if>
															<g:else></g:else>
														</g:else>
														</div>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<g:if test="${memberMasterInstance?.primaryMemberAddress?.address1}">
															<div title="${memberMasterInstance.primaryMemberAddress?.address1}">
															<g:if test="${showMember}">
																<g:link action="show"
																	id="${memberMasterInstance.subscriberID}"
																	params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																	${fieldValue(bean: memberMasterInstance.primaryMemberAddress, field: "address1")}
																</g:link>
															</g:if>
															<g:else>
																${fieldValue(bean: memberMasterInstance.primaryMemberAddress, field: "address1")}
															</g:else>
															</div>
														</g:if>
														<g:else></g:else>
													</td>
													
													<td style="height: 20px; overflow: hidden;">
														<g:if test="${memberMasterInstance?.primaryMemberAddress?.city}">
															<div title="${memberMasterInstance.primaryMemberAddress.city}">
															<g:if test="${showMember}">
																<g:link action="show"
																	id="${memberMasterInstance.subscriberID}"
																	params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																	${fieldValue(bean: memberMasterInstance.primaryMemberAddress, field: "city")}
																</g:link>
															</g:if>
															<g:else>
																${fieldValue(bean: memberMasterInstance.primaryMemberAddress, field: "city")}
															</g:else>
															</div>
														</g:if>
														<g:else></g:else>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<g:if test="${memberMasterInstance?.insertDate}">
															<div title="${memberMasterInstance.insertDate}">
															<g:if test="${showMember}">
																<g:link action="show"
																	id="${memberMasterInstance.subscriberID}"
																	params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}">
																	<g:formatDate format="MM/dd/yyyy"
																		date="${memberMasterInstance.insertDate}" />
																</g:link>
															</g:if>
															<g:else>
																<g:formatDate format="MM/dd/yyyy"
																		date="${memberMasterInstance.insertDate}" />
															</g:else>
															</div>
														</g:if>
														<g:else></g:else>
													</td>									
												</tr>
											</g:each>
										</tbody>

									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div class="pagination">
			<g:paginate total="${memberMasterTotal}"
				params="${[subscriberID:params.subscriberID, issuerSubscriberId:params.issuerSubscriberId ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
		</div>
</g:if>
		<div style="display: none">
			<input type="button" onClick="closeAllIFrames()" id="closeIframes">
			<input type="button" onClick="iFrameSearchTradp()" id="ifSearchTradp">
			<input type="button" onClick="iFrameSearchBatch()" id="ifSearchBatch">
		</div>
	</div>
</body>
</html>
