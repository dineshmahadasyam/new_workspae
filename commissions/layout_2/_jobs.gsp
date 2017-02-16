<%@ page import="com.dell.diamond.service.auth.SecurityService" %>
<%@ page import="com.perotsystems.diamond.bom.AgencyJob" %>
<g:checkURIAuthorization uri="/commissions/jobs"/>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main_2">
	<g:set var="entityName"
		value="${message(code: 'AgencyJob.label', default: 'AgencyJob')}" />
		
	<g:set var="appContext" bean="grailsApplication"/>
	
	<title>Search Jobs</title>
	
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
	
	
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
		
	<%-- JavaScript Includes --%>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
	<script>
		$(function($){
			
			   $("#jobId").alphanum({
				    allowLatin         : false,  // a-z A-Z
					allowSpace         : false,
				});
				
			})
		</script>
	
	<script language="javascript">	
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
	
		function checkForSearchCritera(){
			var elements = document.getElementsByTagName("input");
			var searchCriteria = false;
			
			for (var ii=0; ii < elements.length; ii++) {
			  if (elements[ii].type == "text") {
			    if(elements[ii].value){
				    searchCriteria = true;
				    }
			  }
			  else if (elements[ii].type == "number") {
				    if(elements[ii].value){
					    searchCriteria = true;
					    }
				}
			  else if (elements[ii].type == "radio") {
				    if(elements[ii].checked){
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
	<div class="nav" role="navigation">
		<ul>
			<li style="font: 10pt Tahoma, arial, helvetica, sans-serif;"><g:link class="list" action="searchJobs" params="${[editType :'searchJobs']}">Search Jobs</g:link></li>
			<li style="font: 10pt Tahoma, arial, helvetica, sans-serif;"><g:link class="list" action="batchSearch" params="${[editType :'searchBatch']}">Search Batch</g:link></li>
			<li><a style="font: 10pt Tahoma, arial, helvetica, sans-serif; width:255px;" class="list" href="<g:createLinkTo dir="/rateSchedule/list"/>">Commission - Incentive Rate Schedule</a></li>
		</ul>
	</div>
	<div id="list-planMaster" class="content scaffold-list" role="main" style="width:100%; overflow:scroll;">
		<g:if test="${flash.message}">
			<div class="message" role="status" id="plan_maintance_message_id">
				${flash.message}
			</div>
		</g:if>
		
		<form name="searchForm" action="/${appContext.metadata['app.name']}/commissions/search">
			<input type="hidden" name="searchRef" value="searchForm">
			<table>
				<tr>
					<td>

						<table border="1" >
							<tr>
								<td>
									<table>
										<tr>
												<td class="innerbackground" colspan="7"
													style="color: #FFFFFF; text-align: center"><b>Search Jobs</b></td>
										</tr>
										<tr>
											<td colspan="1" style="width:100px;"><b>Job ID : </b></td>
											<td colspan="1">
												<input type="text" autofocus="autofocus" style="width:200px;" name="jobId" id="jobId" value="${params.jobId}" maxlength="19" > &nbsp;</td>
											<td colspan="1">						
												<input type="radio" name="jobOption" value="B" ${'B'.equals(request.getParameter("jobOption"))? 'checked' :'' }>&nbsp;<b>Batch</b>
											</td>
											<td colspan="1">												
												<input type="radio" name="jobOption" value="A" ${'A'.equals(request.getParameter("jobOption"))? 'checked' :'' }>&nbsp;<b>Agency/Agent</b>												
											</td>		
											<td colspan="1">						
												<input type="radio" name="jobOption" value="G" ${'G'.equals(request.getParameter("jobOption"))? 'checked' :'' }>&nbsp;<b>Group</b>
											</td>
											<td colspan="1"></td>	
											<td colspan="1"></td>														
										</tr>
										<tr>
											<td colspan="1" style="width:100px;"><b> Job Type : </b></td>
											<td colspan="1"><select name="jobType" id="jobType" selected="" style="width:213px;">
													<option value="" ${"".equals(params.jobType)? 'selected' :'' }>--All--</option>
													<option value="I" ${"I".equals(params.jobType)? 'selected' :'' }>I - Incentive</option>
													<option value="C" ${"C".equals(params.jobType)? 'selected' :'' }>C - Commission</option>
													</select>
													
											</td>
											
											
											<td colspan="1"><b> Status : </b></td>
											<td colspan="1"><select name="status" id="status" style="width:213px;">
												<option value="">--All--</option>
												<option value="0" ${"0".equals(request.getParameter("status"))? 'selected' :'' }>New</option>
												<option value="1" ${"1".equals(request.getParameter("status"))? 'selected' :'' }>Running</option>
												<option value="2" ${"2".equals(request.getParameter("status"))? 'selected' :'' }>Calculated</option>
												<option value="3" ${"3".equals(request.getParameter("status"))? 'selected' :'' }>Calculated with Errors</option>
												<option value="4" ${"4".equals(request.getParameter("status"))? 'selected' :'' }>Payment Processed</option>
												<option value="5" ${"5".equals(request.getParameter("status"))? 'selected' :'' }>Payment Processed With Error</option>
												<option value="6" ${"6".equals(request.getParameter("status"))? 'selected' :'' }>Loading Error</option>												
												</select>
											</td>
										</tr>
										<tr id="search_button">
											<td colspan="4" nowrap="nowrap">
												<input type="submit" value="Search" class="load" onClick="return checkForSearchCritera()"> 
												<g:link class="load" style="height:16px;" action="jobsDetail">New</g:link>
											</td>
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
												<g:sortableColumn property="jobId"
													title="${message(code: 'jobId.label', default: 'Job Id')}"
													params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="jobType"
													title="${message(code: 'jobType.label', default: 'Job Type')}"
													params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
												<g:sortableColumn property="jobOption"
													title="${message(code: 'jobOption.label', default: 'Job Sub Type')}"
													params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
												<th>Job Sub ID</th>					
												<g:sortableColumn property="status"
													title="${message(code: 'productType.label', default: 'Status')}"
													params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />	
												<th>Created By User </th>	
												<th>Actions</th>													
											</tr>
										</thead>
										<tbody>
											<g:each in="${searchList}" status="i" var="result">
												<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
													<td style="height: 20px; overflow: hidden;">
														<g:link action="editJobDetail" id="${result.jobId}" params="${[jobId:result.jobId]}">
															${result?.jobId}
														</g:link>
													</td>
																																												
													<td style="height: 20px; overflow: hidden;">
														<g:link action="editJobDetail" id="${result.jobId}" params="${[jobId:result.jobId]}">
															<g:if test="${fieldValue(bean: result, field: "jobType").equals('C') }">Commission</g:if>
															<g:elseif test="${fieldValue(bean: result, field: "jobType").equals('I') }">Incentive</g:elseif>
															<g:else>${fieldValue(bean: result, field: "jobType")}</g:else>
														</g:link>														
													</td>	
													<td style="height: 20px; overflow: hidden;">
														<g:link action="editJobDetail" id="${result.jobId}" params="${[jobId:result.jobId]}">
															<g:if test="${fieldValue(bean: result, field: "jobOption").equals('A') }">Agency/Agent</g:if>
															<g:elseif test="${fieldValue(bean: result, field: "jobOption").equals('B') }">Batch</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "jobOption").equals('G') }">Group</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "jobOption").equals('P') }">Plan</g:elseif>
															<g:else>${fieldValue(bean: result, field: "jobOption")}</g:else>
														</g:link>	
													</td>
													<td style="height: 20px; overflow: hidden;">
														<g:link action="editJobDetail" id="${result.jobId}" params="${[jobId:result.jobId]}">													
															<g:if test="${fieldValue(bean: result, field: "jobOption").equals('A') }">${result?.seqAgencyId}</g:if>
															<g:elseif test="${fieldValue(bean: result, field: "jobOption").equals('B') }">${result?.batchId}</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "jobOption").equals('G') }">${result?.seqGroupId}</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "jobOption").equals('P') }">${result?.planCode}</g:elseif>
															<g:else></g:else>
														</g:link>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<g:link action="editJobDetail" id="${result.jobId}" params="${[jobId:result.jobId]}">														
															<g:if test="${fieldValue(bean: result, field: "status").equals('0') }">New</g:if>
															<g:elseif test="${fieldValue(bean: result, field: "status").equals('1') }">Running</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "status").equals('2') }">Calculated</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "status").equals('3') }">Calculated With Errors</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "status").equals('4') }">Payment Processed</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "status").equals('5') }">Payment Processed With Errors</g:elseif>
															<g:elseif test="${fieldValue(bean: result, field: "status").equals('6') }">Loading Error</g:elseif>
															<g:else>${fieldValue(bean: result, field: "status")}</g:else>
														</g:link>
													</td>
													<td style="height: 20px; overflow: hidden;">
														<g:link action="editJobDetail" id="${result.jobId}" params="${[jobId:result.jobId]}">
														 	${result?.insertAuditInfo?.auditUser}
														</g:link>
													</td>
													<td style="height: 20px; overflow: hidden;">
													<div id="success"></div>
														<g:if test="${fieldValue(bean: result, field: "status").equals('4') || fieldValue(bean: result, field: "status").equals('6') || fieldValue(bean: result, field: "status").equals('0') || fieldValue(bean: result, field: "status").equals('1') }">											
														</g:if>
														<g:else>
															<g:remoteLink class="load" before="if(!confirm('Are you sure?')) return false" action="payJob" params="${[jobId:result.jobId]}" onComplete="alert('Pay initiated successfully'); location.reload();" >Pay</g:remoteLink>
														</g:else>
														<g:if test="${fieldValue(bean: result, field: "status").equals('4') || fieldValue(bean: result, field: "status").equals('6') || fieldValue(bean: result, field: "status").equals('2') }">														
														</g:if>
														<g:else>
															<g:remoteLink class="load" before="if(!confirm('Are you sure?')) return false" action="calculateJob" params="${[jobId:result.jobId]}" onComplete="alert('Calculation initiated successfully'); location.reload();" >Calculate</g:remoteLink>
														</g:else>
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
				params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
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

