<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>

<script type="text/javascript">
	function addFunction() {		
		window.location.assign('<g:createLinkTo dir="/userMaintenance/search"/>?userId=${user?.userId}&addFunction=${true}');
	}

	function copyFunction() {		
		window.location.assign('<g:createLinkTo dir="/userMaintenance/search"/>?userId=${user?.userId}&copyFunction=${true}');
	}
	
</script>

			<table>
				<tr>
					<td style="white-space: nowrap">
						<div
							class="fieldcontain ${hasErrors(bean:user, field: 'userId', 'error')} ">
							<label for="userId"> <g:message
									code="user.userId.label" default="User Id:" />
							</label>				
							<g:textField name="userId" value="${user?.userId}" disabled="true"/>
						</div>
					</td>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean:user, field: 'name', 'error')} " >
							<label for="fullName"> <g:message
									code="user.name.label" default="Name:" />
							</label>
						 <g:textField name="fullName"  value="${user?.fname?: ''} ${user?.lname?: ''}" disabled="true"/>
						</div>
					</td>
					<td>	
						<div
							class="fieldcontain ${hasErrors(bean:user, field: 'userType', 'error')} ">
							<label for="userType"> <g:message
									code="user.userType.label" default="User Type:" />
							</label>		
							<g:if test="${'G'.equals(user?.userType)}">			
								<g:textField name="userType" value="Group" disabled="true"/>
							</g:if>	
							<g:if test="${'M'.equals(user?.userType)}">			
								<g:textField name="userType" value="Member" disabled="true"/>
							</g:if>	
							<g:if test="${'O'.equals(user?.userType)}">			
								<g:textField name="userType" value="Operator" disabled="true"/>
							</g:if>	
							<g:if test="${'P'.equals(user?.userType)}">			
								<g:textField name="userType" value="Provider" disabled="true"/>
							</g:if>				
						</div>
					</td>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean:user, field: 'suPriv', 'error')} ">
							<label for="suPriv"> <g:message
									code="user.suPriv.label" default="Super User:" />
							</label>		
								<g:textField name="suPriv" value="${user?.suPriv}" disabled="true"/>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean:user, field: 'curUsrDept', 'error')} ">
							<label for="curUsrDept"> <g:message
									code="user.curUsrDept.label" default="Department:"   />
							</label>
							<g:textField name="curUsrDept" value="${user?.curUsrDept}" disabled="true"/>
						</div>
					</td>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean:user, field: 'usrLocation', 'error')} ">
							<label for="usrLocation"> <g:message
									code="user.usrLocation.label" default="Location:" />
							</label>
							<g:textField name="usrLocation" value="${user?.usrLocation}" disabled="true"/>
						</div>
					</td>
					<td>
						<div
							class="fieldcontain ${hasErrors(bean:user, field: 'templateFlg', 'error')}">
							<label for="templateFlg"> <g:message 
									code="user.templateFlg.label" default="Template :" />
							</label>
							<g:if test="${'Y'.equals(user?.templateFlg)}">			
								<g:textField name="suPriv" value="Yes" disabled="true"/>
							</g:if>
							<g:if test="${'N'.equals(user?.templateFlg)}">			
								<g:textField name="suPriv" value="No" disabled="true"/>
							</g:if>
						</div>
					</td>
					<td>
							<div
								class="fieldcontain ${hasErrors(bean:user, field: 'sfldlId', 'error')} ">
								<label for="sfldlId"> <g:message
										code="user.sfldlId.label" default="Field Level Security ID:" />
								</label>		
								<g:textField name="sfldlID" id="sfldlID" value="${user?.sfldlId}" disabled="true"/>
							</div>
						</td>		
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<div>
							<g:checkURIAuthorization uri="/userMaintenance/search">
								<input type="button" name="addFunctionAccessButton" class="load" value="Add Function"  onClick="addFunction()">
							</g:checkURIAuthorization>
							&nbsp;
							<g:checkURIAuthorization uri="/userMaintenance/copyFunctionAccess">
								<input type="button" name="copyFunctionAccessButton" class="load" value="Copy Function"  onClick="copyFunction()">
							</g:checkURIAuthorization>
						</div>
					</td>
				</tr>
				<tr><td colspan="8"><hr/></td></tr>
			</table>
			
			<g:if test="${userFunctionTotal > 0}">
				<table style="width: 100%; overflow-x: scroll; font-size: 13px;">
					<tr style="width: 100%;">
						<td width="100%" align="right">Number of Functions - ${userFunctionTotal}
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
													<th><div style="overflow: hidden;">Function</div></th>
													<th><div style="overflow: hidden;">Access</div></th>
												</tr>
											</thead>
											<g:each in="${userFunctionList}" status="i" var="userFunction">
												<tbody>
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;">
																${fieldValue(bean: userFunction, field: "funcId")}
															</div>
														</td>
														<td style="padding-left: 5px">
															<div style="height: 20px; overflow: hidden;"
															title="If checked then this function privilege shall be recognized for the template ID. If unchecked, this function privilege shall be ignored for this user ID.">
																<g:checkBox name="${userFunctionList.funcId[i]}.checkBox" 
																value="${fieldValue(bean: userFunction, field: "pExe").equals('Y')}"/>
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
			
			<input type="hidden" name="editType" value="FUNCTIONACCESS"/>
			<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'insertAuditInfo' }">
			<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'desc' }">
			<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">
			<input type="hidden" name="userID" value="${user?.userId}"/>
			
			
			<g:if test="${userFunctionTotal > 10}">
				<div class="pagination">
						<g:paginate total="${userFunctionTotal}" params="${[id:user?.userId, editType:'FUNCTIONACCESS',offset:request.getParameter('offset')]}" />
				</div>
			</g:if>
			