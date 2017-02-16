<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName"
			value="${message(code: 'user.label', default: 'User')}" />
		
		<g:set var="appContext" bean="grailsApplication"/>	
			
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'forms.css')}" type="text/css" />
		
		<script type="text/javascript">

		//Copy Function screen - Set the Search Button as the default button when enter button is clicked. If the search 
		//results are already populated then the copy button will be the default button when enter button is clicked.
		$(document).keypress(function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if(keycode == '13'){
				var actionStr = $("#searchForm").attr('action');
				if (actionStr.indexOf("copyFunction") >= 0 ) {
					var i = $(':input:submit').length;
					var j = $(':input:button').length;
					if ((parseInt(i) + parseInt(j)) == 4) {
						$(".searchButton").click();
						return false;
					}
					else {
						return getFunctionstoCopy();
					}	
				} 	
			}
			
		});
		
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

			//Clear all input fields which are not disabled/read only
			function clearSearchCriteria() {
				var elements = document.getElementsByTagName("input");
				var firstText = true;
				for ( var ii = 0; ii < elements.length; ii++) {
					if ((elements[ii].type == "text") && (!(elements[ii].disabled))) {
						elements[ii].value = "";
						if (firstText) {
							firstText = false;
							elements[ii].focus();
						 }     
					}
				}
			}
		
			function checkForSearchCriteria() {
				var elements = document.getElementsByTagName("input");
				var searchCriteria = false;
				
				for (var ii=0; ii < elements.length; ii++) {
				  if (elements[ii].type == "text") {
				    if(elements[ii].value){
					    searchCriteria = true;
					    }
				  }
				}
					
				  if(searchCriteria == false){
					alert ("Please enter search criteria to find results.");
				  }
				  
				  return searchCriteria;
				
			}

			//Get a list of all functions that needs to be added 
			function getFunctionstoAdd() {
				var idSelector = function() {
					return this.id;
				};
				var checkedValues = $('input:checkbox:checked').map(idSelector).get();
				document.getElementById('functionList').value = checkedValues;

				if (checkedValues == '') {
					alert("Please select atleast one function to add.");
					return false;

				} else {
					$(".addFunctionButtonHidden").click();
				}

			}

			//Call Search action on the controller passing userID and addfunction
			//Which will then search functions within Add functions screen for that user
			function searchFunctionForUserToAdd() 
			{
				var paramsToPass = {};
				if (location.search) {
				    var parts = location.search.substring(1).split('&');
				    for (var i = 0; i < parts.length; i++) {
				        var nv = parts[i].split('=');
				        if (!nv[0]) continue;
				        paramsToPass[nv[0]] = nv[1] || true;
				    }
				}
				
				var userId = paramsToPass.userId
				var funcId  = $("#funcId").val(); 
				var sdescr =  $("#sdescr").val();  
				var ldescr = $("#ldescr").val(); 	
				
				window.location.assign('<g:createLinkTo dir="/userMaintenance/search?userId="/>' + 
						userId + '&addFunction=${true}' 
						+ '&funcId=' + funcId 
						+ '&sdescr=' + sdescr
						+ '&ldescr=' + ldescr);
			}

			//Call Search action on the controller passing userID and copyfunction
			//which will then search functions for that User ID 
			function searchFunctionForUserToCopy() 
			{
				var userIdToCopyFrom = $("#userIdToCopyFrom").val().toUpperCase();
				var userIdTo = $("#userIdTo").val().toUpperCase();

				if (userIdToCopyFrom == '') {
					alert("Please enter a User Id to copy functions from.");
					return false;
				} 
				else if (userIdToCopyFrom == userIdTo) {
					alert("Copy To and From User Id cannot be the same.");
					return false;
				}
				else {
					window.location.assign('<g:createLinkTo dir="/userMaintenance/search?userId="/>' + 
							userIdTo + '&copyFunction=${true}' 
							+ '&userIdToCopyFrom=' + userIdToCopyFrom
							);
				}
			}
			

			//Get a list of all functions that needs to be copied 
			function getFunctionstoCopy() {
				var idSelector = function() {
					return this.id;
				};
				var checkedValues = $('input:checkbox:checked').map(idSelector).get();

				document.getElementById('functionList').value = checkedValues;

				if (checkedValues == '') {
					alert("Please select atleast one function to copy.");
					return false;

				} else {
					$(".copyFunctionButtonHidden").click();
				}

			}
		</script>
		
		<style type='text/css' media='screen'>
			.addFunctionButton {
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
			
			.copyFunctionButton {
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
			
			div.right-corner {
			    position: absolute;
			    top: 0px;
			    right: 0;
			    margin-right: 40px;
			    font:normal normal 21pt / 1 Tahoma;
			    color: #48802C;
		  }
		  
		  
		</style>
		
	</head>

	<body>
	<%-- START OF ADD FUNCTION CODE --%>
	<g:if test="${request.getParameter('addFunction') == "true" }">
		<g:form name="searchForm" method="post" action="addFunction">
			<fieldset>
				<input type="hidden" name="searchRef" value="searchForm">
				<div id="list-user" class="content scaffold-list" role="main">
					<g:if test="${flash.message}">
						<div class="message" role="status" id="message_id">
							${flash.message}
						</div>
					</g:if>
					<div id="errorDisplay" style="display: none;" class="errors"
						style="float:left; margin: -5px 10px 0px 0px; "></div>
					<br> <br>
					<div class="right-corner" align="center" title="The keyword for this screen that can be used for audit trail">SFUNC</div>
					<table>
						<tr>
							<td>
								<table border="1" style="border-radius: 15px;">
									<tr>
										<td>
											<table style="border:0; width:100%">
												<tr>
													<td class="innerbackground" colspan="4"
														style="color: #FFFFFF; text-align: center"><b>Search
															Functions</b></td>
												</tr>
												<tr>
													<td>
													<b>Function : </b> 
													<input autofocus="autofocus" type="text" name="funcId"
																id="funcId" value="${params.funcId}" maxlength="255" autofocus="autofocus"/>
													</td>
													<td><b>Short Description : </b>
														<input type="text" name="sdescr"
																id="sdescr" value="${params.sdescr}" maxlength="32" /> 
													</td>
												    <td>
												    <b>Long Description : </b> 
												    	<input type="text" name="ldescr"
																id="ldescr" value="${params.ldescr}" maxlength="128" />
													</td>
												</tr>
												<tr><td>&nbsp;</td></tr>
												
												<tr id="search_button">
													<td colspan="2">
														<input type="button" class="searchButton" value="Search"
																onClick="return searchFunctionForUserToAdd()">
													</td>
													<td colspan="4" style="text-align: right">
														<div style="align: right">
															<input type="button" class="load" value="Reset"
																onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
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
					<table style="width: 100%; overflow-x: scroll; font-size: 13px;display:none;">
						<tr>
							<td>
								<g:javascript>
									if ($.browser.mozilla) {
										<g:actionSubmit class="addFunctionButtonHidden" value="Add" action="addFunction"/>
									}
									else {
										<g:actionSubmit class="addFunctionButtonHidden" value="Add"/>
									}
								</g:javascript>
								<g:hiddenField name="functionList" id="functionList" value="" />
								<g:hiddenField name="userId" id="userId" value="${params.userId}"/>
								<g:hiddenField  name="editType" id="editType" value="FUNCTIONACCESS"/>
								<g:hiddenField name="id" id="id" value="${params.userId}"/>
							</td>
						</tr>
					</table>
				</div>
			</fieldset>
			<g:if test="${functionDescriptionTotal > 0}">
				<table style="width: 100%; overflow-x: scroll; font-size: 13px;">
					<tr style="width: 100%;">
							<td width="100%" align="right">Number of Functions available to add - ${functionDescriptionTotal} </td>
							<td>
								<g:submitButton class="addFunctionButton" name="addFunctionButton" value="Add" onclick="return getFunctionstoAdd();" />
							</td>
					</tr>
				</table>
				<table style="width: 100%; overflow-x: scroll; font-size: 13px;">
					<tr>
						<td>
							<table border="1">
								<tr>
									<td>
										<table border="0">
											<thead>
												<tr>
													<g:sortableColumn property="funcId"
														title="${message(code: 'functionDescription.funcId.label', default: 'Function')}"
														params="${[offset:request.getParameter('offset'),
															addFunction:true,
															userId: request.getParameter('userId'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
													<g:sortableColumn property="sdescr"
														title="${message(code: 'functionDescription.sdescr.label', default: 'Short Description')}"
														params="${[offset:request.getParameter('offset'),
															addFunction:true,
															userId: request.getParameter('userId'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
													<g:sortableColumn property="ldescr"
														title="${message(code: 'functionDescription.ldescr.label', default: 'Long Description')}"
														params="${[offset:request.getParameter('offset'),
															addFunction:true,
															userId: request.getParameter('userId'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
														<th><div style="overflow: hidden;">Add</div></th>
												</tr>
											</thead>
											<g:each in="${functionDescriptionList}" status="i" var="functionDescription">
												<tbody>
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "funcId")}
															</div>
														</td>
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "sdescr")}
															</div>
														</td>
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "ldescr")}
															</div>
														</td>
														<td>
																<div  style="height:20px; overflow:hidden;">
																		<g:checkBox name="${functionDescription.funcId}.checkBox" />
																</div>
														</td>
													</tr>
												</tbody>
											</g:each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</g:if>
		</g:form>
		<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'funcId' }">
		<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'asc' }">
		<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">		
		<g:if test="${functionDescriptionTotal > 10}">
			<div class="pagination">
					<g:paginate total="${functionDescriptionTotal}" params="${[addFunction:true, userId:params.userId , offset:request.getParameter('offset'), funcId:request.getParameter('funcId'), sdescr:request.getParameter('sdescr'), ldescr:request.getParameter('ldescr')]}" />
			</div>
		</g:if>
		
	</g:if>
	<%-- END OF ADD FUNCTION CODE --%>
	<%-- START OF COPY FUNCTION CODE --%>
	<g:elseif test="${request.getParameter('copyFunction') == "true" }">
		<g:form name="searchForm" method="post" action="copyFunction">
			<fieldset>
				<input type="hidden" name="searchRef" value="searchForm">
				<div id="list-user" class="content scaffold-list" role="main">
					<g:if test="${flash.message}">
						<div class="message" role="status" id="message_id">
							${flash.message}
						</div>
					</g:if>
					<div id="errorDisplay" style="display: none;" class="errors"
						style="float:left; margin: -5px 10px 0px 0px; "></div>
					<br> <br>
					<div class="right-corner" align="center" title="The keyword for this screen that can be used for audit trail">SFUNC</div>
					<table>
						<tr>
							<td>
								<table border="1" style="border-radius: 15px;">
									<tr>
										<td>
											<table style="border:0; width:100%">
												<tr>
													<td class="innerbackground" colspan="6"
														style="color: #FFFFFF; text-align: center"><b>Search
															Functions</b></td>
												</tr>
												<tr>
													<td colspan="2"><b>User Id :<br/>(Copy To) </b> <input type="text"
														name="userIdTo" id="userIdTo"
														value="${params.userId}" maxlength="8" disabled = "true"
														 /></td>
													<td colspan="2"><b>User Id :<br/>(Copy From)</b> <input type="text"
														name="userIdToCopyFrom" id="userIdToCopyFrom"
														value="${params.userIdToCopyFrom}" maxlength="8"
														autofocus="autofocus" /></td>
													<td colspan="2">&nbsp;</td>
												</tr>
												<tr><td>&nbsp;</td></tr>
												
												<tr id="search_button">
													<td colspan="2">
													<input type="button" class="searchButton" value="Search"
																onClick="return searchFunctionForUserToCopy();">
													</td>
													<td colspan="4" style="text-align: right">
														<div style="align: right">
															<input type="button" class="load" value="Reset"
																onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
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
					<table style="width: 100%; overflow-x: scroll; font-size: 13px;display:none;">
						<tr>
							<td><g:actionSubmit class="copyFunctionButtonHidden" value="Copy" action="copyFunction"/>
								<g:hiddenField name="functionList" id="functionList" value="" />
								<g:hiddenField name="userId" id="userId" value="${params.userId}"/>
								<g:hiddenField  name="editType" id="editType" value="FUNCTIONACCESS"/>
								<g:hiddenField name="id" id="id" value="${params.userId}"/>
							</td>
						</tr>
					</table>
				</div>
			</fieldset>
			<g:if test="${functionDescriptionTotal > 0}">
				<table style="width: 100%; overflow-x: scroll; font-size: 13px;">
					<tr style="width: 100%;">
							<td width="100%" align="right">Number of Functions available to copy - ${functionDescriptionTotal} </td>
							<td>
								<g:submitButton class="copyFunctionButton" name="copyFunctionButton" value="Copy" onclick=" return getFunctionstoCopy();" />
							</td>
					</tr>
				</table>
				<table style="width: 100%; overflow-x: scroll; font-size: 13px;">
					<tr>
						<td>
							<table border="1">
								<tr>
									<td>
										<table border="0">
											<thead>
												<tr>
													<g:sortableColumn property="funcId"
														title="${message(code: 'functionDescription.funcId.label', default: 'Function')}"
														params="${[offset:request.getParameter('offset'),
															copyFunction:true,
															userId: request.getParameter('userId'),
															userIdToCopyFrom: request.getParameter('userIdToCopyFrom'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
													<g:sortableColumn property="sdescr"
														title="${message(code: 'functionDescription.sdescr.label', default: 'Short Description')}"
														params="${[offset:request.getParameter('offset'),
															copyFunction:true,
															userId: request.getParameter('userId'),
															userIdToCopyFrom: request.getParameter('userIdToCopyFrom'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
													<g:sortableColumn property="ldescr"
														title="${message(code: 'functionDescription.ldescr.label', default: 'Long Description')}"
														params="${[offset:request.getParameter('offset'),
															copyFunction:true,
															userId: request.getParameter('userId'),
															userIdToCopyFrom: request.getParameter('userIdToCopyFrom'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
														<th><div style="overflow: hidden;">Copy</div></th>
												</tr>
											</thead>
											<g:each in="${functionDescriptionList}" status="i" var="functionDescription">
												<tbody>
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "funcId")}
															</div>
														</td>
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "sdescr")}
															</div>
														</td>
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "ldescr")}
															</div>
														</td>
														<td>
																<div  style="height:20px; overflow:hidden;">
																		<g:checkBox name="${functionDescription.funcId}.checkBox" />
																</div>
														</td>
													</tr>
												</tbody>
											</g:each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</g:if>
			</g:form>
			<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'funcId' }">
			<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'asc' }">
			<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">		
			<g:if test="${functionDescriptionTotal > 10}">
				<div class="pagination">
						<g:paginate total="${functionDescriptionTotal}" params="${[copyFunction:true, userId:params.userId, userIdToCopyFrom:params.userIdToCopyFrom, offset:request.getParameter('offset'), funcId:request.getParameter('funcId'), sdescr:request.getParameter('sdescr'), ldescr:request.getParameter('ldescr')]}" />
				</div>
			</g:if>
	</g:elseif>
	<%-- END OF COPY FUNCTION CODE --%>
	<%-- START OF PLAIN SEARCH CODE --%>
	<g:else>
		<g:form name="searchForm" method="post" action="search">
			<fieldset>
				<input type="hidden" name="searchRef" value="searchForm">
				<div id="list-user" class="content scaffold-list" role="main">
					<g:if test="${flash.message}">
						<div class="message" role="status" id="message_id">
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
											<table style="border:0; width:100%">
												<tr>
													<td class="innerbackground" colspan="4"
														style="color: #FFFFFF; text-align: center"><b>Function
															Description</b></td>
												</tr>
												<tr>
													<td>
													<b>Function : </b> 
													<input autofocus="autofocus" type="text" name="funcId"
																id="funcId" value="${params.funcId}" maxlength="255" autofocus="autofocus"/>
													</td>
													<td><b>Short Description : </b>
														<input type="text" name="sdescr"
																id="sdescr" value="${params.sdescr}" maxlength="32" /> 
													</td>
												    <td>
												    <b>Long Description : </b> 
												    	<input type="text" name="ldescr"
																id="ldescr" value="${params.ldescr}" maxlength="128" />
													</td>
												</tr>
												<tr><td>&nbsp;</td></tr>
												
												<tr id="search_button">
													<td colspan="2"><g:submitButton name="search"
															class="searchButton"
															value="${message(code: 'default.button.search.label', default: 'Search')}"
															onClick="return checkForSearchCriteria()"/>
													</td>
													<td colspan="4" style="text-align: right">
														<div style="align: right">
															<input type="button" class="load" value="Reset"
																onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
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
					<table style="width: 100%; overflow-x: scroll; font-size: 13px;display:none;">
						<tr>
							<td><g:hiddenField name="functionList" id="functionList" value="" />
								<g:hiddenField name="userId" id="userId" value="${params.userId}"/>
								<g:hiddenField  name="editType" id="editType" value="FUNCTIONACCESS"/>
								<g:hiddenField name="id" id="id" value="${params.userId}"/>
							</td>
						</tr>
					</table>
				</div>
			</fieldset>
			<g:if test="${functionDescriptionTotal > 0}">
				<table style="width: 100%; overflow-x: scroll; font-size: 13px;">
					<tr style="width: 100%;">
							<td width="100%" align="right">Number of Function Description - ${functionDescriptionTotal} </td>
					</tr>
				</table>
				<table style="width: 100%; overflow-x: scroll; font-size: 13px;">
					<tr>
						<td>
							<table border="1">
								<tr>
									<td>
										<table border="0">
											<thead>
												<tr>
													<g:sortableColumn property="funcId" style="padding-left:10px;"
														title="${message(code: 'functionDescription.funcId.label', default: 'Function')}"
														params="${[offset:request.getParameter('offset'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
													<g:sortableColumn property="sdescr"
														title="${message(code: 'functionDescription.sdescr.label', default: 'Short Description')}"
														params="${[offset:request.getParameter('offset'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
													<g:sortableColumn property="ldescr"
														title="${message(code: 'functionDescription.ldescr.label', default: 'Long Description')}"
														params="${[offset:request.getParameter('offset'),
															funcId:request.getParameter('funcId'),
															sdescr:request.getParameter('sdescr'),
															ldescr:request.getParameter('ldescr')]}" />
												</tr>
											</thead>
											<g:each in="${functionDescriptionList}" status="i" var="functionDescription">
												<tbody>
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "funcId")}
															</div>
														</td>
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "sdescr")}
															</div>
														</td>
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: functionDescription, field: "ldescr")}
															</div>
														</td>
													</tr>
												</tbody>
											</g:each>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</g:if>
		</g:form>
		<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'funcId' }">
		<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'asc' }">
		<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">		
		<g:if test="${functionDescriptionTotal > 10}">
			<div class="pagination">
					<g:paginate total="${functionDescriptionTotal}" params="${[offset:request.getParameter('offset'), funcId:request.getParameter('funcId'), sdescr:request.getParameter('sdescr'), ldescr:request.getParameter('ldescr')]}" />
			</div>
		</g:if>
	</g:else>
	<%-- END OF PLAIN SEARCH CODE --%>
	</body>
</html>
