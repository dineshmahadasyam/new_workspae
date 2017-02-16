<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
		<g:set var="appContext" bean="grailsApplication"/>
		
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_ADD_BENEFICIARY.equals(currentPage)?true:false}" />
			
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="memberMaintenance"/>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dirtyform.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script> 

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

		<script>
	
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
			
					
			jQuery.validator.setDefaults({
				ignore: ":hidden",	
				debug: true			 
				});


		/**
		* 	Validation Error Issue	
		*
			jQuery.validator.setDefaults({
			  	debug: true,
				ignore: ":hidden",		  
				success: "valid"
			});	
		*/
			
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
						messages : {
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
							
						} 
						 
					})
				});
			
				});
</script>

<script>			
			$(document).ready(function(){   
			
				$('.btnInfoAlert').hide();  
				$('.btnInfoAlert').click(function(e){ 
		        	$('#InfoAlert').modal('show');
		        });
		     	$('#InfoAlert').modal({
		        	backdrop: 'static',
		           show: false
		       	});
				
				$('.btnInfoAlert1').hide();  
				$('.btnInfoAlert1').click(function(e){ 
		        	$('#InfoAlert1').modal('show');
		        });
		     	$('#InfoAlert1').modal({
		        	backdrop: 'static',
		           show: false
		       	});

		     	$('.btnInfoAlert2').hide();  
				$('.btnInfoAlert2').click(function(e){ 
		        	$('#InfoAlert2').modal('show');
		        });
		     	$('#InfoAlert2').modal({
		        	backdrop: 'static',
		           show: false
		       	});

		     	$("#BtnDeleteRowYes").click(function(e){	  		         
		     		var appName = "${appContext.metadata['app.name']}";
					var subId = "${params.susbcriberId}";
					window.location.assign("/"+appName+"/memberMaintenance/show/" + subId + "?editType=BENEFICIARY")
		           
		  		});
	     	 
		      $('.btnResetddressAlert').hide(); 
		      $('.btnResetddressAlert').click(function(e){ 
	               $('#WarningAlert').modal('show');
	          });
	
             $('#WarningAlert').modal({
               backdrop: 'static',
               show: false
             });

          	$('btnResetddressAlert').click(function() {
              	$('#editForm').each(function() {
              	  	this.reset();
               });
           });
           
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
				$('#beneficiary\\.0\\.P\\.country, #beneficiary\\.0\\.T\\.country, #beneficiary\\.0\\.E\\.country, #beneficiary\\.0\\.O\\.country').on('keydown', function(e) {
						if (e.keyCode != 9) {
							e.preventDefault();
						}
				});
				
				//If date changed set userflag to true. Will be used to check if user clicked on close without saving date.
				$('body').on('dateupdated', function(e) {
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
									//	alert('Employee does not have an active address on file. Please enter the address for the Beneficiary.');
										document.getElementById('BtnInfoAlertId1').click();
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
									$('#personWidget').show();
									$('#personWidgetAddrs').show();
														
									$('#trustTable').hide();
									$('#trustWidget').hide();
									$('#trustWidgetAddrs').hide();	
													
													
									$('#estateTable').hide();
									$('#estateWidget').hide();
									$('#estateWidgetAddrs').hide();
									
									$('#organizationTable').hide();
									$('#orgWidget').hide();
									$('#orgWidgetAddrs').hide();
									
									$('#beneficiary\\.0\\.P\\.bfciaryCategory').val('P');
								}
								else if (benCategory == 'T')
								{
									$('#personTable').hide();
									$('#personWidget').hide();
									$('#personWidgetAddrs').hide();
									
									$('#trustTable').show();
									$('#trustWidget').show();
									$('#trustWidgetAddrs').show();
									
									$('#estateTable').hide();
									$('#estateWidget').hide();
									$('#estateWidgetAddrs').hide();
									
									$('#organizationTable').hide();
									$('#orgWidget').hide();
									$('#orgWidgetAddrs').hide();
									
									$('#beneficiary\\.0\\.T\\.bfciaryCategory').val('T');
								}
								else if (benCategory == 'E')
								{
									$('#personTable').hide();
									$('#personWidget').hide();
									$('#personWidgetAddrs').hide();
									
									$('#trustTable').hide();
									$('#trustWidget').hide();
									$('#trustWidgetAddrs').hide();
									
									$('#estateTable').show();
									$('#estateWidget').show();
									$('#estateWidgetAddrs').show();
									
									$('#organizationTable').hide();
									$('#orgWidget').hide();
									$('#orgWidgetAddrs').hide();
									
									$('#beneficiary\\.0\\.E\\.bfciaryCategory').val('E');
									
								}
								else if (benCategory == 'O')
								{
									$('#personTable').hide();
									$('#personWidget').hide();
									$('#personWidgetAddrs').hide();
									
									$('#trustTable').hide();
									$('#trustWidget').hide();
									$('#trustWidgetAddrs').hide();
									
									$('#estateTable').hide();
									$('#estateWidget').hide();
									$('#estateWidgetAddrs').hide();
									
									$('#organizationTable').show();
									$('#orgWidget').show();
									$('#orgWidgetAddrs').show();
									
									$('#beneficiary\\.0\\.O\\.bfciaryCategory').val('O');
								}
					
				} // function ShowHide end tag
		
			});	//document ready end tag
		
			function showSSNMessage()
			{
				// alert ("Having your Beneficiary's Social Security Number on file prevents unnecessary delay and complications at the time death benefits become payable.");
				document.getElementById('BtnInfoAlertId').click();
			}
			
			function closeForm() 
			{	
				if(userflag)
				{
					document.getElementById('BtnInfoAlertId2').click();			
					
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
	<!-- START - FMS Content -->
	<div id="fms_content">
	
		<div id="fms_content_header">
	    	<div class="fms_content_header_note">
	      		<a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / 
	      		<g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link>
	      			/ Create New Beneficiary : ${params.susbcriberId } Person Number : ${ params.personNumber }
	      	</div>
		  	<div class="fms_content_title">
	          <h1>Create New Beneficiary</h1>
	        </div>
		</div> 
		
		<%-- START - Tabs --%>
        <div id="fms_content_tabs">
          	<ul>
	            <li><g:link class="list" action="memberDashboard1" title="Click to view Dashboard." id="${params.susbcriberId}" params="${[subscriberId: params.susbcriberId, personNumber: params.personNumber, issuerSubscriberId:params.issuerSubscriberId]}">Dashboard</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MASTER']}">Master Record</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BILLING']}">Billing</g:link></li>
	            <li><g:link class="active" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
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
	 		<div class="right-corner" align="right">MEBNM</div>
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
					<g:form action="saveMemberBeneficiary" id="editForm" name="editForm">
						<input type="hidden" name="memberDBID" value="${params.memberDBID}" />
						<input type="hidden" name="personNumber" value="${params.personNumber}" />
						<input type="hidden" name="subscriberId" value="${params.susbcriberId }" />
					
						<table id="personTable" class="report"  border="0" style="table-layout:fixed;">
				
						<!-- START - WIDGET: General Information -->
						<div id="personWidget" class="fms_widget">
							<fieldset class="no_border">
							    <legend><h2>General Information</h2></legend>
	                            <div class="fms_form_layout_2column">                  
									<div class="fms_form_column fms_very_long_labels">
	                              		
										<label id="bfciaryCategory_label" class="control-label fms_required" for="bfciaryCategory"> 
											<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
										</label>
										<div class="fms_form_input">
											<g:getSystemCodeToken
												cssClass="form-control"
												aria-labelledby="bfciaryCategory_label" 
												aria-describedby="bfciaryCategory_error" 
												aria-required="true"
												systemCodeType="BFCIARY_CAT" languageId="0"
												htmlElelmentId="beneficiary.0.P.bfciaryCategory"
												blankValue="Beneficiary Category"
												defaultValue="${beneficiary?.bfciaryCategory}"
												title="The Beneficiary Category" />
											<div class="fms_form_error" id="bfciaryCategory_error"></div>
										</div>
										
										<label id="relationshipCode_label" class="control-label fms_required" for="relationshipCode"> 
											<g:message	code="beneficiary.relationshipCode.label" default="Relationship Code:"/>
										</label>
										<div class="fms_form_input">
											<g:getSystemCodeToken
												cssClass="form-control"
												aria-labelledby="relationshipCode_label" 
												aria-describedby="relationshipCode_error" 
												aria-required="true"
												systemCodeType="BFCIARY_REL" languageId="0"
												htmlElelmentId="beneficiary.0.P.relationshipCode"
												blankValue="Relationship Code"
												defaultValue="${beneficiary?.relationshipCode}"
												title="Relationship Code"/>
											<div class="fms_form_error" id="relationshipCode_error"></div>
										</div>
										
										
										<label id="firstName_label" class="control-label fms_required" for="firstName"> 
											<g:message code="beneficiary.firstName.label" default="First Name:" />
										</label>
											
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="firstName_label" 
												aria-describedby="firstName_error" 
												aria-required="true"
												name="beneficiary.0.P.firstName" 
												maxlength="60" 
												value="${beneficiary.firstName}" 
												title ="The First Name of the Person"/>
											<div class="fms_form_error" id="firstName_error"></div>
										</div>
										
										<label id="middleInitial_label" class="control-label" for="middleInitial"> 
											<g:message code="beneficiary.middleInitial.label" default="Middle Initial:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="middleInitial_label" 
												aria-describedby="middleInitial_error" 
												aria-required="true"
												name="beneficiary.0.P.middleInitial" 
												maxlength="35" 
												value="${beneficiary.middleInitial }"
												title="The Middle Initial of the Person" />
											<div class="fms_form_error" id="middleInitial_error"></div>
										</div>
										
										<label id="lastName_label" class="control-label fms_required" for="lastName"> 
										<g:message code="beneficiary.lastName.label" default="Last Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="lastName_label" 
												aria-describedby="lastName_error" 
												aria-required="true"
												name="beneficiary.0.P.lastName" 
												maxlength="60" 
												value="${beneficiary.lastName }"
												title="The Last Name of the Person" />
											<div class="fms_form_error" id="lastName_error"></div>
										</div>
										
										<label id="socialSecNo_label" class="control-label fms_required" for="beneficiaryGender"> 
											<g:message code="beneficiary.gender.label" default="Gender:" />
										</label>
										<div class="fms_form_input">	
											<g:getDiamondDataWindowDetail 
												cssClass="form-control"
												aria-labelledby="socialSecNo_label" 
												aria-describedby="beneficiaryGender_error" 
												aria-required="true"
												columnName="gender"
												dwName="dw_edied_de" languageId="0"
												htmlElelmentId="beneficiary.0.P.gender"
												defaultValue="${beneficiary?.gender}"
												blankValue="Gender"
												title="The Gender of the Person"/>
											<div class="fms_form_error" id="beneficiaryGender_error"></div>
										</div>
									</div>
									<div class="fms_form_column fms_very_long_labels">
										<label id="bfciaryName_label" class="control-label" for="bfciaryName"> 
											<g:message code="beneficiary.bfciaryName.label" default="Name:"/>
										</label>
										
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="bfciaryName_label" 
												aria-describedby="bfciaryName_error" 
												aria-required="true"
												name="beneficiary.0.P.bfciaryName" 
												readonly="readonly" onkeydown="event.preventDefault()"
												value="${beneficiary.bfciaryName }" 
												tabindex="-1" 
												maxlength="180"
												title="Beneficiary Name as entered in Firstname, Middle Initial, Lastname, Suffix" />
											<div class="fms_form_error" id="bfciaryName_error"></div>
										<br><br>
										</div>
										
										<label id="suffix_label" class="control-label" for="suffix"> 
											<g:message code="beneficiary.suffix.label" default="Suffix:" />
										</label>
										<div class="fms_form_input">
											<g:getCdoSelectBox 
												className="form-control"
												cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
												cdoAttributeWhereValue="F"
												cdoAttributeWhere="titleType"
												cdoAttributeSelect="contactTitle"
												cdoAttributeSelectDesc="description"
												languageId="0"
												htmlElelmentId="beneficiary.0.P.suffix"
												defaultValue="${beneficiary?.suffix}"
												blankValue="Suffix" 
											    title="The Suffix of the Person"/>
			 								<div class="fms_form_error" id="suffix_error"></div>
										</div>
										
										<label id="socialSecNo_label" class="control-label fms_required" for="socialSecNo"> 
											<g:message code="beneficiary.socialSecNo.label" default="SSN:"/>
										</label>
										<div class="fms_form_input fms_has_feedback">
											<g:textField 
												Class="form-control fms_ssn_mask"
												aria-labelledby="socialSecNo_label" 
												aria-describedby="socialSecNo_error" 
												aria-required="true"
												placeholder="000-00-0000"
												name="beneficiary.0.P.socialSecNo" 
												maxlength="11" 
												value="${beneficiary?.socialSecNo}" 
												title="The Social Security Number (SSN) of the Person"/>
											<button type="button" class="btn fms_btn_icon btn-sm fms_form_control_feedback" onclick="showSSNMessage();">
												<i class="fa fa-question"></i>
											</button>
											<div class="fms_form_error" id="socialSecNo_error"></div>
										</div>
										
										<label id="dateOfBirth_label" class="control-label fms_required" for="dateOfBirth"> 
											<g:message code="beneficiary.dateOfBirth.label" default="Date of Birth:" />
										</label>
										<div class="fms_form_input">																
											<fmsui:jqDatePickerUIUX  
												dateElementId="beneficiary.0.P.dateOfBirth"
												dateElementName="beneficiary.0.P.dateOfBirth" mandatory="mandatory"
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+0', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: beneficiary?.dateOfBirth)}" 
												title="The Date of Birth of the Person"
												ariaAttributes="aria-labelledby='beneficiaryDob_label' aria-describedby='beneficiaryDob_error' aria-required='false'" 
                                            	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                            	showIconDefault="${isShowCalendarIcon}"/>	                                  
                                            <div class="fms_form_error" id="beneficiaryDob_error"></div>
										</div>
									</div>
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: General Information -->
						
						<!-- START - WIDGET: Person Address -->
						<div class="fms_widget" id="personWidgetAddrs">        
	                       	<fieldset class="no_border">
	                          	<legend><h3>Person Address</h3></legend>
	                            <div class="fms_form_layout_2column">                  
	                              	<div class="fms_form_column fms_very_long_labels">
											
										<label id="addrSameAsEmp_label" class="control-label fms_required" for="addrSameAsEmp"> 
											<g:message code="addrSameAsEmp.label" default="Address same as Employee:" />
										</label>
										<div class="fms_form_input">
											<select class="form-control" 
													aria-labelledby="addrSameAsEmp_label" 
													aria-describedby="addrSameAsEmp_error" 
													aria-required="false"
													name="addrSameAsEmp" 
													id="addrSameAsEmp" 
													title="Is this Persons address the same as the Employee?">
												<option value="N">No</option>
												<option value="Y">Yes</option>
											</select>
											<div class="fms_form_error" id="addrSameAsEmp_error"></div>
										</div>
																
										<label id="addressLine1_label" class="control-label fms_required" for="addressLine1"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine1_label" 
												aria-describedby="addressLine1_error" 
												aria-required="true"
												name="beneficiary.0.P.addressLine1"  
												maxlength="60" 
												value="${beneficiary.addressLine1 }"
												title="The Address of the Person"/>
											<div class="fms_form_error" id="addressLine1_error"></div>
										</div>
										
										<label id="addressLine2_label" class="control-label" for="addressLine2"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 2:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine2_label" 
												aria-describedby="addressLine2_error" 
												aria-required="true"
												name="beneficiary.0.P.addressLine2"  
												maxlength="60" 
												value="${beneficiary.addressLine2 }"
												title="The Address of the Person (the Suite, the Building, the Floor etc.)"/>
											<div class="fms_form_error" id="addressLine2_error"></div>
										</div>
										
										<label id="city_label" class="control-label fms_required" for="city"> 
											<g:message code="beneficiary.city.label" default="City:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="city_label" 
												aria-describedby="city_error" 
												aria-required="true"
												name="beneficiary.0.P.city"  
												maxlength="30"
												value="${beneficiary.city }"
												title="The City of the Person"/>
											<div class="fms_form_error" id="city_error"></div>
										</div>
								
									</div>
										                  
	                              	<div class="fms_form_column fms_very_long_labels">
	                              		
	                              		<br></br>
										
										<label id="benState_label" class="control-label fms_required" for="benState"> 
											<g:message code="beneficiary.benState.label" default="State:" />
										</label>
										<div class="fms_form_input">
											<g:select 
												Class="form-control"
												aria-labelledby="benState_label" 
												aria-describedby="benState_error" 
												aria-required="true"
												name="beneficiary.0.P.state" 
												optionKey="stateCode" optionValue="stateName"
												id="beneficiary.0.P.state" from="${states}"
												noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
												title="The State of the Person"></g:select>
											<div class="fms_form_error" id="benState_error"></div>
										</div>
										
										<label id="zipCode_label" class="control-label fms_required" for="zipCode"> 
											<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control bZipCode"
												aria-labelledby="zipCode_label" 
												aria-describedby="zipCode_error" 
												aria-required="true"
												name="beneficiary.0.P.zipCode"
												maxlength="10" 
												value="${beneficiary?.zipCode}" 
												title="The Zip Code of the Person"/>
											<div class="fms_form_error" id="zipCode_error"></div>
										</div>
										
									   	<label id="country_label" class="control-label fms_required" for="country"> 
											<g:message code="beneficiary.country.label" default="Country:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="country_label" 
												aria-describedby="country_error" 
												aria-required="true"
												name="beneficiary.0.P.country"
												readonly="readonly" 
												title="The Country of the Person" 
												maxlength="30" 
												value="USA" />
											<div class="fms_form_error" id="country_error"></div>
										</div>
	                              	</div>
	                         	</div>
	                      	</fieldset>
	                  	</div>
	                  	<!-- END - WIDGET: Person Address -->
	                 	</table>
	                 	<table id="trustTable" class="report" border="0" style="table-layout:fixed;">
	                 
	                 	<!-- START - WIDGET: Trust Information 2 --> 	
	                  	<div class="fms_widget" id="trustWidget">        
	                       	<fieldset class="no_border">
	                          	<legend><h3>Trust Info</h3></legend>
	                            <div class="fms_form_layout_2column">                  
	                              	<div class="fms_form_column fms_very_long_labels">
	                         			
										<label id="bfciaryCategory_label" class="control-label fms_required" for="bfciaryCategory"> 
											<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
										</label>
										<div class="fms_form_input">
											<g:getSystemCodeToken
												cssClass="form-control"
												aria-labelledby="bfciaryCategory_label" 
												aria-describedby="bfciaryCategory_error" 
												aria-required="true"
												systemCodeType="BFCIARY_CAT" languageId="0"
												htmlElelmentId="beneficiary.0.T.bfciaryCategory"
												blankValue="Beneficiary Category"
												defaultValue="${beneficiary?.bfciaryCategory}"
												title="The Beneficiary Category" />
											<div class="fms_form_error" id="bfciaryCategory_error"></div>
										</div>
										
										<label id="firstName_label" class="control-label fms_required" for="firstName"> 
											<g:message code="beneficiary.firstName.label" default="Trustee First Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="firstName_label" 
												aria-describedby="firstName_error" 
												aria-required="true"
												name="beneficiary.0.T.firstName" 
												maxlength="60"
												title ="The First Name of the Trustee"/>
											<div class="fms_form_error" id="firstName_error"></div>
										</div>
										
										<label id="lastName_label" class="control-label fms_required" for="lastName"> 
											<g:message code="beneficiary.lastName.label" default="Trustee Last Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="lastName_label" 
												aria-describedby="lastName_error" 
												aria-required="true"
												name="beneficiary.0.T.lastName" 
												maxlength="60" 
												value="${beneficiary.lastName }"
												title="The Last Name of the Trustee"/>
											<div class="fms_form_error" id="lastName_error"></div>
										</div>
									</div>
									
									<div class="fms_form_column fms_very_long_labels">
										
										<label id="bfciaryName_label" class="control-label fms_required" for="bfciaryName"> 
											<g:message code="beneficiary.bfciaryName.label" default="Trust Name:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="bfciaryName_label" 
												aria-describedby="bfciaryName_error" 
												aria-required="true"
												name="beneficiary.0.T.bfciaryName" 
												maxlength="180"
												value="${beneficiary.bfciaryName }"
												title="The Name of the Trust"/>
											<div class="fms_form_error" id="bfciaryName_error"></div>
										</div>
										
										<label id="trustDate_label" class="control-label fms_required" for="trustDate"> 
											<g:message code="beneficiary.trustDate.label" default="Trust Date:" />
										</label>
										<div class="fms_form_input">													
											<fmsui:jqDatePickerUIUX  dateElementId="beneficiary.0.T.trustDate"
												dateElementName="beneficiary.0.T.trustDate" mandatory="mandatory"
												datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+0'" 
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: beneficiary?.trustDate)}" 
												title="The Trust Date"
												ariaAttributes="aria-labelledby='trustDate_label' aria-describedby='trustDate_error' aria-required='false'" 
                                            	classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                            	showIconDefault="${isShowCalendarIcon}"/>  
											<div class="fms_form_error" id="firstName_error"></div>
										</div>
										
										<label id="taxId_label" class="control-label fms_required" for="taxId"> 
											<g:message code="beneficiary.taxId.label" default="Tax ID:" />
										</label>
										<div class="fms_form_input">		
											<g:textField 
												Class="form-control bTaxID"
												aria-labelledby="taxId_label" 
												aria-describedby="taxId_error" 
												aria-required="true"
												name="beneficiary.0.T.taxId" 
												maxlength="10"
												value="${beneficiary.taxId}" 
												title ="The Tax ID of the Trustee"/>
											<div class="fms_form_error" id="taxId_error"></div>
										</div>
									</div>
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: Trust Information -->
						
						<!-- START - WIDGET: Trustee Address -->
						<div class="fms_widget" id="trustWidgetAddrs">        
	                       	<fieldset class="no_border">
	                          	<legend><h3>Trustee Address</h3></legend>
	                            <div class="fms_form_layout_2column">                  
	                              	<div class="fms_form_column fms_very_long_labels">
									
										<label id="addressLine1_label" class="control-label fms_required" for="addressLine1"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine1_label" 
												aria-describedby="addressLine1_error" 
												aria-required="true"
												name="beneficiary.0.T.addressLine1"  
												maxlength="60" 
												value="${beneficiary.addressLine1 }"
												title="The Address of the Trustee"/>
											<div class="fms_form_error" id="addressLine1_error"></div>
										</div>
										
										<label id="addressLine2_label" class="control-label" for="addressLine2"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 2:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine2_label" 
												aria-describedby="addressLine2_error" 
												aria-required="true"
												name="beneficiary.0.T.addressLine2"  
												maxlength="60" 
												value="${beneficiary.addressLine2 }"
												title="The Address of the Trustee"/>
											<div class="fms_form_error" id="addressLine2_error"></div>
										</div>
										
										<label id="city_label" class="control-label fms_required" for="city"> 
											<g:message code="beneficiary.city.label" default="City:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="city_label" 
												aria-describedby="city_error" 
												aria-required="true"
												name="beneficiary.0.T.city"  
												maxlength="30"
												value="${beneficiary.city }"
												title="The City of the Trustee"/>
											<div class="fms_form_error" id="city_error"></div>
										</div>
									</div>
										                  
	                              	<div class="fms_form_column fms_very_long_labels">
										<label id="benState_label" class="control-label fms_required" for="benState"> 
											<g:message code="beneficiary.benState.label" default="State:" />
										</label>
										<div class="fms_form_input">
											<g:select 
												Class="form-control"
												aria-labelledby="benState_label" 
												aria-describedby="benState_error" 
												aria-required="true"
												name="beneficiary.0.T.state" 
												optionKey="stateCode" optionValue="stateName"
												id="beneficiary.0.T.state" from="${states}"
												noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
												title="The State of the Trustee"></g:select>
											<div class="fms_form_error" id="benState_error"></div>
										</div>
										
										<label id="zipCode_label" class="control-label fms_required" for="zipCode"> 
											<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control bZipCode"
												aria-labelledby="zipCode_label" 
												aria-describedby="zipCode_error" 
												aria-required="true"
												name="beneficiary.0.T.zipCode"
												maxlength="10" 
												value="${beneficiary?.zipCode}" 
												title="The Zip Code of the Trustee"/>
											<div class="fms_form_error" id="zipCode_error"></div>
										</div>
										
									   	<label id="country_label" class="control-label fms_required" for="country"> 
											<g:message code="beneficiary.country.label" default="Country:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="country_label" 
												aria-describedby="country_error" 
												aria-required="true"
												name="beneficiary.0.T.country"
												readonly="readonly" 
												title="The Country of the Trustee" 
												maxlength="30" 
												value="USA" />
											<div class="fms_form_error" id="country_error"></div>
										</div>
									</div>
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: Trustee Address -->
						
						</table>
						<table id="estateTable" class="report" border="0" style="table-layout:fixed;">
						
						<!-- START - WIDGET: Estate Information -->
						<div class="fms_widget" id="estateWidget">        
	                       	<fieldset class="no_border">
	                          	<legend><h3>Estate Info</h3></legend>
	                            <div class="fms_form_layout_2column">                  
	                              	<div class="fms_form_column fms_very_long_labels">
	                              			
	                              					
										<label id="bfciaryCategory_label" class="control-label fms_required" for="bfciaryCategory"> 
											<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
										</label>
										<div class="fms_form_input">
											<g:getSystemCodeToken
												cssClass="form-control"
												aria-labelledby="bfciaryCategory_label" 
												aria-describedby="bfciaryCategory_error" 
												aria-required="true"
												systemCodeType="BFCIARY_CAT" languageId="0"
												htmlElelmentId="beneficiary.0.E.bfciaryCategory"
												blankValue="Beneficiary Category"
												defaultValue="${beneficiary?.bfciaryCategory}"
												title="The Beneficiary Category" />
											<div class="fms_form_error" id="bfciaryCategory_error"></div>
										</div>
										
										<label id="bfciaryName_label" class="control-label fms_required"  for="bfciaryName"> 
											<g:message code="beneficiary.bfciaryName.label" default="Estate Name:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="bfciaryName_label" 
												aria-describedby="bfciaryName_error" 
												aria-required="true"
												name="beneficiary.0.E.bfciaryName" 
												maxlength="180"
												value="${beneficiary.bfciaryName }"
												title="The Name of the Estate"/>
											<div class="fms_form_error" id="bfciaryName_error"></div>
										</div>
									</div>
									
									<div class="fms_form_column fms_very_long_labels">
										<label id="firstName_label" class="control-label fms_required" for="firstName"> 
											<g:message code="beneficiary.firstName.label" default="Executor First Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="firstName_label" 
												aria-describedby="firstName_error" 
												aria-required="true"
												name="beneficiary.0.E.firstName" 
												maxlength="60" 
												value="${beneficiary.firstName}" 
												title ="The First Name of the Executor"/>
											<div class="fms_form_error" id="firstName_error"></div>
										</div>
										
										<label id="lastName_label" class="control-label fms_required" for="lastName"> 
											<g:message code="beneficiary.lastName.label" default="Executor Last Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="lastName_label" 
												aria-describedby="lastName_error" 
												aria-required="true"
												name="beneficiary.0.E.lastName" 
												maxlength="60"
												value="${beneficiary.lastName }"
												title="The Last Name of the Executor"/>
											<div class="fms_form_error" id="lastName_error"></div>
										</div>
									</div>
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: Estate Information -->
						
						<!-- START - WIDGET: Executor Address -->
						<div class="fms_widget" id="estateWidgetAddrs">        
	                       	<fieldset class="no_border">
	                          	<legend><h3>Executor Address</h3></legend>
	                            <div class="fms_form_layout_2column">                  
	                              	<div class="fms_form_column fms_very_long_labels">
									
										<label id="addressLine1_label" class="control-label fms_required" for="addressLine1"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine1_label" 
												aria-describedby="addressLine1_error" 
												aria-required="true"
												name="beneficiary.0.E.addressLine1"  
												maxlength="60" 
												value="${beneficiary.addressLine1 }"
												title="The Address of the Executor"/>
											<div class="fms_form_error" id="addressLine1_error"></div>
										</div>
									
										<label id="addressLine2_label" class="control-label" for="addressLine2"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 2:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine2_label" 
												aria-describedby="addressLine2_error" 
												aria-required="true"
												name="beneficiary.0.E.addressLine2"  
												maxlength="60" 
												value="${beneficiary.addressLine2 }"
												title="The Address of the Executor"/>
											<div class="fms_form_error" id="addressLine2_error"></div>
										</div>
											
										<label id="city_label" class="control-label fms_required" for="city"> 
											<g:message code="beneficiary.city.label" default="City:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="city_label" 
												aria-describedby="city_error" 
												aria-required="true"
												name="beneficiary.0.E.city"  
												maxlength="30"
												value="${beneficiary.city }"
												title="The City of the Executor"/>
											<div class="fms_form_error" id="city_error"></div>
										</div>
									</div>
										                  
	                              	<div class="fms_form_column fms_very_long_labels">
										<label id="benState_label" class="control-label fms_required" for="benState"> 
											<g:message code="beneficiary.benState.label" default="State:" />
										</label>
										<div class="fms_form_input">
											<g:select 
												Class="form-control"
												aria-labelledby="benState_label" 
												aria-describedby="benState_error" 
												aria-required="true"
												name="beneficiary.0.E.state" 
												optionKey="stateCode" optionValue="stateName"
												id="beneficiary.0.E.state" from="${states}"
												noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
												title="The State of the Executor"></g:select>
											<div class="fms_form_error" id="benState_error"></div>
										</div>
										
										<label id="zipCode_label" class="control-label fms_required" for="zipCode"> 
											<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control bZipCode"
												aria-labelledby="zipCode_label" 
												aria-describedby="zipCode_error" 
												aria-required="true"
												name="beneficiary.0.E.zipCode"
												maxlength="10" 
												value="${beneficiary?.zipCode}" 
												title="The Zip Code of the Executor"/>
											<div class="fms_form_error" id="zipCode_error"></div>
										</div>
										
									   	<label id="country_label" class="control-label fms_required" for="country"> 
											<g:message code="beneficiary.country.label" default="Country:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="country_label" 
												aria-describedby="country_error" 
												aria-required="true"
												name="beneficiary.0.E.country"
												readonly="readonly" 
												title="The Country of the Executor" 
												maxlength="30" 
												value="USA" />
											<div class="fms_form_error" id="country_error"></div>
										</div>
									</div>
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: Executor Address -->
						
						</table>
						<table id="organizationTable" class="report" border="0" style="table-layout:fixed;">
						
						<!-- START - WIDGET: Organization Information -->
						<div class="fms_widget" id="orgWidget">        
	                       	<fieldset class="no_border">
	                          	<legend><h3>Organization Info</h3></legend>
	                            <div class="fms_form_layout_2column">                  
	                              	<div class="fms_form_column fms_very_long_labels">
	                              	
	                            		<label id="bfciaryCategory_label" class="control-label fms_required" for="bfciaryCategory"> 
											<g:message code="beneficiary.bfciaryCategory.label" default="Beneficiary Category:"/>
										</label>
										<div class="fms_form_input">
											<g:getSystemCodeToken
												cssClass="form-control"
												aria-labelledby="bfciaryCategory_label" 
												aria-describedby="bfciaryCategory_error" 
												aria-required="true"
												systemCodeType="BFCIARY_CAT" languageId="0"
												htmlElelmentId="beneficiary.0.O.bfciaryCategory"
												blankValue="Beneficiary Category"
												defaultValue="${beneficiary?.bfciaryCategory}"
												title="The Beneficiary Category" />
											<div class="fms_form_error" id="bfciaryCategory_error"></div>
										</div>
										
										<label id="bfciaryName_label" class="control-label fms_required" for="bfciaryName"> 
											<g:message code="beneficiary.bfciaryName.label" default="Organization Name:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="bfciaryName_label" 
												aria-describedby="bfciaryName_error" 
												aria-required="true"
												name="beneficiary.0.O.bfciaryName" 
												maxlength="180"
												value="${beneficiary.bfciaryName }"
												title="The Name of the Organization" />
											<div class="fms_form_error" id="bfciaryName_error"></div>	
										</div>
										
										<label id="taxId_label" class="control-label fms_required" for="taxId"> 
											<g:message code="beneficiary.taxId.label" default="Tax ID:" />
										</label>
										<div class="fms_form_input">		
											<g:textField 
												Class="form-control bTaxID"
												aria-labelledby="taxId_label" 
												aria-describedby="taxId_error" 
												aria-required="true"
												name="beneficiary.0.O.taxId" 
												maxlength="10"
												value="${beneficiary.taxId}" 
												title ="The Tax ID of the Organization"/>
											<div class="fms_form_error" id="taxId_error"></div>
										</div>
									</div>							
									
									<div class="fms_form_column fms_very_long_labels">
										
										<label id="firstName_label" class="control-label fms_required" for="firstName"> 
											<g:message code="beneficiary.firstName.label" default="Contact First Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="firstName_label" 
												aria-describedby="firstName_error" 
												aria-required="true"
												name="beneficiary.0.O.firstName" 
												maxlength="60" 
												value="${beneficiary.firstName}" 
												title ="The First Name of the Organization Contact Person"/>
											<div class="fms_form_error" id="firstName_error"></div>
										</div>
										
										<label id="lastName_label" class="control-label fms_required" for="lastName"> 
											<g:message code="beneficiary.lastName.label" default="Contact Last Name:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="lastName_label" 
												aria-describedby="lastName_error" 
												aria-required="true"
												name="beneficiary.0.O.lastName" 
												maxlength="60" 
												value="${beneficiary.lastName }"
												title="The Last Name of the Organization Contact Person"/>
											<div class="fms_form_error" id="lastName_error"></div>
										</div>
									</div>	
								</div>
							</fieldset>
						</div>
						<!-- END - WIDGET: Organization Information -->
							
						<!-- START - WIDGET: Organization Address -->		
						<div class="fms_widget" id="orgWidgetAddrs">        
	                       	<fieldset class="no_border">
	                          	<legend><h3>Organization Address</h3></legend>
	                            <div class="fms_form_layout_2column">                  
	                              	<div class="fms_form_column fms_very_long_labels">
									
										<label id="addressLine1_label" class="control-label fms_required" for="addressLine1"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 1:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine1_label" 
												aria-describedby="addressLine1_error" 
												aria-required="true"
												name="beneficiary.0.O.addressLine1"  
												maxlength="60" 
												value="${beneficiary.addressLine1 }"
												title="The Address of the Organization"/>
											<div class="fms_form_error" id="addressLine1_error"></div>
										</div>
									
										<label id="addressLine2_label" class="control-label" for="addressLine2"> 
											<g:message code="beneficiary.addressLine1.label" default="Address 2:"/>
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="addressLine2_label" 
												aria-describedby="addressLine2_error" 
												aria-required="true"
												name="beneficiary.0.O.addressLine2"  
												maxlength="60" 
												value="${beneficiary.addressLine2 }"
												title="The Address of the Organization"/>
											<div class="fms_form_error" id="addressLine2_error"></div>
										</div>
											
										<label id="city_label" class="control-label fms_required" for="city"> 
											<g:message code="beneficiary.city.label" default="City:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="city_label" 
												aria-describedby="city_error" 
												aria-required="true"
												name="beneficiary.0.O.city"  
												maxlength="30"
												value="${beneficiary.city }"
												title="The City of the Organization"/>
											<div class="fms_form_error" id="city_error"></div>
										</div>
									</div>
										                  
									<div class="fms_form_column fms_very_long_labels">
										<label id="benState_label" class="control-label fms_required" for="benState"> 
											<g:message code="beneficiary.benState.label" default="State:" />
										</label>
										<div class="fms_form_input">
											<g:select 
												Class="form-control"
												aria-labelledby="benState_label" 
												aria-describedby="benState_error" 
												aria-required="true"
												name="beneficiary.0.O.state" 
												optionKey="stateCode" optionValue="stateName"
												id="beneficiary.0.O.state" from="${states}"
												noSelection="['':'-- Select a State --']" value="${beneficiary.state}"
												title="The State of the Organization"></g:select>
											<div class="fms_form_error" id="benState_error"></div>
										</div>
									
										<label id="zipCode_label" class="control-label fms_required" for="zipCode"> 
											<g:message code="beneficiary.zipCode.label" default="Zip Code:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control bZipCode"
												aria-labelledby="zipCode_label" 
												aria-describedby="zipCode_error" 
												aria-required="true"
												name="beneficiary.0.O.zipCode"
												maxlength="10" 
												value="${beneficiary?.zipCode}" 
												title="The Zip Code of the Organization"/>
											<div class="fms_form_error" id="zipCode_error"></div>
										</div>
									   	<label id="country_label" class="control-label fms_required" for="country"> 
											<g:message code="beneficiary.country.label" default="Country:" />
										</label>
										<div class="fms_form_input">
											<g:textField 
												Class="form-control"
												aria-labelledby="country_label" 
												aria-describedby="country_error" 
												aria-required="true"
												name="beneficiary.0.O.country"
												readonly="readonly" 
												title="The Country of the Organization" 
												maxlength="30" 
												value="USA" />
											<div class="fms_form_error" id="country_error"></div>
										</div>
									</div>
								</div>
							</fieldset>
						</div>	
						<!-- END - WIDGET: Organization Address -->		
						
						</table>
						
						<!-- START - BUTTONS -->
						
						<div class="fms_form_button">
						 	<g:actionSubmit class="btn btn-primary" action="saveMemberBeneficiary" value="${message(code: 'default.button.save.label', default: 'Save')}" />
						 	<input type="Reset" class="btn btn-default" value="Reset" id="resetButton" />
							<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
							<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset address form." data-target="#InfoAlert"><span class="glyphicon glyphicon-repeat"></span></button>
							<button id="BtnInfoAlertId1" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert1" title="Click to reset address form." data-target="#InfoAlert1"><span class="glyphicon glyphicon-repeat"></span></button>
		      				<button id="BtnInfoAlertId2" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert2" title="Click to close form." data-target="#InfoAlert2"><span class="glyphicon glyphicon-repeat"></span></button>
		      			</div>	
		      			<!-- END - BUTTONS -->
					</g:form>
				</div>
			</div>
		</div>
		<!-- END - FMS Content Body -->
  	</div>
  	<!-- END - FMS Content -->
  	
  	<!-- START - Search Notice Modal -->
  	<div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>Having your Beneficiary's Social Security Number on file prevents unnecessary delay and complications at the time death benefits become payable.</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
	
	<div class="modal fade" id="InfoAlert1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>Employee does not have an active address on file. Please enter the address for the Beneficiary.</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
	<!-- END - Search Notice Modal -->
	
	<!-- START - Close Modal -->
<div class="modal fade" id="InfoAlert2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	<div class="modal-dialog">
		<div class="modal-content fms_modal_error">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4>You will lose unsaved data, Are you sure you want to close the form?</h4>            
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
			</div>
		</div>
	</div>
</div>
</html>