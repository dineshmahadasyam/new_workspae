<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'user.label', default: 'User')}" />

<g:set var="appContext" bean="grailsApplication"/>	
	
<title>Search Users</title>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>

<!-- Style Includes for lookup-->
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css" />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'forms.css')}" type="text/css" />



<script type="text/javascript">
	function setFirstElementFocus() {
		var firstText = true;
		var elements = document.getElementsByTagName("input");
		for ( var ii = 0; ii < elements.length; ii++) {
			if (elements[ii].type == "text") {
				if (firstText) {
					firstText = false;
					elements[ii].focus();
					//break;
				}
			}
		}
	}

	function clearSearchCriteria() {
		var elements = document.getElementsByTagName("input");
		var firstText = true;
		for ( var ii = 0; ii < elements.length; ii++) {
			if (elements[ii].type == "text") {
				elements[ii].value = "";
				if (firstText) {
					firstText = false;
					elements[ii].focus();
					var clear_btn = document.getElementById('Create_id')
			        if(clear_btn!=null)
				        {
			        	clear_btn.style.display="none"
			        	var usr_maintance_message_div = document.getElementById("usr_maintance_message_id")
				    	if(usr_maintance_message_div !=null){	
				    		var usr_maintance_message_div_value_1 = document.getElementById("usr_maintance_message_id").innerHTML
				    		if(usr_maintance_message_div_value_1!=null)
				  	        {
				  	         usr_maintance_message_div.style.display="none"
				  	        }
				    	}
				    
				        }
			        else
				        {
			        	var usr_maintance_message_div_1 = document.getElementById("usr_maintance_message_id")
			        	if(usr_maintance_message_div_1 !=null){		
			        		var usr_maintance_message_div_value_1 = document.getElementById("usr_maintance_message_id").innerHTML
			        		usr_maintance_message_div_value_1.style.display="none"
			        	}
				        }
			        
				}
			}
			/*if (elements[ii].type == "radio") {
				elements[ii].checked = false;
			}*/
		}
		var elements = document.getElementsByTagName("select");
		for ( var ii = 0; ii < elements.length; ii++) {
			elements[ii].selectedIndex = 0;
		}
	}

	function createUser() {

		var createUserId = document.getElementById("userId").value;
		var appName = "${appContext.metadata['app.name']}";
		
		window.location.assign("/"+appName+"/userMaintenance/create?userId="
				+ createUserId + "&groupEditType=master");
	}

	function clearForm() {
		$('#userId').val('');
	}
</script>
<script>
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
		alert ("Please enter search criteria to find results.");
	  }
	  
	  return searchCriteria;
	
}
</script>



</head>



<body>

	<g:form name="userSearchForm" action="list" method="post">
	<fieldset>
		<input type="hidden" name="searchRef" value="searchForm">
		<div id="list-user" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status" id="usr_maintance_message_id">
					${flash.message}
				</div>
			</g:if>

			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>

			<br> <br>
			<table>
				<tr>
					<td>
						<table border="1" style="border-radius: 15px;">
							<tr>
								<td>
									<table border="0" width="100%">


										<tr>
											<td class="innerbackground" colspan="4"
												style="color: #FFFFFF; text-align: center"><b>User
													Maintenance</b></td>
										</tr>
										<tr>
											<td colspan="4"><b>User Id : </b> <input type="text"
												name="userId" id="userId"
												value="${params.userId}" maxlength="8"
												autofocus="autofocus" /></td>
										</tr>
										<tr id="search_button">

											<td colspan="2"><g:submitButton name="search"
													class="searchButton"
													value="${message(code: 'default.button.search.label', default: 'Search')}"
													onClick="return checkForSearchCritera()"/>

												<g:if test="${create && request.getParameter('userId')}">
													<input type="button" id="Create_id"
														value="Create a User - ${request.getParameter('userId')}"
														onClick="createUser()" class="searchButton" />
												</g:if></td>
											<td colspan="4" style="text-align: right">
												<div style="align: right">
													<input type="button" class="load" value="Reset"
														onClick="document.forms['userSearchForm'].reset();setFirstElementFocus()">
													<input type="button" class="load" value="Clear" 
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

			<g:if test="${userTotal>0}">

				<div id="list-user" class="content scaffold-list" role="main">
					<h1>
						<g:message code="default.list.label" args="[entityName]" />
					</h1>

	 <table>
		 <tr>
			<td>
				<table border="1" style="border-radius: 15px;">
					<tr>
						<td>
							<table border="0" width="100%">
									<thead>
										<tr>
											<g:sortableColumn property="userId" style="padding-left:20px;"
												title="${message(code: 'secUser.subscriberID.label', default: 'User Id')}"
												params="${[userId:request.getParameter('userId')]}" />
											<g:sortableColumn property="userType"
												title="${message(code: 'secUser.getPersonNumber.label', default: 'User Type')}"
												params="${[userId:request.getParameter('userId')]}" />
											<g:sortableColumn property="userCategory"
												title="${message(code: 'secUser.diamondID.label', default: 'User Category')}"
												params="${[userId:request.getParameter('userId')]}" />
											<g:sortableColumn property="fname"
												title="${message(code: 'secUser.firstName.label', default: 'First Name')}"
												params="${[userId:request.getParameter('userId')]}" />
											<g:sortableColumn property="lname"
												title="${message(code: 'secUser.lastName.label', default: 'Last Name')}"
												params="${[userId:request.getParameter('userId')]}" />
											<g:sortableColumn property="dfltTemplate"
												title="${message(code: 'secUser.gender.label', default: 'Template')}"
												params="${[userId:request.getParameter('userId')]}" />
									
										</tr>
									</thead>
									<tbody>
										<g:each in="${userList}" status="i" var="userInstance">
											<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
			
												<td><g:link action="edit" id="${userInstance.userId}">
														${fieldValue(bean: userInstance, field: "userId")}
													</g:link></td>
												<td>
													${fieldValue(bean: userInstance, field: "userType")}
												</td>
												<td>
													${fieldValue(bean: userInstance, field: "userCategory")}
												</td>
			
												<td>
													${fieldValue(bean: userInstance, field: "fname")}
												</td>
												<td>
													${fieldValue(bean: userInstance, field: "lname")}
												</td>
												<td>
													${fieldValue(bean: userInstance, field: "dfltTemplate")}
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
					<g:paginate total="${userTotal}"
						params="${[userId:request.getParameter('userId')]}" />
				</div>
			</g:if>
		</div>
		</fieldset>
	</g:form>

</body>
</html>
