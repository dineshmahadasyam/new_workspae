<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'planMaster.label', default: 'Plan')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="sysMaint"/> 
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>		
		<g:set var="isShowCalendarIcon" value="${ ((PageNameEnum.PLAN_EDIT.equals(currentPage)) || (PageNameEnum.PLAN_CREATE.equals(currentPage)))?true:false}" />
				
		<script type="text/javascript">
			$(document).ready(function(){
				
				$(function() {		
					$("#editForm").validate({
						onfocusout: false,
						submitHandler: function (form) {
							  if ($(form).valid()) 
			                      form.submit(); 
			                  return false; // prevent normal form posting
				        },
				        invalidHandler: function(form, validator) {
				            var errors = validator.numberOfInvalids();
				            if (errors) {      
					            //Hide any previous message from the server when the client validation is occuring
				            	$(".message").hide();              
				            }
				        },
						errorLabelContainer: "#errorDisplay", 
						 wrapper: "li",		
										
						rules : {
							'shortDescription' : {
								required : true
							},
							'description' : {
								required : true
							},
							'productType' : {
								required : true
							},
						},
						messages : {
							'shortDescription' : {
								required : "Please enter the Short Description."
							},
							'description' : {
								required : "Please enter the Long Description."
							},
							'productType' : {
								required : "Please enter the Product Type."
							},
						} 
						
					})
				});
			}); 
			
		</script>
		
		<script>
				function clearSearchCriteria() {
					var elements = document.getElementsByTagName("input");
					var firstText = true;
					for (var ii=0; ii < elements.length; ii++) {
					  if (elements[ii].type == "text") {
					    elements[ii].value = "";
					    if (firstText) {
						    firstText = false;
					    	elements[ii].focus();
						 }
					  }
					  if (elements[ii].type == "radio") {
						    elements[ii].checked = false;
					  }
					}
					var elements = document.getElementsByTagName("select");
					for (var ii=0; ii < elements.length; ii++) {
					    elements[ii].selectedIndex = 0;
					}
				}
				function setFirstElementFocus() {
					//alert ("requesting Focus")
					var firstText = true;
					var elements = document.getElementsByTagName("input");
					for (var ii=0; ii < elements.length; ii++) {
						  if (elements[ii].type == "text") {
						    if (firstText) {
							    firstText = false;
						    	elements[ii].focus();
						    	//break;
							 }
						  }
					}
				}
				
				function create() {
					var createID = "${params.planCode}";
					var appName = "${appContext.metadata['app.name']}";
					window.location.assign("/"+appName+"/planMaintenance/edit/plan?planCode="
									+ createID);
				}
				
				function createNew() {
					window.location.assign("create?planCode=${params.planCode}");
				}
				
				(function($){
				   $("#planCode").alphanum({
					    allow 		: '-_',
					    allowSpace  : false
					});
				})
				
				function edit() {
				var createID = "${params.planCode}";
				var appName = "${appContext.metadata['app.name']}";
				window.location.assign("/"+appName+"/planMaintenance/plan?planCode="
							+ createID);
				}
				
				function checkForSearchCritera(){
				var elements = document.getElementsByTagName("input");
				var searchCriteria = false;
				
				for (var ii=0; ii < elements.length; ii++) {
				  if (elements[ii].type == "text") {
				    if(elements[ii].value){
					    searchCriteria = true;
					    }
				  }
				}
				
				var selects = document.getElementsByTagName("select");
				for (var ii=0; ii < selects.length; ii++) {
				  if (selects[ii]) {
				    if(selects[ii].value != ""){
					    searchCriteria = true;
					}
				  }
				}
					
				  if(searchCriteria == false){
					alert ("Please enter search criteria to find results.");
				  }
				  
				  return searchCriteria;
				
				}
		</script>
		<script>
				function closeForm() {
					window.location.assign('<g:createLinkTo dir="/planMaintenance/search"/>')			
				}
		</script>
		<script type="text/javascript">
	
			$(document).ready(function() {
	
				$('.BtnDeleteRow').click(function(e){
		              $('#DeleteAlertModal').modal('show');
		          });
			      $('#DeleteAlertModal').modal( {
				      backdrop: 'static',
				       show: false 
				  });
			      $("#BtnDeleteRowYes").click(function(e){	  		         
			               var appName = "${appContext.metadata['app.name']}";
			               var myFm = document.getElementById("editForm") ; 			
			               myFm.action = "/"+appName+"/planMaintenance/delete";     	
			               myFm.submit();
			           
			  	  });
			});
		
		</script>
	</head>
    <div id="fms_content">
    	<div id="fms_content_header">
        	<div class="fms_content_header_note">
         		<a href="/FMSAdminConsole/sysMaint/list">System Maintenance</a> / Plan
       		</div>
		    <div class="fms_content_title">
        		<h1>Plan</h1>
        	</div>
      	</div> 
		<!-- START - Tabs -->
        	<div id="fms_content_tabs" class="fms_tab_action">
          		<ul>
		            <li><a class="list" href="<g:createLinkTo dir="/benefitPackage/search"/>">Benefit Package</a></li>
		            <li><a class="list" href="<g:createLinkTo dir="/configurationSwitch/search"/>">Configuration Switch</a></li>
		            <li><a class="list" href="<g:createLinkTo dir="/companyMaster/search"/>">Company</a></li>
		            <li><a class="list" href="<g:createLinkTo dir="/generalLedger/search"/>">G/L Reference</a></li>
		            <li><a class="list" href="<g:createLinkTo dir="/languageMaintenance/search"/>">Language Maintenance</a></li>
		            <li><a class="list" href="<g:createLinkTo dir="/lineOfBusiness/search"/>">Line of Business</a></li>
		            <li class="fms_tab_action_sub">
             			<button class="fms_tab_action_sub_trigger" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
              	    	<ul>
			                <li><a class="list" href="<g:createLinkTo dir="/systemParameter/search"/>">Parameter</a></li>
			                <li><a class="active" href="<g:createLinkTo dir="/planMaintenance/search"/>">Plan</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/providerTypeMaintenance/search"/>">Provider Type</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/reasonCodeMaintenance/search"/>">Reason</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/riderMaintenance/search"/>">Rider</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/systemCodes/search"/>">System Codes</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/taxReportingEntity/search"/>">Tax Reporting Entity</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/tradingPartnerMaintenance/search"/>">Trading Partner</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/userDefinedFields/search"/>">User Defined Fields</a></li>                                             
			                <li><a class="list" href="<g:createLinkTo dir="/about/search"/>">About</a></li>                                             
             			</ul>
            		</li>
          		</ul>
         		<div id="mobile_tabs_select"></div>
        	</div>
		<!-- END - Tabs -->
		<div id="fms_content_body">
			<div class="right-corner" align="right">PLANC</div>
			<g:form action="save" id="editForm" name="editForm">
				<div class="fms_required_legend fms_required">= required</div>           
				<div id="AddNewDataSection" class="fms_form_border" style="display: block;">
					<div class="fms_form_body">
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
  						<g:hasErrors bean="${plan}">
							<ul class="errors" role="alert">
								<g:eachError bean="${plan}" var="error">
									<li	<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message	error="${error}" /></li>
								</g:eachError>
							</ul>
						</g:hasErrors>
						<h3>${editType} Plan </h3>
						<div class="fms_widget">        
							<fieldset class="no_border">
		       		 			<div class="fms_form_layout_2column">                  
									<div class="fms_form_column fms_long_labels">
										<label class="control-label fms_required" for="planCode" id="planCode_label"> 
											<g:message code="planMaster.planCode.label" default="Plan Code :" />
										</label>			
										<div class="fms_form_input">
											<g:textField readOnly="true"
											 name="planCode" 
											 maxlength="50" 
											 required="Plan Code is Required"
											 autofocus="autofocus" 
											 value="${plan?.planCode}" 
											 class="form-control"
											 aria-labelledby="planCode_label"  
											 aria-describedby="planCode_error" 
											 aria-required="false" />
											 <div class="fms_form_error" id="planCode_error"></div>
								    	</div>
							    	
										<label class="control-label fms_required" for="shortDescription" id="shortDescription_label"> 
											<g:message code="planMaster.shortDescription.label" default="Short Description :" /> 
										</label>			
										<div class="fms_form_input">
											<g:textField name="shortDescription" 
											 maxlength="20" 
											 id="shortDescription" 
											 value="${plan?.shortDescription}" 
											 class="form-control"
											 aria-labelledby="shortDescription_label"  
											 aria-describedby="shortDescription_error" 
											 aria-required="false" />
											 <div class="fms_form_error" id="shortDescription_error"></div>
								    	</div>
								    				
										<label class="control-label fms_required" for="description" id="description_label"> 
											<g:message code="planMaster.description.label" default="Long Description :" /> 
										</label>			
										<div class="fms_form_input">
											<g:textArea name="description" 
											 maxlength="240" 
											 id="description" 
											 value="${plan?.description}" 
											 class="form-control"
											 aria-labelledby="description_label"  
											 aria-describedby="description_error" 
											 aria-required="false" />
											 <div class="fms_form_error" id="description_error"></div>
								    	</div>					
									</div>
									<div class="fms_form_column fms_long_labels">
										<label class="control-label fms_required" for="productType" id="productType_label"> 
											<g:message code="planMaster.productType.label" default="Product Type :" />	
										</label>		
										<div class="fms_form_input">
											<g:if test="${editType.equals("Edit")}">
												<g:hiddenField name="productType" value="${plan?.productType}" />
												<g:getSystemCodes cssClass="form-control"
												systemCodeType="PRODUCT_TYPE" 
												systemCodeActive = "Y"
												htmlElelmentId="productType"
												blankValue="productType"
												disable="true"
												defaultValue="${plan?.productType}" 
												title = "Select the type of coverage for the plan from list"
												aria-labelledby="productType_label"  
											    aria-describedby="productType_error" 
											    aria-required="false" />
											</g:if>
											<g:elseif test="${editType.equals("Create")}">
												<g:getSystemCodes cssClass="form-control"
												systemCodeType="PRODUCT_TYPE" 
												systemCodeActive = "Y"
												htmlElelmentId="productType"
												blankValue="productType"
												defaultValue="${plan?.productType}" 
												title = "Select the type of coverage for the plan from list"
												aria-labelledby="productType_label"  
											    aria-describedby="productType_error" 
											    aria-required="false" />
											 </g:elseif>
											<div class="fms_form_error" id="productType_error"></div>
							    		</div>
										
										<g:if test="${HIXProductcodeMandatory}">
											<label class="control-label fms_required" for="hixProductCode" id="hixProductCode_label"> 
												<g:message code="planMaster.hixProductCode.label" default="HIX Product Code :" /> 	
											</label>
											<div class="fms_form_input">
												<g:textField name="hixProductCode" 
													 maxlength="15" 
													 id="hixProductCode" 
													 value="${plan?.hixProductCode}" 
													 class="form-control"
													 aria-labelledby="hixProductCode_label"  
													 aria-describedby="hixProductCode_error" 
													 aria-required="false" />
												<div class="fms_form_error" id="hixProductCode_error"></div>
								   			</div>
										</g:if>
										<g:else>
											<label class="control-label" for="hixProductCode" id="hixProductCode_label"> 
												<g:message code="planMaster.hixProductCode.label" default="HIX Product Code :" /> 	
											</label>
											<div class="fms_form_input">
												<g:textField name="hixProductCode" 
													 maxlength="15" 
													 value="${plan?.hixProductCode}" 
													 class="form-control"
													 aria-labelledby="hixProductCode_label"  
													 aria-describedby="hixProductCode_error" 
													 aria-required="false" />
												<div class="fms_form_error" id="hixProductCode_error"></div>
							   				</div>	
							   			</g:else>	
							   		</div>
							   	</div>
						    </fieldset>
						</div>
						<div id="widgetGeneral" class="fms_widget">				
							<fieldset class="no_border">
								<legend><h3>User Defined Information</h3></legend>
									<div class="fms_form_layout_2column">                  
										<div class="fms_form_column fms_long_labels">	
								            <label class="control-label" for="userDefined1" id="userDefined1_label">
								            	<g:message code="planMaster.userDefined1.label" default="User Defined 1 :" />
											</label>	
											<div class="fms_form_input">
												<g:textField name="userDefined1" 
												 maxlength="30" 
												 value="${plan?.userDefined1}"
												 class="form-control"
												 aria-labelledby="userDefined1_label"  
												 aria-describedby="userDefined1_error" 
												 aria-required="false" />
												 <div class="fms_form_error" id="userDefined1_error"></div>
										     </div>		
											<label class="control-label" for="userDefined2" id="userDefined2_label">
								            	<g:message code="planMaster.userDefined2.label" default="User Defined 2 :" />
											</label>	
											<div class="fms_form_input">
												<g:textField name="userDefined2" 
												 maxlength="30" 
												 value="${plan?.userDefined2}"
												 class="form-control"
												 aria-labelledby="userDefined2_label"  
												 aria-describedby="userDefined2_error" 
												 aria-required="false" />
												 <div class="fms_form_error" id="userDefined2_error"></div>
										     </div>	
								    		 <label class="control-label" for="userDefined3" id="userDefined3_label">
								            	<g:message code="planMaster.userDefined3.label" default="User Defined 3 :" />
											 </label>	
											 <div class="fms_form_input">
											 	<g:textField name="userDefined3" 
												 maxlength="30" 
												 value="${plan?.userDefined3}"
												 class="form-control"
												 aria-labelledby="userDefined3_label"  
												 aria-describedby="userDefined3_error" 
												 aria-required="false" />
												 <div class="fms_form_error" id="userDefined3_error"></div>
										     </div>	
								    		 <label class="control-label" for="userDefined4" id="userDefined4_label">
								            	<g:message code="planMaster.userDefined4.label" default="User Defined 4 :" />
											 </label>	
											 <div class="fms_form_input">
											 	<g:textField name="userDefined4" 
												 maxlength="30" 
												 value="${plan?.userDefined4}"
												 class="form-control"
												 aria-labelledby="userDefined4_label"  
												 aria-describedby="userDefined4_error" 
												 aria-required="false" />
												 <div class="fms_form_error" id="userDefined4_error"></div>
										      </div>	
								    	      <label class="control-label" for="userDefined5" id="userDefined5_label">
								            	 <g:message code="planMaster.userDefined5.label" default="User Defined 5 :" />
										      </label>	
											  <div class="fms_form_input">
											   	 <g:textField name="userDefined5" 
												 maxlength="30" 
												 value="${plan?.userDefined5}"
												 class="form-control"
												 aria-labelledby="userDefined5_label"  
												 aria-describedby="userDefined5_error" 
												 aria-required="false" />
												 <div class="fms_form_error" id="userDefined5_error"></div>
										        </div>	
								    		  <label class="control-label" for="userDefined6" id="userDefined6_label">
								            	 <g:message code="planMaster.userDefined6.label" default="User Defined 6 :" />
											  </label>	
											  <div class="fms_form_input">
												<g:textField name="userDefined6" 
												 maxlength="30" 
												 value="${plan?.userDefined6}"
												 class="form-control"
												 aria-labelledby="userDefined6_label"  
												 aria-describedby="userDefined6_error" 
												 aria-required="false" />
												 <div class="fms_form_error" id="userDefined6_error"></div>
											   </div>			
										</div>
										<div class="fms_form_column fms_long_labels">	
											<label class="control-label" for="userDate1" id="userDate1_label"> 
												<g:message code="planMaster.userDate1.label" default="User Date 1 :" />
											</label>		
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX 
												dateElementId="userDate1"
												dateElementName="userDate1" 
												datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: plan?.userDate1)}" 
												title="The User Date of the Person"
												ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
						                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						                        showIconDefault="${isShowCalendarIcon}"/>	                                  
						                        <div class="fms_form_error" id="userDate1_error"></div>
											</div>	
											<label class="control-label" for="userDate2" id="userDate2_label"> 
												<g:message code="planMaster.userDate2.label" default="User Date 2 :" />
											</label>		
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX 
												dateElementId="userDate2"
												dateElementName="userDate2" 
												datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: plan?.userDate2)}" 
												title="The User Date of the Person"
												ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
						                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						                        showIconDefault="${isShowCalendarIcon}"/>	                                  
							                    <div class="fms_form_error" id="userDate2_error"></div>
											</div>	
											<label class="control-label" for="userDate3" id="userDate3_label"> 
												<g:message code="planMaster.userDate3.label" default="User Date 3 :" />
											</label>		
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX
												dateElementId="userDate3"
												dateElementName="userDate3" 
												datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: plan?.userDate3)}" 
												title="The User Date of the Person"
												ariaAttributes="aria-labelledby='userDate3_label' aria-describedby='userDate3_error' aria-required='false'" 
						                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						                        showIconDefault="${isShowCalendarIcon}"/>	                                  
										        <div class="fms_form_error" id="userDate3_error"></div>
											</div>	
											<label class="control-label" for="userDate4" id="userDate4_label"> 
												<g:message code="planMaster.userDate4.label" default="User Date 4 :" />
											</label>		
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX 
												dateElementId="userDate4"
												dateElementName="userDate4" 
												datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: plan?.userDate4)}" 
												title="The User Date of the Person"
												ariaAttributes="aria-labelledby='userDate4_label' aria-describedby='userDate4_error' aria-required='false'" 
						                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						                        showIconDefault="${isShowCalendarIcon}"/>	                                  
						                        <div class="fms_form_error" id="userDate4_error"></div>
											</div>	
											<label class="control-label" for="userDate5" id="userDate5_label"> 
												<g:message code="planMaster.userDate5.label" default="User Date 5 :" />
											</label>		
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX 
												dateElementId="userDate5"
												dateElementName="userDate5" 
												datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: plan?.userDate5)}" 
												title="The User Date of the Person"
												ariaAttributes="aria-labelledby='userDate5_label' aria-describedby='userDate5_error' aria-required='false'" 
						                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						                        showIconDefault="${isShowCalendarIcon}"/>	                                  
						                        <div class="fms_form_error" id="userDate5_error"></div>
											</div>	
											<label class="control-label" for="userDate6" id="userDate6_label"> 
												<g:message code="planMaster.userDate6.label" default="User Date 6 :" />
											</label>		
											<div class="fms_form_input">
												<fmsui:jqDatePickerUIUX 
												dateElementId="userDate6"
												dateElementName="userDate6" 
												datePickerOptions="changeMonth: true, changeYear: true, yearRange: '${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) - 100)} : ${((plan?.userDate1 != null ? plan?.userDate1.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR)) + 100)}', numberOfMonths: 1"
												dateElementValue="${formatDate(format:'MM/dd/yyyy',date: plan?.userDate6)}" 
												title="The User Date of the Person"
												ariaAttributes="aria-labelledby='userDate6_label' aria-describedby='userDate6_error' aria-required='false'" 
						                        classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						                        showIconDefault="${isShowCalendarIcon}"/>	                                  
						                        <div class="fms_form_error" id="userDate6_error"></div>
											</div>	
										 </div>
									</div>
								</fieldset>
							</div>
							<div class="fms_form_button">
							     <g:if test="${editType.equals("Edit")}">
							          <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
							         	<input id="BtnAddressDelete2" type="button" class="btn btn-default BtnDeleteRow" value="${message(code: 'default.button.delete.label', default: 'Delete1')}" data-target="#DeleteAlertModal" />
							          	<input type="Reset" class="btn btn-default" value="Reset" />
							          	<input type="button" class="btn btn-default" value="Close" onClick="closeForm()"/>
							     </g:if>
							     <g:elseif test="${editType.equals("Create")}">
									  <g:actionSubmit class="create" class="btn btn-primary"  action="save" value="Create" />
							          <input type="Reset" class="btn btn-default" value="Reset" />
							          <input type="button" class="btn btn-default" value="Cancel" onClick="closeForm()">
								 </g:elseif>
							</div>
						</div>
				</div>
			</g:form>
		</div>
	</div>
<!-- START - Delete Notice Modal -->
	<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4>Are you sure you want to delete this record?</h4>            
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button id="BtnDeleteRowYes" type="button" class="btn btn-primary" data-dismiss="modal">Yes, Delete</button>
				</div>
			</div>
		</div>
	</div>
<!-- END - Delete Notice Modal -->
</html>		