<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
		
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_ADD_ADDRESS.equals(currentPage)?true:false}" />
		
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="memberMaintenance"/>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script> 
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>

		<script type="text/javascript"> 
			$(document).ready(function(){
			/**
				$('.UseMemberName').click(function(e) {
				       // var $this = $(this);
				       
				       if ( $(e.target).is(':checked') ) {
				         $('.FirstName, .LastName').attr('disabled', 'disabled');                  
				       } else {
				         $('.FirstName, .LastName').removeAttr( "disabled" );
				       }
				   });*/
			
				jQuery.validator.addMethod("HomePhone", function(value, element) {
					return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
				}, "Home Phone must be 10 digits");
				
				jQuery.validator.addMethod("MobilePhone", function(value, element) {
					return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
				}, "Mobile Phone must be 10 digits");
				
				jQuery.validator.addMethod("BusinessPhone", function(value, element) {
					return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
				}, "Business Phone must be 10 digits");
				
				jQuery.validator.addMethod("AlternatePhone", function(value, element) {
					return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
				}, "Alternate Phone must be 10 digits");
				
				jQuery.validator.addMethod("Telephone", function(value, element) {
					return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
				}, "Telephone Number must be 10 digits");
				
				jQuery.validator.addMethod("BeeperNumber", function(value, element) {
					return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
				}, "Beeper Number must be 10 digits");
				
				jQuery.validator.addMethod("FaxNumber", function(value, element) {
					return this.optional(element) || /^\(\d{3}\)\s?\d{3}-\d{4}$/.test(value)
				}, "Fax Number must be 10 digits");
				
				jQuery.validator.addMethod("zipcodeUS", function(value, element) {
					return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value)
				}, "Zip Code must be 5 or 9 digits");
					
				jQuery.validator.setDefaults({
					ignore: ":hidden",
					debug: true			 
				});
					
				$.validator.addMethod("alphanumeric", function(value, element) {
					return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);
				}, "Please enter only Letters, numbers or underscores only.");
				
				$(function() {		
					$("#editForm").validate({
						onfocusout: false,
						submitHandler: function (form) {
							  if ($(form).valid()) 
			                      form.submit(); 
			                  return false; // prevent normal form posting
				        },
				      //jQuery validate selects the first invalid element or the last focused invalid element
				        //The code below will set focus to first element that fails
				        invalidHandler: function(form, validator) {
				            var errors = validator.numberOfInvalids();
				            if (errors) {      
					            //Hide any previous message from the server when the client validation is occuring
				            	$(".message").hide();              
				                validator.errorList[0].element.focus();
				            }
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
									HomePhone: true
								},
								'address.0.mobilePhone': {
									MobilePhone : true	
								},
								'address.0.beeperNumber': {
									BeeperNumber : true	
								},
								'address.0.alternatePhone': {
									AlternatePhone : true	
								},
								'address.0.faxNumber': {
									required: { depends : function() {					
										return (document.getElementById("address.0.contactPref").selectedIndex == 2)
									}
								},
									FaxNumber : true	
								},
								'address.0.telephoneNumber': {
									Telephone : true	
								},
								'address.0.businessPhone': {
									BusinessPhone : true	
								},
								'address.0.lastName' : {
									required : true,
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
								zipcodeUS : "Zip Code must be 5 or 9 digits"			
							},
							'address.0.homePhone' : {
								HomePhone: "Home Phone must be 10 digits"
							},
							'address.0.mobilePhone': {
								MobilePhone : "Mobile Phone must be 10 digits"	
							}
							,'address.0.beeperNumber': {
								BeeperNumber : "Beeper Number must be 10 digits"
							}
							,'address.0.alternatePhone': {
								AlternatePhone : "Alternate Phone must be 10 digits"
							}
							,'address.0.faxNumber': {
							    required : "Please enter an faxNumber as contact preference is set as Fax.",
								FaxNumber : "Fax Number must be 10 digits"
							}
							,'address.0.telephoneNumber': {
								Telephone : "Telephone Number must be 10 digits"
							}
							,'address.0.businessPhone': {
								BusinessPhone : "Business Phone must be 10 digits"
							}
							,'address.0.lastName' : {
								required : "Please enter a value for Last Name" ,
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
	 	</script>

		<script>
		
			function closeForm() {
				var subscriberId = "${params.susbcriberId}";
				var appName = "${appContext.metadata['app.name']}";
			
				window.location.assign("/"+appName+"/memberMaintenance/show?subscriberId="
						+ subscriberId + "&editType=ADDRESS");
			}
			var grpInnerWindow
			var innerWindowClosed = true;
			function closeAllIFrames() {
				if (grpInnerWindow) {
					grpInnerWindow.close()
				}
			}
		
		</script>
	</head>

	<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
	    	<div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / 
	      		<g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'ADDRESS']}">Addresses</g:link>
	      			/ New Address for Subscriber ${params.susbcriberId } Person Number : ${ params.personNumber }
	  		</div>
		  	<div class="fms_content_title">
	          	<h1>Add New Address</h1>
	        </div>
		</div> 
		
		<%-- START - Tabs --%>
        <div id="fms_content_tabs">
          	<ul>
	            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${params.susbcriberId}" params="${[subscriberId: params.susbcriberId, personNumber: params.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MASTER']}">Master Record</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
	            <li><g:link class="active" action="show" id="${params.susbcriberId}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BILLING']}">Billing</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
          	</ul>
          	<div id="mobile_tabs_select"></div>
        </div>
      	<%-- END - Tabs --%>
		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
			<div class="right-corner" align="right">MEMBA</div>
			<div class="fms_required_legend fms_required">= required</div> 
	 	  	<div class="fms_form_border">
	    		<div class="fms_form_body fms_form_border">
				
					<%-- Error messages start--%>
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
					<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
					<%-- Error messages end--%>
				
					<div id="show-memberMaster" class="content scaffold-show" role="main">
					&nbsp;
					
					<g:form action="saveAddress" id="editForm" name="editForm">
						<input type="hidden" name="memberDBID" value="${params.memberDBID}" />
						<input type="hidden" name="personNumber"
							value="${params.personNumber}" />
						<input type="hidden" name="subscriberId"
							value="${params.susbcriberId }" />
					
				
						<!-- START - WIDGET: General Information -->
		    			<div id="widgetGeneral" class="fms_widget">
				 			<fieldset class="no_border">
		
		                  		<legend><h2>General Information</h2></legend>
		                  		<div class="fms_form_layout_2column">                  
		                    		<div class="fms_form_column fms_very_long_labels">
		
		               					<label id="AddressType_r2_label" for="addressType" class="control-label fms_required" >
											<g:message code="address.addressType.label" default="Address Type:" />
										</label>
										
										<div class="fms_form_input">
		                                   	<g:getSystemCodeToken
												cssClass="form-control"
												systemCodeType="ADDRESSTYPE" languageId="0"
												htmlElelmentId="address.0.addressType"
												blankValue="Address Type" 
												defaultValue="${address?.addressType}"
												title="Type of Address">
												</g:getSystemCodeToken>
		                                   	<div class="fms_form_error" id="AddressType_r2_error"></div>
		                              	</div>
		                              	
										<label class="control-label" id="ContractPref_r2_label" for="contactPref"> 
		                                 		<g:message code="subscriberMember.contactPref.label" default="Contact Pref:" />
										</label>
		                               	<div class="fms_form_input">
		                                 	<g:getDiamondDataWindowDetail 
		                                 		columnName="contact_pref" dwName="dw_memba_de" 
		                                 		languageId="0" cssClass="form-control"
												htmlElelmentId="address.0.contactPref"
												defaultValue="${address?.contactPref}"
												blankValue="Contact Pref" 
												title="Preference of the Contact"/>
		                                 	<div class="fms_form_error" id="ContractPref_r2_error"></div>
		                               	</div>
											
										<label class="control-label" id="billingAddress_label" for="billingAddress"> 
											<g:message code="subscriberMember.billingAddress.label" default="Billing Address:" />
										</label>
										<div class="fms_form_input">
											<select class="form-control fms_width_auto" name="address.0.billingAddress"
												title="If this is the Billing Address choose Y else choose N">
												<option value="Y" ${address.billingAddress.equals('Y') ? 'selected':'' }>Yes</option>
												<option value="N" ${address.billingAddress.equals('N') ? 'selected':'' }>No</option>
											</select>
											<div class="fms_form_error" id="billingAddres_error"></div>
										</div>
									</div>

									<div class="fms_form_column fms_very_long_labels">
		                              	<label for="effectiveDate"class="control-label fms_required" id="effectiveDate_label" > 
		                              		<g:message code="subscriberMember.effectiveDate.label" default="Effective Date:" />
		                              	</label>
		                              	<div class="fms_form_input">
		                                  	<fmsui:jqDatePickerUIUX  
		                                  		datePickerOptions="changeMonth: true, changeYear: true, yearRange: '-100:+100', numberOfMonths: 1" 
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.effectiveDate)}"
		                                  		dateElementId="address.0.effectiveDate" 
		                                  		dateElementName="address.0.effectiveDate" 
		                                        ariaAttributes="aria-labelledby='effectiveDate_label' aria-describedby='effectiveDate_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"
		                                        title="Effective Date of the Address"/> 
		                                  	<div class="fms_form_error" id="effectiveDate_error"></div>
		                                </div>
		                               
		                           		<label for="termDate" class="control-label" id="termDate_label"> 
		                                	<g:message code="subscriberMember.termDate.label" default="Term Date:" />
										</label>
										<div class="fms_form_input">
		                                  	<fmsui:jqDatePickerUIUX  
		                                  		datePickerOptions="changeMonth: true, changeYear: true, yearRange: '-100:+100', numberOfMonths: 1" 
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.termDate)}" 
		                                  		dateElementId="address.0.termDate" 
		                                  		dateElementName="address.0.termDate" 
		                                        ariaAttributes="aria-labelledby='termDate_label' aria-describedby='termDate_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"
		                                        title="Termination Date of the Address"/> 
		                                  	<div class="fms_form_error" id="termDate_error"></div>
		                                </div>
										
										<label for="termReason" class="control-label" id="TermReason_r2_label" > 
		                                	<g:message code="subscriberMember.termReason.label" default="Term Reason:" />
		                                </label>
													
		                                <div class="fms_form_input fms_has_feedback">
		                                	<g:textField 
		                                		class="form-control"
		                                		name="address.0.termReason" value="${address?.termReason}"
												maxlength="5" 
												title="The Reason the Address is terminated"/>
											<fmsui:cdoLookup 
												lookupElementId="address.0.termReason"
												lookupElementName="address.0.termReason" 
												lookupElementValue="${address?.termReason}"
												lookupCDOClassName="com.perotsystems.diamond.dao.cdo.ReasonCodeMaster"
												lookupCDOClassAttribute="reasonCode"/>		
											<div class="fms_form_error" id="termReason_error"></div>	
		                                </div>
		                           	</div>
		                       	</div>
		                  	</fieldset>
		               	</div>	
						<!-- END - WIDGET: General Information -->
						
						<!-- START - WIDGET: Address -->		
						<div class="fms_widget">        
		                    <fieldset class="no_border">
		                       	<legend><h3>Address</h3></legend>
		                         <div class="fms_form_layout_2column">                  
		                           	<div class="fms_form_column fms_very_long_labels">
		
										<!-- <label class="control-label fms_form_input fms_checkbox_offset UseMemberName"><input type="checkbox" name="" value="" checked="checked" /> Use member name for address.</label> -->
			
										<label for="lastName" class="control-label fms_required" id="LastName_r2_label" > 
											<g:message code="subscriberMember.lastName.label" default="Last Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField maxlength="60"
												name="address.0.lastName" 
												value="${address?.lastName}" 
												class="form-control fms-alphanumeric"
												title="Last Name of the Contact for the Address"/>
		                                   	<div class="fms_form_error" id="LastName_r2_error"></div>
		                              	</div> 	
													
										<label for="firstName"class="control-label" id="FirstName_r2_label"> 
											<g:message code="subscriberMember.firstName.label" default="First Name:" />
									 	</label>
										
		                                <div class="fms_form_input">                                     	
		                                   	<g:textField 
		                                   		name="address.0.firstName"
		                                   		class="form-control fms-alphanumeric" 
		                                   		value="${address?.firstName}" 
		                                   		title="First Name of the Contact for the Address"/>
		                                   	<div class="fms_form_error" id="FirstName_r2_error"></div>
		                               	</div> 
		                              	
		                              	<label class="control-label" id="middleName_label" for="middleName"> 
		                           			<g:message code="subscriberMember.middleName.label" default="Middle:" />
										</label>
		                             		<div class="fms_form_input">
											<g:textField 
												name="address.0.middleName" 
												tableName="MEMBER_ADDRESS" attributeName="middleName"
												maxlength="25"
												value="${address?.middleName}" 
												type="text" 
												class="form-control" 
												id="address.0.middleName" 
												title="Middle Initial or Middle Name of the Contact for the Address"
												aria-labelledby="middleName_label" 
												aria-describedby="middleName_error" 
												aria-required="false" />
											<div class="fms_form_error" id="middleName_error"></div>
										</div>	
										
		                           		<label for="addressLine1" class="control-label fms_required" id="addressLine1_label"> 
		                           			<g:message code="subscriberMember.address1.label" default="Address 1:" />
										</label>				
		                               	<div class="fms_form_input">
		                                 	<g:textField
		                                 		name="address.0.address1" maxlength="60"
		                                 		value="${address?.address1}" 
			                                 	class="form-control" 
			                                 	title="Line 1 Address"/>
		                                 	<div class="fms_form_error" id="addressLine1_error"></div>
		                              	</div> 
		                              	
										<label class="control-label" id="addressLine2_label" for="address2"> 
											<g:message code="subscriberMember.address2.label" default="Address 2:" />		
										</label>		
		                              	<div class="fms_form_input">
		                                 	<g:textField 
				                                 name="address.0.address2" 
				                                 value="${address?.address2}" 
				                                 maxlength="60"
				                                 class="form-control" 
				                                 title="Line 2 Address"/>
		                                 	<div class="fms_form_error" id="addressLine2_error"></div>
		                              	</div> 
		                              	
		                              	<label class="control-label" id="addressLine3_label" for="addressLine3"> 
		                              		<g:message code="subscriberMember.addressLine3.label" default="Address 3:" />
										</label> 
										<div class="fms_form_input">
											<g:textField 
											name="address.0.addressLine3" maxlength="60"
											value="${address?.addressLine3}" 
											class="form-control" 
											title="Line 3 Address"/>
											<div class="fms_form_error" id="addressLine3_error"></div>
										</div> 
										
		                              	<label class="control-label" id="Address4_label" for="addressLine4"> 
		                              		<g:message code="subscriberMember.addressLine4.label" default="Address 4:" />
										</label>				
		                              	<div class="fms_form_input">
											<g:textField 
												name="address.0.addressLine4"  maxlength="60"
												value="${address?.addressLine3}" 
												class="form-control" 
												title="Line 4 Address"/>
											<div class="fms_form_error" id="Address4_error"></div>
										</div> 
													
										<label for="addressLine5" class="control-label" id="Address5_label">
											<g:message code="subscriberMember.addressLine5.label" default="Address 5:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
											name="address.0.addressLine5" maxlength="60"
											value="${address?.addressLine5}" 
											class="form-control" 
											title="Line 5 Address"/>
											<div class="fms_form_error" id="Address5_error"></div>
										</div> 
									  	
										<label class="control-label" id="Address6_label" for="addressLine6"> 
											<g:message code="subscriberMember.addressLine6.label" default="Address 6:" />
										</label>					  
									  	<div class="fms_form_input">
											<g:textField 
												name="address.0.addressLine6" maxlength="60"
												value="${address?.addressLine6}" 
												class="form-control" 
												title="Line 6 Address"/>
											<div class="fms_form_error" id="Address6_error"></div>
										</div> 
									</div>
		                             	
		                           	<div class="fms_form_column fms_very_long_labels">
									  	<label class="control-label fms_required" id="City_r2_label" for="city"> 
									  		<g:message code="subscriberMember.city.label" default="City:" />
										</label>				
										<div class="fms_form_input">
		                                 	<g:textField 
			                                 	name="address.0.city"
			                                 	maxlength="30"
			                                 	value="${address?.city}" 
			                                 	class="form-control" 
			                                 	title="City of the Address" />
		                                 	<div class="fms_form_error" id="City_error"></div>
		                              	</div>
			                               
										<label class="control-label fms_required" id="State_r2_label" for="groupState"> 
											<g:message code="subscriberMember.groupState.label" default="State:" />
										</label>	  
										<div class="fms_form_input">
											<g:select
												name="address.0.state"
												class="form-control"
												optionKey="stateCode"
												optionValue="stateName" id="state.name" from="${states}"
												noSelection="['':'-- Select a State --']"
												value="${address?.state}" 
												title="State of the Address"/>
		                                   	<div class="fms_form_error" id="State_r2_error"></div>
		                                </div>
		                                  
					                 	<label class="control-label" id="County_r2_label" for="county"> 
					                 		<g:message code="subscriberMember.county.label" default="County:" />
										</label>     
		
		                                <div class="fms_form_input">
		                                    <g:textField 
			                                 	name="address.0.county"
			                                 	maxlength="30"
				                                value="${address?.county}" 
				                                class="form-control" 
				                                title="County of the Address" />
						                    <div class="fms_form_error" id="County_r2_error"></div>
		                                </div>  
										 	
	                                 	<label class="control-label" id="Country_r2_label" for="country"> 
	                                 		<g:message code="subscriberMember.country.label" default="Country:" />
	                                 	</label>
										<div class="fms_form_input">
											<g:textField 
												class="form-control"
												maxlength="30"
												name="address.0.country" 
												value="${address?.country}" 
												title="Country of the Address"/>
											<div class="fms_form_error" id="Country_r2_error"></div>
		                                 </div> 
		                                 
										<label class="control-label fms_required" id="ZIP_r2_label" for="zipCode"> 
											<g:message code="subscriberMember.zipCode.label" default="Zip Code:" />
										</label>						
									  	<div class="fms_form_input">
									  		<g:textField maxlength="10"
												name="address.0.zip" 
												value="${address?.zip}" 
												placeholder="00000-0000"
												class="form-control maskZip" 
												title="Zip Code of the Address"/>
	                                    	<div class="fms_form_error" id="ZIP_r2_error"></div>
	                                 	</div>  
	                                 	
	                                 	<label class="control-label" id="email_label" for="email"> 
	                                 		<g:message code="subscriberMember.email.label" default="Email Id:" />
	                                 	</label>
									
	                                 	<div class="fms_form_input">
			                                <g:textField 
				                                name="address.0.email" 
			                                 	value="${address?.email}" maxlength="80"
			                                 	class="form-control" 
			                                 	title="Email Address of the Contact"/>
				                            <div class="fms_form_error" id="email_error"></div>
				                      	</div>
				                      		
		                                 <label class="control-label" id="countrySubdivisionCode_label" for="countrySubdivisionCode"> 
		                                 	<g:message code="subscriberMember.countrySubdivisionCode.label" default="Country Sub Division Code:" /> 
		                                 </label>
		                                 <div class="fms_form_input">
				                         	<g:textField 
				                         		class="form-control" 
				                        	   	maxlength="3" 
				                        	   	name="address.0.countrySubdivisionCode" 
												value="${address?.countrySubdivisionCode}" 
												title="Country Sub Division Code of the Address"/>
				                        	<div class="fms_form_error" id="countrySubdivisionCode_error"></div>
				                      	</div> 
									</div>
		                       	</div>
		                   	</fieldset>
		              	</div>
						<!-- END - WIDGET: Address -->	
						
						<!-- START - WIDGET: Phone -->	
		               	<div class="fms_widget">        
		                	<fieldset class="no_border">
		                      	<legend><h3>Phone</h3></legend>
		                       	<div class="fms_form_layout_2column">                  
		                        	<div class="fms_form_column fms_very_long_labels">
		                              		
		                           		<label class="control-label" id="HomePhone_r2_label" for="homePhone"> 
		                           			<g:message code="subscriberMember.homePhone.label" default="Home Phone:" />
		           						</label>
		                               	<div class="fms_form_input">
		                                  	<g:textField 
												maxlength="40"
												name="address.0.homePhone"
												value="${address?.homePhone}"
												class="form-control fms_phone_mask" 
												placeholder="(000) 000-0000" 
												title="Home Phone Number for the Address"/>
		                                  	<div class="fms_form_error" id="HomePhone_r2_error"></div>
		                               	</div>
		                                 	
		                                <label class="control-label" id="BusinessPhone_r2_label" for="businessPhone"> 
		                                	<g:message code="subscriberMember.businessPhone.label" default="Business Phone:" /> 
		                               	</label>
		                                	<div class="fms_form_input">
		                                    <g:textField maxlength="40"
												name="address.0.businessPhone" 
												value="${address?.businessPhone}"
												class="form-control fms_phone_mask" 
												placeholder="(000) 000-0000" 
												title="Business Phone Number for the Address"/>
		                                 	<div class="fms_form_error" id="BusinessPhone_r2_error"></div>
		                                 </div>
		                                  						
		                               	<label class="control-label" id="AlternatePhone_r2_label" for="alternatePhone"> 
		                               		<g:message code="subscriberMember.alternatePhone.label" default="Alternate Phone:" />  
		                               	</label>
		                               	<div class="fms_form_input">
		                                  <g:textField maxlength="40"
												name="address.0.alternatePhone" 
												value="${address?.alternatePhone}"
												class="form-control fms_phone_mask" 
												placeholder="(000) 000-0000" 
												title="Alternate Phone Number for the Address"/>
		                                  <div class="fms_form_error" id="AlternatePhone_r2_error"></div>
		                               	</div> 
		                               						
		                               	<label class="control-label" id="telephoneNumber_label" for="telephoneNumber"> 
		                               		<g:message code="subscriberMember.telephoneNumber.label" default="Telephone:" />
		                               	</label>
		                               	<div class="fms_form_input">
											<g:textField 
												name="address.0.telephoneNumber"
												value="${address?.telephoneNumber}" 
												maxlength="40"
												class="form-control fms_phone_mask" 
												placeholder="(000) 000-0000" 
												title="Telephone Number for the Address"/>
											<div class="fms_form_error" id="telephoneNumber_error"></div>
										</div> 
		                            </div> 
		                            		
		                            <div class="fms_form_column fms_very_long_labels">		 
		                                <label class="control-label" id="MobilePhone_r2_label" for="mobilePhone"> 
		                                	<g:message code="subscriberMember.mobilePhone.label" default="Mobile Phone:" />
		                                </label>	
		                                <div class="fms_form_input">
		                                    <g:textField maxlength="40"
												name="address.0.mobilePhone" 
												value="${address?.mobilePhone}"
												class="form-control fms_phone_mask" 
												placeholder="(000) 000-0000" 
												title="Mobile Phone Number for the Address"/>
		                                    <div class="fms_form_error" id="MobilePhone_r2_error"></div>
		                                </div>
		                                				
		                              	<label class="control-label" id="beeperNumber_label" for="beeperNumber"> 
		                                 	<g:message code="subscriberMember.beeperNumber.label" default="Beeper Number:" />
		                                 </label> 
										<div class="fms_form_input">
											<g:textField 
												name="address.0.beeperNumber" 
												value="${address?.beeperNumber}" 
												maxlength="40"
												class="form-control fms_phone_mask" 
												placeholder="(000) 000-0000" 
												title="Beeper Number for the Address"/>
											<div class="fms_form_error" id="beeperNumber_error"></div>
										</div> 
		                                							
		                                <label class="control-label" id="FaxNumber_r2_label"for="faxNumber"> 
		                                	<g:message code="subscriberMember.faxNumber.label"default="Fax Number:" />
		                                </label>
										<div class="fms_form_input">
		                                    <g:textField maxlength="40"
												name="address.0.faxNumber" 
												value="${address?.faxNumber}" 
												class="form-control fms_phone_mask" 
												placeholder="(000) 000-0000" 
												title="Fax Numer for the Address"/>
		                                    <div class="fms_form_error" id="FaxNumber_r2_error"></div>
		                                </div>
				                                
		                               	<label class="control-label" id="Extension_r2_label" for="telephoneNumberEx"> 
		                               		<g:message code="subscriberMember.telephoneNumberEx.label" default="Tel Ext:" />
										</label>				
										<div class="fms_form_input">
		                                    <g:secureTextField maxlength="40"
												name="address.${memberDBID }.${address.seqMembAddress}.telephoneNumberEx" 
												tableName="MEMBER_ADDRESS" attributeName="telephoneExtension" 
												value="${address?.telephoneNumberEx}"
												type="text" placeholder="00000000"
												class="form-control fms_ext_mask" 
												id="Extension_r2" 
												title="Telephone Ext for the Telephone Number"
												aria-labelledby="Extension_r2_label" 
												aria-describedby="Extension_r2_error" 
												aria-required="false"/>
		                                    <div class="fms_form_error" id="Extension_r2_error"></div>
		                                </div>
				                                  		
									</div>
		                      	</div>
		                  	</fieldset>
		              	</div>
		              	<!-- END - WIDGET: Phone -->	
		              	
		              	<!-- START - WIDGET: Other Information -->	          
		                <div class="fms_widget">        
		                	<fieldset class="no_border">
		                    	<legend><h3>Other Information</h3></legend>
		                        <div class="fms_form_layout_2column">                  
		                        	<div class="fms_form_column fms_very_long_labels">
		                              		
		                           		<label class="control-label" id="prefixName_label" for="prefixName"> 
		                           			<g:message code="subscriberMember.prefixName.label" default="Prefix:" />
		         						</label>
		                               	<div class="fms_form_input">
											<g:getCdoSelectBox 
												cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
												cdoAttributeWhereValue="S"
												cdoAttributeWhere="titleType"
												cdoAttributeSelect="contactTitle"
												cdoAttributeSelectDesc="description"
												languageId="0"
												blankValue="Prefix"
												defaultValue="${address?.prefixName}" 
												htmlElelmentId="address.0.prefixName"
												className="form-control" 
												title="Prefix of the Contact"/>			
											<div class="fms_form_error" id="prefixName_error"></div>
										</div>
								
										<label class="control-label" id="suffixName_label" for="suffixName"> 
											<g:message code="subscriberMember.suffixName.label" default="Suffix:" />
										</label>				
										<div class="fms_form_input">
											<g:getCdoSelectBox 
												cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
												cdoAttributeWhereValue="F"
												cdoAttributeWhere="titleType"
												cdoAttributeSelect="contactTitle"
												cdoAttributeSelectDesc="description"
												languageId="0"
												htmlElelmentId="address.0.suffixName"
												defaultValue="${address?.suffixName}"
												blankValue="Suffix" 
												className="form-control" 
												title="Suffix of the Contact"/>	
											<div class="fms_form_error" id="suffixName_error"></div>
										</div> 
											
										<label class="control-label" id="socialSecNo_label" for="socialSecurityNumber"> 
											<g:message code="subscriberMember.socialSecurityNumber.label" default="SSN:" />
										</label>						
										<div class="fms_form_input">
										<g:textField
											id="idSocialSecurityNumber"
											name="address.0.socialSecurityNumber" 
											class="form-control fms_ssn_mask" maxlength="11" 
											value="${address?.socialSecurityNumber}" 
											placeholder="000-00-0000" 
											title="Social Security Number of the Contact"/>
										<div class="fms_form_error" id="SSN_error"></div>
										</div>
											
										<label class="control-label" id="employerIdNumber_label" for="employeridNumber"> 
											<g:message code="subscriberMember.employeridNumber.label" default="Emp ID Number:" />
										</label>
										<div class="fms_form_input">
											<g:textField
											name="address.0.employeridNumber" 
											maxlength="80" 
											value="${address?.employeridNumber}" 
											class="form-control" />
											<div class="fms_form_error" id="employerIdNumber_error"></div>
										</div> 
															
										<label class="control-label" id="nationalIndivIdNumber_label" for="nationalIndividNumber"> 
											<g:message code="subscriberMember.nationalIndividNumber.label" default="Nat. Ind. ID Number:" />
										</label>				
										<div class="fms_form_input">
											<g:textField
												class="form-control"			
												name="address.0.nationalIndividNumber" 
												maxlength="80" 
												value="${address?.nationalIndividNumber}" />
										</div> 
											
										<label class="control-label" id="beneficiaryRelCode_label" for="beneficiaryRelationShip"> 
											<g:message code="subscriberMember.beneficiaryRelationShip.label" default="Ben Rel Code:" />			
										</label>
										<div class="fms_form_input">
											<g:textField
												class="form-control"
												name="address.0.beneficiaryRelationShip" 
												maxlength="1" 
												value="${address?.beneficiaryRelationShip}" />										
											<div class="fms_form_error" id="beneficiaryRelCode_error"></div>
										</div> 
									</div> 
									 
									<div class="fms_form_column fms_very_long_labels">
								 		<label class="control-label" id="beneficiaryGender_label" for="beneficiaryGender"> 
								 			<g:message code="subscriberMember.beneficiaryGender.label" default="Ben Gender:" />
		                                 </label>
		                                 <div class="fms_form_input">
											<g:getDiamondDataWindowDetail columnName="gender"
												dwName="dw_edied_de" languageId="0"
												htmlElelmentId="address.0.beneficiaryGender"
												defaultValue=""
												blankValue="Benificiary Gender" 
												cssClass="form-control" />			
											<div class="fms_form_error" id="SelectMember_error"></div>
										</div>
									
										<label class="control-label" id="beneficiaryDob_label" for="beneficiaryDOB"> 
											<g:message code="subscriberMember.beneficiaryDOB.label" default="Ben DOB:" />
										</label>				
										<div class="fms_form_input">
		                                  	<fmsui:jqDatePickerUIUX  dateElementId="address.0.beneficiaryDOB" 
												dateElementName="address.0.beneficiaryDOB"
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+0', numberOfMonths: 1" 
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.beneficiaryDOB)}"
												ariaAttributes="aria-labelledby='memAddrUserDate1_label' aria-describedby='memAddrUserDate1_error' aria-required='false'" 
                                        		classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                        		showIconDefault="${isShowCalendarIcon}"/> 
		                                  	<div class="fms_form_error" id="beneficiaryDob_error"></div>
		                                </div>
		                              				
										<label class="control-label" id="memAddrUserDefined1_label" for="userDefined1"> 
											<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_1_t" defaultText="User Defined 1:"/>
										</label>			
										<div class="fms_form_input">
											<g:textField 
												class="form-control" 
												name="address.0.userDefined1"
												maxlength="30" 
												value="${address?.userDefined1}" />	
											<div class="fms_form_error" id="memAddrUserDefined1_error"></div>
										</div> 
										
										<label class="control-label" id="memAddrUserDefined2_label" for="userDefined2"> 
											<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_defined_2_t" defaultText="User Defined 2"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												class="form-control"
												name="address.0.userDefined2"
												maxlength="30" 
												value="${address?.userDefined2}" />	
											<div class="fms_form_error" id="memAddrUserDefined2_error"></div>
										</div> 
											
														
										<label class="control-label" id="memAddrUserDate1_label" for="userDate1"> 
											<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_1_t" defaultText="User Date 1:"/>
										</label>
										<div class="fms_form_input">
											<fmsui:jqDatePickerUIUX  
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate1)}" 
												dateElementId="address.0.userDate1" 
												dateElementName="address.0.userDate1" 
		                                        ariaAttributes="aria-labelledby='memAddrUserDate1_label' aria-describedby='memAddrUserDate1_error' aria-required='false'" 
		                                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
		                                        showIconDefault="${isShowCalendarIcon}"/> 									          
		                                  <div class="fms_form_error" id="memAddrUserDate1_error"></div>
		                                </div> 
				                          
									 	<label id="userDate2_label" class="control-label" for="userDate2"> 
											<g:userDefinedFieldLabel winId="MEMBA" datawindowId ="dw_memba_de" userDefineTextName="mem_addr_user_date_2_t" defaultText="User Date 2:"/>
										</label>
										<div class="fms_form_input">
		                                  	<fmsui:jqDatePickerUIUX 
		                                  		datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100' , numberOfMonths: 1" 
		                                  		dateElementValue="${formatDate(format:'MM/dd/yyyy',date: address?.userDate2)}"  
		                                  		dateElementId="address.0.userDate2" 
		                                  		dateElementName="address.0.userDate2" 
	                                       		ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
	                                            classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
	                                            showIconDefault="${isShowCalendarIcon}"/> 
											<div class="fms_form_error" id="userDate2_error"></div>
		                                </div> 
				                  	</div>
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: Other Information -->	
				 		
				 		<div class="fms_form_button">
						 	<g:actionSubmit class="btn btn-primary" action="saveAddress" value="${message(code: 'default.button.save.label', default: 'Save')}" />
						 	<input type="Reset" class="btn btn-default" value="Reset" id="resetButton" />
							<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
		      			</div>		
					</g:form>
				</div>
			</div>
		</div>
		<!-- END - FMS Content Body -->
	</div>
	<!-- END - FMS Content -->
</html>