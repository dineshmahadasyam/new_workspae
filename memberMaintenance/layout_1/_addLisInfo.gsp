<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<%@ page import="com.perotsystems.diamond.bom.Member"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />

<g:set var="appContext" bean="grailsApplication"/>

<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_ADD_LIS.equals(currentPage)?true:false}" />
	
<title><g:message code="default.show.label" args="[entityName]" /></title>

<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>		
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script> 
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'additional-methods.js')}"></script>
		
<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="memberMaintenance"/>
		
<script type="text/javascript"> 


$(document).ready(function() { 	

	$(function(){
	    $(".numeric").numeric({});
	});
	
	$(function(){
		$(".alphanum").alphanum();
	});

	$(function(){
	    $(".amtNumeric").numeric({});
	    $(".qhpMask").mask("99999aa999999999");		
	});
	
	jQuery.validator.setDefaults({
		ignore: ":hidden",
		debug: true			 
	});

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
				 'lisInfo.0.lisStartDate' : {
					required : true
				},
				'lisInfo.0.lisEndDate' : {
					required : true
				},
				'lisInfo.0.lisCopayCategory' : {
					required : true					
				},
				'lisInfo.0.lisSourceCode' : {
					required : true		
				},
				'lisInfo.0.enrolleeTypeFlag' : {
					required : true		
				}									
								
	},
		messages : {
			'lisInfo.0.lisStartDate' : {
				required : "Please select LIS Start Date"
			},
			'lisInfo.0.lisEndDate' : {
				required : "Please select LIS End Date"
			},
			'lisInfo.0.lisCopayCategory' : {
				required : "Please select LIS Copay Category"
			},
			'lisInfo.0.lisSourceCode' : {
				required : "Please select LIS Source Code"
			},
			'lisInfo.0.enrolleeTypeFlag' : {
				required : "Please select Enrollee Type Flag"
			}
						
		} 			 
	})
});

}); // end of function ready

</script>	
   <script type="text/javascript">
       $(document).ready(function() {            
 

// Add datepicker to Date of Birth input
            $("#LisStartDate,#LisEndDate,#DOB,#effectiveDate,#userDate1,#userDate2,#dateOfDeath,#termDate,#benefitEndDate,#benefitStartDate,#hireDate").datepicker({
              numberOfMonths: 1,
              showOn: "button",
              buttonText: "<i class='fa fa-calendar'></i>",
            });
       });
    </script>



<script>

function closeForm() {
		var subscriberId = "${params.susbcriberId}";
		var appName = "${appContext.metadata['app.name']}";
	
		window.location.assign("/"+appName+"/memberMaintenance/show?subscriberId="
				+ subscriberId + "&editType=MEMMC_LIS_INFO");
	}
	var grpInnerWindow
	var innerWindowClosed = true;
	function closeAllIFrames() {
		if (grpInnerWindow) {
			grpInnerWindow.close()
		}
	}

</script>

<script type="text/javascript">

	$(document).ready(function() {

		 $('.btnSaveLis').hide();
         // $('.btnResetddress').hide();  
         $('.btnResetddressAlert').hide();  


         $('.tablesorter').delegate('.btnEditAddress, .btnResetddress', 'click' ,function(){
             var parentTR = $(this).closest('tr');
             $(parentTR).find('.btnEditAddress').toggle();
             $(parentTR).find('.btnSaveLis').toggle();
             $(parentTR).find('.btnResetddressAlert').toggle();
             $(parentTR).nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
             $('#NewAddress').prop('disabled', function(i, v) { return !v; });


             // $(this).closest('tr').nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
            //  return false;
           });

         $('.tablesorter').delegate('.btnSaveLis', 'click' ,function(){
             $('#editForm').submit();
           });
         
           
           $( ".btnResetddress" ).click(function() {             
             $('.btnEditAddress').show();
             $('.btnSaveLis').hide();
             $('.btnResetddressAlert').hide();
             $('.tablesorter-childRow').find('td').hide();
              $('#NewAddress').prop('disabled', function(i, v) { return !v; });
             // return false;
           });


           $( "#EffectiveDate, #TermDate, #EffectiveDate2, #TermDate2" ).datepicker({
               numberOfMonths: 1,
               showOn: "button",
               buttonText: "<i class='fa fa-calendar'></i>",
             });

             $('.btnResetddressAlert').click(function(e){ 
               $('#WarningAlert').modal('show');
             });

             $('#WarningAlert').modal({
               backdrop: 'static',
               show: false
             });
	});

</script>	
</head>

  <div id="fms_content">
  
      <div id="fms_content_header">
    	<div class="fms_content_header_note">
      	<h5><a href="${createLink(uri: '/memberMaintenance/list')}">Member Maintenance</a> / 
      			<g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MEMMC_LIS_INFO']}">MEMMC LIS Info</g:link>
	      			/ New MEMMC LIS Info for Subscriber ${params.susbcriberId } Person Number : ${ params.personNumber }
  		</div>
  		</h5>
  		<div class="fms_content_title">
    		<h1>Add MEMMC LIS INFO</h1>
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
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
	            <li><g:link class="active" action="show" id="${params.susbcriberId}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
	            <li><g:link class="list" action="show" id="${params.susbcriberId}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
          	</ul>
          	<div id="mobile_tabs_select"></div>
        </div>
      	<%-- END - Tabs --%>

   <div id="fms_content_body">
   	<div class="right-corner" align="right">MEMMCLIS</div>
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
<g:form action="saveLisInfo" id="editForm" name="editForm">
			<input type="hidden" name="memberDBID" value="${params.memberDBID}" />
			<input type="hidden" name="personNumber" value="${params.personNumber}" />
			<input type="hidden" name="subscriberId" value="${params.susbcriberId }" />			
		
              <!-- START - WIDGET: General Information -->
      			<div id="widgetGeneral" class="fms_widget">       
                  <fieldset class="no_border">
                       <legend><h2>General Information</h2></legend>
                  <div class="fms_form_layout_2column">                  
                      
                  <div class="fms_form_column fms_long_labels">
            
                      <label id="LisStartDate" class="control-label fms_required" >
                            <g:message code="lisInfo.lisStartDate.label" default="LIS Start Date :" />
                       </label>                     
                      <div class="fms_form_input">
                        <fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
                        					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: lisInfo?.lisStartDate)}" 
                        					dateElementId="lisInfo.0.lisStartDate" dateElementName="lisInfo.0.lisStartDate"
                        					title="Low Income Subsidy Start Date"
                                           ariaAttributes="aria-labelledby='DOB_label' aria-describedby='lisInfo_error' aria-required='false'" 
                                           classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                           showIconDefault="${isShowCalendarIcon}"/> 

                         <div class="fms_form_error" id="LisStartDate_r2_error"></div>
                      </div>                                  
                    
                      <label id="LisSubsidyLevel_r2_label" class="control-label"><g:message code="lisInfo.lisSubsidyLevel.label" default="LIS Subsidy Level :" /></label>
                      <div class="fms_form_input">
                        <g:textField name="lisInfo.0.lisSubsidyLevel" maxlength="6" class="form-control amtNumeric"
									value="${lisInfo?.lisSubsidyLevel}" title="Calculated value as per TRR business"/>
                         			<div class="fms_form_error" id="LisSubsidyLevel_r2_error"></div>
                      </div>            
 					
 					 <label  id="LisSourceCode_r2_label" class="control-label fms_required"><g:message code="lisInfo.lisSourceCode.label" default="LIS Source Code :" /></label>
                      <div class="fms_form_input">
                        <select name="lisInfo.0.lisSourceCode" class="form-control" title="Low Income Subsidy Source Code">
								<option value="A" ${lisInfo.lisSourceCode.equals('A') ? 'selected':'' }>Approved SSA Applicant</option>
								<option value="D" ${lisInfo.lisSourceCode.equals('D') ? 'selected':'' }>Deemed eligible by CMS</option>
								<option value="B" ${lisInfo.lisSourceCode.equals('B') ? 'selected':'' }>BAE</option>																										
						</select>                      
                        <div class="fms_form_error" id="LisSourceCode_r2_error"></div>                       
                      </div>
                    
                    
                      <label id="PartLisEnrSubsidy_r2_label" class="control-label" > <g:message code="lisInfo.partdLisEnrSubsidy.label" default="Part D Enr Subsidy :" /></label>
                      <div class="fms_form_input">
                        <g:textField name="lisInfo.0.partdLisEnrSubsidy" maxlength="19" class="form-control amtNumeric"
									value="${lisInfo?.partdLisEnrSubsidy}" title="Part D late enrollment penalty subsidy amount"/>                        
                      <div class="fms_form_error" id="PartLisEnrSubsidy_r2_error"></div>
                      </div>             
               </div>
               
                <div class="fms_form_column fms_long_labels">     
					  <label id="LisEndDate" class="control-label fms_required" > <g:message code="lisInfo.lisEndDate.label" default="LIS End Date :" /></label> 
                      <div class="fms_form_input">
                        <fmsui:jqDatePickerUIUX datePickerOptions="changeMonth:true, changeYear:true, yearRange:'-100:+100', numberOfMonths: 1" 
                        					dateElementValue="${formatDate(format:'MM/dd/yyyy', date: lisInfo?.lisEndDate)}" 
                        					dateElementId="lisInfo.0.lisEndDate" dateElementName="lisInfo.0.lisEndDate"
                        					title="Low Income Subsidy End Date"
                                            ariaAttributes="aria-labelledby='lisEndDate_label' aria-describedby='lisEndDate_error' aria-required='false'" 
                                            classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
                                            showIconDefault="${isShowCalendarIcon}"/> 

                         <div class="fms_form_error" id="LisEndDate_r2_error"></div>
                      </div>
                                           
                      <label id="EnrolleeTypeFlag_r2_label" class="control-label fms_required"> <g:message code="lisInfo.enrolleeTypeFlag.label" default="LIS Enrollee Type Flag:" /></label>
                      <div class="fms_form_input">
                        <select name="lisInfo.0.enrolleeTypeFlag" class="form-control" title="Low Income Subsidy Type Flag">
								<option value="C" ${lisInfo.enrolleeTypeFlag.equals('C') ? 'selected':'' }>Current PBP Enrollee</option>
								<option value="P" ${lisInfo.enrolleeTypeFlag.equals('P') ? 'selected':'' }>Prospective PBP Enrollee</option>
								<option value="Y" ${lisInfo.enrolleeTypeFlag.equals('Y') ? 'selected':'' }>Previous PBP Enrollee</option>																										
						</select>
                        <div class="fms_form_error" id="EnrolleeTypeFlag_r2_error"></div>
                      </div>
                            
                      <label id="lisCopayCategory_r2_label" class="control-label fms_required"> <g:message code="lisInfo.lisCopayCategory.label" default="LIS Copay Category :" /></label>
                      <div class="fms_form_input">
                        <select name="lisInfo.0.lisCopayCategory" class="form-control" title="Low Income Subsidy Category">													
							<option value="0" ${lisInfo.lisCopayCategory.equals('0') ? 'selected':'' }>None, not low-income</option>
							<option value="1" ${lisInfo.lisCopayCategory.equals('1') ? 'selected':'' }>High</option>
							<option value="2" ${lisInfo.lisCopayCategory.equals('2') ? 'selected':'' }>Low</option>
							<option value="3" ${lisInfo.lisCopayCategory.equals('3') ? 'selected':'' }>$0 Full duals that are institutionalized</option>
							<option value="4" ${lisInfo.lisCopayCategory.equals('4') ? 'selected':'' }>15%</option>
							<option value="5" ${lisInfo.lisCopayCategory.equals('0') ? 'selected':'' }>Unknown</option>													
						</select>
                        <div class="fms_form_error" id="lisCopayCategory_r2_error"></div>
                      </div>            
                    
                     <label id="lisPartdLisSubsidy_r2_label" for="partdLisSubsidy" class="control-label"> <g:message code="lisInfo.partdLisSubsidy.label" default="Part D LIS Subsidy :" /></label>
                      <div class="fms_form_input">
                         <g:textField name="lisInfo.0.partdLisSubsidy" maxlength="19" class="form-control amtNumeric"
									value="${lisInfo?.partdLisSubsidy}" title="Low Income Part D premium subsidy amount"/>
                        		 <div class="fms_form_error" id="lisPartdLisSubsidy_r2_error"></div>
                      </div>                    
                    </div>
                  </div>
                </fieldset>
            
               </div>
            
            <div class="fms_form_button">
              	<g:actionSubmit  class="btn btn-primary" action="saveLisInfo" value="${message(code: 'default.button.Save.label', default: 'Save')}" />
				<input type="Reset" class="btn btn-default" value="Reset" id="resetButton" />
				<input type="button" class="btn btn-default" name="close" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onClick="closeForm()"/>
           </div></g:form>
         </div> 
           </div>
         </div>
               </div>

</html>