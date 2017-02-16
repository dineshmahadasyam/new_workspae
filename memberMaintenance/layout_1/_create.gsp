<%@ page import="com.perotsystems.diamond.bom.SimpleMember" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'benefitPackage.label', default: 'BenefitPackage')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<script type="text/javascript">var selectedMenuID = "fms_menu_system";   </script>
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="memberMaintenance"/>
		<g:set var="appContext" bean="grailsApplication"/>	

<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>


<script type="text/javascript">
$(document).ready(function(){

	jQuery.validator.addMethod("ssnmaxdigits", function(value, element) {
		if(element.value=="___-__-____"){element.value="";}
		return this.optional(element) || /\d{3}-\d{2}-\d{4}$/.test(value) || /\d{9}$/.test(value)
	}, "SSN must be 9 digits");

	//New validation method to compare date fields.
	jQuery.validator.addMethod("greaterThan",
	function(value, element, params) {
	//params[0]-start date field id
	//params[1]-end date field id
	//params[2]-start date field Name in error message
	//params[3]-end date field Name in error message
	//params[4]-form or tab name used to identify the date field id


		var startYear = params[0]+ "_year";
		var startMonth = params[0]+ "_month";
		var startDay = params[0]+ "_day";

		var endYear = params[1]+ "_year";
		var endMonth = params[1]+ "_month";
		var endDay = params[1]+ "_day";

		var startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
				var endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;

		return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
					&& $(startDay).val().length > 0 && startDate < endDate) ;

	}, jQuery.format("{3} Must be greater than {2}") );

	jQuery.validator.setDefaults({
		ignore: ":hidden",
		debug: true			 
	});

$(function() {		
		$("#createForm").validate({
			submitHandler: function (form) {
				isInvalidForm = 'false';
				  if ($(form).valid()) 
                     form.submit(); 
                  return false; // prevent normal form posting
	        },
	        invalidHandler: function(event, validator) {            
	            isInvalidForm = 'true';     	
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
						ssnmaxdigits: true,
						required : false		
					},
					 'eligHistory.0.effectiveDate' : {
						required : true,
						greaterThan:[ "#memberMaster\\.0\\.dob","#eligHistory\\.0\\.effectiveDate","Date of Birth","Effective Date"]
					},
					'eligHistory.0.eligStatus' : {
						required : true
					},
					'eligHistory.0.benefitStartDate' : {
						required : true,
						greaterThan:[ "#memberMaster\\.0\\.dob","#eligHistory\\.0\\.benefitStartDate","Date of Birth","Benefit Start Date"]
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
					'eligHistory.0.lineOfBusiness' : {
						required : true		
					},
					'eligHistory.0.privacyOn' : {
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
				'eligHistory.0.benefitStartDate' : {
					required : "Please enter a Benefit Start Date."
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
				'eligHistory.0.lineOfBusiness' : {
					required : "Please enter a Line Of Business."	
				},
				'eligHistory.0.privacyOn' : {
					required : "Please select a value for Privacy On"					
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
		
</head>

<g:form action="save" method="post"  id="createForm" name="createForm">
			<input type="hidden" name="editType" value="${request.getParameter("editType")}">			 
				<fieldset class="memberMasterForm">
					<div id="fms_content_header">
				        <div class="fms_content_header_note">
				          <a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / Master Record for Subscriber ID ${subscriberMember.subscriberID}
				        </div>
				        <div class="fms_content_title">
				          <h1>Master Record</h1>
				        </div>
				      </div>
					 <%-- START - Tabs --%>
				     <!-- <div id="fms_content_tabs">
				          <ul>
				            <li><g:link class="active" action="show" id="${subscriberMember.subscriberID}" params="${[editType :'MASTER']}">Master Record</g:link></li>
				          </ul>
				          <div id="mobile_tabs_select"></div>
				        </div>  -->
				      <%-- END - Tabs --%>
					<g:render template="memberMasterForm" />
				</fieldset>		
				</g:form>			
				</div> 
	
</html>