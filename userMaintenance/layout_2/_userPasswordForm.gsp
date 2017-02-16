<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>
<script>

$(document).ready(function(){
	//list all functions after document is loaded.
	
$.validator.addMethod("customfirstchar", function(value, element) {
	return this.optional(element) || /^[A-Za-z][A-Za-z0-9 $#_]*$/i.test(value);
	
}, "Password cannot start with a special character or number.");
	
$( "#newPassword" ).rules( "add", {  required: true,  
									minlength: 6,  
									customfirstchar: true,
						messages: {  required: "Please enter a New Password .",    
									 minlength: jQuery.format("Please enter at least {0} characters for New Password.")
}}); 

$( "#oldPassword" ).rules( "add", {   required: true,   
	
							messages: {  required: "Please enter the old Password ."	}
}); 


//end document ready

});

</script>

<style>
TD 
{
	white-space: nowrap
}
</style>
User Records for User Id (${user.userId})
<br/>
<input type="hidden" id="editSecId" name="editSecId" value="0"/>
<input type="hidden" id="templateFlg" name="templateFlg" value="N"/>
<input type="hidden" name="editType" value="PASSWORD"/>


<table>
	<tr>
		<td>
			<div
				class="fieldcontain ${hasErrors(bean:user, field: 'userId', 'error')} required ">
				<label for="userId"> <g:message
						code="user.userId.label" default="User Id:" />
				</label>
			
				<input type="hidden" name="userId" value="${user.userId}"/>
					&nbsp;${user.userId}
			</div>
		</td>
		<td >
			<div
				class="fieldcontain">
				<label for="oldPassword"> <g:message
						code="oldPassword.label" default="Old Password:" /><span class="required-indicator">*</span></label>				
				<g:passwordField name="oldPassword"  />
			</div>
		</td>
		<td>
			<div
				class="fieldcontain">
				<label for="newPassword"> <g:message
						code="newPassword.label" default="New Password:" /><span class="required-indicator">*</span></label>
				
				<g:passwordField name="newPassword"  />
			</div>
		</td>
	</tr>
	
</table>
