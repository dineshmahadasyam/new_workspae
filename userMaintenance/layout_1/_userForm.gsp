<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>
		
<input type="hidden" name="editType" value="MASTER"/>
<br/>

<g:if test="${params.action == "create"}">
	<input type="hidden" id="editSecId" name="editSecId" value="0"/>
	<input type="hidden" id="disableDisp" name="disableDisp" value="N"/>
	<input type="hidden" id="qSupervisorPriv" name="qSupervisorPriv" value="N"/>
	<input type="hidden" id="bypassMbrNav" name="bypassMbrNav" value="Y"/>
	<input type="hidden" id="overrideClmLock" name="overrideClmLock" value="N"/>
</g:if>

<!-- START - FMS Content Body -->
<div id="fms_content_body">

	<div class="right-corner" align="right">SUSER</div>
				
	<div class="fms_required_legend fms_required">= required</div>
	
	<div id="AddNewDataSection" class="fms_form_border" style="display: block;">
        
    	<div class="fms_form_body">
    	
    		<%-- Error messages start--%>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:if test="${fieldErrors}">
				<ul class="errors" role="alert">
					<g:each in="${fieldErrors}" var="error">
						<li>${error}</li>
					</g:each>
				</ul>
			</g:if>
			<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
			<%-- Error messages end--%>
    		
    		<g:if test="${editType.equals("edit")}">
    			<h3>Edit User</h3>
    		</g:if>
    		<g:else>
    			<h3>Create User</h3>
			</g:else>
    		<br>

			<!-- START Widget: Edit User -->
    		<div class="fms_widget">        
               	<fieldset class="no_border">
                  	<legend><h3>General Information</h3></legend>
	
					<div class="fms_form_layout_2column">                  
						<div class="fms_form_column fms_long_labels">
						
							<label class="control-label" id="userId_label" for="userId" >
								<g:message code="user.userId.label" default="User Id:" />
							</label>
							<div class="fms_form_input">
								<input type="hidden" name="userId" value="${user.userId}"/>
								<p id="userId" aria-labelledby="userId_label" class="form-control-static">${user.userId}</p>      
								<div class="fms_form_error" id="userId_error"></div>	    
							</div>
					
							<g:if test="${editType.equals("create")}">
								<label class="control-label fms_required" id="password-div" for="password" >
									<g:message code="password.label" default="Password:  " />
								</label>
								<div class="fms_form_input">
									<g:passwordField class="form-control" name="password"  maxlength="15" />
									<div class="fms_form_error" id="password_error"></div>	                  
								</div>			
											
								<label class="control-label fms_required" id="confirmPassword-div" for="confirmPassword" >
									<g:message code="confirmPassword.label" default="Confirm Password:" />
								</label>
								<div class="fms_form_input">
									<g:passwordField class="form-control" name="confirmPassword" maxlength="15" />
									<div class="fms_form_error" id="confirmPassword_error"></div>	                  
								</div>
							</g:if>	
							
							<label class="control-label fms_required" id="resetPwdInd_label" for="resetPwdInd" >
								<g:message code="user.resetPwdInd.label" default="Reset Password Indicator:" />
							</label>
							<div class="fms_form_input">
								<select class="form-control" 
									name="resetPwdInd"
									aria-labelledby="resetPwdInd_label" 
									aria-describedby="resetPwdInd_error" 
									aria-required="false">
									<option value="">-- Select a Reset Ind --</option>
									<option value="Y"
										${(user && user?.resetPwdInd?.equals('Y')) ? 'selected':'' }>Yes</option>
									<option value="N"
										${(user && user?.resetPwdInd?.equals('N')) ? 'selected':'' }>No</option>
								</select>
								<div class="fms_form_error" id="resetPwdInd_error"></div>	
							</div>
															
							<label class="control-label" id="templateFlg_label" for="templateFlg" >
								<g:message code="user.templateFlg.label" default="Template:" />
							</label>
							<div class="fms_form_input">
								<select name="templateFlg" id="templateFlg" class="form-control"
									title="If this user id will be used as a Template, select “Y”, if not, select “N”" 
									aria-labelledby="templateFlg_label" 
									aria-describedby="templateFlg_error" 
									aria-required="false">
									<option value="N"
										${(user && user?.templateFlg?.equals('N')) ? 'selected':'' }>No</option>
									<option value="Y"
										${(user && user?.templateFlg?.equals('Y')) ? 'selected':'' }>Yes</option>
								</select>
								<div class="fms_form_error" id="templateFlg_error"></div>	                  
							</div>				
											
							<label class="control-label" id="dfltTemplate_label" for="dfltTemplate" >
								<g:message code="user.dfltTemplate.label" default="Template ID:" />
							</label>
							<div class="fms_form_input">
								<g:select 
									class="form-control"
									name="dfltTemplate" 
									optionKey="userId" 
									optionValue="userId" 
									value="${user?.dfltTemplate}"
									from="${securityTemplateList}" 
									noSelection="${['':'Select a template']}"
									aria-labelledby="dfltTemplate_label" 
									aria-describedby="dfltTemplate_error" 
									aria-required="false">
								</g:select>
								<div class="fms_form_error" id="dfltTemplate_error"></div>	                  
							</div>	
								
							<label class="control-label fms_required" id="lname_label" for="lname">
								<g:message code="user.lname.label" default="Last Name:" />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="lname"  
									value="${user.lname}"  
									maxlength="22"
									class="form-control"
									aria-labelledby="dfltTemplate_label" 
									aria-describedby="dfltTemplate_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="lname_error"></div>	                  
							</div>    
														
							<label class="control-label" id="fname_label" for="fname">
								<g:message code="user.fname.label" default="First Name: " />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="fname"  
									value="${user.fname}"  
									maxlength="22"
									class="form-control"
									aria-labelledby="fname_label" 
									aria-describedby="fname_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="fname_error"></div>	                  
							</div>
							
							<label class="control-label" id="mi_label" for="mi">
								<g:message code="user.mi.label" default="Mi: " />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="mi"  
									value="${user.mi}"  
									maxlength="1"
									class="form-control"
									aria-labelledby="mi_label" 
									aria-describedby="mi_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="mi_error"></div>	                  
							</div>
							
							<label class="control-label" id="tel_label" for="tel">
								<g:message code="user.tel.label" default="Telephone: " />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="tel"  
									value="${user.tel}"  
									maxlength="22"
									class="form-control fms_phone_mask"
									aria-labelledby="tel_label" 
									aria-describedby="tel_error" 
									aria-required="false"
									placeholder="(000) 000-0000"/>						
								<div class="fms_form_error" id="tel_error"></div>	                  
							</div>
										
							<label class="control-label" id="ext_label" for="ext">
								<g:message code="user.dob.label" default="Extn: " />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="ext"  
									value="${user.ext}"  
									maxlength="4"
									class="form-control"
									aria-labelledby="ext_label" 
									aria-describedby="ext_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="ext_error"></div>	                  
							</div>
							
							<label class="control-label" id="curUsrDept_label" for="curUsrDept">
								<g:message code="user.curUsrDept.label" default="Department: "   />
							</label>
							<div class="fms_form_input fms_has_feedback">
                               	<g:textField 
                               		class="form-control"
                               		name="curUsrDept" 
                               		value="${user?.curUsrDept}"
									maxlength="10" />
								<fmsui:cdoLookup 
									lookupElementId="curUsrDept"
									lookupElementName="curUsrDept" 
									lookupElementValue="${user?.curUsrDept}"
									lookupCDOClassName="com.perotsystems.diamond.dao.cdo.GroupDepartment"
									lookupCDOClassAttribute="deptNumber" />		
								<div class="fms_form_error" id="curUsrDept_error"></div>	
							</div>
						</div>
							
						<div class="fms_form_column fms_long_labels">
							<label class="control-label" id="usrLocation_label" for="usrLocation">
								<g:message code="user.usrLocation.label" default="Location: " />
							</label>
							<div class="fms_form_input fms_has_feedback">
                               	<g:textField 
                               		class="form-control"
                               		name="usrLocation" 
                               		value="${user?.usrLocation}"
									maxlength="10" />
								<fmsui:cdoLookup 
									lookupElementId="usrLocation"
									lookupElementName="usrLocation" 
									lookupElementValue="${user?.usrLocation}"
									lookupCDOClassName="com.perotsystems.diamond.dao.cdo.SystemCodes"
									lookupCDOClassAttribute="systemCode"
									htmlElementsToAddToQuery="systemCodeTypeHidden"
									htmlElementsToAddToQueryCDOProperty="systemCodeType" />		
								<div class="fms_form_error" id="usrLocation_error"></div>	
							</div>
										
							<label class="control-label" id="userStatus_label" for="userStatus">
								<g:message code="user.userStatus.label" default="User Status: " />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="userStatus"  
									value="${user.userStatus}"  
									maxlength="1"
									readonly="readonly" 
									class="form-control"
									aria-labelledby="userStatus_label" 
									aria-describedby="userStatus_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="userStatus_error"></div>	                  
							</div>	
								
							<label class="control-label" id="userDefined1_label" for="userDefined1">
								<g:userDefinedFieldLabel 
									winId="SUSER" 
									datawindowId ="dw_suser_de" 
									userDefineTextName="user_defined_1_t" 
									defaultText="User Defined 1" />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="userDefined1"  
									value="${user.userDefined1}"  
									maxlength="30"
									class="form-control"
									aria-labelledby="userDefined1_label" 
									aria-describedby="userDefined1_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="userDefined1_error"></div>	                  
							</div>
							
							<label class="control-label" id="userDate1_label" for="userDate1">
								<g:userDefinedFieldLabel 
									winId="SUSER" 
									datawindowId ="dw_suser_de" 
									userDefineTextName="user_date_1_t"  
									defaultText="User Date 1" />
							</label>
							
							<div class="fms_form_input">	
								<fmsui:jqDatePickerUIUX  
									datePickerOptions="changeMonth: true, changeYear: true, maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (user?.userDate1 != null ? user?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100', numberOfMonths: 1" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: user?.userDate1)}"
									dateElementId="userDate1" 
									dateElementName="userDate1" 
									ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}" />
								<div class="fms_form_error" id="userDate1_error"></div>	                  
							</div>
							
							<label class="control-label" id="userDefined2_label" for="userDefined2">
								<g:userDefinedFieldLabel 
									winId="SUSER" 
									datawindowId ="dw_suser_de" 
									userDefineTextName="user_defined_2_t" 
									defaultText="User Defined 2"   />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="userDefined2"  
									value="${user.userDefined2}"  
									maxlength="30"
									class="form-control"
									aria-labelledby="userDefined2_label" 
									aria-describedby="userDefined2_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="userDefined2_error"></div>	                  
							</div>
							
							<label class="control-label" id="userDate2_label" for="userDate2">
								<g:userDefinedFieldLabel 
									winId="SUSER" 
									datawindowId ="dw_suser_de" 
									userDefineTextName="user_date_2_t" 
									defaultText="User Date 2"   />
							</label>
							<div class="fms_form_input">
								<fmsui:jqDatePickerUIUX  
									datePickerOptions="changeMonth: true, changeYear: true, maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (user?.userDate2 != null ? user?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100', numberOfMonths: 1" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: user?.userDate2)}"
									dateElementId="userDate2" 
									dateElementName="userDate2" 
									ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}" />
								<div class="fms_form_error" id="userDate2_error"></div>	                  
							</div>
							
							<label class="control-label" id="userDefined3_label" for="userDefined3">
								<g:userDefinedFieldLabel 
									winId="SUSER" 
									datawindowId ="dw_suser_de" 
									userDefineTextName="user_defined_3_t" 
									defaultText="User Defined 3"   />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="userDefined3"  
									value="${user.userDefined3}"  
									maxlength="30"
									class="form-control"
									aria-labelledby="userDefined3_label" 
									aria-describedby="userDefined3_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="userDefined3_error"></div>	                  
							</div>
							
							<label class="control-label" id="effDate_label" for="effDate">
								<g:message code="user.effDate.label" default="Effective Date: " />
							</label>
							<div class="fms_form_input">
								<fmsui:jqDatePickerUIUX  
									datePickerOptions="changeMonth: true, changeYear: true, maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (user?.effDate != null ? user?.effDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100', numberOfMonths: 1" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: user?.effDate)}"
									dateElementId="effDate" 
									dateElementName="effDate" 
									ariaAttributes="aria-labelledby='effDate_label' aria-describedby='effDate_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}" />
								<div class="fms_form_error" id="effDate_error"></div>
							</div>
							
							<label class="control-label" id="termDate_label" for="termDate">
								<g:message code="user.termDate.label" default="Term Date: " />
							</label>
							<div class="fms_form_input">	
								<fmsui:jqDatePickerUIUX  
									datePickerOptions="changeMonth: true, changeYear: true, maxDate:'+100y', yearRange: '${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (user?.termDate != null ? user?.termDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+100', numberOfMonths: 1" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: user?.termDate)}"
									dateElementId="termDate" 
									dateElementName="termDate" 
									ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}" />				
								<div class="fms_form_error" id="termDate_error"></div>	                  
							</div>
							
							<label class="control-label" id="termReason_label" for="termReason">
								<g:message code="user.termReason.label" default="Term Reason: " />
							</label>
							<div class="fms_form_input fms_has_feedback">
								<input type="hidden" id="reasonCodeTypeHidden" value="UT" />
                               	<g:textField 
                               		class="form-control"
                               		name="termReason" 
                               		value="${user?.termReason}"
									maxlength="5" />
								<fmsui:cdoLookup 
									lookupElementId="termReason"
									lookupElementName="termReason" 
									lookupElementValue="${user?.termReason}"
									lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
									lookupCDOClassAttribute="reasonCode"
									htmlElementsToAddToQuery="reasonCodeTypeHidden"
									htmlElementsToAddToQueryCDOProperty="reasonCodeType" />		
								<div class="fms_form_error" id="termReason_error"></div>	
							</div>
						</div>
					</div>
				</fieldset>
			</div>
			<!-- END Widget: Edit User -->
			
			<!-- START Widget: Rules Information -->
			<div class="fms_widget">        
               	<fieldset class="no_border">
                  	<legend><h3>Rules Information</h3></legend>
	
					<div class="fms_form_layout_2column">                  
						<div class="fms_form_column fms_long_labels">
						
							<label class="control-label" id="userCategory_label" for="userCategory">
								<g:message code="user.userCategory.label" default="User Category:" />
							</label>
							<div class="fms_form_input">	
								<Select 
									class="form-control" 
									name="userCategory" 
									aria-labelledby="userCategory_label" 
									aria-describedby="dfltTemplate_error" 
									aria-required="false" > 									
									<option value="DB" ${'DB'.equals(user.userCategory) ?'selected':""}>Database</option>
									<option value="ED" ${'ED'.equals(user.userCategory) ?'selected':""}>Enterprise Directory</option>				
								</Select>					
								<div class="fms_form_error" id="userCategory_error"></div>	                  
							</div>	
							
							<label class="control-label" id="userType_label" for="userType">
								<g:message code="user.userType.label" default="User Type:" />
							</label>
							<div class="fms_form_input">	
								<Select 
									name="userType"
									class="form-control"
									aria-labelledby="userType_label" 
									aria-describedby="userType_error" 
									aria-required="false"> 									
									<option value="G" ${'G'.equals(user.userType) ?'selected':""}>Group</option>
									<option value="M" ${'M'.equals(user.userType) ?'selected':""}>Member</option>
									<option value="O" ${'O'.equals(user.userType) ?'selected':""}>Operator</option>
									<option value="P" ${'P'.equals(user.userType) ?'selected':""}>Provider</option>
								</Select>						
								<div class="fms_form_error" id="userType_error"></div>	                  
							</div>	
							
							<label class="control-label" id="suPriv_label" for="suPriv">
								<g:message code="user.suPriv.label" default="Super User:" />
							</label>
							<div class="fms_form_input">	
								<g:select 
									name="suPriv" 
									value="${user?.suPriv}"
									from="${['N','Y']}"
									class="form-control"
									aria-labelledby="suPriv_label" 
									aria-describedby="suPriv_error" 
									aria-required="false" >
								</g:select>			
								<div class="fms_form_error" id="suPriv_error"></div>	                  
							</div>	
						</div>
						
						<div class="fms_form_column fms_long_labels">	
							<label class="control-label" id="directoryName_label" for="directoryName">
								<g:message code="user.directoryName.label" default="Directory Name: " />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									readonly="readonly"
									name="directoryName"  
									value="${user.directoryName}"  
									class="form-control"
									aria-labelledby="userStatus_label" 
									aria-describedby="directoryName_label" 
									aria-required="false"/>						
								<div class="fms_form_error" id="directoryName_error"></div>	                  
							</div>	
							
							<label class="control-label" id="userStatus_label" for="userStatus">
								<g:message code="user.languageId.label" default="Language:" />
							</label>
							<div class="fms_form_input">	
								<g:select 
									name="languageId" 
									optionKey="languageId" 
									optionValue="languageCode" 
									value="${user?.languageId}"
									from="${languageList}"  
									class="form-control"
									aria-labelledby="userType_label" 
									aria-describedby="userType_error" 
									aria-required="false">
								</g:select>				
								<div class="fms_form_error" id="userStatus_error"></div>	                  
							</div>							
						
						</div>
					</div>
				</fieldset>
			</div>
			<!-- END Widget: Rules Information -->
			
			<!-- START Widget: Security Information -->		
			<div class="fms_widget">        
               	<fieldset class="no_border">
                  	<legend><h3>Security Information</h3></legend>
	
					<div class="fms_form_layout_2column">                  
						<div class="fms_form_column fms_long_labels">					
							<label class="control-label" id="usePwdProfInd_label" for="usePwdProfInd">
								<g:message code="user.usePwdProfInd.label" default="Use Password Profile:" />
							</label>
							<div class="fms_form_input">	
								<g:select 
									name="usePwdProfInd" 
									value="${user?.usePwdProfInd}"
									from="${['N','Y']}" 
									class="form-control"
									aria-labelledby="usePwdProfInd_label" 
									aria-describedby="usePwdProfInd_error" 
									aria-required="false">
								</g:select>					
								<div class="fms_form_error" id="usePwdProfInd_error"></div>	                  
							</div>	
							
							<label class="control-label" id="noteSecurityLevel_label" for="noteSecurityLevel">
								<g:message code="user.noteSecurityLevel.label" default="Note Type Security:" />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="noteSecurityLevel"  
									value="${user.noteSecurityLevel}"  
									maxlength="1"
									class="form-control"
									aria-labelledby="noteSecurityLevel_label" 
									aria-describedby="noteSecurityLevel_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="noteSecurityLevel_error"></div>	                  
							</div>	
							
							<label class="control-label" id="restrictionIndicator_label" for="restrictionIndicator">
								<g:message code="user.restrictionIndicator.label" default="Restriction Indicator:" />
							</label>
							<div class="fms_form_input">	
								<g:select 
									name="restrictionIndicator" 
									value="${user?.restrictionIndicator}"
									from="${['N','Y']}" 
									class="form-control"
									aria-labelledby="restrictionIndicator_label" 
									aria-describedby="restrictionIndicator_error" 
									aria-required="false">
								</g:select>					
								<div class="fms_form_error" id="restrictionIndicator_error"></div>	                  
							</div>	
		
						</div>
						
						<div class="fms_form_column fms_long_labels">
							<label class="control-label" id="accountStatus_label" for="accountStatus">
								<g:message code="user.accountStatus.label" default="Account Status:" />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="accountStatus"  
									value="${accountStatus}"  
									readonly="readonly" 
									class="form-control"
									aria-labelledby="accountStatus_label" 
									aria-describedby="accountStatus_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="accountStatus_error"></div>	                  
							</div>	
							
							<label class="control-label" id="usrSecurityLevel_label" for="usrSecurityLevel">
								<g:message code="user.usrSecurityLevel.label" default="Row Level Security:" />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="usrSecurityLevel"  
									value="${user.usrSecurityLevel}"  
									maxlength="1"
									class="form-control"
									aria-labelledby="usrSecurityLevel_label" 
									aria-describedby="usrSecurityLevel_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="usrSecurityLevel_error"></div>	                  
							</div>	
							
							<label class="control-label" id="userStatus_label" for="userStatus">
								<g:message code="user.sfldlId.label" default="Field Level Security ID:" />
							</label>
							<div class="fms_form_input fms_has_feedback">
                               	<g:textField 
                               		class="form-control"
                               		name="sfldlId" 
                               		value="${user?.sfldlId}"
									maxlength="25" />
								<fmsui:cdoLookup 
									lookupElementId="sfldlId"
									lookupElementName="sfldlId" 
									lookupElementValue="${user?.sfldlId}"
									lookupCDOClassName="com.perotsystems.diamond.dao.cdo.SecColMaster"
									lookupCDOClassAttribute="sfldlId"/>		
								<div class="fms_form_error" id="sfldlId_error"></div>	
							</div>	
						</div>
					</div>
				</fieldset>
			</div>
			<!-- START Widget: Security Information -->		
			
			<g:if test="${editType.equals("edit")}">	
				<div class="fms_form_button">
					<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
					<input id="BtnAddressDelete2" type="button" class="btn btn-default BtnDeleteRow" formnovalidate="" value="${message(code: 'default.button.delete.label', default: 'Delete1')}" title="Click to delete User ID." data-target="#DeleteAlertModal" />
					<g:actionSubmit class="btn btn-default" action="unlock" value="${message(code: 'default.button.unlock.label', default: 'Unlock Account')}" />
					<input type="button" class="btn btn-default" value="Close" onClick="closeForm()" />
	           	</div>
			</g:if>
			<g:else>
				<div class="fms_form_button">
					<g:submitButton class="btn btn-primary" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}" />
										<input class="btn btn-default" type="button" onclick="document.forms['createForm'].reset();" value="Reset">	
					<input type="button" class="btn btn-default" value="Cancel" onClick="closeForm()" />

				</div>
			</g:else>
		</div>
	</div>	
	
</div>
<!-- END - FMS Content Body -->