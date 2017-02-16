<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />

		<g:set var="appContext" bean="grailsApplication"/>

		<title><g:message code="default.create.label" args="[entityName]" /></title>
		
			 <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
			<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
			<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
			<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
			<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
					
			<!-- Style Includes for lookup-->
	  	 	<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">

			
			
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


	$.validator.addMethod("phoneUS", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 
	}, "Telephone must be 0, 7 or 10 digits.");


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

				,'password' : {
					required : "Please enter a Password.",
					minlength: jQuery.format("Please enter at least {0} characters for Password.")
					
						}

				,'confirmPassword' : {
					equalTo : "Please enter the same Password."
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
		<a href="#create-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" action="create"  params="${[userId: request.getParameter('userId')]}">User</g:link></li>
			</ul>
		</div>
		<div id="create-user" class="content scaffold-create" role="main">
			<h1  style="color: #48802C">Create User</h1>
			<div class="right-corner" align="center">SUSER</div>			
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${userInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${userInstance}" var="error">
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
			<g:form action="save"   name="createForm">
			 <input type="hidden" name="editType" value="${request.getParameter("editType")}" />
			 	
			  <div id="errorDisplay" style="display:none;"  class="errors" style="float:left; margin: -5px 10px 0px 0px; ">
			 </div>
			 			
					<fieldset class="userForm">
						<g:render template="userForm"/>
					</fieldset>	
					<fieldset class="buttons">
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
						<input type="button" class="close" value="Close" 	onClick="closeForm()" />
					
					</fieldset>	
			<%--used by lookup window to close the lookup on selection--%>
			<div style="display: none">
				<input type="button" onClick="closeAllIFrames()" id="closeIframes">
			</div>
										
			</g:form>
		</div>
	</body>
</html>
