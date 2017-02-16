<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
<head>
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
	    top: 42px;
	    right: 0;
	    margin-right: 40px;
	    font:normal normal 21pt / 1 Tahoma;
	    color: #48802C;
	}
</style>
<meta name="layout" content="main_2">
<g:set var="entityName"
	value="${message(code: 'memberMaster.label', default: 'Member Master')}" />

<g:set var="appContext" bean="grailsApplication"/>	
	
<title><g:message code="default.edit.label" args="[entityName]" /></title>

<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'jquery.window.css')}"
	type="text/css">

<script  type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>	
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

function checkNullValue(){
    var x = document.getElementsByClassName("amtNumeric");
    var i;
    for (i = 0; i < x.length; i++) {
   	 if(x[i].value==''){
        x[i].value="0.00";
   	 }
    }
	
}

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
		value = value.replace(/\s+/g, ""); 
		return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value) || /\d{9}$/.test(value)
	}, "Zip Code must be 5 or 9 digits.");

	jQuery.validator.addMethod("ssnmaxdigits", function(value, element) {
		return this.optional(element) || /\d{3}-\d{2}-\d{4}$/.test(value) || /\d{9}$/.test(value)
	}, "SSN must be 9 digits");

	jQuery.validator.addMethod("taxidUS", function(value, element) {
		return this.optional(element) || /\d{2}-\d{7}$/.test(value) || /\d{9}$/.test(value)
	}, "Tax ID must be 9 digits");

	jQuery.validator.addMethod("alphanumeric", function(value, element) {
		return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);
	}, "Please enter only Letters, numbers or underscores only.");

	jQuery.validator.addMethod("numeric", function(value, element) {
		return this.optional(element) || /^[0-9 ]+$/i.test(value);
	}, "Please enter only numbers.");
	
	jQuery.validator.addMethod("alpha", function(value, element) {
		return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
	}, "Please enter only Letters A through Z");

	jQuery.validator.addMethod("alphaspecialchar", function(value, element) {
		return this.optional(element) || /^[a-zA-Z-,_. ]+$/i.test(value);
	}, "Please enter only Letters A through Z and characters dash, comma, hyphen, period.");

	//If date changed set userflag to true. Will be used to check if user clicked on close without saving date.
	$('body').live('dateupdated', function(e) {
		userflag = true;
	});
	
jQuery.validator.setDefaults({
	ignore: [],
	debug: true,
	});
<g:if test="${!'MEDICARE_ENROLLMENT_INFO'.equals(params.editType)}">
$(function() {		
    var selectObj = document.getElementById("memberIdSelectList");
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
				<g:if test="${'MASTER'.equals(params.editType)}">
					<g:if test="memberMasterMap">
						 <g:each in="${memberMasterMap.keySet() }" status="idCount" 
							     var="memberDBID">
						 	<g:each in="${ memberMasterMap.get(memberDBID)}" status="i" 
							 	 var="master">
								'memberMaster.${memberDBID}.lastName' : {
									required : true
								}, 
								'memberMaster.${memberDBID}.dob' : {
									required : true
								},
								'memberMaster.${memberDBID}.gender' : {
									required : true
								},
								'memberMaster.${memberDBID}.socialSecurityNumber': {
									ssnmaxdigits: true		
								},
							</g:each>
						</g:each>
					</g:if>
				</g:if>
				
				<g:if test="${'DETAIL'.equals(params.editType)}">
				<g:if test="${memberEligHistoryMap}">
				 <g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
						var="memberDBID">
				 <g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
						var="eligibilityHistoryVar">
					 'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.effectiveDate' : {
						required : true
					},
					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.eligStatus' : {
						required : true
					},
					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.benefitStartDate' : {
						required : true
					},
					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.relationshipCode' : {
						required : true
					},
					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.groupId' : {
						required : true
					},
					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.planCode' : {
						required : true
					},
					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.lineOfBusiness' : {
						required : true
					},
					'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.privacyOn' : {
						required : { 
							depends :function() { 																			        
						        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
						            return true;
						        }
						        return false;
						    }
						}		
					}			
					<g:if test="${i < memberEligHistoryMap.get(memberDBID).size() && (i != memberEligHistoryMap.get(memberDBID).size()-1)}">
						,
					</g:if>
					</g:each>
						<g:if test="${i < memberEligHistoryMap.size() && (i != memberEligHistoryMap.size()-1)}">
							,
						</g:if>
					 </g:each>		
						 </g:if>
						 </g:if>
						 <g:if test="${'BILLING'.equals(params.editType)}">
							<g:if test="${memberEligHistoryMap}">
							 <g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
									var="memberDBID">
							 <g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
									var="eligibilityHistoryVar">
								 'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.effectiveDate' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}
								},
								'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.eligStatus' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}
								},
								'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.aboveGiaApprovalInd' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}
								},
								
								'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.relationshipCode' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}
								},
								'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.groupId' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}
								},
								'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.planCode' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}		
								},
								'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.privacyOn' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}		
								}
								<g:if test="${i < memberEligHistoryMap.get(memberDBID).size() && (i != memberEligHistoryMap.get(memberDBID).size()-1)}">
									,
								</g:if>
								</g:each>
									<g:if test="${i < memberEligHistoryMap.size() && (i != memberEligHistoryMap.size()-1)}">
										,
									</g:if>
								 </g:each>		
									 </g:if>
									</g:if>
						 <g:if test="${'ADDRESS'.equals(params.editType)}">
							 <g:if test="memberAddressMap">
							 <g:each in="${memberAddressMap.keySet() }" status="idCount"
								 var="memberDBID">
								<g:each in="${ memberAddressMap.get(memberDBID)}" status="i"
									var="address">
								'address.${memberDBID }.${address.seqMembAddress}.effectiveDate' : {
									required : { 
									depends :function() { 																			        
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									            return true;
									        }
									        return false;
									    }
									}
								},
								'address.${memberDBID }.${address.seqMembAddress}.email' : {
									required: { depends : function() {
										var isThisAddressEdited = false;
										 
									        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
									        	isThisAddressEdited  = true;
									        }
									        
										return isThisAddressEdited  && (document.getElementById("address.${memberDBID }.${address.seqMembAddress}.contactPref").selectedIndex == 1)
									}},
									email: true, 									
								},
								'address.${memberDBID }.${address.seqMembAddress}.addressType': {
									required : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    	}
									}
								},
								'address.${memberDBID }.${address.seqMembAddress}.billingAddress' : {
									required : {
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    	}
									}
								},
								'address.${memberDBID }.${address.seqMembAddress}.address1' : {
									required : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    	}
									}
								},
								'address.${memberDBID }.${address.seqMembAddress}.lastName' : {
									required : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    	}
									}
								},			
								'address.${memberDBID }.${address.seqMembAddress}.city' : {
									required : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
									    }
									}
								},
								'address.${memberDBID }.${address.seqMembAddress}.state' : {
									required : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    	}
									}
								},
								'address.${memberDBID }.${address.seqMembAddress}.zip' : {
									required : {
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									zipcodeUS: true
								},
								'address.${memberDBID }.${address.seqMembAddress}.homePhone' : {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									HomePhone: true
								},
								'address.${memberDBID }.${address.seqMembAddress}.mobilePhone': {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									MobilePhone : true
								},
								'address.${memberDBID }.${address.seqMembAddress}.beeperNumber': {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									BeeperNumber : true
								},
								'address.${memberDBID }.${address.seqMembAddress}.alternatePhone': {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									AlternatePhone : true
								},
								'address.${memberDBID }.${address.seqMembAddress}.faxNumber': {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									FaxNumber : true
								},
								'address.${memberDBID }.${address.seqMembAddress}.telephoneNumber': {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									Telephone : true
								},
								'address.${memberDBID }.${address.seqMembAddress}.telephoneNumberEx': {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value && selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									}
								},
								'address.${memberDBID }.${address.seqMembAddress}.socialSecurityNumber':{
								
									ssnmaxdigits : true
								},								
								'address.${memberDBID }.${address.seqMembAddress}.businessPhone': {
									digits : { 
									depends : function() { 										
								        
								        if (selectObj && selectObj.value &&  selectObj.value == "${memberDBID }") {
								            return true;
								        }
								        return false;
								    }
									},
									BusinessPhone : true
								}
								 <g:if test="${i <memberAddressMap.get(memberDBID).size() && (i != memberAddressMap.get(memberDBID).size()-1)}">
									,
								</g:if>
								</g:each>	
									<g:if test="${i <memberAddressMap.size() && (i != memberAddressMap.size()-1)}">
									,
									</g:if>								
								 </g:each>
					</g:if>						 
						</g:if>	
				
				<g:if test="${'BENEFICIARY'.equals(params.editType)}">
					<g:if test="memberBeneficiaryMap">
						 <g:each in="${memberBeneficiaryMap.keySet()}" status="idCount" var="memberDBID">
						 	<g:each in="${memberBeneficiaryMap.get(memberDBID)}" status="i" var="beneficiary">
							 	'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory' : {
									required : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName' : {
									required: {
												depends: function(element) 
												{
													if ($('#beneficiary\\.' + ${memberDBID} + '\\.' + ${beneficiary.seqBfciaryId} + '\\.bfciaryCategory').val() == 'P')
													{
														return false;
													}
													else
													{
														return true;
													}
											
												}
											}
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.relationshipCode' : {
									required : true
								}, 
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName' : {
									required : true,
									alphaspecialchar  : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName' : {
									required : true,
									alphaspecialchar  : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.middleInitial' : {
									alpha  : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.socialSecNo' : {
									required : true,
									ssnmaxdigits : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.dateOfBirth' : {
									required : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.gender' : {
									required : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.trustDate' : {
									required : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.taxId' : {
									required : true,
									taxidUS : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1' : {
									required : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city' : {
									required : true,
									alphanumeric  : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state' : {
									required : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode' : {
									required : true,
									zipcodeUS : true
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country' : {
									required : true,
									alphanumeric  : true
								},
							</g:each>
						</g:each>
					</g:if>
				</g:if>
			
			<g:if test="${'MEMMC_LIS_INFO'.equals(params.editType)}">
			
				<g:if test="lisInfoMap">
				
				 <g:each in="${lisInfoMap.keySet()}" status="idCount" var="memberDBID">
				 
				 	<g:each in="${lisInfoMap.get(memberDBID)}" status="i" var="lisInfo">
				 	
					 	'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisStartDate' : {
							required : true
						},
						'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisEndDate' : {
							required : true
						}, 
						'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisSubsidyLevel' : {
							required : false
						},
						'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisCopayCategory' : {
							required : true
						},
						
						'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisSourceCode' : {
							required : true
						},
						'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.enrolleeTypeFlag' : {
							required : true
						},
						
						'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.partdLisEnrSubsidy' : {
							required : false
						},
						%{--
						'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.partdLisSubsidy' : {
							required : false
						}
						--}%
					</g:each>
						
				</g:each>
				
			</g:if>
			
		</g:if>
		
		},
			messages : {
				<g:if test="${'MASTER'.equals(params.editType)}">
					<g:if test="memberMasterMap">
						 <g:each in="${memberMasterMap.keySet() }" status="idCount" 
							     var="memberDBID">
						 	<g:each in="${ memberMasterMap.get(memberDBID)}" status="i" 
							 	 var="master">
										'memberMaster.${memberDBID}.lastName' : {
											required : "Please enter Last Name"
										}, 
										'memberMaster.${memberDBID}.dob' : {
											required : "Please select a Date of Birth"
										},
										'memberMaster.${memberDBID}.gender' : {
											required : "Please select the Gender"
										}
										
							</g:each>
						</g:each>
					</g:if>
				</g:if>
				
				<g:if test="${'BENEFICIARY'.equals(params.editType)}">
					<g:if test="memberBeneficiaryMap">
						 <g:each in="${memberBeneficiaryMap.keySet()}" status="idCount" var="memberDBID">
						 	<g:each in="${memberBeneficiaryMap.get(memberDBID)}" status="i" var="beneficiary">
							 	'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryCategory' : {
									required : "Please select a Category"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.bfciaryName' : {
									required: function() 
									{
										var fieldName = 'bfciaryName'; 
										return setMessage(${memberDBID}, ${beneficiary.seqBfciaryId}, fieldName);
									}
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.relationshipCode' : {
									required : "Please select a Relationship Code"
								}, 
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.firstName' : {
									required: function() 
									{
										var fieldName = 'firstName'; 
										return setMessage(${memberDBID}, ${beneficiary.seqBfciaryId}, fieldName);
									},
									alphaspecialchar: function() 
									{
										var fieldName = 'alphaspecialcharfirstName'; 
										return setMessage(${memberDBID}, ${beneficiary.seqBfciaryId}, fieldName);
									}
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.lastName' : {
									required: function() 
									{
										var fieldName = 'lastName'; 
										return setMessage(${memberDBID}, ${beneficiary.seqBfciaryId}, fieldName);
									},
									alphaspecialchar: function() 
									{
										var fieldName = 'alphaspecialcharlastName'; 
										return setMessage(${memberDBID}, ${beneficiary.seqBfciaryId}, fieldName);
									}
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.middleInitial' : {
									alpha  : "Please enter only Letters A through Z for Middle Initial"	
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.socialSecNo' : {
									required : "Please enter a SSN",
									ssnmaxdigits : "SSN must be 9 digits"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.dateOfBirth' : {
									required : "Please select a Date Of Birth"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.gender' : {
									required : "Please select a Gender"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.trustDate' : {
									required : "Please select a Trust Date"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.taxId' : {
									required : "Please enter a valid Tax ID",
									taxidUS : "Tax ID must be 9 digits"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.addressLine1' : {
									required : "Please enter a Address"	
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.city' : {
									required : "Please enter a City",
									alphanumeric : "Please enter only Letters, numbers or underscores only for City"	
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.state' : {
									required : "Please select a State"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.zipCode' : {
									required : "Please enter a Zip Code" ,
									zipcodeUS : "Zip Code must be 5 or 9 digits"
								},
								'beneficiary.${memberDBID}.${beneficiary.seqBfciaryId}.country' : {
									required : "Please enter a Country",
									alphanumeric : "Please enter only Letters, numbers or underscores only for Country"	
								},
							</g:each>
						</g:each>
					</g:if>
				</g:if>

				%{--
					<g:if test="${'MEMMC_LIS_INFO'.equals(params.editType)}">
						<g:if test="lisInfoMap">
						 <g:each in="${lisInfoMap.keySet()}" status="idCount" var="memberDBID">
						 
						 	<g:each in="${lisInfoMap.get(memberDBID)}" status="i" var="lisInfo">
						 	
							 	'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisStartDate' : {
									required : "Please select LIS Start Date"
								},
								'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisEndDate' : {
									required : "Please select LIS End Date"
								},
								
								'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisSubsidyLevel' : {
									
								},
								'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisCopayCategory' : {
									required : "Please select LIS Copay Category"
								},
								
								'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.lisSourceCode' : {
									required : "Please select LIS Source Code"
								},
								'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.enrolleeTypeFlag' : {
									required : "Please select LIS Enrollee Type Flag"
								},
								'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.partdLisEnrSubsidy' : {
									
								},
								
								'lisInfo.${memberDBID}.${lisInfo.seqLisInfo}.partdLisSubsidy' : {
									
								},		
													
							</g:each>
								
						</g:each>
					</g:if>
				</g:if>				
				--}%	
				<g:if test="${'BILLING'.equals(params.editType)}">
					<g:if test="${memberEligHistoryMap}">
						<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
							var="memberDBID">
							<g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
								var="eligibilityHistoryVar">
									'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.aboveGiaApprovalInd' : {
										required : "Please select Above GIA Approval Indicator"
									},
							</g:each>
						</g:each>
				 	</g:if>
				 </g:if>
									
				<g:if test="${'DETAIL'.equals(params.editType)}">
				<g:if test="${memberEligHistoryMap}">
				<g:each in="${memberEligHistoryMap.keySet() }" status="idCount"
					var="memberDBID">
			 <g:each in="${memberEligHistoryMap.get(memberDBID)}" status="i"
					var="eligibilityHistoryVar">
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.effectiveDate' : {
					required : "Please select a Effective Date"
				},
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.relationshipCode': {
					required : "Please select a Relationship Code"						
				},
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.eligStatus' : {
					required : "Please select a Eligibility Status"
				},
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.benefitStartDate' : {
					required : "Please select a Benefit Start Date"
				},
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.groupId' : {
					required : "Please enter a Group Id"						
				},
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.planCode' : {
					required : "Please enter a Plan Code."			
				},
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.lineOfBusiness' : {
					required : "Please enter a Line Of Business."			
				},
				'eligHistory.${memberDBID}.${eligibilityHistoryVar.seqEligHist}.privacyOn' : {
					required : "Please select a value for Privacy On"					
				}						
				<g:if test="${i < memberEligHistoryMap.get(memberDBID).size() && (i != memberEligHistoryMap.get(memberDBID).size()-1)}">
					,
					</g:if>
				</g:each>
					<g:if test="${i < memberEligHistoryMap.size() && (i != memberEligHistoryMap.size()-1)}">
						,
					</g:if>
				 </g:each>
				 </g:if>
				 </g:if>
				<g:if test="${'ADDRESS'.equals(params.editType)}">
					 <g:if test="memberAddressMap">
					 <g:each in="${memberAddressMap.keySet() }" status="idCount"
						 var="memberDBID">
						<g:each in="${ memberAddressMap.get(memberDBID)}" status="i"
							var="address">
						'address.${memberDBID }.${address.seqMembAddress}.effectiveDate' : {
							required : "Please select a Effective Date"
						},
						'address.${memberDBID }.${address.seqMembAddress}.email' : {
							required : "Please enter an email Id as contact preference is set as Email.", 
							email : "Please enter a valid email id"
						},
						'address.${memberDBID }.${address.seqMembAddress}.addressType': {
							required : "Please select a Address Type"
						}, 
						'address.${memberDBID }.${address.seqMembAddress}.billingAddress' : {
							required : "Please select a Billing Address"
						},
						'address.${memberDBID }.${address.seqMembAddress}.lastName' : {
							required : "Please enter Last Name"
						},
						'address.${memberDBID }.${address.seqMembAddress}.address1' : {
							required : "Please enter a Address 1"
						},
						'address.${memberDBID }.${address.seqMembAddress}.city' : {
							required : "Please select a value for City"
						},
						'address.${memberDBID }.${address.seqMembAddress}.state' : {
							required : "Please select a value for State"
						},
						'address.${memberDBID }.${address.seqMembAddress}.zip' : {
							required : "Please enter a value for Zip Code"	
						},
						'address.${memberDBID }.${address.seqMembAddress}.homePhone' : {
							digits : "Please enter only numbers for Home Phone"
						},
						'address.${memberDBID }.${address.seqMembAddress}.mobilePhone': {
							digits : "Please enter only numbers for Mobile Phone"
						},
						'address.${memberDBID }.${address.seqMembAddress}.beeperNumber': {
							digits : "Please enter only numbers for Beeper Number"
						},
						'address.${memberDBID }.${address.seqMembAddress}.alternatePhone': {
							digits : "Please enter only numbers for Alternate Phone"
						},
						'address.${memberDBID }.${address.seqMembAddress}.faxNumber': {
							digits : "Please enter only numbers for Fax Number"
						},
						'address.${memberDBID }.${address.seqMembAddress}.telephoneNumber': {
							digits : "Please enter only numbers for Telephone Number"
						},
						'address.${memberDBID }.${address.seqMembAddress}.telephoneNumberEx': {
							digits : "Please enter only numbers for Telephone Ext"
						},
						'address.${memberDBID }.${address.seqMembAddress}.businessPhone': {
							digits : "Please enter only numbers for Business Phone"
						}
						 <g:if test="${i <memberAddressMap.get(memberDBID).size() && (i != memberAddressMap.get(memberDBID).size()-1)}">
							,
						</g:if>
						</g:each>
									<g:if test="${i <memberAddressMap.size() && (i != memberAddressMap.size()-1)}">
									,
									</g:if>		
						 </g:each>
			</g:if>
					</g:if>
			} 
		
		})
	});
</g:if>
	
	<g:if test="${'BENEFICIARY'.equals(params.editType)}">
		<g:if test="memberBeneficiaryMap">
				<g:each in="${memberBeneficiaryMap.keySet()}" status="idCount" var="memberDBID">
						 <g:each in="${memberBeneficiaryMap.get(memberDBID)}" status="i" var="beneficiary">					 
							<g:if test="${'P'.equals(beneficiary.bfciaryCategory)}">
						 		$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.firstName]').bind('input', function () {
									var nameArray = [$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.firstName]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.middleInitial]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.lastName]').val(), 
													$('#beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.suffix').val() ];
										$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.bfciaryName]').val(nameArray.join(' '));	
								});
								
								$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.middleInitial]').bind('input', function () {
									var nameArray = [$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.firstName]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.middleInitial]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.lastName]').val(), 
													$('#beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.suffix').val() ];
										$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.bfciaryName]').val(nameArray.join(' '));
								});
								
								$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.lastName]').bind('input', function () {
									var nameArray = [$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.firstName]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.middleInitial]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.lastName]').val(), 
													$('#beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.suffix').val() ];
										$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.bfciaryName]').val(nameArray.join(' '));
								});
								
								
								$('#beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.suffix').change(function () {
									var nameArray = [$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.firstName]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.middleInitial]').val(), 
													$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.lastName]').val(), 
													$('#beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.suffix').val() ];
										$('input[name=beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.bfciaryName]').val(nameArray.join(' '));
								});
								
							</g:if>
							
							//Allow tabbing but prevent postback to previous page if user presses backspace since this field is readonly
							$('#beneficiary\\.${memberDBID}\\.${beneficiary.seqBfciaryId}\\.country').live('keydown', function(e) {
							    if (e.keyCode != 9) {
							        e.preventDefault();
							    }
							});
							
						 </g:each>
				</g:each>
			</g:if>
	</g:if>
	
	
	function setMessage(memberDBID, seqBfciaryId, fieldName)
	{
		if ($('#beneficiary\\.' + memberDBID + '\\.' + seqBfciaryId + '\\.bfciaryCategory').val() == 'P')
		{
			if (fieldName == 'bfciaryName') {
				return "Please enter a Name";
			}
			else if (fieldName == 'firstName') {
				return "Please enter a First Name";
			}
			else if (fieldName == 'lastName') {
				return "Please enter a Last Name";
			}
			else if (fieldName == 'alphaspecialcharfirstName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for First Name";
			}
			else if (fieldName == 'alphaspecialcharlastName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Last Name";
			}
		}
		else if ($('#beneficiary\\.' + memberDBID + '\\.' + seqBfciaryId + '\\.bfciaryCategory').val() == 'T')
		{
			if (fieldName == 'bfciaryName') {
				return "Please enter a Trust Name";
			}
			else if (fieldName == 'firstName') {
				return "Please enter a Trustee First Name";
			}
			else if (fieldName == 'lastName') {
				return "Please enter a Trustee Last Name";
			}
			else if (fieldName == 'alphaspecialcharfirstName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Trustee First Name";
			}
			else if (fieldName == 'alphaspecialcharlastName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Trustee Last Name";
			}
		}
		else if ($('#beneficiary\\.' + memberDBID + '\\.' + seqBfciaryId + '\\.bfciaryCategory').val() == 'E')
		{
			if (fieldName == 'bfciaryName') {
				return "Please enter a Estate Name";
			}
			else if (fieldName == 'firstName') {
				return "Please enter a Executor First Name";
			}
			else if (fieldName == 'lastName') {
				return "Please enter a Executor Last Name";
			}
			else if (fieldName == 'alphaspecialcharfirstName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Executor First Name";
			}
			else if (fieldName == 'alphaspecialcharlastName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Executor Last Name";
			}
		}
		else if ($('#beneficiary\\.' + memberDBID + '\\.' + seqBfciaryId + '\\.bfciaryCategory').val() == 'O')
		{
			if (fieldName == 'bfciaryName') {
				return "Please enter a Organization Name";
			}
			else if (fieldName == 'firstName') {
				return "Please enter a Contact First Name";
			}
			else if (fieldName == 'lastName') {
				return "Please enter a Contact Last Name";
			}
			else if (fieldName == 'alphaspecialcharfirstName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Contact First Name";
			}
			else if (fieldName == 'alphaspecialcharlastName') {
				return "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Contact Last Name";
			}
		}
	}	

	}); 
	
	
</script>

<style type="text/css">
#report changed {
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

function closeForm() 
{
	if(userflag)
	{
			var result = confirm("You will lose unsaved data, Are you sure you want to close the form?");
			if (result==true) 
			{
				var appName = "${appContext.metadata['app.name']}";
				window.location.assign("/"+appName+"/memberMaintenance/list")
			}
	}
	else
	{
			var appName = "${appContext.metadata['app.name']}";
			window.location.assign("/"+appName+"/memberMaintenance/list")
	}
}
var grpInnerWindow 
var innerWindowClosed = true;
function closeAllIFrames() {
	if(grpInnerWindow) {
		grpInnerWindow.close()
	}
}

function lookup(idName, cdoClassName, cdoClassAttributeName, assocFieldIds, assocFieldCdoName, updateFields, updateFieldsCdoName) {

    if(${'MASTER'.equals(params.editType)})
    {
    if(cdoClassName !="com.perotsystems.diamond.bom.Language"){
      	return false;
     }
    }
    
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
<body>
	<a href="#show-memberMaster" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'MASTER']}">Master Record</g:link></li>
			<li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
			<li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'ADDRESS']}">Addresses</g:link></li>
			<li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'BILLING']}">Billing</g:link></li>
		</ul>
		<ul>
		    <li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
			 <li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
			 <li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Information</g:link></li>
			<li><g:link class="list" action="show"
					id="${subscriberMember.subscriberID}"
					params="${[editType :'MEMMC_LIS_INFO']}">MEMMC LIS Info</g:link></li>
		</ul>
	</div>
	<div id="show-memberMaster" class="content scaffold-show" role="main">
		&nbsp;
		<h1 style="color: #48802C">
 			<g:if test="${("MASTER".equals(request.getParameter('editType')))}">Edit Member Master</g:if>
			<g:if test="${("DETAIL".equals(request.getParameter('editType')))}">Edit Member Detail</g:if>
			<g:if test="${("ADDRESS".equals(request.getParameter('editType')))}">Edit Member Address</g:if>
			<g:if test="${("BILLING".equals(request.getParameter('editType')))}">Edit Member Billing</g:if>
			<g:if test="${("BENEFICIARY".equals(request.getParameter('editType')))}">Edit Member Beneficiary</g:if>	
			<g:if test="${("BENEFICIARY_ALLOCATION".equals(request.getParameter('editType')))}">Edit Member Beneficiary Allocation</g:if>
			<g:if test="${("MEDICARE_ENROLLMENT_INFO".equals(request.getParameter('editType')))}">Edit Member Medicare Enrollment Info</g:if>
			<g:if test="${("MEMMC_LIS_INFO".equals(request.getParameter('editType')))}">Edit Member Lis Info</g:if>
			
		</h1>
		<div class="right-corner" align="center">
			<g:if test="${("MASTER".equals(request.getParameter('editType')))}">MEMBR</g:if>
			<g:if test="${("DETAIL".equals(request.getParameter('editType')))}">MELIG</g:if>
			<g:if test="${("ADDRESS".equals(request.getParameter('editType')))}">MEMBA</g:if>
			<g:if test="${("BILLING".equals(request.getParameter('editType')))}">MELIG</g:if>
			<g:if test="${("BENEFICIARY".equals(request.getParameter('editType')))}">MEBNM</g:if>	
			<g:if test="${("BENEFICIARY_ALLOCATION".equals(request.getParameter('editType')))}">MEBNA</g:if>
			<g:if test="${("MEDICARE_ENROLLMENT_INFO".equals(request.getParameter('editType')))}">MSMCE</g:if>
			<g:if test="${("MEMMC_LIS_INFO".equals(request.getParameter('editType')))}">MEMMCLIS</g:if>
		</div>
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
		<g:form action="update" id="editForm" name="editForm">
			<g:hiddenField name="memberDBID"
				value="${memberMasterInstance?.memberDBID}" />

			<div id="errorDisplay" style="display: none;" class="errors"
				style="float:left; margin: -5px 10px 0px 0px; "></div>
			<g:if
				test="${request.getParameter('editType')== null  | (request.getParameter('editType') && 'MASTER'.equals(request.getParameter('editType')))}">
				<fieldset class="memberMasterForm">
					<g:render template="memberMasterForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'DETAIL'.equals(request.getParameter('editType'))}">
				<fieldset class="memberEligibilityHistoryForm">
					<g:render template="memberEligibilityHistory" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'ADDRESS'.equals(request.getParameter('editType'))}">
				<fieldset class="groupAddressForm">
					<g:render template="memberAddressForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BILLING'.equals(request.getParameter('editType'))}">
				<fieldset class="groupBillingForm">
					<g:render template="memberBillingForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BENEFICIARY'.equals(request.getParameter('editType'))}">
				<fieldset class="memberBeneficiaryForm">
					<g:render template="memberBeneficiaryForm" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'BENEFICIARY_ALLOCATION'.equals(request.getParameter('editType'))}">
				<fieldset class="beneficiaryAllocation">
					<g:render template="beneficiaryAllocation" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'MEDICARE_ENROLLMENT_INFO'.equals(request.getParameter('editType'))}">
				<fieldset class="MEMMCValidation">
					<g:render template="MEMMCValidation" />
				</fieldset>
			</g:if>
			<g:if
				test="${request.getParameter('editType') && 'MEMMC_LIS_INFO'.equals(request.getParameter('editType'))}">
				<fieldset class="memberLisForm">
					<g:render template="memberLisForm" />
				</fieldset>
			</g:if>
			
			<fieldset class="buttons">
				<g:if test="${request.getParameter('editType') && 'BENEFICIARY_ALLOCATION'.equals(request.getParameter('editType'))}">
				</g:if>
				<g:else>
					<g:checkURIAuthorization uri="/memberMaintenance/update">
						<g:actionSubmit class="save" action="update"
							value="${message(code: 'default.button.update.label', default: 'List')}" onclick="checkNullValue()"/>
						<input type="Reset" class="reset" value="Reset" id="resetButton" />
					</g:checkURIAuthorization>
				</g:else>
				<input type="button" name="close" value="Close" class="close"
					onClick="closeForm()">
			</fieldset>
		</g:form>
	</div>
	<div style="display: none">
		<input type="button" onClick="closeAllIFrames()" id="closeIframes">
	</div>
</body>
</html>