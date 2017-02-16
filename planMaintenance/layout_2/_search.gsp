<%@ page import="com.dell.diamond.service.auth.SecurityService" %>
<%@ page import="com.perotsystems.diamond.dao.cdo.PlanMaster"%>

<g:checkURIAuthorization uri="/planMaintenance/search"/>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'planMaster.label', default: 'PlanMaster')}" />
	
<g:set var="appContext" bean="grailsApplication"/>

<title>Plan Maintenance</title>

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
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf');
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
	border-radius: 15px;
}
</style>

<!-- Style Includes -->
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">
	
<%-- JavaScript Includes --%>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>

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

		function create() {
			var createID = "${params.planCode}";
			var appName = "${appContext.metadata['app.name']}";
			window.location.assign("/"+appName+"/planMaintenance/edit/plan?planCode="
							+ createID);
		}
		
		function createNew() {
			window.location.assign("create?planCode=${params.planCode}");
		}
		
		$(function($){
		   $("#planCode").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});
		})

function edit() {
	var createID = "${params.planCode}";
	var appName = "${appContext.metadata['app.name']}";
	window.location.assign("/"+appName+"/planMaintenance/plan?planCode="
					+ createID);
}

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
	<div id="list-planMaster" class="content scaffold-list" role="main" style="width:100%; overflow:scroll;">
		<g:if test="${flash.message}">
			<div class="message" role="status" id="plan_maintance_message_id">
				${flash.message}
			</div>
		</g:if>
		<br> <br>
		<form name="searchForm" action="/${appContext.metadata['app.name']}/planMaintenance/search">
			<input type="hidden" name="searchRef" value="searchForm">
			<table>
				<tr>
					<td>

						<table border="1" >
							<tr>
								<td>
									<table>
										<tr>
												<td class="innerbackground" colspan="4"
													style="color: #FFFFFF; text-align: center"><b>Plan</b></td>
										</tr>
										<tr>
											<td colspan="1" style="width:100px;"><b>Plan Code : </b></td>
											<td colspan="1"><input autofocus="autofocus" type="text" maxlength="50" style="width:300px;" name="planCode"
												id="planCode" value="${params.planCode}"
												maxlength="100" > &nbsp;</td>		
											<td colspan="1" style="width:110px;"><b>Description : </b></td>
											<td colspan="1"><input type="text" name="shortDescription" style="width:300px;"
												id="shortDescription" value="${params.shortDescription}" maxlength="20"
												maxlength="150"> &nbsp;</td>																
										</tr>
										<tr>
											<td colspan="1" style="width:120px;"><b>Product Type : </b></td>
											<td colspan="1">
												<g:getSystemCodes
												systemCodeType="PRODUCT_TYPE" 
												systemCodeActive = "Y"
												htmlElelmentId="productType"
												blankValue="productType"
												defaultValue="${params.productType}" 
												width="300px"
												title = "Select the type of coverage for the plan from list"/> &nbsp;
											</td>
											<td colspan="1" style="width:160px;"><b>HIX Product Code : </b></td>
											<td colspan="1"><input type="text" name="hixProductCode" style="width:300px;"
												id="hixProductCode" value="${params.hixProductCode}" maxlength="15"
												title = "Enter valid HIX Product Code"> &nbsp;
											</td>		
										</tr>
										<tr id="search_button">
											<td colspan="2" nowrap="nowrap"><input type="submit" value="Search"
												class="load" onClick="return checkForSearchCritera()"> <g:if
													test="${create && params.planCode}">
													<g:checkURIAuthorization uri="/planMaintenance/plan">
														<input type="button" class="load" value="Create Plan - ${params.planCode}" onClick="createNew()">
													</g:checkURIAuthorization>
												</g:if></td>
											<td colspan="2" style="text-align: right">
												<input type="button" class="load" value="Reset"
													onClick="document.forms['searchForm'].reset();setFirstElementFocus()">&nbsp;
												<input	type="button" class="load" value="Clear"
													onClick="clearSearchCriteria()">
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
	<g:if test="${searchTotal > 0}">
		<div id="list-planMaster" class="content scaffold-list" role="main"  style="width:100%; overflow-x: scroll;">
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Number of results for the search criteria - ${searchTotal}<br> <br>
			<table>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>
									<table>
										<thead>
											<tr>
												<g:sortableColumn property="planCode"
													title="${message(code: 'planMaster.planCode.label', default: 'Plan Code')}"
													params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="shortDescription"
													title="${message(code: 'planMaster.shortDescription.label', default: 'Short Description')}"
													params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="productType"
													title="${message(code: 'planMaster.productType.label', default: 'Product Type')}"
													params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />											
											</tr>
										</thead>
										<tbody>
											<g:each in="${searchList}" status="i" var="result">
												<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
													<td style="height: 20px; overflow: hidden;">
														<g:link action="edit"
																	id="${result.planCode}"
																	params="${[planCode:result.planCode]}">
																	${fieldValue(bean: result, field: "planCode")}
														</g:link>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<g:link action="edit"
																	id="${result.shortDescription}"
																	params="${[planCode:result.planCode]}">
																	${fieldValue(bean: result, field: "shortDescription")}
														</g:link>
													</td>	
													<td style="height: 20px; overflow: hidden;">
														<g:link action="edit"
																	id="${result.productType}"
																	params="${[planCode:result.planCode]}">
																	${fieldValue(bean: result, field: "productType")}
														</g:link>
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
			<g:paginate total="${searchTotal}"
				params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />
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

