<%@ page import="com.perotsystems.diamond.bom.fms.Agency" %>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="agency"/>
		
		<g:set var="entityName" value="${message(code: 'agency.label', default: 'Agency')}" />
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.AGENT_EDIT.equals(currentPage)?true:false}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:set var="STATUSDATE" value="false" />
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
		<script>
			function closeForm() {
				window.location.assign('<g:createLinkTo dir="/agency/list"/>')			
			}
		</script>

<script>
	
	$(document).ready(function() {

			$(".maskZip").mask("?99999-9999");

			$(".maskPhoneNumber").mask("?999-999-9999");
				
			$(".maskExtension").mask("?999999");

			$.validator.addMethod("phoneValidation", function(value, element) {
				return this.optional(element) || /\d{3}-\d{3}-\d{4}$/.test(value) || /\d{10}$/.test(value)
			}, "Phone Number must be 10 digits");

			$.validator.addMethod("zipcodeUS", function(value, element) {
				return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value) || /\d{9}$/.test(value)
			}, "Zip Code must be 5 or 9 digits");

			$.validator.addMethod("customValidation1", function(value, element) {
				return this.optional(element) || /^[a-zA-Z0-9-. ]+$/i.test(value);
			}, "Please enter letters, numbers, hyphen, period and space only");

			$.validator.addMethod("customValidation2", function(value, element) {
				return this.optional(element) || /^[a-zA-Z. ]+$/i.test(value);
			}, "Please enter letters, period and space only");

			$.validator.addMethod("customValidation3", function(value, element) {
				return this.optional(element) || /^[a-zA-Z- ]+$/i.test(value);
			}, "Please enter letters and hyphen only");

			$.validator.addMethod("customValidation4", function(value, element) {
				return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
			}, "Please enter letters only");

			$.validator.addMethod("numberValidation", function(value, element) {
				return this.optional(element) || /^[0-9]+$/.test(value);				
			}, "Please enter only numbers 0 through 9");

			
			<g:if test="${'LICENSE'.equals(params.editType)}">

				//Allow tabbing but prevent postback to previous page if user presses backspace since these fields are readonly
				$('#agencyIdReadonly, #agencyNameReadonly, #tinReadonly, #agencyLicense\\.0\\.licenseNumber').on('keydown', function(e) {
						if (e.keyCode != 9) {
							e.preventDefault();
						}
				});

				$('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').change(function(){
					toggleStatusDateField();
				});	

				//When page loads show current status date to be required based on the status field
				toggleStatusDateField();
				
				//Enable and Disable Current Status Date field based on Status field
				function toggleStatusDateField() {
					if($("#agencyLicense\\.agencyLicenceDtls\\.0\\.status").val() == 'AC') {
						//If status is Active(AC) then Current Status date is not required and needs to be disabled 
						STATUSDATE = false;
						$('input[id="agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').attr('disabled', 'disabled');
						$('button[id="_calendar_button_agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').hide();
						$('#reqdCurrentStatusDate').hide()
					}
					else {
						//If status is not equal to Active(AC) then Current Status date is required and needs to be enabled 
						STATUSDATE = true;
						$('input[id="agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').removeAttr('disabled', 'disabled');
						$('#reqdCurrentStatusDate').show();
						$('button[id="_calendar_button_agencyLicense.agencyLicenceDtls.0.currentStatusDate"]').show();
					}
				}

				//When page loads if there is certificate (Not just empty rows) then mark the completion date to be required
				if ($(".courseGroup,.descriptionGroup").filter(function() { return $(this).val(); }).length > 0) { 
						$('#reqdCompletionDate').show()
				}
					else {
						$('#reqdCompletionDate').hide()
				}

				//If there is a value within the course or description field (during one of the user interaction) mark the completion date mandatory
				$(".courseGroup,.descriptionGroup").bind("change paste keyup", function() {
					if ($(".courseGroup,.descriptionGroup").filter(function() { return $(this).val(); }).length > 0) {
						$('#reqdCompletionDate').show()
					}
					else {
						$('#reqdCompletionDate').hide()
					}
				});

				$.validator.addMethod("alphanumeric", function(value, element) {
					return this.optional(element) || /^[a-zA-Z0-9 ]+$/i.test(value);
				}, "Please enter letters or numbers only");

				 //Alias required to add rules and message so these can be used for fields with the same classname
				$.validator.addMethod("courseAlphanumeric", $.validator.methods.alphanumeric, "Please enter letters or numbers only for Certification Course");
				$.validator.addMethod("descriptionAlphanumeric", $.validator.methods.alphanumeric, "Please enter letters or numbers only for Certification Description");
				
				$.validator.addClassRules("courseGroup", {courseAlphanumeric : true });
				$.validator.addClassRules("descriptionGroup", {descriptionAlphanumeric : true });

				$.validator.addMethod("dateCompareGreaterThan", function(value, element, params) {
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
					
					var startDate
					var endDate
					
					if ( $(startYear).val().length > 0 && $(startMonth).val().length > 0 && $(startDay).val().length > 0 && 
						 $(endYear).val().length > 0 &&  $(endMonth).val().length > 0 && $(endDay).val().length > 0) {
						 
						startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
						endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;
		
						return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
									&& $(startDay).val().length > 0 && startDate < endDate) ;
					}
					else {
						return true;
					}
				});

				$.validator.addMethod("dateCompareGreaterThanOrEqual", function(value, element, params) {
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
					
					var startDate
					var endDate

					//if the first date being compared is optional and was disabled then the field wont have any dates in them - hence just return true
					if ($(startYear).val().length == 0 && $(startMonth).val().length == 0 && $(startDay).val().length == 0) {
						return true;
					}
					else if ($(startYear).val().length > 0 && $(startMonth).val().length > 0 && $(startDay).val().length > 0 &&
							$(endYear).val().length > 0 && $(endMonth).val().length > 0 && $(endDay).val().length > 0) {
						
						startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
						endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;
						
						return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
								&& $(startDay).val().length > 0 && startDate <= endDate) ;	
					}
					else {
						return true;
					}
				});
				
				$.validator.addMethod("dateCompareGreaterThanOrEqual2", function(value, element, params) {
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
					
					var startDate
					var endDate

					//if the first date being compared is optional and was disabled then the field wont have any dates in them - hence just return true
					if ($(startYear).val().length == 0 && $(startMonth).val().length == 0 && $(startDay).val().length == 0) {
						return true;
					}
					else if ($(startYear).val().length > 0 && $(startMonth).val().length > 0 && $(startDay).val().length > 0 &&
							$(endYear).val().length > 0 && $(endMonth).val().length > 0 && $(endDay).val().length > 0) {
						
						startDate= new  Date($(startYear).val(),$(startMonth).val(), $(startDay).val());
						endDate = new Date($(endYear).val(),$(endMonth).val(), $(endDay).val()) ;
						
						return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0
								&& $(startDay).val().length > 0 && startDate <= endDate) ;	
					}
					else {
						return true;
					}
				});

				//No future dates allowed
				$.validator.addMethod("noFutureDates", function(value, element, params) { 
					var enteredYear = params[0]+ "_year";
					var enteredMonth = params[0]+ "_month";
					var enteredDay = params[0]+ "_day"; 
					var enteredDate;
					var now;
					
					//Date entered needs to be compared with the current date to check if its in the future.
					//Grails date picker month has it set to Jan=1, Feb=1 and so on and Date objects have Jan=0, Feb=1
					//To compare we need to make the date entered equal. 
					//For eg: Date entered comes in as 1 for Jan from grails date picker but to compare with the current date object enteredMonth = enteredMonth - 1

					if ($(enteredYear).val().length > 0 && $(enteredMonth).val().length > 0 && $(enteredDay).val().length > 0) {
						enteredDate = new  Date($(enteredYear).val(), $(enteredMonth).val()-1, $(enteredDay).val());
						now = new Date();
						return this.optional(element) ||( $(enteredYear).val().length > 0 && $(enteredMonth).val().length > 0
							&& $(enteredDay).val().length > 0 && enteredDate <= now) ;
					}
					else {
						return true;
					}
				
				}, "No Future dates allowed");
				
				//Fire Description rule so the errors dont get left behind if Course has data
				$("input[name$='course']").bind("change keyup", function() {
					var errors = validator.numberOfInvalids();
					if (errors) { 
						var id = $(this).attr("id").replace("agencyLicenseCertificate.", "").replace(".course", "")
						$("#editForm").validate().element("#agencyLicenseCertificate\\." + id + "\\.description");
					}
				});
				
				//Fire Course rule so the errors dont get left behind if description has data
				$("input[name$='description']").bind("change keyup", function() {
					var errors = validator.numberOfInvalids();
					if (errors) { 
						var id = $(this).attr("id").replace("agencyLicenseCertificate.", "").replace(".description", "")
						$("#editForm").validate().element("#agencyLicenseCertificate\\." + id + "\\.course");
					}
				});
				
			</g:if>
		

			//Add extra validations for effective and term date.
			//New validation method to compare date fields.
			$.validator.addMethod("greaterThan", function(value, element, params) {
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


				return this.optional(element) ||( $(startYear).val().length > 0 && $(startMonth).val().length > 0 && $(startDay).val().length > 0 && startDate.getTime() <= endDate.getTime()) ;

			}, $.format("{3} must be greater than {2}") );
			
			
			jQuery.validator.setDefaults({
				  debug: true,
					ignore: []
				});

			$(function() {	
				validator = $('#editForm').validate({
					//Added ignoreTitle=true so it does not pick up the default title as the validation message
					//for fields for which the validation is set through their class name
					ignoreTitle: true,
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
					<g:if test="${'ADDRESS'.equals(params.editType)}">
						<g:each in="${agencyInstance?.agentAddresses}" var="agencyAddress" status="i">
								 'agencyAddress.${i}.addressLine1' : {
										required : true,
										customValidation1 : true
								},
								'agencyAddress.${i}.addressLine2' : {
									customValidation1 : true
								},
								'agencyAddress.${i}.city' : {
									required : true,
									customValidation2 : true
								},
								'agencyAddress.${i}.state' : {
									required : true
								},
								'agencyAddress.${i}.county' : {
									customValidation3 : true
								},
								'agencyAddress.${i}.country' : {
									customValidation4 : true
								},
								'agencyAddress.${i}.zipCode' : {
									required : true,
									zipcodeUS : true
								},
								'agencyAddress.${i}.addressType' : {
									required : true
								},
								'agencyAddress.${i}.effectiveDate' : {
									required : true
								},
								'agencyAddress.${i}.termReason' :  {
									required : function(element){														
										return $.trim($("#agencyAddress\\.${i}\\.termDate").val()).length > 0 ;						
									}
								},
								'agencyAddress.${i}.termDate' :  {
									required : function(element){														
										return $.trim($("#agencyAddress\\.${i}\\.termReason").val()).length > 0 	;						
									},
									greaterThan:[ "#agencyAddress\\.${i}\\.effectiveDate","#agencyAddress\\.${i}\\.termDate","Effective Date","Term Date"]
								},
	
						</g:each>
					</g:if>
					<g:if test="${'CONTACT'.equals(params.editType)}">
						<g:each in="${agencyInstance?.agentContacts}" var="agencyContact" status="i">
							'agencyContact.${i}.contactName' : {
								required : true,
								customValidation1 : true
							},
							'agencyContact.${i}.phoneNumber' : {
								required : true,
								phoneValidation: true
							},
							'agencyContact.${i}.emailAddress': {
								email : true
							},
							'agencyContact.${i}.faxNumber' : {
								phoneValidation: true
							},
							'agencyContact.${i}.mobilePhone' : {
								phoneValidation: true
							},
							'agencyContact.${i}.businessPhone' : {
								phoneValidation: true
							},
						</g:each>
					</g:if>

					<g:if test="${'CONTRACTS'.equals(params.editType)}">
						<g:each in="${agencyInstance?.agencyGroupContracts}" var="agencyContract" status="i">
							'agencyContract.${i}.seqGroupId' : {
								required : function(element){														
									return $.trim($("#${i}\\.groupId").val()).length > 0 &&	
										   $("#agencyContract\\.${i}\\.seqGroupId").val() != null;						
								},
							},
							'${i}.groupId' : {
								required : true
							},
							'${i}.planRiderCode' : {
								required : true
							},
						</g:each>
					</g:if>

					
					<g:if test="${'BANKING'.equals(params.editType)}">
				 	 <g:each in="${agencyInstance?.agentEFTs}" var="agentEFT" status="i">	
						 	'agentEFT.${i}.accountNumber' : {
								required : true,
								numberValidation : true
							},
							'agentEFT.${i}.nameOnAccount' : {
								required : true,
								customValidation1 : true
							},
							'agentEFT.${i}.bankName' : {
								required : true,
								customValidation1 : true
							},
							'agentEFT.${i}.routingNumber' : {
								required : true,
								numberValidation:true
							},
							'agentEFT.${i}.description' : {
								customValidation1 : true
							},
							'agentEFT.${i}.statusFlag' : {
								required : true
							},
							'agentEFT.${i}.effectiveDate' : {
								required : true
							},
							'agentEFT.${i}.termReason' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.${i}\\.termDate").val()).length > 0 
								}
							},
							'agentEFT.${i}.termDate' :  {
								required : function(element){														
									return $.trim($("#agentEFT\\.${i}\\.termReason").val()).length > 0 	;						
								},
								greaterThan:[ "#agentEFT\\.${i}\\.effectiveDate","#agentEFT\\.${i}\\.termDate","Effective Date","Term Date"]
							},
							'agentEFT.${i}.accountType' : {
								required : true
							},
									
					 </g:each>
				</g:if>	
				<g:if test="${'LICENSE'.equals(params.editType) && 'UPDATE'.equals(params.editSubType)}">
						<g:each in="${agencyLicenseHdrInstance}" var="agencyLicense" status="i">
							'agencyLicense.0.licenseLoa' : {
								required : true
							},
						  	'agencyLicense.0.state' : {
								required : true
							},
							'agencyLicense.agencyLicenceDtls.0.effectiveDate' : {
								required : true
							},
							'agencyLicense.agencyLicenceDtls.0.expirationDate' : {
								required : true,
								dateCompareGreaterThan:["#agencyLicense\\.agencyLicenceDtls\\.0\\.effectiveDate","#agencyLicense\\.agencyLicenceDtls\\.0\\.expirationDate","Effective Date","Expiration Date"]
							},
						  	'agencyLicense.agencyLicenceDtls.0.status' : {
								required : true
							},
							'agencyLicense.agencyLicenceDtls.0.currentStatusDate' : {
								required : {
									depends: function(){	
										return 	($('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != 'AC'	&&  $('#agencyLicense\\.agencyLicenceDtls\\.0\\.status').val() != '')												
									}
								}
							},
							
								<g:each in="${agencyLicenseHdrInstance?.agencyLicenseCertificates}" var="agencyLicenseCertificate" status="j">
									'agencyLicenseCertificate.${j}.course' : {
										required : {
											depends: function(){
												return ($("#agencyLicenseCertificate\\.${j}\\.completionDate").val().length > 0 ) &&
												$.trim($("#agencyLicenseCertificate\\.${j}\\.description").val()) == 0;				
											}
										}
									},
									'agencyLicenseCertificate.${j}.description' : {
										required : {
											depends: function(){
												return ($("#agencyLicenseCertificate\\.${j}\\.completionDate").val().length > 0 ) &&
												$.trim($("#agencyLicenseCertificate\\.${j}\\.course").val()) == 0;			
											}
										}
									},
									'agencyLicenseCertificate.${j}.completionDate' : {
										noFutureDates: ["#agencyLicenseCertificate\\.${j}\\.completionDate"],
										required : function(element){														
											return $.trim($("#agencyLicenseCertificate\\.${j}\\.course").val()).length > 0 ||
											$.trim($("#agencyLicenseCertificate\\.${j}\\.description").val()).length > 0;						
										}
									},
									'agencyLicenseCertificate.${j}.expirationDate' : {
										dateCompareGreaterThanOrEqual2:["#agencyLicenseCertificate\\.${j}\\.completionDate","#agencyLicenseCertificate\\.${j}\\.expirationDate","Completion Date","Expiration Date"],
										dateCompareGreaterThanOrEqual:["#agencyLicense\\.agencyLicenceDtls\\.0\\.currentStatusDate","#agencyLicenseCertificate\\.${j}\\.expirationDate","Status Date","Expiration Date"]					
									},
								</g:each>
						</g:each>
					</g:if>	
				},
				messages : {
					<g:if test="${'ADDRESS'.equals(params.editType)}">
						<g:each in="${agencyInstance?.agentAddresses}" var="agencyAddress" status="i">
								'agencyAddress.${i}.addressLine1' : {
									required : "Please enter the Address Line 1",
									customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Address Line 1"
							},
							'agencyAddress.${i}.addressLine2' : {
								customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Address Line 2"
							},
							'agencyAddress.${i}.city' : {
								required : "Please enter the City",
								customValidation2 : "Please enter letters, period and space only for City"
							},
							'agencyAddress.${i}.state' : {
								required : "Please select a State"
							},
							'agencyAddress.${i}.county' : {
								customValidation3 : "Please enter letters, space and hyphen only for County"
							},
							'agencyAddress.${i}.country' : {
								customValidation4 : "Please enter letters only for Country"
							},
							'agencyAddress.${i}.zipCode' : {
								required : "Please enter the Zip Code",
								zipcodeUS : "Zip Code must be 5 or 9 digits"
							},
							'agencyAddress.${i}.addressType' : {
								required : "Please select an Address Type"
							},
							'agencyAddress.${i}.effectiveDate' : {
								required : "Please enter the Effective Date"
							},
							'agencyAddress.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
							},
							'agencyAddress.${i}.termDate' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
							},
						</g:each>	
					</g:if>	
					<g:if test="${'CONTACT'.equals(params.editType)}">
						<g:each in="${agencyInstance?.agentContacts}" var="agencyContact" status="i">
							'agencyContact.${i}.contactName' : {
								required : "Please enter the Name of the Contact",
								customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Name of the Contact"
							},
							'agencyContact.${i}.phoneNumber' : {
								required : "Please enter the Phone Number",
								phoneValidation: "Phone Number must be 10 digits"
							},
							'agencyContact.${i}.emailAddress': {
								email : "Please enter a valid Email Address"
							},
							'agencyContact.${i}.faxNumber' : {
								phoneValidation: "Fax Number must be 10 digits"
							},
							'agencyContact.${i}.mobilePhone' : {
								phoneValidation: "Mobile Phone must be 10 digits"
							},
							'agencyContact.${i}.businessPhone' : {
								phoneValidation: "Business Phone must be 10 digits"
							},
						</g:each>
				</g:if>	
				
				<g:if test="${'CONTRACTS'.equals(params.editType)}">
						<g:each in="${agencyInstance?.agencyGroupContracts}" var="agencyContract" status="i">
							'agencyContract.${i}.seqGroupId' : {
								required : "Please enter a valid Group Id"
							},
							'${i}.groupId' : {
								required : "Please enter a Group Id"
							},
							'${i}.planRiderCode' : {
								required : "Please enter a Plan/Rider Code"
							},
						</g:each>
				</g:if>	
				
				<g:if test="${'BANKING'.equals(params.editType)}">
				 <g:each in="${agencyInstance?.agentEFTs}" var="agentEFT" status="i">
							'agentEFT.${i}.accountNumber' : {
								required : "Please enter the Account Number",
								numberValidation : "Please enter numbers only for Bank Account No."
							},
							'agentEFT.${i}.nameOnAccount' : {
								required : "Please enter the Name on Account",
								customValidation1 : "Please enter letters, numbers, hyphen, space and period only for Name on Account"
							},
							'agentEFT.${i}.bankName' : {
								required : "Please enter the Bank Name",
								customValidation1 : "Please enter letters, numbers, hyphen, spaces and period only for Bank Name"
							},
							'agentEFT.${i}.routingNumber' : {
								required : "Please enter the Routing No.",
								numberValidation : "Please enter numbers only for ABA Routing No."
							},
							'agentEFT.${i}.description' : {
								customValidation1 : "Please enter letters, numbers, hyphen, spaces and period only for Account Description."
							},
							'agentEFT.${i}.statusFlag' : {
								required : "Please select a Status",
							},
							'agentEFT.${i}.effectiveDate' : {
								required : "Please enter the Effective Date"
							},
						    'agentEFT.${i}.termReason' :  {
								required : "Term Reason is a mandatory field if Term Date is entered, please enter the Term Reason"
							},
							'agentEFT.${i}.termDate' :  {
								required : "Term Date is a mandatory field if Term Reason is entered, please enter the Term Date"
							},
							'agentEFT.${i}.accountType' : {
							required : "Please select an Account Type",
						},
				</g:each>
				</g:if>		
				
				<g:if test="${'LICENSE'.equals(params.editType) && 'UPDATE'.equals(params.editSubType)}">
						<g:each in="${agencyLicenseHdrInstance}" var="agencyLicense" status="i">
							'agencyLicense.0.licenseLoa' : {
								required : "Please select a LOA"
							},
						  	'agencyLicense.0.state' : {
								required : "Please select a State"
							},
							'agencyLicense.agencyLicenceDtls.0.effectiveDate' : {
								required : "Please enter the Effective Date"
							},
							'agencyLicense.agencyLicenceDtls.0.expirationDate' : {
								required : "Please enter the Expiration Date",
								dateCompareGreaterThan: "Expiration Date must be after the Effective Date"
							},
						  	'agencyLicense.agencyLicenceDtls.0.status' : {
								required : "Please select a Status"
							},
							'agencyLicense.agencyLicenceDtls.0.currentStatusDate' : {
								required : "Current Status Date is required for the current License Status. Please enter the Status Date"
							},
							
							
								<g:each in="${agencyLicenseHdrInstance?.agencyLicenseCertificates}" var="agencyLicenseCertificate" status="j">
									'agencyLicenseCertificate.${j}.course' : {
										required : "Either the Course ID or Description must be entered. Both cannot be blank"
									},
									'agencyLicenseCertificate.${j}.description' : {
										required : "Either the Course ID or Description must be entered. Both cannot be blank"
									},
									'agencyLicenseCertificate.${j}.completionDate' : {
										noFutureDates:  "Completion Date cannot be in the future",
										required : "Completion Date is required if Certification Course or Description is entered. Please enter Completion Date"
									},
									'agencyLicenseCertificate.${j}.expirationDate' : {
										dateCompareGreaterThanOrEqual2: "Certificate Expiration Date cannot be before Completion Date",
										dateCompareGreaterThanOrEqual: "Certificate Expiration Date cannot be before Current Status Date"
									},
								</g:each>
							
						</g:each>
					</g:if>	
				
						
				} 

				}) //validate End Tag
				
			}); //Function End Tag
			
	}); //document ready end tag




</script>
	</head>

<div id="fms_content">  
			<div id="fms_content_header">
			  <div class="fms_content_header_note">
			   <a href="${createLink(uri: '/agency/list')}">Agency Maintenance</a> / ${ params.editType} Record for Agency ID ${agencyInstance?.agencyId}
			  </div>
			  <div class="fms_content_title">
			  	<g:if test="${params.editType?.equals("MASTER") || params.editType?.equals("ADDRESS") || params.editType?.equals("CONTRACTS") || params.editType?.equals("CONTACT")||params.editType?.equals("BANKING")}">
					<h1><g:message code="default.edit.label" args="[entityName]" /> - ${ params.editType}</h1>
				</g:if>
				<g:elseif test="${params.editType?.equals("LICENSE") && params.editSubType?.equals("UPDATE") }">
					<h1><g:message code="default.edit.label" args="[entityName]" /> - LICENSE AND CERTIFICATION</h1>
				</g:elseif>
				</div>
			</div>
			<%-- START - Tabs --%>
		     <div id="fms_content_tabs">
		       <ul>
					<g:if test="${("MASTER".equals(request.getParameter('editType')))}">
						<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'MASTER']}">Master Record</g:link></li>
					</g:if>
					<g:else>
						<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'MASTER']}">Master Record</g:link></li>
					</g:else>
					
					<g:if test="${("ADDRESS".equals(request.getParameter('editType')))}">
						<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'ADDRESS']}">Addresses</g:link></li>
					</g:if>
					<g:else>
						<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'ADDRESS']}">Addresses</g:link></li>
					</g:else>
					
					<g:if test="${("CONTACT".equals(request.getParameter('editType')))}">
						<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTACT']}">Contacts</g:link></li>					
					</g:if>
					<g:else>
						<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTACT']}">Contacts</g:link></li>					
					</g:else>
					
					<g:if test="${("CONTRACTS".equals(request.getParameter('editType')))}">
						<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTRACTS']}">Contracts</g:link></li>
					</g:if>
					<g:else>
						<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'CONTRACTS']}">Contracts</g:link></li>
					</g:else>
					
					<g:if test="${("BANKING".equals(request.getParameter('editType')))}">
						<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'BANKING']}">Banking</g:link></li>					
					</g:if>
					<g:else>
						<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'BANKING']}">Banking</g:link></li>					
					</g:else>
					
					<g:if test="${("LICENSE".equals(request.getParameter('editType')))}">
						<li><g:link class="active" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'LICENSE', callingPage: 'AGENCY']}">License and Certification</g:link></li>
					</g:if>
					
					<g:else>
						<li><g:link class="list" action="edit" params="${[seqAgencyId: agencyInstance?.seqAgencyId, agencyId: agencyInstance?.agencyId, agencyType: agencyInstance?.agencyType, editType :'LICENSE', callingPage: 'AGENCY']}">License and Certification</g:link></li>
					</g:else>
		       </ul>
		       <div id="mobile_tabs_select"></div>
		     </div>
		   <%-- END - Tabs --%>
			<div id="edit-agentMaster" class="content scaffold-edit" role="main">
			
			<div class="right-corner" align="right">
			<g:if test="${("MASTER".equals(request.getParameter('editType')))}">AGNCM&nbsp</g:if>
				<g:if test="${("ADDRESS".equals(request.getParameter('editType')))}">AGNCA&nbsp</g:if>
				<g:if test="${("CONTACT".equals(request.getParameter('editType')))}">AGNCC&nbsp</g:if>
				<g:if test="${("BANKING".equals(request.getParameter('editType')))}">BRBNK&nbsp</g:if>
				<g:if test="${("LICENSE".equals(request.getParameter('editType')))}">
					<g:if test= "${("UPDATE".equals(request.getParameter('editSubType'))) && ("AGENCY".equals(request.getParameter('callingPage')))}">
						AGNCL&nbsp					
					</g:if>
					<g:elseif test= "${("UPDATE".equals(request.getParameter('editSubType'))) && ("AGENT".equals(request.getParameter('callingPage')))}">
						AGNTL&nbsp					
					</g:elseif>
				</g:if>
			</div>
				<g:if test="${params.editType?.equals("MASTER")}">
				<g:form action="update" id="agencyForm" name="agencyForm">
						<fieldset class="form">
							<g:render template="form" />
						</fieldset>
				</g:form>
			</g:if>
			<g:elseif test="${params.editType?.equals("ADDRESS")}">
					<g:form action="update" id="editForm" name="editForm">
							<fieldset class="form">
									<g:render template="agencyAddressForm"/>
							</fieldset>
						</g:form>		
			</g:elseif>
			<g:elseif test="${params.editType?.equals("CONTACT")}">
					<g:form action="update" id="editForm" name="editForm">
							<fieldset class="form">
									<g:render template="agencyContactForm"/>
							</fieldset>
							
						</g:form>		
			</g:elseif>
			<g:elseif test="${params.editType?.equals("CONTRACTS")}">
					<g:form action="update" id="editForm" name="editForm">
							<fieldset class="form">
									<g:render template="agencyContractsForm"/>
							</fieldset>
							
					</g:form>	
			</g:elseif>
			<g:elseif test="${params.editType?.equals("BANKING")}">
					<g:form action="update" id="editForm" name="editForm">
						<fieldset class="form">
								<g:render template="agencyBankingForm"/>
						</fieldset>
					</g:form>	
			</g:elseif>
			<g:elseif test="${params.editType?.equals("LICENSE")}">
				<g:if test="${params.editSubType?.equals("UPDATE")}">
						<g:form action="update" id="editForm" name="editForm">
							<fieldset class="form">
							
									<g:render template="licenseCertificationForm"/>
							</fieldset>
							
						</g:form>
				</g:if>
				<g:else>
						<g:render template="searchLicense"/>
				</g:else>
			</g:elseif>
			
		</div>

</html>