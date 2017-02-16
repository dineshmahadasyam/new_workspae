<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />

		<g:set var="appContext" bean="grailsApplication"/>

		<title><g:message code="default.edit.label" args="[entityName]" /></title>  
	 
	 <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>	
	<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
<g:javascript>
var userflag=false;
	$(function(){
	  $("form")	   
	    .dirty_form({changedClass: "forever_changes"})
	    .dirty(function(event, data){
	      var label = $(event.target).parents("li").find("label");
	      userflag=true;	     
	    })
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


function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds, assocFieldCdoName, updateFields, updateFieldsCdoName) {
	var htmlElementValue 
	var assocHTMLElementsValue= ""
	htmlElementValue = document.getElementById(idName).value
	//alert (assocFieldIds)
	if (assocFieldIds) {
		if(assocFieldIds.indexOf('|') == -1){			
			if (document.getElementById(assocFieldIds) && document.getElementById(assocFieldIds).value != "undefined") {
				assocHTMLElementsValue = document.getElementById(assocFieldIds).value
			}
		} else {
			var nameArray = assocFieldIds.split("|")
			for (var i =0;i<nameArray.length;i++) {			
				if (document.getElementById(nameArray[i]) && document.getElementById(nameArray[i]).value != "undefined") {
			//		alert (document.getElementById(nameArray[i]).value)
					assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
				}
			}
		}
	}
	//alert("assocHTMLElementsValue = "+assocHTMLElementsValue )
	var appName = "${appContext.metadata['app.name']}";
	
	var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName=" + idName
			+ "&htmlElementValue="+ htmlElementValue 
			+ "&cdoClassName="+ cdoClassName 
			+ "&cdoClassAttributeName="+ cdoClassAttributeName 
			+ (assocFieldIds?"&assocFields="+assocFieldIds :"")			
			+ (assocFieldCdoName?"&assocFieldCdoName="+assocFieldCdoName :"")
			+ (assocHTMLElementsValue? "&assocFieldValue="+ assocHTMLElementsValue : "") 
			+ (updateFieldsCdoName?  "&updateFieldsCdoName=" + updateFieldsCdoName : "")
			+ (updateFields? "&updateFields="+updateFields : "")
			+ "&offset=0"
	if (!innerWindowClosed) {
		grpInnerWindow.setUrl(urlValue)
	} else {
		innerWindowClosed = false;
		grpInnerWindow = $.window({
			showModal : true,
			title : "Lookup",
			bookmarkable : false,
			minimizable : false,
			maximizable : false,
			width : 900,
			height : 350,
			scrollable: false,
			url : urlValue, 
		 onClose: function(wnd) { // a callback function while user click close button
			 innerWindowClosed = true;
		  }
		});
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
	//list all functions after document is loaded.
	//suPriv = super user flag
	//if a super user
	$.validator.addMethod("phoneUS", function(value, element) {
		    value = value.replace(/\s+/g, ""); 
			return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 
		}, "Telephone must be 0, 7 or 10 digits.");

	  

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
			digits : true,
			phoneUS : true			
		}

		,'ext' : {
			digits : true			
		}

		,'termReason' : {
			required : function(element){								
						return $.trim($("#termDate_year").val()).length >0;						
						}
		}

		,'termDate_year' : {		

			required : function(element){				
				return ($.trim($("#termReason").val()).length > 0);
				}					
		}	
		,'termDate_month' : {		

			required : function(element){			
				return ($.trim($("#termReason").val()).length > 0);
				}					
		}	

		,'termDate_day' : {	
			required : function(element){		
				return ($.trim($("#termReason").val()).length > 0);
				}					
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
					digits : "Please enter only numbers for Telephone."			
				}

				,'ext' : {
					digits : "Please enter only numbers for Extn."					
				}
				,'termReason' : {
					required : "Term reason is required if Term date is entered."
				}
				,'termDate_year' : {
					required : "Term reason Year is required if Term reason is entered."					
				}

				,'termDate_month' : {
					required : "Term reason Month is required if Term reason is entered."					
				}

				,'termDate_day' : {
					required : "Term reason Day is required if Term reason is entered."					
				}
				
			}
		})
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
<style>
	div.right-corner {
	    position: absolute;
	    top: 0px;
	    right: 0;
	    margin-right: 40px;
	    font:normal normal 21pt / 1 Tahoma;
	    color: #48802C;
	}
</style>

	</head>
	<body>
		<!-- JavaScript Includes -->
		
	  
		<a href="#edit-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'MASTER']}">User</g:link></li>
				<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'PASSWORD']}">Change Password</g:link></li>
				<g:if test="${session["superUser"] == 'Y'}" >
					<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'RESET']}">Reset Password</g:link></li>
				</g:if>
				<g:if test="${user?.dfltTemplate == null}">
					<li><g:link class="list" action="edit" id="${user?.userId}" params="${[editType :'FUNCTIONACCESS']}">Function Access</g:link></li>
				</g:if>
				<g:else>
					<li><a class="list" title="Template ID is assigned to this User ID. Function Level Access cannot be assigned.">Function Access</a></li>
				</g:else>
			</ul>
		</div>
		
		
		<div id="edit-user" class="content scaffold-edit" role="main">
			<h1 style="color: #48802C">Edit User</h1>
			<g:if test="${request.getParameter('editType') && 'FUNCTIONACCESS'.equals(request.getParameter('editType'))}">
				<div title="The keyword for this screen that can be used for audit trail" class="right-corner" align="center">SFUNC</div>
			</g:if>
			<g:else>
				<div class="right-corner" align="center">SUSER</div>
			</g:else>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${user}">
				<ul class="errors" role="alert">
					<g:eachError bean="${user}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
			</g:hasErrors>
			<g:if test="${fieldErrors}">
				<ul class="errors" role="alert">
					<g:each in="${fieldErrors}" var="error">
						<li>${error}</li>
					</g:each>
				</ul>
			</g:if>


			<g:form method="post" name="form1">
				<input type="hidden" name="editType" value="${editType}" />
				<g:hiddenField name="id" value="${user?.userId}" />
	
				<div id="errorDisplay" style="display: none;" class="errors"
					style="float:left; margin: -5px 10px 0px 0px; ">
				</div>
	
				<g:if test="${request.getParameter('editType') == null | (request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType')))}">
					<fieldset class="userForm">
						<g:render template="userForm" />
					</fieldset>
						<fieldset class="buttons">
						<g:actionSubmit class="save" action="update"
							value="${message(code: 'default.button.update.label', default: 'Update')}" />
						<g:actionSubmit class="delete cancel" action="delete"
							value="${message(code: 'default.button.delete.label', default: 'Delete')}"
							formnovalidate=""
							onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						<g:actionSubmit class="save cancel" action="unlock"
							value="${message(code: 'default.button.unlock.label', default: 'Unlock Account')}" />
						<input type="button" class="close" value="Close"						
							onClick="closeForm()" />
	
					</fieldset>
				</g:if>
				<g:if test="${request.getParameter('editType') && 'PASSWORD'.equals(request.getParameter('editType'))}">
					<fieldset class="userPasswordForm">
						<g:render template="userPasswordForm" />
					</fieldset>
					
					<fieldset class="buttons">
						<g:actionSubmit class="save" action="changePassword"
							value="${message(code: 'default.button.updatePassword.label', default: 'Change Password')}" />
						<input type="button" class="close" value="Close"
							onClick="closeForm()" />
					</fieldset>
				</g:if>
	
	
				<g:if test="${request.getParameter('editType') && 'RESET'.equals(request.getParameter('editType'))}">
					<fieldset class="resetUserPasswordForm">
						<g:render template="resetUserPasswordForm" />
					</fieldset>
					
					<fieldset class="buttons">
						<g:actionSubmit class="save" action="resetUserPassword"
							value="${message(code: 'default.button.resetUserPassword.label', default: 'Reset Password')}" />
						<input type="button" class="close" value="Close"
							onClick="closeForm()" />
					</fieldset>
				</g:if>
				
				<g:if test="${request.getParameter('editType') && 'FUNCTIONACCESS'.equals(request.getParameter('editType'))}">
					<fieldset class="functionAccessForm">
						<g:render template="functionAccessForm" />
					</fieldset>
					
					<fieldset class="buttons">
						<g:actionSubmit class="save" action="updateFunctionAccess"
							value="Update access to functions on this page" />
						<input type="button" class="close" value="Close"
							onClick="closeForm()" />
					</fieldset>
				</g:if>
				
				<g:if test="${request.getParameter('editType') == null | (request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType')))}">
				
				</g:if>
				
				<g:if test="${request.getParameter('editType') && 'PASSWORD'.equals(request.getParameter('editType'))}">
	
	
				</g:if>
				<%--used by lookup window--%>
				<div style="display: none">
					<input type="button" onClick="closeAllIFrames()" id="closeIframes">
				</div>
			</g:form>
		</div>			  
		
	</body>
</html>
