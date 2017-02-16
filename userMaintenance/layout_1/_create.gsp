<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="userMaintenance"/>
		
		<g:set var="appContext" bean="grailsApplication"/>
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.USER_SECURITY_CREATE.equals(currentPage)?true:false}" />
		
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		
			<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
			<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
			
<script type="text/javascript">
	$(document).ready(function(){
		
	
		jQuery.validator.addMethod("greaterThan", function(value, element, params) {
		
			var startDate= new  Date($("#effDate").val());
				var endDate = new Date($("#termDate").val()) ;
				return this.optional(element) ||( $("#effDate").val().length > 0 && startDate < endDate ) ;
				
							},'Term Date Must be greater than Effective Date.');
		
//		$("#termDate").rules('add', { greaterThan: true });
		
	});

</script>			
					
<script type="text/javascript">

var grpInnerWindow 
var innerWindowClosed = true;
function closeAllIFrames() {
	if(grpInnerWindow) {
		grpInnerWindow.close()
	}
}

function closeForm() {
	var result = confirm("You will lose unsaved data, Are you sure you want to close the form?");
	var appName = "${appContext.metadata['app.name']}";
	
	if (result==true) {		
	window.location.assign("/"+appName+"/userMaintenance/list");
	}	
}


$(document).ready(function(){
	//list all functions after document is loaded.
	
	$.validator.addMethod("custompassword", function(value, element) {
			return this.optional(element) || /^[a-zA-Z0-9_$#]+$/i.test(value);
			
		}, "Only numbers, alphabets and special characters _ , $ and # are allowed.");
	
	$.validator.addMethod("customfirstchar", function(value, element) {
		return this.optional(element) || /^[A-Za-z][A-Za-z0-9 $#_]*$/i.test(value);
		
	}, "Password cannot start with a special character or number.");


	jQuery.validator.addMethod("phoneUS", function(value, element) {
		return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
	}, "Telephone Number must be 10 digits.");


$('#suPriv, #templateFlg').change(function()
{
	if($("#suPriv").val() =='Y')
	{
		$("#sfldlId").attr("disabled","disabled");
		$("#sfldlIdLookup").hide();
		$("#dfltTemplate").attr("disabled","disabled");
	}
	else{
		if($("#templateFlg").val() =='Y')
		{
			$("#sfldlId").removeAttr('disabled');
			$("#sfldlIdLookup").show();
			$("#dfltTemplate").attr("disabled","disabled");
		}
		else
		{
			$("#sfldlId").removeAttr('disabled');
			$("#sfldlIdLookup").show();
			$("#dfltTemplate").removeAttr('disabled');
		}	 
	}
});

$("#dfltTemplate").change(function(){
	if($("#dfltTemplate").val()!=''){
		$("#sfldlId").val("");
		$("#sfldlId").attr("disabled","disabled");
		$("#sfldlIdLookup").hide();
		}
	else{
		$("#sfldlIdLookup").show();
		$("#sfldlId").removeAttr('disabled');
		}
});


	$(function() {				
		$("#createForm").validate({
			
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
				
			rules : {
				'lname' : {
					required : true
				}
		,'resetPwdInd' : {
			required : true
		}
		,'noteSecurityLevel' : {
					required : true,
					range : [0, 9]
				}
				
		,'usrSecurityLevel' : {
			required : true,
			range : [0, 9]
		}

		,password: {
			required : true,
		  minlength : 6,
		  custompassword : true,
		  customfirstchar : true

		}
		
		,confirmPassword: {
            equalTo: '#password'
        }

		,'tel' : {
			phoneUS : true		
		}

		,'ext' : {
			digits : true			
		}	
		,'termReason' : {
			required : function(element){								
						return $.trim($("#termDate").val()).length >0;						
						}
		}

		,'termDate' : {	
			required : function(element){		
				return ($.trim($("#termReason").val()).length > 0);
			},		
			greaterThan: true			
		}	
        
				},
			messages : {
				'lname' : {
					required : "Please enter a last name."
				}
				,'resetPwdInd' : {
					required : "Please select the Reset Password Indicator."
				}
				,'noteSecurityLevel' : {
					required : "Please enter Note Type Security."
						,rangelength :"Note Type Security must be between 0 and 9."
				}

				,'usrSecurityLevel' : {
					required : "Please enter row level Security."
						,rangelength :"Note Type Security must be between 0 and 9."
				}

				,'password' : {
					required : "Please enter a Password.",
					minlength: jQuery.format("Please enter at least {0} characters for Password.")
					
						}

				,'confirmPassword' : {
					equalTo : "Please enter the same Password."
						}
				,'tel' : {
					phoneUS : "Telephone Number must be 10 digits."			
				}

				,'ext' : {
					digits : "Please enter only numbers for Extn."					
				}	
				,'termReason' : {
					required : "Term reason is required if Term date is entered."
				}
				,'termDate' : {
					required : "Term Date is required if Term reason is entered."					
				}
				
			}
		})
	});

	//end document ready
}); 

		
	
</script>
	</head>
		
	<div id="fms_content">
		<div id="fms_content_header">
        	<div class="fms_content_header_note">
        		
          		<a href="/FMSAdminConsole/userMaintenance/list">Security Maintenance</a> /
          		<a href="/FMSAdminConsole/userMaintenance/list"/> User Maintenance </a> / 
          		User Records for User Id (${user.userId})
        	</div>		
			
			<div class="fms_content_title">
          		<h1>Create User</h1>

		<!-- 
				<div class="fms_content_header_startpage">
            		<div class="checkbox">
                		<label>
                  			<input id="myStartPage" name="myStartPage" type="checkbox" /> My start page
                		</label>
              		</div>
          		</div>
				<div class="fms_content_header_tabs">
            		<a href="#" title="Click to add individual."><i class="fa fa-user-plus"></i></a>          
            		<a id="BookmarkTab" href="#" title="Click to bookmark this page."><i class="fa fa-bookmark-o"></i></a>
          		</div>		
		 -->
          	</div>
		</div>
	<!-- 
		<div id="fms_content_message" class="arrow_bgnd parent_close_this">      
          	<h4>Did you know that you can change your FMS start page?</h4>
          	<p>You can select a new default start page just be navigating to the other page and clicking the checkbox.</p>
          	<a href="#" class="fms_content_message_close btn_close_this" title="Hide Form"><i class="fa fa-times-circle"></i></a>      
        </div>
	 -->	
		
		<!-- START - Tabs -->
		<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
				<li><g:link class="active" action="create"  params="${[userId: request.getParameter('userId')]}">User</g:link></li>
			</ul>
		</div>
      	<!-- END - Tabs -->
	
		<div id="create-user" class="content scaffold-create" role="main">
		
			<g:form action="save" id="createForm" name="createForm">
			
				<input type="hidden" name="editType" value="${request.getParameter("editType")}" />
			 	<fieldset class="userForm">
					<g:render template="userForm" model="[editType: 'create']"/>
				</fieldset>	
				
				<%--used by lookup window to close the lookup on selection--%>
				<div style="display: none">
					<input type="button" onClick="closeAllIFrames()" id="closeIframes">
				</div>	
			</g:form>
		</div>
	</div>
</html>
