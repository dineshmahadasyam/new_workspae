<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
<head>

<meta name="layout" content="main_2">
<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
<g:set var="appContext" bean="grailsApplication"/>
	
<title><g:message code="default.show.label" args="[entityName]" /></title>


<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css">

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-1.3.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.7.2.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
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

$(document).ready(function(){
		
	jQuery.validator.setDefaults({
		  	debug: true,
			ignore: ":hidden",		  
			success: "valid"
		});	
		
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
	                validator.errorList[0].element.focus();
	            }
	        },

	        errorLabelContainer: "#errorDisplay", 
			wrapper: "li",	
			rules : {
				 'beneficiary.0.P.bfciaryCategory' : {
					required : true
				},
				'beneficiary.0.P.relationshipCode' : {
					required : true
				},
				'beneficiary.0.P.firstName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.P.lastName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.P.middleInitial' : {
					alpha  : true
				},					
				'beneficiary.0.P.socialSecNo' : {
					required  : true,
					ssnmaxdigits: true	
				},
				'beneficiary.0.P.dateOfBirth' : {
					required : true
				},
				'beneficiary.0.P.gender' : {
					required : true
				},
				'beneficiary.0.P.addressLine1' : {
					required : true
				},
				'beneficiary.0.P.city' : {
					required : true,
					alphanumeric  : true	
				},
				'beneficiary.0.P.state' : {
					required : true		
				},
				'beneficiary.0.P.zipCode' : {
					required : true,
					zipcodeUS : true
				},
				'beneficiary.0.P.country' : {
					required : true,
					alphanumeric  : true		
				},
				'beneficiary.0.T.bfciaryCategory' : {
					required : true
				},
				'beneficiary.0.T.bfciaryName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.T.firstName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.T.lastName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.T.trustDate' : {
					required : true
				},
				'beneficiary.0.T.taxId' : {
					required : true,
					taxidUS	: true
				},
				'beneficiary.0.T.addressLine1' : {
					required : true
				},
				'beneficiary.0.T.city' : {
					required : true,
					alphanumeric  : true	
				},
				'beneficiary.0.T.state' : {
					required : true		
				},
				'beneficiary.0.T.zipCode' : {
					required : true,
					zipcodeUS : true
				},
				'beneficiary.0.T.country' : {
					required : true,
					alphanumeric  : true		
				},
				'beneficiary.0.E.bfciaryCategory' : {
					required : true
				},
				'beneficiary.0.E.bfciaryName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.E.firstName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.E.lastName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.E.addressLine1' : {
					required : true
				},
				'beneficiary.0.E.city' : {
					required : true,
					alphanumeric  : true	
				},
				'beneficiary.0.E.state' : {
					required : true		
				},
				'beneficiary.0.E.zipCode' : {
					required : true,
					zipcodeUS : true
				},
				'beneficiary.0.E.country' : {
					required : true,
					alphanumeric  : true		
				},
				'beneficiary.0.O.bfciaryCategory' : {
					required : true
				},
				'beneficiary.0.O.bfciaryName' : {
					required : true,
					alphaspecialchar  : true
				},	
				'beneficiary.0.O.firstName' : {
					required : true,
					alphaspecialchar  : true
				},
				'beneficiary.0.O.lastName' : {
					required : true,
					alphaspecialchar  : true
				},		
				'beneficiary.0.O.taxId' : {
					required : true,
					taxidUS : true
				},
				'beneficiary.0.O.addressLine1' : {
					required : true
				},
				'beneficiary.0.O.city' : {
					required : true,
					alphanumeric  : true	
				},
				'beneficiary.0.O.state' : {
					required : true		
				},
				'beneficiary.0.O.zipCode' : {
					required : true,
					zipcodeUS : true
				},
				'beneficiary.0.O.country' : {
					required : true,
					alphanumeric  : true		
				},

			},
			
			messages : 
			{
				'beneficiary.0.P.bfciaryCategory' : {
					required : "Please select a Category"
				},
				'beneficiary.0.P.relationshipCode' : {
					required : "Please select a Relationship Code"
				},
				'beneficiary.0.P.firstName': {
					required : "Please enter a First Name",
					alphaspecialchar : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for First Name"				
				},
				'beneficiary.0.P.lastName' : {
					required : "Please enter a Last Name",
					alphaspecialchar : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Last Name"						
				},
				'beneficiary.0.P.middleInitial' : {
					alpha : "Please enter only Letters A through Z for Middle Initial"						
				},
				'beneficiary.0.P.socialSecNo' : {
					required : "Please enter a SSN",
					ssnmaxdigits: "SSN must be 9 digits"
				},
				'beneficiary.0.P.dateOfBirth' : {
					required : "Please select a Date Of Birth"
				},
				'beneficiary.0.P.gender' : {
					required : "Please select a Gender"
				},
				'beneficiary.0.P.addressLine1' : {
					required : "Please enter a Address"					
				},
				'beneficiary.0.P.city' : {
					required : "Please enter a City",
					alphanumeric : "Please enter only Letters, numbers or underscores only for City"				
				},
				'beneficiary.0.P.state' : {
					required : "Please select a State"					
				},
				'beneficiary.0.P.zipCode' : {
					required : "Please enter a Zip Code" ,
					zipcodeUS : "Zip Code must be 5 or 9 digits"			
				},
				'beneficiary.0.P.country' : {
					required : "Please enter a Country",
					alphanumeric : "Please enter only Letters, numbers or underscores only for Country"										
				},
				'beneficiary.0.T.bfciaryCategory' : {
					required : "Please select a Category"
				},
				'beneficiary.0.T.bfciaryName' : {
					required : "Please enter a Trust Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Trust Name"
				},
				'beneficiary.0.T.firstName' : {
					required : "Please enter a Trustee First Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Trustee First Name"
				},
				'beneficiary.0.T.lastName' : {
					required : "Please enter a Trustee Last Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Trustee Last Name"
				},
				'beneficiary.0.T.trustDate' : {
					required : "Please select a Trust Date"
				},
				'beneficiary.0.T.taxId' : {
					required : "Please enter a valid Tax ID",
					taxidUS : "Tax ID must be 9 digits"
				},
				'beneficiary.0.T.addressLine1' : {
					required : "Please enter a Address"					
				},
				'beneficiary.0.T.city' : {
					required : "Please enter a City",
					alphanumeric : "Please enter only Letters, numbers or underscores only for City"				
				},
				'beneficiary.0.T.state' : {
					required : "Please select a State"					
				},
				'beneficiary.0.T.zipCode' : {
					required : "Please enter a Zip Code" ,
					zipcodeUS : "Zip Code must be 5 or 9 digits"			
				},
				'beneficiary.0.T.country' : {
					required : "Please enter a Country",
					alphanumeric : "Please enter only Letters, numbers or underscores only for Country"										
				},
				'beneficiary.0.E.bfciaryCategory' : {
					required : "Please select a Category"
				},
				'beneficiary.0.E.bfciaryName' : {
					required : "Please enter a Estate Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Estate Name"
				},
				'beneficiary.0.E.firstName' : {
					required : "Please enter a Executor First Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Executor First Name"
				},
				'beneficiary.0.E.lastName' : {
					required : "Please enter a Executor Last Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Executor Last Name"
				},
				'beneficiary.0.E.addressLine1' : {
					required : "Please enter a Address"					
				},
				'beneficiary.0.E.city' : {
					required : "Please enter a City",
					alphanumeric : "Please enter only Letters, numbers or underscores only for City"				
				},
				'beneficiary.0.E.state' : {
					required : "Please select a State"					
				},
				'beneficiary.0.E.zipCode' : {
					required : "Please enter a Zip Code" ,
					zipcodeUS : "Zip Code must be 5 or 9 digits"			
				},
				'beneficiary.0.E.country' : {
					required : "Please enter a Country",
					alphanumeric : "Please enter only Letters, numbers or underscores only for Country"										
				},
				'beneficiary.0.O.bfciaryCategory' : {
					required : "Please select a Category"
				},
				'beneficiary.0.O.bfciaryName' : {
					required : "Please enter a Organization Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Organization Name"
				},
				'beneficiary.0.O.firstName' : {
					required : "Please enter a Contact First Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Contact First Name"
				},
				'beneficiary.0.O.lastName' : {
					required : "Please enter a Contact Last Name",
					alphaspecialchar  : "Please enter only Letters A through Z and characters dash, comma, hyphen, period only for Contact Last Name"
				},
				'beneficiary.0.O.taxId' : {
					required : "Please enter a valid Tax ID",
					taxidUS : "Tax ID must be 9 digits"
				},
				'beneficiary.0.O.addressLine1' : {
					required : "Please enter a Address"					
				},
				'beneficiary.0.O.city' : {
					required : "Please enter a City",
					alphanumeric : "Please enter only Letters, numbers or underscores only for City"				
				},
				'beneficiary.0.O.state' : {
					required : "Please select a State"					
				},
				'beneficiary.0.O.zipCode' : {
					required : "Please enter a Zip Code" ,
					zipcodeUS : "Zip Code must be 5 or 9 digits"			
				},
				'beneficiary.0.O.country' : {
					required : "Please enter a Country",
					alphanumeric : "Please enter only Letters, numbers or underscores only for Country"										
				}
				
			} //messages end tag

		}); //editform validate end tag	

			jQuery.validator.addMethod("zipcodeUS", function(value, element) {
				return this.optional(element) || /\d{5}-\d{4}$|^\d{5}$/.test(value) || /\d{5}-____$/.test(value)
			}, "Zip Code must be 5 or 9 digits");
			
			jQuery.validator.addMethod("ssnmaxdigits", function(value, element) {
				return this.optional(element) || /\d{3}-\d{2}-\d{4}$/.test(value) 
			}, "SSN must be 9 digits");
			
			jQuery.validator.addMethod("taxidUS", function(value, element) {
				return this.optional(element) || /\d{2}-\d{7}$/.test(value) 
			}, "Tax ID must be 9 digits");
	
			jQuery.validator.addMethod("alphanumeric", function(value, element) {
				return this.optional(element) || /^[a-zA-Z0-9_ ]+$/i.test(value);
			}, "Please enter only Letters, numbers or underscores only.");
	
			jQuery.validator.addMethod("alphaspecialchar", function(value, element) {
				return this.optional(element) || /^[a-zA-Z-,_. ]+$/i.test(value);
			}, "Please enter only Letters A through Z and characters dash, comma, hyphen, period.");
	
			jQuery.validator.addMethod("alpha", function(value, element) {
				return this.optional(element) || /^[a-zA-Z]+$/i.test(value);
			}, "Please enter only Letters A through Z");

		   $(".bSSN").mask("?999-99-9999");
		   
		   $(".bZipCode").mask("99999?-9999");
		   
		   $(".bTaxID").mask("?99-9999999");
		   
		   //When page loads for the first time default the beneficiary category to Person
		   $('#beneficiary\\.0\\.P\\.bfciaryCategory').val('P')
		   ShowHide('P');
		
			//Load text fields appropriately when beneficiary category is changed
			$('#beneficiary\\.0\\.P\\.bfciaryCategory').change( function() {
				var benCategory = $('#beneficiary\\.0\\.P\\.bfciaryCategory').val();
				ShowHide(benCategory);
			});

			$('#beneficiary\\.0\\.T\\.bfciaryCategory').change( function() {
				var benCategory = $('#beneficiary\\.0\\.T\\.bfciaryCategory').val();
				ShowHide(benCategory);
			});

			$('#beneficiary\\.0\\.E\\.bfciaryCategory').change( function() {
				var benCategory = $('#beneficiary\\.0\\.E\\.bfciaryCategory').val();
				ShowHide(benCategory);
			});

			$('#beneficiary\\.0\\.O\\.bfciaryCategory').change( function() {
				var benCategory = $('#beneficiary\\.0\\.O\\.bfciaryCategory').val();
				ShowHide(benCategory);
			});

			//For Person Category - Populate the Name field with values from First name, Middle Initial,  and Last name and Suffix  when they change	
			$('input[name=beneficiary\\.0\\.P\\.firstName]').bind('input', function () {
				var nameArray = [$('input[name=beneficiary\\.0\\.P\\.firstName]').val(), $('input[name=beneficiary\\.0\\.P\\.middleInitial]').val(), $('input[name=beneficiary\\.0\\.P\\.lastName]').val(), $('#beneficiary\\.0\\.P\\.suffix').val() ];
				$('input[name=beneficiary\\.0\\.P\\.bfciaryName]').val(nameArray.join(' '));
			});

			$('input[name=beneficiary\\.0\\.P\\.middleInitial]').bind('input', function () {
				var nameArray = [$('input[name=beneficiary\\.0\\.P\\.firstName]').val(), $('input[name=beneficiary\\.0\\.P\\.middleInitial]').val(), $('input[name=beneficiary\\.0\\.P\\.lastName]').val(), $('#beneficiary\\.0\\.P\\.suffix').val() ];
				$('input[name=beneficiary\\.0\\.P\\.bfciaryName]').val(nameArray.join(' '));
			});

			$('input[name=beneficiary\\.0\\.P\\.lastName]').bind('input', function () {
				var nameArray = [$('input[name=beneficiary\\.0\\.P\\.firstName]').val(), $('input[name=beneficiary\\.0\\.P\\.middleInitial]').val(), $('input[name=beneficiary\\.0\\.P\\.lastName]').val(), $('#beneficiary\\.0\\.P\\.suffix').val() ];
				$('input[name=beneficiary\\.0\\.P\\.bfciaryName]').val(nameArray.join(' '));
			});

			$('#beneficiary\\.0\\.P\\.suffix').change(function () {
				var nameArray = [$('input[name=beneficiary\\.0\\.P\\.firstName]').val(), $('input[name=beneficiary\\.0\\.P\\.middleInitial]').val(), $('input[name=beneficiary\\.0\\.P\\.lastName]').val(), $('#beneficiary\\.0\\.P\\.suffix').val() ];
				$('input[name=beneficiary\\.0\\.P\\.bfciaryName]').val(nameArray.join(' '));
			});

			//Allow tabbing but prevent postback to previous page if user presses backspace since this field is readonly
			$('#beneficiary\\.0\\.P\\.country, #beneficiary\\.0\\.T\\.country, #beneficiary\\.0\\.E\\.country, #beneficiary\\.0\\.O\\.country').live('keydown', function(e) {
					if (e.keyCode != 9) {
						e.preventDefault();
					}
			});
			
			//If date changed set userflag to true. Will be used to check if user clicked on close without saving date.
			$('body').live('dateupdated', function(e) {
    			userflag = true;
			});
			

		$('#addrSameAsEmp').change( function()
			{
					var strAddrSameAsEmp= $('#addrSameAsEmp').val();
					var memberAddress = '${memberR1Address}';
					var memberAddressArray = [];
					var emptyAddress = true;
					memberAddressArray = memberAddress.split("|");
					
					if (strAddrSameAsEmp == 'Y')
					{
						for (i = 0; i < memberAddressArray.length; i++) 
							{
								if ((memberAddressArray[i].length) != 0) 
								{
									emptyAddress = false;
									break;
								}
							}
							//If active R1 address exists for the member then display that in the fields and mark the fields readonly
							if (!emptyAddress) 
								{
										$('input[name=beneficiary\\.0\\.P\\.addressLine1]').val(memberAddressArray[0]);
										$('input[name=beneficiary\\.0\\.P\\.addressLine2]').val(memberAddressArray[1]);
										$('input[name=beneficiary\\.0\\.P\\.city]').val(memberAddressArray[2]);
										$('#beneficiary\\.0\\.P\\.state').val(memberAddressArray[3]);
										if (memberAddressArray[4].length > 5)
										{
											$(".bZipCode").val(memberAddressArray[4].substr(0,5) + '-' + memberAddressArray[4].substr(5));
										}
										else if (memberAddressArray[4].length <= 5)
										{
											$(".bZipCode").val(memberAddressArray[4]);
										}
								}
							else
								{
									//alert the user that the member does not have a active address and the user will need to enter the address
									$('#addrSameAsEmp').val('N');
									alert('Employee does not have an active address on file. Please enter the address for the Beneficiary.');
									
								}
					}
					else
					{
						$('input[name=beneficiary\\.0\\.P\\.addressLine1]').val('');
						$('input[name=beneficiary\\.0\\.P\\.addressLine2]').val('');
						$('input[name=beneficiary\\.0\\.P\\.city]').val('');
						$('#beneficiary\\.0\\.P\\.state').val('');
						$(".bZipCode").val('');
					}
			});  //addrSameAsEmp change end tag

				

		//Called when the page is loaded and also when the beneficiary category is changed 
		function ShowHide(benCategory) 
		{
				var benCategory = benCategory;
				
				if (benCategory == 'P')
				{
					$('#personTable').show();
					$('#trustTable').hide();
					$('#estateTable').hide();
					$('#organizationTable').hide();
					$('#beneficiary\\.0\\.P\\.bfciaryCategory').val('P');
				}
				else if (benCategory == 'T')
				{
					$('#personTable').hide();
					$('#trustTable').show();
					$('#estateTable').hide();
					$('#organizationTable').hide();
					$('#beneficiary\\.0\\.T\\.bfciaryCategory').val('T');
				}
				else if (benCategory == 'E')
				{
					$('#personTable').hide();
					$('#trustTable').hide();
					$('#estateTable').show();
					$('#organizationTable').hide();
					$('#beneficiary\\.0\\.E\\.bfciaryCategory').val('E');
					
				}
				else if (benCategory == 'O')
				{
					$('#personTable').hide();
					$('#trustTable').hide();
					$('#estateTable').hide();
					$('#organizationTable').show();
					$('#beneficiary\\.0\\.O\\.bfciaryCategory').val('O');
				}
				
			} // function ShowHide end tag
	
	});	//document ready end tag

	function showSSNMessage()
	{
		alert ("Having your Beneficiary's Social Security Number on file prevents unnecessary delay and complications at the time death benefits become payable.");
	}
	
	function closeForm() 
	{		
		if(userflag)
		{
			var result = confirm("You will lose unsaved data, Are you sure you want to close the form?");
			if (result==true) 
			{
				var appName = "${appContext.metadata['app.name']}";
				var subId = "${params.susbcriberId}";
				window.location.assign("/"+appName+"/memberMaintenance/show/" + subId + "?editType=BENEFICIARY")
			}
		}
		else
		{
			var appName = "${appContext.metadata['app.name']}";
			var subId = "${params.susbcriberId}";  
			window.location.assign("/"+appName+"/memberMaintenance/show/" + subId + "?editType=BENEFICIARY")
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
					id="${params.susbcriberId}"
					params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}"
					params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" 
					params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Information</g:link></li>		
			<li><g:link class="list" action="show"
					id="${params.susbcriberId}" params="${[editType :'MEMMC_LIS_INFO']}">MEMMC LIS Info</g:link></li>
		</ul>
	</div>
	<div id="show-memberMaster" class="content scaffold-show" role="main">
		&nbsp;
		<h1 style="color: #48802C">
			Create New Beneficiary :
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

		<g:form action="saveMemberBeneficiary" id="editForm" name="editForm">
			<input type="hidden" name="memberDBID" value="${params.memberDBID}" />
			<input type="hidden" name="personNumber" value="${params.personNumber}" />
			<input type="hidden" name="subscriberId" value="${params.susbcriberId }" />
			<table>
				<tr>
					<td>
						<table border="0" id="report">
							<tr class="showme">
								<td colspan="13">
									<div class="divContent">
											<table id="personTable" class="report"  border="0" style="table-layout:fixed;">
													<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
																<label for="bfciaryCategory"> 
																	<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:getSystemCodeToken
																systemCodeType="BFCIARY_CAT" languageId="0"
																htmlElelmentId="beneficiary.0.P.bfciaryCategory"
																blankValue="Beneficiary Category"
																defaultValue="${beneficiary?.bfciaryCategory}" width="250px" 
																title="The Beneficiary Category" />
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
																<label for="bfciaryName"> 
																	<g:message code="beneficiary.bfciaryName.label" default="Name:"/>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.bfciaryName" readonly="readonly" onkeydown="event.preventDefault()"
																style="width:50%" value="${beneficiary.bfciaryName }" tabindex="-1" maxlength="180"
																title="Beneficiary Name as entered in Firstname, Middle Initial, Lastname, Suffix"/>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'relationshipCode', 'error')} ">
																<label for="relationshipCode"> 
																	<g:message	code="beneficiary.relationshipCode.label" default="Relationship Code:"/>
																	<span class="required-indicator">*</span> 
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<div class="fieldcontain">
																<g:getSystemCodeToken
																systemCodeType="BFCIARY_REL" languageId="0"
																htmlElelmentId="beneficiary.0.P.relationshipCode"
																blankValue="Relationship Code"
																defaultValue="${beneficiary?.relationshipCode}" width="250px" 
																title="Relationship Code"/>
															</div>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
																<label for="firstName"> 
																	<g:message code="beneficiary.firstName.label" default="First Name:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.firstName" 
																maxlength="60" style="width:50%" value="${beneficiary.firstName}" 
																title ="The First Name of the Person"/>
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.middleInitial', 'error')} ">
																<label for="middleInitial"> 
																	<g:message code="beneficiary.middleInitial.label" default="Middle Initial:"/>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.middleInitial" 
																maxlength="35" style="width:50%" value="${beneficiary.middleInitial }"
																title="The Middle Initial of the Person"/>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
																<label for="lastName"> 
																	<g:message code="beneficiary.lastName.label" default="Last Name:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.lastName" 
																maxlength="60" style="width:50%" value="${beneficiary.lastName }"
																title="The Last Name of the Person"/>
														</td>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.suffix', 'error')} ">
																<label for="suffix"> 
																	<g:message code="beneficiary.suffix.label" default="Suffix:" />
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:getCdoSelectBox cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
																cdoAttributeWhereValue="F"
																cdoAttributeWhere="titleType"
																cdoAttributeSelect="contactTitle"
																cdoAttributeSelectDesc="description"
																languageId="0"
																htmlElelmentId="beneficiary.0.P.suffix"
																defaultValue="${beneficiary?.suffix}"
																blankValue="Suffix" 
																width="150px"
															    title="The Suffix of the Person"/>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.socialSecNo', 'error')} ">
																<label for="socialSecNo"> 
																	<g:message code="beneficiary.socialSecNo.label" default="SSN:"/>
																		<span class="required-indicator">*</span>
																</label>									
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
																<g:textField name="beneficiary.0.P.socialSecNo" class="bSSN" style="width:50%"
																	maxlength="11" value="${beneficiary?.socialSecNo}" 
																	title="The Social Security Number (SSN) of the Person"/>
																<img width="15" height="15" src="${resource(dir: 'images', file: 'help.gif')}" style="float:none;vertical-align:middle" title="Click to see why we ask for SSN" onclick="showSSNMessage();">
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.dateOfBirth', 'error')} ">
																<label for="dateOfBirth"> 
																	<g:message code="beneficiary.dateOfBirth.label" default="Date of Birth:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">																	
																<fmsui:jqDatePicker dateElementId="beneficiary.0.P.dateOfBirth"
																	dateElementName="beneficiary.0.P.dateOfBirth" mandatory="mandatory"
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (beneficiary?.dateOfBirth != null ? beneficiary?.dateOfBirth.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100', maxDate:0" 
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: beneficiary?.dateOfBirth)}" 
																	title="The Date of Birth of the Person"/>  
													   	</td>
													</tr>
													<tr>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.gender', 'error')} ">
																<label for="beneficiaryGender"> 
																	<g:message code="beneficiary.gender.label" default="Gender:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:getDiamondDataWindowDetail columnName="gender"
																dwName="dw_edied_de" languageId="0"
																htmlElelmentId="beneficiary.0.P.gender"
																defaultValue="${beneficiary?.gender}"
																blankValue="Gender" 
																width="150px"
																title="The Gender of the Person"/>
														</td>
													</tr>
													<tr>
														<td colspan="6">&nbsp;</td>
													</tr>
													<tr>
														<td colspan="6">
															Person Address
															<hr/>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap">
																<div class="fieldcontain">
																	<label for="addrSameAsEmp"> 
																		<g:message code="addrSameAsEmp.label" default="Address same as Employee :" />
																	</label>
																</div>
														</td>
														<td class="tdFormElement" colspan="2">
																<div class="fieldcontain">
																	<select name="addrSameAsEmp" id="addrSameAsEmp" title="Is this Persons address the same as the Employee?">
																		<option value="N">No</option>
																		<option value="Y">Yes</option>
																	</select>
																</div>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
																<label for="addressLine1"> 
																	<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.addressLine1"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine1 }"
																title="The Address of the Person"/>
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
																<label for="addressLine2"> 
																	<g:message code="beneficiary.addressLine2.label" default="Address 2:"/>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.addressLine2"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine2 }"
																title="The Address of the Person (the Suite, the Building, the Floor etc.)"/>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
																<label for="city"> 
																	<g:message code="beneficiary.city.label" default="City:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.city"  
																maxlength="30" style="width:50%" value="${beneficiary.city }"
																title="The City of the Person"/>
														</td>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
																<label for="benState"> 
																	<g:message code="beneficiary.benState.label" default="State:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:select name="beneficiary.0.P.state" 
																optionKey="stateCode" optionValue="stateName"
																id="beneficiary.0.P.state" from="${states}"
																noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
																title="The State of the Person"></g:select>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
																	<label for="zipCode"> 
																		<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																			<span class="required-indicator">*</span>
																	</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
																<g:textField name="beneficiary.0.P.zipCode" class="bZipCode"
																maxlength="10" style="width:50%" value="${beneficiary?.zipCode}" 
																title="The Zip Code of the Person"/>
														</td>
													   	<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
																<label for="country"> 
																	<g:message code="beneficiary.country.label" default="Country:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.P.country" style="width:50%" readonly="readonly" 
															title="The Country of the Person" maxlength="30" value="USA" />
														</td>
												</tr>
											</table>
											<table id="trustTable" class="report" border="0" style="table-layout:fixed;">
												<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
																<label for="bfciaryCategory"> 
																	<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:getSystemCodeToken
																systemCodeType="BFCIARY_CAT" languageId="0"
																htmlElelmentId="beneficiary.0.T.bfciaryCategory"
																blankValue="Beneficiary Category"
																defaultValue="${beneficiary?.bfciaryCategory}" width="250px" 
																title="The Beneficiary Category" />
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
																<label for="bfciaryName"> 
																	<g:message code="beneficiary.bfciaryName.label" default="Trust Name:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.T.bfciaryName" maxlength="180"
																style="width:50%" value="${beneficiary.bfciaryName }"
																title="The Name of the Trust"/>
														</td>
													</tr>
												<tr>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
																<label for="firstName"> 
																	<g:message code="beneficiary.firstName.label" default="Trustee First Name:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
													</td>
													<td class="tdFormElement" colspan="2">
														<g:textField name="beneficiary.0.T.firstName" 
															maxlength="60" style="width:50%" value="${beneficiary.firstName}" 
															title ="The First Name of the Trustee"/>
													</td>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
																<label for="lastName"> 
																	<g:message code="beneficiary.lastName.label" default="Trustee Last Name:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.T.lastName" 
																maxlength="60" style="width:50%" value="${beneficiary.lastName }"
																title="The Last Name of the Trustee"/>
														</td>
												</tr>
												<tr>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.trustDate', 'error')} ">
																<label for="trustDate"> 
																	<g:message code="beneficiary.trustDate.label" default="Trust Date:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
													</td>
													<td class="tdFormElement" colspan="2">																	
																<fmsui:jqDatePicker dateElementId="beneficiary.0.T.trustDate"
																	dateElementName="beneficiary.0.T.trustDate" mandatory="mandatory"
																	datePickerOptions="changeMonth:true, changeYear:true, yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (beneficiary?.trustDate != null ? beneficiary?.trustDate.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:100', maxDate:0" 
																	dateElementValue="${formatDate(format:'MM/dd/yyyy',date: beneficiary?.trustDate)}" 
																	title="The Trust Date"/>  
													</td>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.taxId', 'error')} ">
																<label for="taxId"> 
																	<g:message code="beneficiary.taxId.label" default="Tax ID:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
													</td>
													<td class="tdFormElement" colspan="2">
														<g:textField name="beneficiary.0.T.taxId" class="bTaxID"
															maxlength="10" style="width:50%" value="${beneficiary.taxId}" 
															title ="The Tax ID of the Trustee"/>
													</td>
												</tr>
												<tr>
													<td colspan="6">&nbsp;</td>
												</tr>
												<tr>
														<td colspan="6">
															Trustee Address
															<hr/>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
																<label for="addressLine1"> 
																	<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.T.addressLine1"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine1 }"
																title="The Address of the Trustee"/>
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
																<label for="addressLine2"> 
																	<g:message code="beneficiary.addressLine2.label" default="Address 2:"/>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.T.addressLine2"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine2 }"
																title="The Address of the Trustee"/>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
																<label for="city"> 
																	<g:message code="beneficiary.city.label" default="City:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.T.city"  
																maxlength="30" style="width:50%" value="${beneficiary.city }"
																title="The City of the Trustee"/>
														</td>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
																<label for="benState"> 
																	<g:message code="beneficiary.benState.label" default="State:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:select name="beneficiary.0.T.state" 
																optionKey="stateCode" optionValue="stateName"
																id="beneficiary.0.T.state" from="${states}"
																noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
																title="The State of the Trustee"></g:select>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
																	<label for="zipCode"> 
																		<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																			<span class="required-indicator">*</span>
																	</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
																<g:textField name="beneficiary.0.T.zipCode" class="bZipCode"
																maxlength="10" style="width:50%" value="${beneficiary?.zipCode}" 
																title="The Zip Code of the Trustee"/>
														</td>
													   	<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
																<label for="country"> 
																	<g:message code="beneficiary.country.label" default="Country:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.T.country" style="width:50%" 
															readonly="readonly" title="The Country of the Trustee" maxlength="30" value="USA" />
														</td>
												</tr>
											</table>
											<table id="estateTable" class="report" border="0" style="table-layout:fixed;">
												<tr>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
																<label for="bfciaryCategory"> 
																	<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:getSystemCodeToken
																systemCodeType="BFCIARY_CAT" languageId="0"
																htmlElelmentId="beneficiary.0.E.bfciaryCategory"
																blankValue="Beneficiary Category"
																defaultValue="${beneficiary?.bfciaryCategory}" width="250px" 
																title="The Beneficiary Category" />
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
																<label for="bfciaryName"> 
																	<g:message code="beneficiary.bfciaryName.label" default="Estate Name:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.E.bfciaryName" maxlength="180"
																style="width:50%" value="${beneficiary.bfciaryName }"
																title="The Name of the Estate"/>
														</td>
													</tr>
												<tr>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
																<label for="firstName"> 
																	<g:message code="beneficiary.firstName.label" default="Executor First Name:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
													</td>
													<td class="tdFormElement" colspan="2">
														<g:textField name="beneficiary.0.E.firstName" 
															maxlength="60" style="width:50%" value="${beneficiary.firstName}" 
															title ="The First Name of the Executor"/>
													</td>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
																<label for="lastName"> 
																	<g:message code="beneficiary.lastName.label" default="Executor Last Name:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
													</td>
													<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.E.lastName" 
																maxlength="60" style="width:50%" value="${beneficiary.lastName }"
																title="The Last Name of the Executor"/>
													</td>
												</tr>
												<tr>
													<td colspan="6">&nbsp;</td>
												</tr>
												<tr>
														<td colspan="6">
															Executor Address
															<hr/>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
																<label for="addressLine1"> 
																	<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.E.addressLine1"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine1 }"
																title="The Address of the Executor"/>
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
																<label for="addressLine2"> 
																	<g:message code="beneficiary.addressLine2.label" default="Address 2:"/>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.E.addressLine2"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine2 }"
																title="The Address of the Executor"/>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
																<label for="city"> 
																	<g:message code="beneficiary.city.label" default="City:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.E.city"  
																maxlength="30" style="width:50%" value="${beneficiary.city }"
																title="The City of the Executor"/>
														</td>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
																<label for="benState"> 
																	<g:message code="beneficiary.benState.label" default="State:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:select name="beneficiary.0.E.state" 
																optionKey="stateCode" optionValue="stateName"
																id="beneficiary.0.E.state" from="${states}"
																noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
																title="The State of the Executor"></g:select>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
																	<label for="zipCode"> 
																		<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																			<span class="required-indicator">*</span>
																	</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
																<g:textField name="beneficiary.0.E.zipCode" class="bZipCode"
																maxlength="10" style="width:50%" value="${beneficiary?.zipCode}" 
																title="The Zip Code of the Executor"/>
														</td>
													   	<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
																<label for="country"> 
																	<g:message code="beneficiary.country.label" default="Country:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.E.country" style="width:50%" readonly="readonly" 
															title="The Country of the Executor" maxlength="30" value="USA" />
														</td>
												</tr>	
											
											
											</table>
											<table id="organizationTable" class="report" border="0" style="table-layout:fixed;">
												<tr>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryCategory', 'error')} ">
																<label for="bfciaryCategory"> 
																	<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:getSystemCodeToken
																systemCodeType="BFCIARY_CAT" languageId="0"
																htmlElelmentId="beneficiary.0.O.bfciaryCategory"
																blankValue="Beneficiary Category"
																defaultValue="${beneficiary?.bfciaryCategory}" width="250px" 
																title="The Beneficiary Category" />
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.bfciaryName', 'error')} ">
																<label for="bfciaryName"> 
																	<g:message code="beneficiary.bfciaryName.label" default="Organization Name:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.O.bfciaryName" maxlength="180"
																style="width:50%" value="${beneficiary.bfciaryName }"
																title="The Name of the Organization"/>
														</td>
													</tr>
													<tr>
														<td class="tdnoWrap">
																<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.firstName', 'error')} ">
																	<label for="firstName"> 
																		<g:message code="beneficiary.firstName.label" default="Contact First Name:" />
																		<span class="required-indicator">*</span>
																	</label>
																</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.O.firstName" 
																maxlength="60" style="width:50%" value="${beneficiary.firstName}" 
																title ="The First Name of the Organization Contact Person"/>
														</td>
														<td class="tdnoWrap">
																<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.lastName', 'error')} ">
																	<label for="lastName"> 
																		<g:message code="beneficiary.lastName.label" default="Contact Last Name:" />
																		<span class="required-indicator">*</span>
																	</label>
																</div>
														</td>
														<td class="tdFormElement" colspan="2">
																<g:textField name="beneficiary.0.O.lastName" 
																	maxlength="60" style="width:50%" value="${beneficiary.lastName }"
																	title="The Last Name of the Organization Contact Person"/>
														</td>
												</tr>
												<tr>
													<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.taxId', 'error')} ">
																<label for="taxId"> 
																	<g:message code="beneficiary.taxId.label" default="Tax ID:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
													</td>
													<td class="tdFormElement" colspan="2">
														<g:textField name="beneficiary.0.O.taxId" class="bTaxID"
															maxlength="10" style="width:50%" value="${beneficiary.taxId}" 
															title ="The Tax ID of the Organization"/>
													</td>
												</tr>
											
												<tr>
													<td colspan="6">&nbsp;</td>
												</tr>
												<tr>
														<td colspan="6">
															Organization Address
															<hr/>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine1', 'error')} ">
																<label for="addressLine1"> 
																	<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.O.addressLine1"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine1 }"
																title="The Address of the Organization"/>
														</td>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.addressLine2', 'error')} ">
																<label for="addressLine2"> 
																	<g:message code="beneficiary.addressLine2.label" default="Address 2:"/>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.O.addressLine2"  
																maxlength="60" style="width:50%" value="${beneficiary.addressLine2 }"
																title="Additional Organization Address information "/>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.city', 'error')} ">
																<label for="city"> 
																	<g:message code="beneficiary.city.label" default="City:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.O.city"  
																maxlength="30" style="width:50%" value="${beneficiary.city }"
																title="The City of the Organization"/>
														</td>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.state', 'error')} ">
																<label for="benState"> 
																	<g:message code="beneficiary.benState.label" default="State:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:select name="beneficiary.0.O.state" 
																optionKey="stateCode" optionValue="stateName"
																id="beneficiary.0.O.state" from="${states}"
																noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
																title="The State of the Organization"></g:select>
														</td>
												</tr>
												<tr>
														<td class="tdnoWrap" >
															<div class="fieldcontain ${hasErrors(bean: beneficiary, field: 'beneficiary.zipCode', 'error')} ">
																	<label for="zipCode"> 
																		<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
																			<span class="required-indicator">*</span>
																	</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
																<g:textField name="beneficiary.0.O.zipCode" class="bZipCode"
																maxlength="10" style="width:50%" value="${beneficiary?.zipCode}" 
																title="The Zip Code of the Organization"/>
														</td>
													   	<td class="tdnoWrap">
															<div class="fieldcontain ${hasErrors(bean:beneficiary, field: 'beneficiary.country', 'error')} ">
																<label for="country"> 
																	<g:message code="beneficiary.country.label" default="Country:" />
																	<span class="required-indicator">*</span>
																</label>
															</div>
														</td>
														<td class="tdFormElement" colspan="2">
															<g:textField name="beneficiary.0.O.country" style="width:50%" readonly="readonly" 
															title="The Country of the Organization" maxlength="30" value="USA" />
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
				<g:actionSubmit class="save" action="saveMemberBeneficiary"
					value="${message(code: 'default.button.create.label', default: 'List')}" />
				<input type="Reset" class="reset" value="Reset" id="resetButton" />
				<input type="button" class="close" name="close" value="Close" onClick="closeForm()">
			</fieldset>
		</g:form>
	</div>

</body>
</html>