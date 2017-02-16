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
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.USER_SECURITY_EDIT.equals(currentPage)?true:false}" />
		
		<title><g:message code="default.edit.label" args="[entityName]" /></title>  
	 
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
  		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
		<script src="${resource(dir: '/js/layout_1_scripts', file: 'unmask.js')}" ></script>  		
		
		<script type="text/javascript">
			$(document).ready(function(){
				
			
				jQuery.validator.addMethod("greaterThan", function(value, element, params) {
				
					var startDate= new  Date($("#effDate").val());
						var endDate = new Date($("#termDate").val()) ;
						return this.optional(element) ||( $("#effDate").val().length > 0 && startDate < endDate ) ;
						
									},'Term Date Must be greater than Effective Date.');
				
			});
		
		</script>
		
		<script>

			$(document).ready(function(){
				//list all functions after document is loaded.
				
				$.validator.addMethod("customfirstchar", function(value, element) {
					return this.optional(element) || /^[A-Za-z][A-Za-z0-9 $#_]*$/i.test(value);
					
				}, "Password cannot start with a special character or number.");
			
			});
			
		</script>
		
		<script>

			$(document).ready(function(){
				//list all functions after document is loaded.
			
				$.validator.addMethod("customfirstchar", function(value, element) {
					return this.optional(element) || /^[A-Za-z][A-Za-z0-9 $#_]*$/i.test(value);
					
				}, "Password cannot start with a special character or number.");
			
				//end document ready
			
			});
		
		</script>
		
		<g:javascript>
		var userflag=false;
			$(function(){
			  $("form")	   
			    .dirty_form({changedClass: "forever_changes"})
			    .dirty(function(event, data){
			      var label = $(event.target).parents("li").find("label");
			      userflag=true;	     
			    });
			});	
			
				
		</g:javascript>
		 
		<script type="text/javascript">
		
		var grpInnerWindow 
		var innerWindowClosed = true;
		function closeAllIFrames() {
			if(grpInnerWindow) {
				grpInnerWindow.close()
			}
		}
		
		function closeForm() {
			if(userflag){
			var result = confirm("You will lose unsaved data, Are you sure you want to close the form?");
			var appName = "${appContext.metadata['app.name']}";
			
			if (result==true) {		
				window.location.assign("/"+appName+"/userMaintenance/list")
			}
			}else{
				var appName = "${appContext.metadata['app.name']}";
				window.location.assign("/"+appName+"/userMaintenance/list")		
				}
			
		}
		
		
		$(document).ready(function(){
			jQuery.validator.addMethod("phoneUS", function(value, element) {
				return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
			}, "Telephone Number must be 10 digits.");
			  
			$("#suPriv").change(function(){			
				if($(this).val() =='Y'){
					//disable template picking
					$("#dfltTemplate").val("");
					$("#dfltTemplate").attr("disabled","disabled");
		
					//disable fls id
					$("#sfldlId").val("");
					$("#sfldlId").attr("disabled","disabled");
					$("#sfldlIdLookup").attr("onClick","");
				}
				
				//if not a super user
				else{
					//if acct is a template
					if($("#templateFlg").val() == 'Y'){
						//disable template picking
						$("#dfltTemplate").val("");
						$("#dfltTemplate").attr("disabled","disabled");
		
						//allow FLS Id
						$("#sfldlId").removeAttr('disabled');
						$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
					}
					
					//if acct is not a template
					else{
						//enable template picking
						$("#dfltTemplate").removeAttr('disabled');
		
						//if there is a template id
						if($("#dfltTemplate").val() != ""){
							//disable fls id
							$("#sfldlId").val("");
							$("#sfldlId").attr("disabled","disabled");
							$("#sfldlIdLookup").attr("onClick","");	
						}
						else{
							//allow FLS Id
							$("#sfldlId").removeAttr('disabled');
							$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
						}
					}
				}
			});
		
			//templateFlg = the Y/N flag for if the acct is a user or template
			$("#templateFlg").change(function(){
				if($(this).val() =='Y'){
					//disable template picking
					$("#dfltTemplate").val("");
					$("#dfltTemplate").attr("disabled","disabled");
		
					//if not a super user
					if($("#suPriv").val() != 'Y'){
						//allow FLS Id
						$("#sfldlId").removeAttr('disabled');
						$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
					}
					else{
						//disable fls id
						$("#sfldlId").val("");
						$("#sfldlId").attr("disabled","disabled");
						$("#sfldlIdLookup").attr("onClick","");	
					}
				}
				//if not a template
				else{
					//if not a super user
					if($("#suPriv").val() != 'Y'){
						//allow template picking
						$("#dfltTemplate").removeAttr('disabled');
		
						//if there is not a template id
						if($("#dfltTemplate").val() == ""){
							//allow FLS Id
							$("#sfldlId").removeAttr('disabled');
							$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
						}
						else{
							//allow FLS Id
							$("#sfldlId").removeAttr('disabled');
							$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
						}
					}
					//if acct is a super user
					else{
						//disable template picking
						$("#dfltTemplate").val("");
						$("#dfltTemplate").attr("disabled","disabled");
		
						//disable fls id
						$("#sfldlId").val("");
						$("#sfldlId").attr("disabled","disabled");
						$("#sfldlIdLookup").attr("onClick","");
					}
				}
			});
		
			$("#dfltTemplate").change(function(){
				if($(this).val() != ""){
					//set it to blank
					$("#sfldlId").val("");
					$("#sfldlId").attr("disabled","disabled");
					$("#sfldlIdLookup").attr("onClick","");
					
					}
				else{
					//only disable field if not a template
					$("#sfldlId").removeAttr('disabled');
					$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
				}
			});
		
		
		
			$(function() {		
				$("#form1").validate({
					
					invalidHandler: function(form, validator) {
			            var errors = validator.numberOfInvalids();
			            if (errors) {      
				            //Hide any previous message from the server when the client validation is occuring
			            	$(".message").hide();              
			            }
			        },
					
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
						
						,'newPassword' : {
							required: true,  
							minlength: 6,  
							customfirstchar: true
						}
						
						,'oldPassword' : {
							required: true
						}
						
						,'confirmPassword' : {
							equalTo: '#newPassword'
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
						,'newPassword' : {
							required: "Please enter a New Password .",    
							minlength: jQuery.format("Please enter at least {0} characters for New Password.")
						}
						,'oldPassword' : {
							required: "Please enter the old Password ."
						}
						,'confirmPassword' : {
							messages: {  equalTo: "Please enter the same Password in Confirm Password."	}
						}
					}
				});
			});
		
		
			//hide password fields in Edit mode	
		
			 $('#password-div').hide();
			 $('#confirmPassword-div').hide();
		
		
			 //disable the template for super user
			 
			 if($("#suPriv").val() =='Y'){
				 
				//disable template picking
					$("#dfltTemplate").val("");
					$("#dfltTemplate").attr("disabled","disabled");
		
					//disable fls id
					$("#sfldlId").val("");
					$("#sfldlId").attr("disabled","disabled");
					$("#sfldlIdLookup").attr("onClick","");
				}
				//if not a super user
				else{
					//if a template
					if($("#templateFlg").val() =='Y'){
						//disable template picking
						$("#dfltTemplate").val("");
						$("#dfltTemplate").attr("disabled","disabled");
						
						//allow FLS Id
						$("#sfldlId").removeAttr('disabled');
						$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
					}
					//if not a template
					else{
						//enable template picking
						$("#dfltTemplate").removeAttr('disabled');
						
						//if there is a template id
						if($("#dfltTemplate").val() != ""){
							//disable fls id
							$("#sfldlId").val("");
							$("#sfldlId").attr("disabled","disabled");
							$("#sfldlIdLookup").attr("onClick","");	
						}
						else{
							//allow FLS Id
							$("#sfldlId").removeAttr('disabled');
							$("#sfldlIdLookup").attr("onClick","lookup('sfldlId', 'com.perotsystems.diamond.dao.cdo.SecColMaster','sfldlId')");
						}	
					}
				}
				
			//end document ready
			}); 
			
		</script>
		
		<script type="text/javascript">
	
			$(document).ready(function() {
	
			      $('.BtnDeleteRow').click(function(e){
		              $('#DeleteAlertModal').modal('show');
		          });
			      $('#DeleteAlertModal').modal( {
				      backdrop: 'static',
				       show: false 
				  });
			      $("#BtnDeleteRowYes").click(function(e){	  		         
			               var appName = "${appContext.metadata['app.name']}";
			               var myFm = document.getElementById("form1") ; 			
			               myFm.action = "/"+appName+"/userMaintenance/delete";     	
			               myFm.submit();
			           
			  		});
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
          		<h1>User Maintenance</h1>
          	</div>
		</div>
	
        <!-- START - Tabs -->
		<div id="fms_content_tabs" class="fms_tab_action">
          	<ul>
          		<g:if test="${request.getParameter('editType') == null | (request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType')))}">
		            <li><g:link class="active" action="edit" id="${user?.userId}" params="${[editType :'MASTER']}">User</g:link></li>
				</g:if>
				<g:else>
					<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'MASTER']}">User</g:link></li>
				</g:else>
				
				<g:if test="${request.getParameter('editType') && 'PASSWORD'.equals(request.getParameter('editType'))}">
		        	<li><g:link class="active" action="edit" id="${user?.userId}" params="${[editType :'PASSWORD']}">Change Password</g:link></li>    
				</g:if>
				<g:else>		            
					<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'PASSWORD']}">Change Password</g:link></li>   		            
	            </g:else>
	            
				<g:if test="${request.getParameter('editType') && 'RESET'.equals(request.getParameter('editType'))}">	            
					<g:if test="${session["superUser"] == 'Y'}" >
						<li><g:link class="active" action="edit" id="${user?.userId}" params="${[editType :'RESET']}">Reset Password</g:link></li>
					</g:if>
				</g:if>
				<g:else>
					<g:if test="${session["superUser"] == 'Y'}" >
						<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'RESET']}">Reset Password</g:link></li>
					</g:if>
				</g:else>
				
				<g:if test="${request.getParameter('editType') && 'FUNCTIONACCESS'.equals(request.getParameter('editType'))}">
					<g:if test="${user?.dfltTemplate == null}">
						<li><g:link class="active" action="edit" id="${user?.userId}" params="${[editType :'FUNCTIONACCESS']}">Function Access</g:link></li>
					</g:if>
					<g:else>
						<li><a class="active" title="Template ID is assigned to this User ID. Function Level Access cannot be assigned.">Function Access</a></li>
					</g:else>
				</g:if>
				<g:else>
					<g:if test="${user?.dfltTemplate == null}">
						<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'FUNCTIONACCESS']}">Function Access</g:link></li>
					</g:if>
					<g:else>
						<li><a class="list" title="Template ID is assigned to this User ID. Function Level Access cannot be assigned.">Function Access</a></li>
					</g:else>
				</g:else>
          	</ul>
    		<div id="mobile_tabs_select"></div>
		</div>
      	<!-- END - Tabs -->
			
		<div id="edit-user" class="content scaffold-edit" role="main">
			
			<g:form method="post" name="form1">
			
				<input type="hidden" name="editType" value="${editType}" />
				<g:hiddenField name="id" value="${user?.userId}" />
	
				<g:if test="${request.getParameter('editType') == null | (request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType')))}">
					<fieldset class="userForm">
						<g:render template="userForm" model="[editType: 'edit']" />
					</fieldset>
					
				</g:if>
		
		 		
				<g:if test="${request.getParameter('editType') && 'PASSWORD'.equals(request.getParameter('editType'))}">
					<fieldset class="userPasswordForm">
						<g:render template="userPasswordForm" />
					</fieldset>
					
				</g:if>

			<g:if
				test="${request.getParameter('editType') && 'RESET'.equals(request.getParameter('editType'))}">
				<fieldset class="resetUserPasswordForm">
					<g:render template="resetUserPasswordForm" />
				</fieldset>

			</g:if>

			<g:if test="${request.getParameter('editType') && 'FUNCTIONACCESS'.equals(request.getParameter('editType'))}">
					<fieldset class="functionAccessForm">
						<g:render template="functionAccessForm" />
					</fieldset>
					
					<div class="fms_form_button">
						<g:actionSubmit class="btn btn-primary save" action="updateFunctionAccess"
							value="Update access to functions on this page" />
						<input type="button" class="btn btn-default" value="Close"
							onClick="closeForm()" />
					</div>
					
				</g:if>
				
				<g:if test="${request.getParameter('editType') == null | (request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType')))}">
				</g:if>
				
				<g:if test="${request.getParameter('editType') && 'PASSWORD'.equals(request.getParameter('editType'))}">
				</g:if>
	
				<div style="display: none">
					<input type="button" onClick="closeAllIFrames()" id="closeIframes">
				</div>
			</g:form>
		</div>
	</div>
	
	<!-- START - Delete Notice Modal -->
	<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4>Are you sure you want to delete this record?</h4>            
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END - Delete Notice Modal -->
</html>