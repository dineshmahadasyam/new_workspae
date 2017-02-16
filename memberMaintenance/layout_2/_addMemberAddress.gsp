<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#memberIdSelectList [disabled] {
	color: #933;
}
label {
	white-space: nowrap;
}
</style>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />

<g:set var="appContext" bean="grailsApplication"/>
	
<title><g:message code="default.show.label" args="[entityName]" /></title>


<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>

<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>



<script type="text/javascript"> 
$(document).ready(function(){

	jQuery.validator.addMethod("HomePhone", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 
	}, "Home Phone must be 0,7 or 10 digits.");
	
	jQuery.validator.addMethod("MobilePhone", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 
	}, "Mobile Phone must be 0,7 or 10 digits.");
	
	jQuery.validator.addMethod("BusinessPhone", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 
	}, "Business Phone must be 0,7 or 10 digits.");
	
	jQuery.validator.addMethod("AlternatePhone", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 
	}, "Alternate Phone must be 0,7 or 10 digits.");
	
	jQuery.validator.addMethod("Telephone", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 
	}, "Telephone must be 0,7 or 10 digits.");
	
	jQuery.validator.addMethod("BeeperNumber", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 || value.length == 40
	}, "Beeper Number must be 0,7,10 or 40 digits.");
	
	jQuery.validator.addMethod("FaxNumber", function(value, element) {
	    value = value.replace(/\s+/g, ""); 
		return this.optional(element) || value.length == 0 || value.length == 7 || value.length == 10 || value.length == 40
	}, "Fax Number must be 0,7,10 or 40 digits.");
	
	jQuery.validator.addMethod("zipcodeUS", function(value, element) {
		return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value)
	}, "Zip Code must be 0, 5 or 9 digits");

		
	jQuery.validator.setDefaults({
	  	debug: true,
		ignore: [],		  
	  success: "valid"
	});
	
$.validator.addMethod("alphanumeric", function(value, element) {
	return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);
}, "Please enter only Letters, numbers or underscores only.");


$(function() {		
		$("#editForm").validate({
			submitHandler: function (form) {
				  if ($(form).valid()) 
                      form.submit(); 
                  return false; // prevent normal form posting
	        },
			errorLabelContainer: "#errorDisplay", 
			 wrapper: "li",		
			rules : {
					 'address.0.effectiveDate' : {
						required : true
					},
					'address.0.addressType' : {
						required : true
					},
					'address.0.address1' : {
						required : true
					},
					'address.0.city' : {
						required : true,
						alphanumeric  : true	
					},
					'address.0.county' : {
						alphanumeric  : true		
					},
					'address.0.country' : {
						alphanumeric  : true		
					},
					'address.0.state' : {
						required : true		
					},
					'address.0.zip' : {
						required : true,
						zipcodeUS : true
					},
					'address.0.homePhone' : {
						digits : true,						
						HomePhone: true
							
					},
					'address.0.mobilePhone': {
						digits : true,
						MobilePhone : true	
					},
					'address.0.beeperNumber': {
						digits : true,
						BeeperNumber : true	
					},
					'address.0.alternatePhone': {
						digits : true,
						AlternatePhone : true	
					},
					'address.0.faxNumber': {
					required: { depends : function() {					
							return (document.getElementById("address.0.contactPref").selectedIndex == 2)
					}
					},
						digits : true,
						FaxNumber : true	
					},
					'address.0.telephoneNumber': {
						digits : true,
						Telephone : true	
					},
					'address.0.telephoneNumberEx': {
						digits : true							
					},
					'address.0.businessPhone': {
						digits : true,
						BusinessPhone : true	
					},
					'address.0.lastName' : {
						alphanumeric  : true	
					},					
					'address.0.firstName' : {
					    alphanumeric  : true	
					},
					'address.0.middleName' : {
					    alphanumeric  : true	
					},
					'address.0.userDefined1' : {
					    alphanumeric  : true	
					},
					'address.0.userDefined2' : {
					    alphanumeric  : true	
					},
					'address.0.countrySubdivisionCode' : {
						digits  : true	
					},
					'address.0.employeridNumber' : {
					    alphanumeric  : true	
					},
					'address.0.nationalIndividNumber' : {
					    alphanumeric  : true	
					},
					'address.0.beneficiaryRelationShip' : {
					    alphanumeric  : true	
					},
					'address.0.email' : {
						required: { depends : function() {					
								return (document.getElementById("address.0.contactPref").selectedIndex == 1)
						}},
						email  : true		
					}
									
		},
			messages : {
				'address.0.effectiveDate' : {
					required : "Please select a Effective Date"
				}
				,'address.0.addressType': {
					required : "Please select a Address Type"						
				}
				,'address.0.address1' : {
					required : "Please enter a value for  Address 1"						
				}
				,'address.0.city' : {
					required : "Please enter a value for City" ,
					alphanumeric : "Please enter only Letters, numbers or underscores only for City"				
				}
				,'address.0.county' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for County"					
				}
				,'address.0.country' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for Country"					
				}
				,'address.0.state' : {
					required : "Please select a value for State"					
				}
				,'address.0.zip' : {
					required : "Please enter a value for Zip Code" ,
					zipcodeUS : "Zip Code must be 0, 5 or 9 digits"			
				},
				'address.0.homePhone' : {
					digits : "Please enter only numbers for Home Phone"
				},'address.0.mobilePhone': {
					digits : "Please enter only numbers for Mobile Phone"	
				}
				,'address.0.beeperNumber': {
					digits : "Please enter only numbers for Beeper Number"	
				}
				,'address.0.alternatePhone': {
					digits : "Please enter only numbers for Alternate Phone"	
				}
				,'address.0.faxNumber': {
				    required : "Please enter an faxNumber as contact preference is set as Fax.",
					digits : "Please enter only numbers for Fax Number"	
				}
				,'address.0.telephoneNumber': {
					digits : "Please enter only numbers for Telephone Number"	
				}
				,'address.0.telephoneNumberEx': {
					digits : "Please enter only numbers for Telephone Ext"
				}
				,'address.0.businessPhone': {
					digits : "Please enter only numbers for Business Phone"	
				}
				,'address.0.lastName' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for Last Name"
			    }
				,'address.0.firstName' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for First Name"
			    }				
				,'address.0.middleName' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for Middle Name"
			    }
				,'address.0.userDefined1' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for UserDefined1"
			    }
				,'address.0.userDefined2' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for UserDefined2"
			    }
				,'address.0.countrySubdivisionCode' : {
					digits :"Please enter only numbers for Country Sub Division Code"	
			    }
			    ,'address.0.employeridNumber' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for Emp ID Number"
			    }
			    ,'address.0.nationalIndividNumber' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for Nat. Ind. ID Number"
			    }
			    ,'address.0.beneficiaryRelationShip' : {
					alphanumeric : "Please enter only Letters, numbers or underscores only for Ben Rel Code"
			    }
			    ,'address.0.email' : {
			    	required : "Please enter an email Id as contact preference is set as Email.", 
					email : "Please enter a valid email id."
			    }
				
			} 
			 
		})
	});

	}); 

$(function($){
	   $(".SSNAddNew").mask("999-99-9999");
	   $(".ZipAddNew").mask("99999?-9999");
	})
	
	 </script>

<style type="text /css">#report changed {
	color: blue;
}

#report {
	border-collapse: collapse;
}

#report div {
	background: #C7DDEE
}

#report h4 {
	margin: 0px;
	padding: 0px;
}

#report img {
	float: right;
}

#report ul {
	margin: 10px 0 10px 40px;
	padding: 0px;
}

#report td {none repeat-x scroll center left;
	color: #000;
	padding: 2px 15px;
}

#report tr.hideme {
	background: #C7DDEE none repeat-x scroll center left;
	color: #000;
	padding: 7px 15px;
}

#report td.clickme td {
	background: #fffff repeat-x scroll center left;
	cursor: pointer;
}

#report div.arrow {
	background: transparent url(arrows.png) no-repeat scroll 0px -16px;
	width: 16px;
	height: 16px;
	display: block;
}

#report div.up {
	background-position: 0px 0px;
}

#tdFormElement td {
	align: left
}

#tdnoWrap td {
	white-space: nowrap
}
</style>


<script>
	function closeForm() {
		var appName = "${appContext.metadata['app.name']}";
	
		window.location.assign("/"+appName+"/memberMaintenance/list")
	}
	var grpInnerWindow
	var innerWindowClosed = true;
	function closeAllIFrames() {
		if (grpInnerWindow) {
			grpInnerWindow.close()
		}
	}

	function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds,
			assocFieldCdoName, updateFields, updateFieldsCdoName) {
		var htmlElementValue
		var assocHTMLElementsValue = ""
		htmlElementValue = document.getElementById(idName).value
		//alert (assocFieldIds)
		if (assocFieldIds) {
			if (assocFieldIds.indexOf('|') == -1) {
				if (document.getElementById(assocFieldIds)
						&& document.getElementById(assocFieldIds).value != "undefined") {
					assocHTMLElementsValue = document
							.getElementById(assocFieldIds).value
				}
			} else {
				var nameArray = assocFieldIds.split("|")
				for ( var i = 0; i < nameArray.length; i++) {
					if (document.getElementById(nameArray[i])
							&& document.getElementById(nameArray[i]).value != "undefined") {
						//		alert (document.getElementById(nameArray[i]).value)
						assocHTMLElementsValue += document
								.getElementById(nameArray[i]).value
								+ "|"
					}
				}
			}
		}
		//alert("assocHTMLElementsValue = "+assocHTMLElementsValue )
		var appName = "${appContext.metadata['app.name']}";
		
		var urlValue = "/"+appName+"/lookUp/lookUp?htmlElementIdName="
				+ idName
				+ "&htmlElementValue="
				+ htmlElementValue
				+ "&cdoClassName="
				+ cdoClassName
				+ "&cdoClassAttributeName="
				+ cdoClassAttributeName
				+ (assocFieldIds ? "&assocFields=" + assocFieldIds : "")
				+ (assocFieldCdoName ? "&assocFieldCdoName="
						+ assocFieldCdoName : "")
				+ (assocHTMLElementsValue ? "&assocFieldValue="
						+ assocHTMLElementsValue : "")
				+ (updateFieldsCdoName ? "&updateFieldsCdoName="
						+ updateFieldsCdoName : "")
				+ (updateFields ? "&updateFields=" + updateFields : "")
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
				scrollable : false,
				url : urlValue,
				onClose : function(wnd) { // a callback function while user click close button
					innerWindowClosed = true;
				}
			});
		}
	}
</script>
</head>
<body>
	<a href="#show-memberMaster" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}"
					params="${[editType :'MASTER']}">Master Record</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}"
					params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}"
					params="${[editType :'ADDRESS']}">Addresses</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}"
					params="${[editType :'BILLING']}">Billing</g:link></li>
		</ul>
		<ul>
		    <li><g:link class="list" action="show"
					id="${params.subscriberID}"
					params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
			 <li><g:link class="list" action="show"
					id="${params.subscriberID}"
					params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">MEMMC LIS Info</g:link></li>
		</ul>
	</div>
	<div id="show-memberMaster" class="content scaffold-show" role="main">
		&nbsp;
		<h1 style="color: #48802C">
			Add Address to Member :
			${params.susbcriberId }
			Person Number :
			${ params.personNumber }
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:if test="${fieldErrors}">
			<ul class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>${error}</li>
				</g:each>
			</ul>
			</g:if>
		<div id="errorDisplay" style="display: none;" class="errors"
			style="float:left; margin: -5px 10px 0px 0px; "></div>

		<g:form action="saveAddress" id="editForm" name="editForm">
			<input type="hidden" name="memberDBID" value="${params.memberDBID}" />
			<input type="hidden" name="personNumber"
				value="${params.personNumber}" />
			<input type="hidden" name="subscriberId"
				value="${params.susbcriberId }" />
			
			
			<table>
				<tr>
					<td>
						<table border="0" id="report">
							<tr class="showme">
								<td colspan="13">
									<div class="divContent">
										<table class="report1"  border="0" style="table-layout:fixed;">
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.addressType', 'error')} ">
														<label for="effectiveDate"> <g:message
																code="subscriberMember.addressType.label"
																default="Address Type :" />
															<span
															class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:getSystemCodeToken
														systemCodeType="ADDRESSTYPE" languageId="0"
														htmlElelmentId="address.0.addressType"
														blankValue="Address Type"
														defaultValue="${address?.addressType}" width="150px" />
												</td>
												
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.billingAddress', 'error')} ">
														<label for="billingAddress"> <g:message
																code="subscriberMember.billingAddress.label"
																default="Billing Address :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><select name="address.0.billingAddress">
													<option value="Y" ${address.billingAddress.equals('Y') ? 'selected':'' }>Yes</option>
													<option value="N" ${address.billingAddress.equals('N') ? 'selected':'' }>No</option>
												</select></td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.contactPref', 'error')} ">
														<label for="contactPref"> <g:message
																code="subscriberMember.contactPref.label"
																default="Contact Pref :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2">
													<g:getDiamondDataWindowDetail columnName="contact_pref"
														dwName="dw_memba_de" languageId="0"
														htmlElelmentId="address.0.contactPref"
														defaultValue="${address?.contactPref}"
														blankValue="Contact Pref" size="150px"/>
												</td>

											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.effectiveDate', 'error')} ">
														<label for="effectiveDate"> <g:message
																code="subscriberMember.effectiveDate.label"
																default="Effective Date :" />
															<span
															class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" colspan="2">
												<%--CQ 57526 started --%>
											     <g:datePicker name="address.0.effectiveDate" precision="day"
														noSelection="['':'']" default="none" value="${address?.effectiveDate}" /></td>
												<%--CQ 57526 Ended --%>
												</td>
										  </tr>
											  <tr>

												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.termDate', 'error')} ">
														<label for="termDate"> <g:message
																code="subscriberMember.termDate.label"
																default="Term Date :" value="${address?.termDate}"/>

														</label>
													</div>
												</td>
												<td class="tdFormElement" colspan="2">
												<%--CQ 57526 started --%>
												 <g:datePicker name="address.0.termDate"
														precision="day" noSelection="['':'']" default="none" /></td>
												<%--CQ 57526 Ended --%>
												</td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.termReason', 'error')} ">
														<label for="termReason"> <g:message
																code="subscriberMember.termReason.label"
																default="Term Reason :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.termReason" value="${address?.termReason}"
														maxlength="5" /> <img width="25" height="25"
													style="float: none; vertical-align: bottom"
													class="magnifying" src="${resource(dir: 'images', file: 'Search-icon.png')}"
													onclick="lookup('address.0.termReason', 'com.perotsystems.diamond.dao.cdo.ReasonCodeMaster','reasonCode')">
												</td>
											</tr>
										</table>
										<hr />
										<table  border="0" style="table-layout:fixed;">
											<tr>
												<td class="tdnoWrap">
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.lastName', 'error')} ">
														<label for="lastName"> <g:message
																code="subscriberMember.lastName.label"
																default="Last Name :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.lastName" 
														maxlength="60" style="width:50%" value="${address.lastName }"/></td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.firstName', 'error')} ">
														<label for="firstName"> <g:message
																code="subscriberMember.firstName.label"
																default="First Name:" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.firstName"
														maxlength="60" style="width:50%" value="${address.firstName }" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.middleName', 'error')} ">
														<label for="middleName"> <g:message
																code="subscriberMember.middleName.label"
																default="Middle:" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.middleName"
														maxlength="25" style="width:50%" value="${address.middleName }"  /></td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.address1', 'error')} ">
														<label for="address1"> <g:message
																code="subscriberMember.address1.label"
																default="Address 1:" />
															<span
															class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.address1"
														style="width:50%" maxlength="60" value="${address.address1 }"/></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.address2', 'error')} ">
														<label for="address2"> <g:message
																code="subscriberMember.address2.label"
																default="Address 2:" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.address2"
														style="width:50%" maxlength="60" value="${address.address2 }"/></td>
											</tr>
											
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine3', 'error')} ">
														<label for="addressLine3"> <g:message
																code="subscriberMember.addressLine3.label" default="Address 3:" />
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.addressLine3" maxlength="60"
														value="${address.addressLine3 }" style="width:50%" />
												</td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine4', 'error')} ">
														<label for="addressLine4"> <g:message
																code="subscriberMember.addressLine4.label" default="Address 4:" />
			
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.addressLine4" maxlength="60"
														value="${address.addressLine4 }" style="width:50%" /></td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine5', 'error')} ">
														<label for="addressLine5"> <g:message
																code="subscriberMember.addressLine5.label" default="Address 5:" />
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.addressLine5" maxlength="60"
														value="${address.addressLine5 }" style="width:50%" />
												</td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.addressLine6', 'error')} ">
														<label for="addressLine6"> <g:message
																code="subscriberMember.addressLine6.label" default="Address 6:" />
			
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.addressLine6" maxlength="60"
														value="${address.addressLine6 }" style="width:50%" /></td>
											</tr>
											
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.city', 'error')} ">
														<label for="city"> <g:message
																code="subscriberMember.city.label" default="City :" />
															<span
															class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.city" value="${address?.city}"
														maxlength="30" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.state', 'error')} ">
														<label for="groupState"> <g:message
																code="subscriberMember.groupState.label"
																default="State :" />
															<span
															class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:select name="address.0.state"
														optionKey="stateCode" optionValue="stateName"
														id="state.name" from="${states}"
														noSelection="['':'-- Select a State --']" value="${address.state}"></g:select>
												</td>
											</tr>
											<tr>

												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.county', 'error')} ">
														<label for="county"> <g:message
																code="subscriberMember.county.label" default="County :" />
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.county"
														maxlength="30" style="width:50%" value="${address?.county}" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.country', 'error')} ">
														<label for="country"> <g:message
																code="subscriberMember.country.label"
																default="Country :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.country"
														maxlength="30" style="width:50%" value="${address?.country}"/></td>
											</tr>

											<tr>
												<td>&nbsp;</td>
												<td colspan="2">&nbsp;</td>
												
												<td class="tdWrapCondition">
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.countrySubdivisionCode', 'error')} ">
														<label for="countrySubdivisionCode"><g:message
																code="subscriberMember.countrySubdivisionCode.label"
																default="Country Sub Division Code :" />
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.countrySubdivisionCode" 
														maxlength="3" value="${address?.countrySubdivisionCode}"/></td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.zip', 'error')} ">
														<label for="zipCode"> <g:message
																code="subscriberMember.zipCode.label"
																default="Zip Code :" />
															<span
															class="required-indicator">*</span>
														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.zip"
														maxlength="10" class="ZipAddNew" value="${address?.zip}" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.email', 'error')} ">
														<label for="email"> <g:message
																code="subscriberMember.email.label" default="Email Id :"
																style="width:50%" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.email"
														maxlength="80" value="${address?.email}" /></td>
											</tr>
										</table>
										<hr />
										<table  border="0" style="table-layout:fixed;">
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.homePhone', 'error')} ">
														<label for="homePhone"> <g:message
																code="subscriberMember.homePhone.label"
																default="Home Phone :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.homePhone"
														maxlength="40" style="width:50%" value="${address?.homePhone}" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.mobilePhone', 'error')} ">
														<label for="mobilePhone"> <g:message
																code="subscriberMember.mobilePhone.label"
																default="Mobile Phone :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.mobilePhone" value="${address?.mobilePhone}" 
														maxlength="40" style="width:50%" /></td>
											</tr>

											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.businessPhone', 'error')} ">
														<label for="businessPhone"> <g:message
																code="subscriberMember.businessPhone.label"
																default="Business Phone :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.businessPhone" maxlength="40"
														style="width:50%" value="${address?.businessPhone}" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.beeperNumber', 'error')} ">
														<label for="beeperNumber"> <g:message
																code="subscriberMember.beeperNumber.label"
																default="Beeper Number :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.beeperNumber"
														maxlength="40" style="width:50%" value="${address?.beeperNumber}"/></td>
											</tr>

											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.alternatePhone', 'error')} ">
														<label for="alternatePhone"> <g:message
																code="subscriberMember.alternatePhone.label"
																default="Alternate Phone :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.alternatePhone" maxlength="40"
														style="width:50%" value="${address?.alternatePhone}" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.faxNumber', 'error')} ">
														<label for="faxNumber"> <g:message
																code="subscriberMember.faxNumber.label"
																default="Fax Number :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField name="address.0.faxNumber"
														maxlength="40" style="width:50%" value="${address?.faxNumber}"/></td>
											</tr>


											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.telephoneNumber', 'error')} ">
														<label for="telephoneNumber"> <g:message
																code="subscriberMember.telephoneNumber.label"
																default="Telephone :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.telephoneNumber" maxlength="40" value="${address?.telephoneNumber}"
														style="width:50%" /></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.telephoneNumberEx', 'error')} ">
														<label for="telephoneNumberEx"> <g:message
																code="subscriberMember.telephoneNumberEx.label"
																default="Tel Ext :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.telephoneNumberEx" style="width:50%" maxlength="40" value="${address?.telephoneNumberEx}" /></td>
											</tr>
										</table>
										<hr />
										<table  border="0" style="table-layout:fixed;">
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.prefixName', 'error')} ">
														<label for="prefixName"> <g:message
																code="subscriberMember.prefixName.label"
																default="Prefix :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2">
													<g:getCdoSelectBox cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
														cdoAttributeWhereValue="S"
														cdoAttributeWhere="titleType"
														cdoAttributeSelect="contactTitle"
														cdoAttributeSelectDesc="description"
														languageId="0"
														htmlElelmentId="address.0.prefixName"
														defaultValue="${address?.prefixName}"
														blankValue="Prefix" 
														width="150px"/>
													</td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.suffixName', 'error')} ">
														<label for="suffixName"> <g:message
																code="subscriberMember.suffixName.label"
																default="Suffix :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2">
													<g:getCdoSelectBox cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
														cdoAttributeWhereValue="F"
														cdoAttributeWhere="titleType"
														cdoAttributeSelect="contactTitle"
														cdoAttributeSelectDesc="description"
														languageId="0"
														htmlElelmentId="address.0.suffixName"
														defaultValue="${address?.suffixName}"
														blankValue="Suffix" 
														width="150px"/>
												</td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.socialSecurityNumber', 'error')} ">
														<label for="socialSecurityNumber"> <g:message
																code="subscriberMember.socialSecurityNumber.label"
																default="SSN :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.socialSecurityNumber" class="SSNAddNew" maxlength="11" value="${address?.socialSecurityNumber}"  /></td>

											</tr>
										</table>
										<hr />
										<table  border="0" style="table-layout:fixed;">
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.employeridNumber', 'error')} ">
														<label for="employeridNumber"> <g:message
																code="subscriberMember.employeridNumber.label"
																default="Emp ID Number :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.employeridNumber" maxlength="80" value="${address?.employeridNumber}"  /></td>
												<td class="tdWrapCondition" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.nationalIndividNumber', 'error')} ">
														<label for="nationalIndividNumber"> <g:message
																code="subscriberMember.nationalIndividNumber.label"
																default="Nat. Ind. ID Number :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.nationalIndividNumber" maxlength="80" value="${address?.nationalIndividNumber}" /></td>
											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.beneficiaryRelationShip', 'error')} ">
														<label for="beneficiaryRelationShip"> <g:message
																code="subscriberMember.beneficiaryRelationShip.label"
																default="Ben Rel Code :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2"><g:textField
														name="address.0.beneficiaryRelationShip" maxlength="1" value="${address?.beneficiaryRelationShip}"/></td>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.beneficiaryGender', 'error')} ">
														<label for="beneficiaryGender"> <g:message
																code="subscriberMember.beneficiaryGender.label"
																default="Ben Gender :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" 
													colspan="2">
													<g:getDiamondDataWindowDetail columnName="gender"
														dwName="dw_edied_de" languageId="0"
														htmlElelmentId="address.0.beneficiaryGender"
														defaultValue=""
														blankValue="Benificiary Gender" 
														width="150px"/>
													</td>

											</tr>
											<tr>
												<td class="tdnoWrap" >
													<div
														class="fieldcontain ${hasErrors(bean: address, field: 'address.beneficiaryDOB', 'error')} ">
														<label for="beneficiaryDOB"> <g:message
																code="subscriberMember.beneficiaryDOB.label"
																default="Ben DOB :" />

														</label>
													</div>
												</td>
												<td class="tdFormElement" colspan="2">
													<fmsui:jqDatePicker dateElementId="address.0.beneficiaryDOB" 
																dateElementName="address.0.beneficiaryDOB"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (address?.beneficiaryDOB != null ? address?.beneficiaryDOB.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100' , maxDate:0" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.beneficiaryDOB)}"/>
													</td>

											</tr>
										</table>
							<hr />
							<table  border="0" style="table-layout:fixed;">
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined1', 'error')} ">
											<label for="userDefined1"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_1_t" defaultText="User Defined 1:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2"><g:textField name="address.0.userDefined1"
											maxlength="30" style="width:50%" value="${address?.userDefined1}" /></td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate1', 'error')} ">
											<label for="userDate1"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_1_t" defaultText="User Date 1:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" colspan="2">
										<fmsui:jqDatePicker dateElementId="address.0.userDate1" 
																dateElementName="address.0.userDate1"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (address?.userDate1 != null ? address?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate1)}"/>
									</td>
								</tr>
								<tr>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDefined2', 'error')} ">
											<label for="userDefined2"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_2_t" defaultText="User Defined 2:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" 
										colspan="2"><g:textField name="address.0.userDefined2"
											maxlength="30" style="width:50%" value="${address?.userDefined2}" /></td>
									<td class="tdnoWrap" >
										<div
											class="fieldcontain ${hasErrors(bean: address, field: 'address.userDate2', 'error')} ">
											<label for="userDate2"> 
												<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_2_t" defaultText="User Date 2:"/>
											</label>
										</div>
									</td>
									<td class="tdFormElement" colspan="2">
										<fmsui:jqDatePicker dateElementId="address.0.userDate2" 
																dateElementName="address.0.userDate2"
																datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (address?.userDate2 != null ? address?.userDate2.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100'" 
																dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate2)}"/>
									</td>
								</tr>


							</table>
							</div>
							</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<fieldset class="buttons">
				<g:actionSubmit class="save" action="saveAddress"
					value="${message(code: 'default.button.update.label', default: 'List')}" />
				<input type="Reset" class="reset" value="Reset" id="resetButton" />
				<input type="button" class="close" name="close" value="Close"
					onClick="closeForm()">
			</fieldset>
		</g:form>
	</div>

	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>

</body>
</html>