<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>
	<script type="text/javascript">
		$(document).ready(function(){
			
		
		jQuery.validator.addMethod("greaterThan", 
		function(value, element, params) {
		
			var startDate= new  Date($("#effDate_year").val(),$("#effDate_month").val(), $("#effDate_day").val());
				var endDate = new Date($("#termDate_year").val(),$("#termDate_month").val(), $("#termDate_day").val()) ;
				return this.optional(element) ||( $("#effDate_year").val().length > 0 && $("#effDate_month").val().length > 0 
						&& $("#effDate_day").val().length > 0 && startDate < endDate ) ;
				
							},'Term Date Must be greater than Effective Date.');
		
		
		$("#termDate_year").rules('add', { greaterThan: "#termDate_year" });
		
		
		});
	
	</script>

	<input type="hidden" name="editType" value="MASTER"/>
	User Records for User Id (${user.userId})
	<br/>



	<g:if test="${params.action == "create"}">
	
	
	<input type="hidden" id="editSecId" name="editSecId" value="0"/>
	<input type="hidden" id="disableDisp" name="disableDisp" value="N"/>
	<input type="hidden" id="qSupervisorPriv" name="qSupervisorPriv" value="N"/>
	<input type="hidden" id="bypassMbrNav" name="bypassMbrNav" value="Y"/>
	<input type="hidden" id="overrideClmLock" name="overrideClmLock" value="N"/>
	
	</g:if>

<table>
	<tr>
		<td style="white-space: nowrap" >
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userId', 'error')} required ">
				<label for="userId"> <g:message
						code="user.userId.label" default="User Id:" />
				</label>
				
				<input type="hidden" name="userId" value="${user.userId}"/>
					${user.userId}
			</div>
		</td>
		<td>
			<div
				class="fieldcontain" id="password-div">
				<label for="password"> <g:message
						code="password.label" default="Password:  " />
					<span class="required-indicator">*</span>
				</label>				
				<g:passwordField name="password"  maxlength="15" />
			</div>
		</td>
		<td>
			<div
				class="fieldcontain" id="confirmPassword-div">
				<label for="confirmPassword"> <g:message
						code="confirmPassword.label" default="Confirm Password:" />
					<span class="required-indicator">*</span>
				</label>
				
				<g:passwordField name="confirmPassword" maxlength="15" />
			</div>
		</td>
	</tr>
	
	<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'resetPwdInd', 'error')} required">
				<label for="resetPwdInd"> <g:message 
						code="user.resetPwdInd.label" default="Reset Password Indicator :" />
					<span class="required-indicator">*</span>
				</label>
				<select name="resetPwdInd" style="width:150px">
					<option value="">-- Select a Reset Ind --</option>
					<option value="Y"
						${(user && user?.resetPwdInd?.equals('Y')) ? 'selected':'' }>Yes</option>
					<option value="N"
						${(user && user?.resetPwdInd?.equals('N')) ? 'selected':'' }>No</option>
				</select>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'templateFlg', 'error')}">
				<label for="templateFlg"> <g:message 
						code="user.templateFlg.label" default="Template :" />
				</label>
				<select name="templateFlg" id="templateFlg" style="width:150px" 
				title="If this user id will be used as a Template, select “Y”, if not, select “N”" >
					<option value="N"
						${(user && user?.templateFlg?.equals('N')) ? 'selected':'' }>No</option>
					<option value="Y"
						${(user && user?.templateFlg?.equals('Y')) ? 'selected':'' }>Yes</option>
				</select>
			</div>
		</td>
	</tr>
	<tr>
		<td class="tdnoWrap" style="white-space: nowrap">
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'dfltTemplate', 'error')}">
				<label for="dfltTemplate"> <g:message 
						code="user.dfltTemplate.label" default="Template ID:" />
				</label>
					
				<g:select name="dfltTemplate" optionKey="userId" optionValue="userId" value="${user?.dfltTemplate}"
									        from="${securityTemplateList}" noSelection="${['':'Select a template']}"
									         ></g:select>
									        
									        
			</div>
		</td>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'lname', 'error')} required " >
				<label for="lname"> <g:message
						code="user.lname.label" default="Last Name:" /><span class="required-indicator">*</span>
				</label>
				<g:textField name="lname"  value="${user.lname}"  maxlength="22"/>
			</div>
		</td>
	
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'fname', 'error')}  ">
				<label for="fname"> <g:message
						code="user.fname.label"
						default="First Name: " />

				</label>
				<g:textField name="fname" value="${user?.fname}" maxlength="22"/>
			</div>
		</td>
	</tr>	
	<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'mi', 'error')} ">
				<label for="mi"> <g:message
						code="user.mi.label" default="Mi: " />

				</label>
				<g:textField name="mi" value="${user?.mi}" maxlength="1" />
			</div>
		</td>
		
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'tel', 'error')} ">
				<label for="tel"> <g:message
						code="user.tel.label" default="Telephone: " />

				</label>
				<g:textField name="tel" value="${user?.tel}" maxlength="20"  />
			</div>
		</td>
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'ext', 'error')} ">
				<label for="ext"> <g:message
						code="user.dob.label" default="Extn: " />
				</label>
				<g:textField name="ext" value="${user?.ext}"  maxlength="4"/>
							
			</div>
		</td>		
	</tr>	
		<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'curUsrDept', 'error')} ">
				<label for="curUsrDept"> <g:message
						code="user.curUsrDept.label" default="Department: "   />

				</label>
				<g:textField name="curUsrDept" value="${user?.curUsrDept}" maxlength="10"/>
				<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('curUsrDept', 'com.perotsystems.diamond.dao.cdo.GroupDepartment','deptNumber')" />
															
			</div>
		</td>
		
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'usrLocation', 'error')} ">
				<label for="usrLocation"> <g:message
						code="user.usrLocation.label" default="Location: " />

				</label>
				<g:textField name="usrLocation" value="${user?.usrLocation}"  maxlength="10"/>
				<img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('usrLocation', 'com.perotsystems.diamond.dao.cdo.SystemCodes','systemCode','systemCodeTypeHidden','systemCodeType')" />
					
					 <input type="hidden" id="systemCodeTypeHidden" value="MELIGLOC" />
			</div>
		</td>
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userStatus', 'error')} ">
				<label for="userStatus"> <g:message
						code="user.userStatus.label" default="User Status: " />
				</label>
				<g:textField name="userStatus" value="${user?.userStatus}" maxlength="1"  readonly="readonly"/>
							
			</div>
		</td>		
	</tr>
	<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userDefined1', 'error')} ">
				<label for="userDefined1"> 						
						<g:userDefinedFieldLabel winId="SUSER" datawindowId ="dw_suser_de" userDefineTextName="user_defined_1_t"  defaultText="User Defined 1" />

				</label>								
								<g:textField name="userDefined1" value="${user?.userDefined1}" maxlength="30" />					
						
			</div>
		</td>		
			<td >
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userDate1', 'error')} ">
				<label for="userDate1"> 
				<g:userDefinedFieldLabel winId="SUSER" datawindowId ="dw_suser_de" userDefineTextName="user_date_1_t"  defaultText="User Date 1" />
				</label>				
				<g:datePicker name="userDate1" precision="day"
					value="${user?.userDate1}" noSelection="['':'']"
					 default="none" />					
			</div>			
		</td>
		
		</tr>		
			<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userDefined2', 'error')} ">
				<label for="userDefined2">			
				<g:userDefinedFieldLabel winId="SUSER" datawindowId ="dw_suser_de" userDefineTextName="user_defined_2_t" defaultText="User Defined 2"   />

				</label>								
								<g:textField name="userDefined2" value="${user?.userDefined2}" maxlength="30"/>					
						
			</div>
		</td>		
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userDate2', 'error')} ">
				<label for="userDate2"> 
				<g:userDefinedFieldLabel winId="SUSER" datawindowId ="dw_suser_de" userDefineTextName="user_date_2_t"   defaultText="User Date 2"   />

				</label>					
				
			<g:datePicker name="userDate2" precision="day"
					value="${user?.userDate2}" noSelection="['':'']"
					 default="none" />
					
			</div>			
		</td>
				<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userDefined3', 'error')} ">
				<label for="userDefined3"><g:userDefinedFieldLabel winId="SUSER" datawindowId ="dw_suser_de" userDefineTextName="user_defined_3_t" defaultText="User Defined 3"   />
				</label>								
					<g:textField name="userDefined3" value="${user?.userDefined3}" maxlength="30"/>					
						
			</div>
		</td>
		
		</tr>
		
		<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'effDate', 'error')} ">
				<label for="effDate"> <g:message
						code="user.effDate.label" default="Effective Date: " />

				</label>
								
				<g:datePicker name="effDate" precision="day"
					value="${user?.effDate}" noSelection="['':'']"
					 default="none" />			
					
					
			</div>
		</td>		
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'termDate', 'error')} ">
				<label for="termDate"> <g:message
						code="user.termDate.label" default="Term Date: " />

				</label>					
				
			<g:datePicker name="termDate" precision="day"
					value="${user?.termDate}" noSelection="['':'']"
					 default="none" />
					
			</div>
		</td>
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'termReason', 'error')} ">
				<label for="termReason"> <g:message
						code="user.termReason.label" default="Term Reason: " />
				</label>
							        <input type="hidden" id="reasonCodeTypeHidden" value="UT" />
									        <g:textField name="termReason" value="${user?.termReason}"  maxlength="5" />
									        <img width="25" height="25" style="float:none;vertical-align:bottom" class="magnifying"
															src="${resource(dir: 'images', file: 'Search-icon.png')}"
															onclick="lookup('termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode','reasonCodeTypeHidden','reasonCodeType')" />
															
															
									         
							
			</div>
		</td>		
	</tr>	
	
		<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">
			<h4>Rules Information</h4><hr>
		</td>
	</tr>
	
		<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userCategory', 'error')} ">
				<label for="userCategory"> <g:message
						code="user.userCategory.label" default="User Category:" />
				</label>
							
				<Select name="userCategory" style="width:150px"> 									
				<option value="DB" ${'DB'.equals(user.userCategory) ?'selected':""}>Database</option>
				<option value="ED" ${'ED'.equals(user.userCategory) ?'selected':""}>Enterprise Directory</option>				
				</Select>			
								
				
			</div>
		</td>		
			<td >
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'directoryName', 'error')} ">
				<label for="directoryName"> <g:message
						code="user.directoryName.label" default="Directory Name: " />

				</label>					
				
				<g:textField name="directoryName" value="${user?.directoryName}"  readonly="readonly" />
						
			</div>
		</td>
	</tr>	
		<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'suPriv', 'error')} ">
				<label for="suPriv"> <g:message
						code="user.suPriv.label" default="Super User:" />
				</label>
								
		
				<g:select name="suPriv" value="${user?.suPriv}"
									        from="${['N','Y']}" ></g:select>

									        
			</div>
		</td>		
			<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userType', 'error')} ">
				<label for="userType"> <g:message
						code="user.userType.label" default="User Type:" />
				</label>					
				<Select name="userType" style="width:150px"> 									
				<option value="G" ${'G'.equals(user.userType) ?'selected':""}>Group</option>
				<option value="M" ${'M'.equals(user.userType) ?'selected':""}>Member</option>
				<option value="O" ${'O'.equals(user.userType) ?'selected':""}>Operator</option>
				<option value="P" ${'P'.equals(user.userType) ?'selected':""}>Provider</option>
				</Select>					
			</div>
		</td>
		
					<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'languageId', 'error')} ">
				<label for="languageId"> <g:message
						code="user.languageId.label" default="Language:" />
				</label>
				<g:select name="languageId" optionKey="languageId" optionValue="languageCode" value="${user?.languageId}"
						from="${languageList}"  ></g:select>     							         	
							
			</div>
		</td>
		
	</tr>	
	
		<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">
			<h4>Security Information</h4><hr>
		</td>
	</tr>
		<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'usePwdProfInd', 'error')} ">
				<label for="usePwdProfInd"> <g:message
						code="user.usePwdProfInd.label" default="Use Password Profile:" />
				</label>
								
								<g:select name="usePwdProfInd" value="${user?.usePwdProfInd}"
									        from="${['N','Y']}" ></g:select>
									        
<%--				<g:checkBox name="usePwdProfInd" value="${user?.usePwdProfInd}" checked="${'Y'.equals(user.usePwdProfInd) ? true:false}" />--%>
<%--				<input type="checkbox" name="address.${i}.isInactive" ${ address.isPrimaryAddress ? 'checked' : ''}>		--%>
				
			</div>
		</td>		
		<td>
			<div
				class="fieldcontain ">
				<label for="accountStatus"> <g:message
						code="user.accountStatus.label" default="Account Status:" />
				</label>
								
				<g:textField name="accountStatus" value="${accountStatus}"  readonly="readonly" />
			</div>
		</td>	
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'restrictionIndicator', 'error')} ">
				<label for="restrictionIndicator"> <g:message
						code="user.restrictionIndicator.label" default="Restriction Indicator :" />
				</label>
							
				<g:select name="restrictionIndicator" value="${user?.restrictionIndicator}"
									        from="${['N','Y']}" ></g:select>
									        
<%--				<input type="checkbox" name="restrictionIndicator" ${user.restrictionIndicator =='Y' ? 'checked' : ''} />--%>
				
				
			</div>
		</td>	
		</tr>	
		<tr>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean:user, field: 'noteSecurityLevel', 'error')} ">
					<label for="noteSecurityLevel"> <g:message
							code="user.noteSecurityLevel.label" default="Note Type Security:" />
					</label>
									
					<g:textField name="noteSecurityLevel" value="${user?.noteSecurityLevel}"  maxlength="1"  />
				</div>
			</td>	
			<td>
				<div
					class="fieldcontain ${hasErrors(bean:user, field: 'usrSecurityLevel', 'error')} ">
					<label for="usrSecurityLevel"> <g:message
							code="user.usrSecurityLevel.label" default="Row Level Security:" />
					</label>
					<g:textField name="usrSecurityLevel" value="${user?.usrSecurityLevel}" maxlength="1"   />
				</div>
			</td>
			<td>
				<div
					class="fieldcontain ${hasErrors(bean:user, field: 'sfldlId', 'error')} ">
					<label for="sfldlId"> <g:message
							code="user.sfldlId.label" default="Field Level Security ID:" />
					</label>
									
					<g:textField name="sfldlId" id="sfldlId" value="${user?.sfldlId}" maxlength="25" 
					title="Field Level Security ID"  />
					<img width="25" height="25" name="sfldlIdLookup" id="sfldlIdLookup"
						style="float: none; vertical-align: bottom"
						class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
						onclick="lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')">
				</div>
			</td>		
		</tr>
</table>