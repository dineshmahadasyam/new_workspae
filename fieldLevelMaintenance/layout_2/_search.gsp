<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
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
	filter: progid:DXImageTransform.Microsoft.gradient(           startColorstr='#0066cc',
		endColorstr='#7db9e8', GradientType=0); /* IE6-8 */
	border-radius: 15px;
}
</style>
<script>
function createSecColMaster() {
	var createSecColMasterCoded = "${params.sfldlId}";
	window.location.assign('<g:createLinkTo dir="/fieldLevelMaintenance/create?sfldlId="/>'
		+ createSecColMasterCoded );
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
		alert ("Please enter search criteria to find Field Level Security Id.");
	  }
	  
	  return searchCriteria;
	
}

function clearSearchCriteria() {
	var elements = document.getElementsByTagName("input");
	var firstText = true;
	for (var ii=0; ii < elements.length; ii++) {
	  if (elements[ii].type == "text") {			
	    elements[ii].value = "";
	    if (firstText) {
	    	 elements[ii].focus();
		    firstText = false;
		 }
	  }
	}
}
</script>
<script type="text/javascript">
	$(function($){
		   
		   $("#sfldlId").alphanum({
				allow 		: '-_',
				allowSpace  : false
			});	
	})	  
</script>

<meta name="layout" content="main_2">
</head>
<body>
	<div id="list-secColMaster" class="content scaffold-list" role="main"
		style="width: 100%; overflow: scroll;">
		<g:if test="${flash.message}">
			<div class="message" role="status" style="display:${flash.message?'show':'hidden'};" >
				${flash.message}
			</div>
		</g:if>
		<form name="searchForm" action='<g:createLinkTo dir="/fieldLevelMaintenance/search"/>'>
			<input type="hidden" name="searchRef" value="searchForm">
			<table>
				<tr>
					<td>
						<table border="1">
							<tr>
								<td>
									<table>
										<tr>
											<td class="innerbackground" colspan="4"
												style="color: #FFFFFF; text-align: center"><b>Field Level Security
											</b></td>
										</tr>
										<tr>
											<td><b>Field Level Security Id: </b>
											<input autofocus="autofocus" type="text"
													name="sfldlId" id="sfldlId"
													value="${params.sfldlId}" maxlength="9"
													title="Field Level Security ID"></td>
											<td>
												 &nbsp;
											</td>

											<td><b>Description: </b>
											<input type="text"
													name="description" id="description"
													value="${params.description}" maxlength="50"></td>
											<td>
												 &nbsp;
											</td>
										</tr>

										<tr id="search_button">
											<td colspan="2"><input type="submit" value="Search"
												class="load" onClick="return checkForSearchCritera()"> <g:if
													test="${params.sfldlId}">
													<div id="createsecColMasterDiv" style="visibility:${iscreateSecColMasterFlag? 'show':'hidden'};display:inline" >
														<g:checkURIAuthorization uri="/secColMaster/create">
														<g:if test="${iscreateSecColMasterFlag == true}">
															<input type="button" class="load"
																value="Create a Field Level Security - ${params.sfldlId}"
																onClick="createSecColMaster()" />	
														</g:if>														
														</g:checkURIAuthorization>
													</div>
												</g:if></td>
											<td colspan="2" style="text-align: right">
												<div style="align: right">
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
		</form>
		<g:if test="${ secColMasterCount >0}">
			<div id="list-memberMaster" class="content scaffold-list" role="main"
				style="width: 100%; overflow-x: scroll; display:inline">
				&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Number of Field Level Securities -
				${secColMasterCount}
				<table>
					<tr>
						<td>
							<table border="1">
								<tr>
									<td>
										<table>
											<thead>
												<tr>
													<g:sortableColumn property="sfldlId" style="padding-left:20px;"
														title="${message(code: 'secColMaster.secColMaster.label', default: 'Field Level Security Id')}"
														params="${[sfldlId:params.sfldlId,description:params.description, offset:request.getParameter('offset')]}" />

													<g:sortableColumn property="description"
														title="${message(code: 'secColMaster.description.label', default: 'Description')}"
														params="${[sfldlId:params.sfldlId,description:params.description, offset:request.getParameter('offset')]}"/>
												</tr>
											</thead>
											<tbody>
												<g:each in="${secColMasterCollection}" status="i"
													var="secColMasterInstance">
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

														<td style="height: 20px; overflow: hidden;">
															<div title="${secColMasterInstance.sfldlId}">
																	<g:link action="show"																		
																		params="${[editType:'MASTER', sfldlId: secColMasterInstance.sfldlId]}">
																		${fieldValue(bean: secColMasterInstance, field: "sfldlId")}
																	</g:link>
															</div>
														</td>
														<td style="height: 20px; overflow: hidden;">
															<div title="${secColMasterInstance.description}">
																	<g:link action="show"
																		params="${[editType:'MASTER', sfldlId: secColMasterInstance.sfldlId]}">
																		${fieldValue(bean: secColMasterInstance, field: "description")}
																	</g:link>
															</div>
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
				<g:paginate total="${secColMasterCount}"
					params="${[sfldlId:params.sfldlId, description :params.description , offset:request.getParameter('offset')]}" />
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