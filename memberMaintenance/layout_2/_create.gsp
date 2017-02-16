<%@ page import="com.perotsystems.diamond.bom.SimpleMember" %>


<!DOCTYPE html>
<html>
	<head>
				<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
	
	<style type="text/css">
#memberIdSelectList [disabled] {
	color: #933;
}
TD
{
	line-height: 1.4em;
	padding: 0em 0em;
	text-align: left;
	vertical-align: middle;
}
.fieldcontain {
	margin-top: 0.1em;
}
</style>
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
<g:set var="appContext" bean="grailsApplication"/>

<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>


<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript">
$(document).ready(function(){

	jQuery.validator.addMethod("ssnmaxdigits", function(value, element) {
		return this.optional(element) || /\d{3}-\d{2}-\d{4}$/.test(value) || /\d{9}$/.test(value)
	}, "SSN must be 9 digits");
	
jQuery.validator.setDefaults({
	ignore: [],
	  debug: true,
	  success: "valid"
	});

$(function() {		
		$("#createForm").validate({
			submitHandler: function (form) {
				  if ($(form).valid()) 
                     form.submit(); 
                  return false; // prevent normal form posting
	        },
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
							
			rules : {
					'memberMaster.0.subscriberID' : {
						required : true
					},
					'memberMaster.0.personNumber' : {
						required : true
					}, 
					'memberMaster.0.lastName' : {
						required : true
					}, 
					'memberMaster.0.dob' : {
						required : true
					},
					'memberMaster.0.gender' : {
						required : true
					},
					'memberMaster.0.socialSecurityNumber': {
						ssnmaxdigits: true		
					},
					 'eligHistory.0.effectiveDate' : {
						required : true
					},
					'eligHistory.0.eligStatus' : {
						required : true
					},
					'eligHistory.0.benefitStartDate_day' : {
						required : true
					},
				    'eligHistory.0.benefitStartDate_month' : {
						required : true
					},		
				    'eligHistory.0.benefitStartDate_year' : {
						required : true
					},					
					'eligHistory.0.relationshipCode' : {
						required : true
					},
					'eligHistory.0.groupId' : {
						required : true
					},
					'eligHistory.0.planCode' : {
						required : true		
					},
					'eligHistory.0.privacyOn' : {
						required : true		
					},
					'eligHistory.0.lineOfBusiness' : {
						required : true		
					},
					'address.0.effectiveDate' : {
						required : true
					},
					'address.0.addressType': {
						required : true
					},
					'address.0.billingAddress' : {
						required : true
					},
					'address.0.address1' : {
						required : true
					},
					'address.0.city' : {
						required : true
					},
					'address.0.state' : {
						required : true
					},
					'address.0.zip' : {
						required : true,
						zipcodeUS : true
					},
					'address.0.homePhone' : {
						digits : true
					},
					'address.0.mobilePhone': {
						digits : true
					},
					'address.0.beeperNumber': {
						digits : true
					},
					'address.0.alternatePhone': {
						digits : true
					},
					'address.0.faxNumber': {
						digits : true
					},
					'address.0.telephoneNumber': {
						digits : true
					},
					'address.0.telephoneNumberEx': {
						digits : true
					},
					'address.0.businessPhone': {
						digits : true
					}					
			},
			messages : {		
				'memberMaster.0.subscriberID' : {
					required : "Please enter a Subscriber ID"
				},
				'memberMaster.0.personNumber' : {
					required : "Please enter a Person Number"
				}, 
				'memberMaster.0.lastName' : {
					required : "Please enter Last Name"
				}, 
				'memberMaster.0.dob' : {
					required : "Please select a Date of Birth"
				},
				'memberMaster.0.socialSecurityNumber' : {
					required : "SSN must be 9 digits"
				},
				'memberMaster.0.gender' : {
					required : "Please select the Gender"
				},
				'eligHistory.0.effectiveDate' : {
					required : "Please select a Effective Date"
				},
				'eligHistory.0.eligStatus' : {
					required : "Please select a Eligibility Status"
				},
				'eligHistory.0.benefitStartDate_day' : {
					required : "Please enter a Benefit Start Day."
				},
			    'eligHistory.0.benefitStartDate_month' : {
					required : "Please enter a Benefit Start Month."
				},	
			    'eligHistory.0.benefitStartDate_year' : {
					required : "Please enter a Benefit Start Year."
				},
				'eligHistory.0.relationshipCode': {
					required : "Please select a Relationship Code"						
				}, 
				'eligHistory.0.groupId' : {
					required : "Please enter a Group Id"						
				},
				'eligHistory.0.planCode' : {
					required : "Please enter a Plan Code."			
				},
				'eligHistory.0.privacyOn' : {
					required : "Please select a value for Privacy On"					
				},
				'eligHistory.0.lineOfBusiness' : {
					required : "Please enter a Line Of Business."
				},
				'address.0.effectiveDate' : {
					required : "Please select a Effective Date"
				},
				'address.0.addressType': {
					required : "Please select a Address Type"
				},
				'address.0.billingAddress' : {
					required : "Please select a Billing Address"
				},
				'address.0.address1' : {
					required : "Please enter a Address 1"
				},
				'address.0.city' : {
					required : "Please select a value for City"
				},
				'address.0.state' : {
					required : "Please select a value for State"
				},
				'address.0.zip' : {
					required : "Please enter a value for Zip Code",
					zipcodeUS : "Zip Code must be 0, 5 or 9 digits"	
				},
				'address.0.homePhone' : {
					digits : "Please enter only numbers for Home Phone"
				},
				'address.0.mobilePhone': {
					digits : "Please enter only numbers for Mobile Phone"
				},
				'address.0.beeperNumber': {
					digits : "Please enter only numbers for Beeper Number"
				},
				'address.0.alternatePhone': {
					digits : "Please enter only numbers for Alternate Phone"
				},
				'address.0.faxNumber': {
					digits : "Please enter only numbers for Fax Number"
				},
				'address.0.telephoneNumber': {
					digits : "Please enter only numbers for Telephone Number"
				},
				'address.0.telephoneNumberEx': {
					digits : "Please enter only numbers for Telephone Ext"
				},
				'address.0.businessPhone': {
					digits : "Please enter only numbers for Business Phone"
				}					
			} 
		
		})
	});

	}); 
</script>


			<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
<script>
var grpInnerWindow 
var innerWindowClosed = true;
function closeAllIFrames() {
	if(grpInnerWindow) {
		grpInnerWindow.close()
	}
}
function closeForm() {
	var appName = "${appContext.metadata['app.name']}";
	
	window.location.assign("/"+appName+"/memberMaintenance/list")
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
</script>

		<meta name="layout" content="main_2">
		<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-memberMaster" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
			</ul>
		</div>
		<div id="create-memberMaster" class="content scaffold-create" role="main">
			<h1 style="color: #48802C">Create Member</h1>
			<div class="right-corner" align="center">MEMBR</div>
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
			<g:form action="save" method="post"  id="createForm" name="createForm">
			 <input type="hidden" name="editType" value="${request.getParameter("editType")}">			 
			  <div id="errorDisplay" style="display: none;" class="errors" style="float:left; margin: -5px 10px 0px 0px; "></div>
				<fieldset class="memberMasterForm">
					<g:render template="memberMasterForm"/>
				</fieldset>	
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					<input type="Reset" class="reset" value="Reset" id="resetButton" />
					<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
				</fieldset>
			  <div style="display:none">
				<input type="button" onClick="closeAllIFrames()" id="closeIframes" name="closeIframes">
			  </div>				
			</g:form>
		</div>
	</body>
</html>
