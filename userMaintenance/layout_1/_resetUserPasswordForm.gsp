<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>
<br/>
<input type="hidden" id="editSecId" name="editSecId" value="0"/>
<input type="hidden" id="templateFlg" name="templateFlg" value="N"/>
<input type="hidden" name="editType" value="RESET"/>

<div id="fms_content_body">

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

	<div class="right-corner" align="right">SUSER</div>
	<div class="fms_required_legend fms_required">= required</div>
	
	<!-- START - WIDGET: Reset Information -->
	<div id="WidgetResetPassword" class="fms_widget">
	
		<fieldset>
			<legend><h2>Reset Password</h2></legend>
			
			<div class="fms_form_layout_2column">                  
				<div class="fms_form_column fms_long_labels">

					<label class="control-label" id="userId_label" for="lname">
						<g:message code="user.userId.label" default="User Id:" />
					</label>
					<div class="fms_form_input">
						<input 
							type="hidden" 
							name="userId" 
							value="${user.userId}"/>
							
						<g:textField 
							readonly="readonly" 
							name="userId"  
							value="${user.userId}"  
							class="form-control"
							aria-labelledby="userId_label" 
							aria-describedby="userId_error" 
							aria-required="false"/>						
						<div class="fms_form_error" id="userId_error"></div>	                  
					</div> 
					
					<label class="control-label fms_required" id="newPassword_label" for="newPassword">
						<g:message code="newPassword.label" default="New Password:" />
					</label>
					<div class="fms_form_input">
						<g:passwordField class="form-control" name="newPassword" id="newPassword" />					
						<div class="fms_form_error" id="newPassword_error"></div>	                  
					</div>
					
					<label class="control-label fms_required" id="confirmPassword_label" for="confirmPassword">
						<g:message code="confirmPassword.label" default="Confirm Password:" />
					</label>
					<div class="fms_form_input">
						<g:passwordField class="form-control" name="confirmPassword" id="confirmPassword" />					
						<div class="fms_form_error" id="confirmPassword_error"></div>	                  
					</div> 
					
					<label class="control-label fms_form_input fms_checkbox_offset">
						<input id="togglePasswordField" type="checkbox" name="ckbx1" value="" checked="checked" /> Mask characters</label>
					
					<g:actionSubmit type="button" class="btn btn-primary fms_button_offset" action="resetUserPassword"
						value="${message(code: 'default.button.resetUserPassword.label', default: 'Reset Password')}" />
				</div>
			</div>
		</fieldset>
	</div>
	<!-- END - WIDGET: Reset Information -->
</div>

<script type="text/javascript">

	$('#togglePasswordField').change('click', function(){
	  var $input = $("#newPassword");
	  if( $($input).attr('type') == 'password') {
	  	changeType( $input, 'text');		  
	  } else{
	    changeType( $input , 'password');
	  }

	  var $input2 = $("#confirmPassword");
	  if( $($input2).attr('type') == 'password') {
	  	changeType( $input2, 'text');		  
	  } else{
	    changeType( $input2, 'password');
	  }
	  
	  return false;
	});

   </script>