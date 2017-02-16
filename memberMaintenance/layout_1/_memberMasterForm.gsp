<%@ page import="com.perotsystems.diamond.bom.Member"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.States"%>
<%@ page import="com.perotsystems.diamond.bom.SimpleMember"%>
<%@ page import="com.perotsystems.diamond.bom.Language"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistory"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberEligHistoryExtn"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.MemberMaster"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.GroupMaster"%>
<%@ page import="com.perotsystems.diamond.dao.cdo.AgentMaster"%>
<%@ page import="com.perotsystems.diamond.bom.GroupContactPerson"%>
<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>

<head>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'commonfunctions.js')}"></script>
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'member_pages.css')}" type="text/css"/>
	<g:set var="pageId" value="${currentPage?.pageName? '"'+currentPage?.pageName+'"':'""' }" />

<script>
	var addRowClicked = false
	function cloneRow() {

		var divObjSrc = document.getElementById('newMemberMaster')
		var divObjDest = document.getElementById('addGroupPlaceHolder')
		divObjDest.innerHTML = divObjSrc.innerHTML
		var divObj = document.getElementById('addAddressDiv')
		divObj.style.display = "none"
		var selectObj = document.getElementById("memberIdSelectList")
		selectObj.disabled = true;
		var divObjSrc = document.getElementById('releaseSelect')
		divObjSrc.style.display = "block"
		addRowClicked = true
	}
	var previousDivObj
	function releaseMemberSelection() {
		var result = confirm(
				"Navigating to a new Member would result in the loss of data of the newly added member, Please confirm ",
				"Yes - Change Member ", "No - Stay on this page")
		if (result) {
			addRowClicked = false;
			var selectObj = document.getElementById("memberIdSelectList")
			selectObj.disabled = false;
			var divObjSrc = document.getElementById('releaseSelect')
			divObjSrc.style.display = "none"
			var divObjDest = document.getElementById('addGroupPlaceHolder')
			divObjDest.innerHTML = "&nbsp;<b>gone</b>"
			var divObj = document.getElementById('addAddressDiv')
			divObj.style.display = "block"
			var formObj = document.getElementById('editForm')
			formObj.reset()
		}
	}
	function showAddress(selectedObj) {
		var hiddenObj = document.getElementById("editMemberDBID")
		if (!addRowClicked) {
			var selectedValue = selectedObj.options[selectedObj.selectedIndex].value
			var addressDivObj = document.getElementById(selectedValue)
			var addAddressDivObj = document.getElementById("addAddressDiv")
			hiddenObj.value = selectedValue
			if (addressDivObj != null) {
				if (previousDivObj != null) {
					previousDivObj.style.display = "none"
				}
				addressDivObj.style.display = "block"
				//addAddressDivObj.style.display = "block"
				previousDivObj = addressDivObj				
				
				personNoProp = document.getElementsByName('memberMaster.' + selectedValue+ '.personNumber')[0].value;
				

				$('#BtnGeneralEdit'+ personNoProp).show();
				$('#BtnGeneralSave'+ personNoProp).hide();
				$('#BtnGeneralReset'+ personNoProp).hide();
				
				var pageId = ${currentPage?.pageName? '"'+currentPage?.pageName+'"':'""' }
				
				if (pageId == 'show') {
							$('#BtnSave, #BtnReset').hide();
							$('#widgetGeneral input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
							$('#widgetEligibility input, #widgetEligibility  select, #widgetEligibility .fms_btn_icon, #widgetEligibility .fms_form_control_feedback').attr('disabled', 'disabled');

							
							
					} else {// Treating this is a create action	  
						$('button[id^="BtnGeneralEdit"]').hide();				
						$('#BtnEligibilityEdit').hide();
						$('#widgetEmployer').hide();					
					}
				
				$( ".btnResetddress" ).click(function() { 
					if (pageId == 'show') {
						$('#BtnGeneralEdit' + personNoProp).show();
						$('#BtnGeneralSave' + personNoProp).hide();
						$('#BtnGeneralReset' + personNoProp).hide();
						$('#widgetGeneral input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
						$('.ui-datepicker-trigger').hide();
						$('button[id^="_calendar_button_memberMaster"]').hide();
					}
				 });

				 $("#BtnGeneralEdit" + personNoProp).click(	function(e) {
							
							$('#widgetGeneral input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').removeAttr('disabled');
							$('.ui-datepicker-trigger').show();
							$('button[id^="_calendar_button_memberMaster"]').show()
							
							//Don't enable subscriberID field
							$('input[id$=".subscriberID"]').attr('disabled', 'disabled');
							//Don't enable personNumber field
							$('input[id$="personNumber"]').attr('disabled', 'disabled');

							//Don't enable Salutation field
							$('select[id$=".prefixName"]').attr('disabled', 'disabled');
							
							//has been comented as part of DIA00059560 fix
							//Don't enable dob field
							//$('button[id$=".dob"]').hide();
							//$('input[id$=".dob"]').attr('disabled', 'disabled');

							//Don't enable Date Created
							$('button[id$=".insertDate"]').hide();
							
							$('button[id^="_calendar_button_eligHistory"]').hide()
							$('button[id^="_calendar_button_memberEligHistoryExtn"]').hide()
							
							$('button[id^="BtnGeneralEdit"]').hide();
							
							$('#BtnGeneralSave'+ personNoProp).show();
							$('#BtnGeneralReset' + personNoProp).show();							
							
						});

				 	$('#BtnGeneralReset'+ personNoProp).click(function(e) {
						this.form.reset();
						if (pageId == 'show') {
						$('#BtnGeneralEdit' + personNoProp).show();
						$('#BtnGeneralSave' + personNoProp).hide();
						$('#BtnGeneralReset' + personNoProp).hide();
						$('#widgetGeneral input, #widgetGeneral select, #widgetGeneral .fms_btn_icon').attr('disabled', 'disabled');
						$('.ui-datepicker-trigger').hide();
						$('button[id^="_calendar_button_memberMaster"]').hide();
					}
					});
				
			} else {
				addAddressDivObj.style.display = "none"
			}
		} else {
			var result = confirm(
					"Navigating to a new Member would result in the loss of data, Please confirm ",
					"Yes - Change Member ", "No - Stay on this page")
			if (result) {
				addRowClicked = false;
				showAddress(selectedObj)
			} else {

			}
		}
	}

	function addDependant() {
		var subscriberId = "${subscriberMember.subscriberID}";
		var appName = "${appContext.metadata['app.name']}";
		window.location.assign("/"+appName+"/memberMaintenance/addDependant?subscriberID="
				+ subscriberId + "&editType=MASTER");
	}
	function lookupplanId(idName, cdoClassName, cdoClassAttributeName, setToIdName, setToIdName1) {
		var groupId = document.getElementById(idName).value
		 if(groupId == null || groupId == "") {
			//alert ("Please enter Group Id");
			document.getElementById('GroupIdAlertInfo').click();						
			return false;
		}

		var isValidGroupId= "";
		 var descr = jQuery.ajax({
				url : '<g:createLinkTo dir="/agency/ajaxValidateGroupId"/>',
				async: false,				
				type : "POST",
				data : {groupId:groupId},
				success : function(result) {
					isValidGroupId = result
				}
			});
		
		if(isValidGroupId == null || isValidGroupId != "true"){
			//alert ("Please enter a valid Group Id");
			document.getElementById('GroupIdAlert').click();						
			return false;
		}
		
		var htmlElementValue 
		var assocHTMLElementsValue
		if(idName.indexOf('|') == -1){			
			htmlElementValue = document.getElementById(idName).value
			assocHTMLElementsValue = htmlElementValue
		} else {
			var nameArray = idName.split("|")
			for (var i =0;i<nameArray.length;i++) {
				if(i == 0) {
					htmlElementValue = document.getElementById(nameArray[i]).value					
				}
				assocHTMLElementsValue += document.getElementById(nameArray[i]).value+"|"
			}
		}
		//alert("htmlElementValue = "+htmlElementValue )
		var appName = "${appContext.metadata['app.name']}";
			$('#LookupModal').modal('show');
			var urlValue = "/"+appName+"/lookUp/lookUpPlanId?htmlElementIdName=" + idName
							+ "&htmlElementValue=" + htmlElementValue 
							+ "&cdoClassName="+ cdoClassName 
							+ "&cdoClassAttributeName="+ cdoClassAttributeName 
							+ "&assocHTMLElementsValue="+ assocHTMLElementsValue 
							+ "&setToIdName=" + setToIdName
							+ "&setToIdName1=" + setToIdName1
							+ "&offset=0"
			document.getElementById('LookupSrc').setAttribute('src', urlValue);
		
	}

	$(function($){
		   $(".SSNMask").mask("?999-99-9999");
		})	

</script>
<script type="text/javascript">

function displayAddressMessage(){
	$("#BtnInfoAlertId").removeAttr('disabled')	
	document.getElementById('BtnInfoAlertId').click();
}

</script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {

						$('.btnInfoAlert').hide();
						$('.btnInfoAlert').click(function(e) {
							$('#InfoAlert').modal('show');
						});
						$('#InfoAlert').modal({
							backdrop : 'static',
							show : false
						});

						$('#BtnReset').click(function(e) {
								this.form.reset();
						});

						var pageId = ${currentPage?.pageName? '"'+currentPage?.pageName+'"':'""' }
						if(pageId=="create"){							
							$('#lnkEmpInfo').hide()
						}
							

					});
</script>

	<script type="text/javascript">
			$(document).ready(function() {
						
						$('.groupIdAlert').hide();  
						$('.groupIdAlert').click(function(e){ 
					    	$('#SearchAlertModal').modal('show');
					    });
					 	$('#SearchAlertModal').modal({
					    	backdrop: 'static',
					       show: false
					   	});
					
					 	$('.groupIdAlertInfo').hide();  
						$('.groupIdAlertInfo').click(function(e){ 
					    	$('#SearchAlertModalInfo').modal('show');
					    });
					 	$('#SearchAlertModalInfo').modal({
					    	backdrop: 'static',
					       show: false
					   	});
					
					 	
					});
	</script>
</head>
 <g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_SHOW.equals(currentPage)?false:true}" />      
		<!-- START - Jump To: -->
        <div id="jumpto">
          <div class="jumpto_inner">
            <ul>
              <li><a href="#widgetGeneral">General Information</a></li>
              <li><a href="#widgetAddress">Primary Address</a></li>
              <li><a href="#widgetEligibility">Current Eligibility</a></li>
			  <li id="lnkEmpInfo"><a href="#widgetEmployer">Employer Information</a></li>              
            </ul>

            </div>
        </div>      
		<!-- END - Jump To: -->
		
<div id="fms_content_body">
		
	<div class="right-corner" align="right">MEMBR</div> 
	
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<g:if test="${fieldErrors}">
			<ul class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>
						${error}
					</li>
				</g:each>
			</ul>
		</g:if>
		<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
		
		<div class="fms_widget form-inline">
		<input type="hidden" name="editType" value="MASTER" />
		<input type="hidden" id="editMemberDBID" name="editMemberDBID" value="0" />
          <label class="control-label bold" id="SelectMember_label" for="SelectMember">Select Member:</label>
            <% def personNumber = (params.personNumber) ? params.personNumber : "01" %>
			<select class="form-control" id="memberIdSelectList" name="memberIdlist" aria-labelledby="SelectMember_label"  aria-required="false" onChange="showAddress(this)">
				<option value="dummy">-- Select a Member --</option>
				<g:each in="${memberMasterMap.keySet() }" status="idCount" var="memberDBID">
					<% SimpleMember member = memberMasterMap.get(memberDBID) %>
					<option value="${memberDBID }"
						${personNumber.equals( member.personNumber )?'selected':'' }>
						<g:if test="${member.personNumber }">
							${ member.personNumber }
						</g:if>
						-
						<g:if test="${member.firstName }">
							${member.firstName }
						</g:if>
						<g:if test="${member.lastName }">
							${member.lastName }
						</g:if>
					</option>
				</g:each>
			</select>
			
			
		<g:if test="${subscriberMember?.memberDBID }">
			<g:checkURIAuthorization uri="/memberMaintenance/addDependant">
	        	<button type="button" id="BtnNewDependent" class="btn btn-primary btn-sm" onClick="addDependant()"><i class="fa fa-plus"></i> New Dependent</button>
	        </g:checkURIAuthorization>    
        </g:if>      
       </div>
        
 
<div id="dummy" style="display: none">&nbsp;</div>
	<g:each in="${memberMasterMap.values() }" status="idCount" var="memberMaster">
		<div id="${memberMaster.memberDBID }" style="display: none">
			<input type="hidden" name="seq_master_id_${i}" value="${memberMaster.memberDBID }">
			<input type="hidden" name="memberMaster.${memberMaster.memberDBID }.iterationCount" value="${memberMaster.memberDBID }">

	         <div class="fms_required_legend fms_required">= required</div>
	         <!-- START - WIDGET: General Information -->
	         <div id="widgetGeneral" class="fms_widget">				
	            <fieldset>
	              <legend>
	                <h2>General Information</h2>
					<button type="button" id="BtnGeneralEdit${memberMaster.personNumber}" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span>Edit</button>  
	                <button id="BtnGeneralSave${memberMaster.personNumber}" class="BtnGeneralSave btn btn-primary btn-xs" ><span class="fa fa-floppy-o"></span>Save</button>
	                <button type="button" id="BtnGeneralReset${memberMaster.personNumber}" class="BtnGeneralReset btn btn-default btn-xs" ><span class="glyphicon glyphicon-repeat"></span>Reset</button>
	                
	 	            <button id="BtnSave" class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span> Save</button>
					<button id="BtnReset" class="btn btn-default btn-xs" type="button"><span class="glyphicon glyphicon-repeat"></span> Reset</button>
	                
	              </legend>	
	
	              <div class="fms_form_layout_2column">                  
	                <div class="fms_form_column fms_long_labels">
	                
	                  
	                  <label class="control-label" id="SubscriberID_label" for="SubscriberID">Subscriber ID:</label>
	                  <input type="hidden" name="memberDBID" value="${memberMaster?.memberDBID}" />
	                  <div class="fms_form_input">     
	                    <g:if test="${ subscriberMember.subscriberID}">
							<input type="hidden"  id="subscriberID" name="subscriberID" value="${subscriberMember.subscriberID}" />
						<g:secureTextField maxlength="50" size="60" disabled="disabled"
											name="memberMaster.${ memberMaster?.memberDBID }.subscriberID"
											tableName="MEMBER_MASTER" attributeName="subscriberId" 
											value="${memberMaster.subscriberID}"
											class="form-control"
											aria-labelledby="subscriberID_label"
											aria-describedby="subscriberID_error"
											aria-required="false"></g:secureTextField>													
						</g:if>
						<g:else>
							<g:secureTextField maxlength="50" size="60" class="form-control"
								name="memberMaster.${ memberMaster?.memberDBID }.subscriberID"
								id="subscriberID"
								tableName="MEMBER_MASTER" attributeName="subscriberID" 
								value="${request.getParameter('subscriberID')}"
								aria-labelledby="subscriberID_label"
								aria-describedby="subscriberID_error"
								aria-required="false"
								onChange="document.getElementById('subscriberID').value=this.value"></g:secureTextField>
						</g:else>              
	                  </div>
	
	                
	                  <label class="control-label fms_required" id="personNumber_label" for="personNumber">
						<g:message code="memberMaster.groupLevel.label" default="Person Number:" />
					  </label>
	                  <div class="fms_form_input">
						<input type="hidden" name="memberMaster.${ memberMaster?.memberDBID }.personNumber" value="${memberMaster.personNumber}" />
						<g:secureTextField id="personNumber" name="memberMaster.${ memberMaster?.memberDBID }.personNumber" disabled="disabled" 
								tableName="MEMBER_MASTER" attributeName="personNumber" value="${memberMaster.personNumber}"
								class="form-control" aria-labelledby="personNumber_label" aria-describedby="personNumber_error" aria-required="false"></g:secureTextField>	                  
	                  </div>         
	                
	                  <label class="control-label fms_required" id="LastName_label" for="LastName">
	                  	<g:message code="memberMaster.lastName.label" default="Last Name:" />
	                  </label>
	                  <div class="fms_form_input">
	                       <g:secureTextField class="form-control fms-alphanumeric" maxlength="60" size="60" title="last Name" 
								name="memberMaster.${ memberMaster?.memberDBID }.lastName"
								id="memberMaster.${ memberMaster?.memberDBID }.lastName" 
								tableName="MEMBER_MASTER" attributeName="lastName" 
								value="${memberMaster.lastName}" 
								aria-labelledby="LastName_label" aria-describedby="LastName_error" aria-required="false">
							</g:secureTextField>	 
	                     <div class="fms_form_error" id="LastName_error"></div>
	                  </div>            
	
	                
	                  <label class="control-label" id="MiddleName_label" for="MiddleName">
	                  	<g:message code="memberMaster.middleInitial.label" default="Middle Name:" />
	                  </label>
	                  <div class="fms_form_input">
	                    <g:secureTextField class="form-control fms-alphanumeric" maxlength="25" size="60"
							name="memberMaster.${ memberMaster?.memberDBID }.middleInitial"
							id="memberMaster.${ memberMaster?.memberDBID }.middleInitial" 
							tableName="MEMBER_MASTER" attributeName="middleInitial" 
							value="${memberMaster.middleInitial}"
							title="Middle Initial or Middle Name of the Member"
							aria-labelledby="MiddleName_label" aria-describedby="MiddleName_error" aria-required="false">
						</g:secureTextField>
	                    <div class="fms_form_error" id="MiddleName_error"></div>
	                  </div>            
	
	                
	                  <label class="control-label" id="FirstName_label" for="FirstName">
	                  	<g:message code="memberMaster.firstName.label" default="First Name:" />
	                  </label>
	                  <div class="fms_form_input">
	                    <g:secureTextField class="form-control fms-alphanumeric" maxlength="35" size="60" title="first Name"
							name="memberMaster.${ memberMaster?.memberDBID }.firstName"
							id="memberMaster.${ memberMaster?.memberDBID }.firstName" 
							tableName="MEMBER_MASTER" attributeName="firstName" 
							value="${memberMaster.firstName}"
							aria-labelledby="FirstName_label" aria-describedby="FirstName_error" aria-required="false">
						</g:secureTextField>
	                    <div class="fms_form_error" id="FirstName_error"></div>
	                  </div>             
	                

					<label for="DOB" class="control-label fms_required" id="DOB_label" > 
							<g:message code="memberMaster.dob.label" default="Date of Birth:" />
					</label>
					<div class="fms_form_input">                                                                                                                                                                                                  
							<g:securejqDatePickerUIUX 
									tableName="MEMBER_MASTER" attributeName="dateOfBirth" 
									dateElementId="memberMaster.${ memberMaster?.memberDBID }.dob" 
									dateElementName="memberMaster.${ memberMaster?.memberDBID }.dob" 
									datePickerOptions="changeMonth:true, changeYear:true, 
									yearRange:'${(Calendar.getInstance().get(Calendar.YEAR) - 100) - (memberMaster?.dob != null ? memberMaster?.dob.get(Calendar.YEAR):Calendar.getInstance().get(Calendar.YEAR))}:+0',	maxDate:0, numberOfMonths: 1" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberMaster?.dob)}"
									title="Date of Birth of the Member"
									ariaAttributes="aria-labelledby='DOB_label' aria-describedby='DOB_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
									showIconDefault="${isShowCalendarIcon}"/>
							<div class="fms_form_error" id="DOB_error"></div>
					</div> 

	
	                  <label class="control-label fms_required" id="Gender_label" for="Gender">
	                  	<g:message code="memberMaster.gender.label" default="Gender : " />
	                  </label>
	                  <div class="fms_form_input">
						<g:secureDiamondDataWindowDetail columnName="gender"
										cssClass="form-control"
										dwName="dw_edied_de" languageId="0"
										htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.gender"
										defaultValue="${memberMaster?.gender}" blankValue="Gender"
										name="memberMaster.${ memberMaster?.memberDBID }.gender"
										tableName="MEMBER_MASTER" attributeName="gender"
										value="${memberMaster?.gender}"
										id="gender"
										title="Gender of the Member"
										aria-labelledby="gender_label"
										aria-describedby="gender_error"
										aria-required="false" />	
	                    <div class="fms_form_error" id="Gender_error"></div>
	                  </div>


					<label class="control-label" id="userDefined1_label" for="userDefined1">
						<g:message code="memberMaster.userDefined1.label" default="User Defined 1 : " />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="userDefined1" aria-labelledby="userDefined1_label" aria-describedby="userDefined1_error" aria-required="false" 
										size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined1" 
										tableName="MEMBER_MASTER" attributeName="userDefined1" 
										value="${memberMaster?.userDefined1}"></g:secureTextField>
						<div class="fms_form_error" id="userDefined1_error"></div>
					</div>  
					
					<label class="control-label" id="userDefined2_label" for="userDefined2">
						<g:message code="memberMaster.userDefined2.label" default="User Defined 2 : " />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="userDefined2" aria-labelledby="userDefined2_label" aria-describedby="userDefined2_error" aria-required="false" 
										size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined2" 
										tableName="MEMBER_MASTER" attributeName="userDefined2" 
										value="${memberMaster?.userDefined2}"></g:secureTextField>						
						<div class="fms_form_error" id="userDefined2_error"></div>
					</div>  
					
					<label class="control-label" id="userDefined3_label" for="userDefined3">
						<g:message code="memberMaster.userDefined3.label" default="User Defined 3 : " />	
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="userDefined3" aria-labelledby="userDefined3_label" aria-describedby="userDefined3_error" aria-required="false" 
										size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined3" 
										tableName="MEMBER_MASTER" attributeName="userDefined3" 
										value="${memberMaster?.userDefined3}"></g:secureTextField>							
						<div class="fms_form_error" id="userDefined3_error"></div>
					</div>  
					
					<label class="control-label" id="userDefined4_label" for="userDefined4">
						<g:message code="memberMaster.userDefined4.label" default="User Defined 4 : " />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="userDefined4" aria-labelledby="userDefined4_label" aria-describedby="userDefined4_error" aria-required="false" 
										size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined4" 
										tableName="MEMBER_MASTER" attributeName="userDefined4" 
										value="${memberMaster?.userDefined4}"></g:secureTextField>							
						<div class="fms_form_error" id="userDefined4_error"></div>
					</div> 	
					
					<label class="control-label" id="userDefined5_label" for="userDefined5">
						<g:message code="memberMaster.userDefined5.label" default="User Defined 5 : " />
					</label>
					<div class="fms_form_input">
						<g:secureTextField class="form-control" id="userDefined5" aria-labelledby="userDefined5_label" aria-describedby="userDefined5_error" aria-required="false"
										size="30"  maxlength="15"
										name="memberMaster.${ memberMaster?.memberDBID }.userDefined5" 
										tableName="MEMBER_MASTER" attributeName="userDefined5" 
										value="${memberMaster?.userDefined5}"></g:secureTextField>
						<div class="fms_form_error" id="userDefined5_error"></div>
					</div>
	
	                </div>


					<div class="fms_form_column fms_long_labels">


							<label class="control-label" id="SSN_label" for="SSN"> <g:message
									code="memberMaster.socialSecurityNumber.label" default="SSN :" />
							</label>
							<div class="fms_form_input">
								<g:secureTextField name="memberMaster.${ memberMaster?.memberDBID }.socialSecurityNumber"
													id="memberMaster.${ memberMaster?.memberDBID }.socialSecurityNumber"
													tableName="MEMBER_MASTER" attributeName="socialSecNo" value="${memberMaster.socialSecurityNumber}" maxlength="11"
													placeholder="000-00-0000" class="form-control SSNMask" 
													title="Social Security Number of the Member"
													aria-labelledby="SSN_label" aria-describedby="SSN_error" aria-required="false">
								</g:secureTextField>
								<div class="fms_form_error" id="SSN_error"></div>
							</div>


							<label class="control-label" id="PrimaryLanguage_label"
								for="PrimaryLanguage"> <g:message
									code="memberMaster.code.label" default="Primary Language : " />
							</label>
							<div class="fms_form_input fms_has_feedback ">
								<g:secureTextField class="form-control" id="memberMaster.${ memberMaster?.memberDBID }.language.code"
									name="memberMaster.${ memberMaster?.memberDBID }.language.code"
									id="memberMaster.${ memberMaster?.memberDBID }.language.code"
									size="30"  maxlength="5" title="Primary Language of the Member"
									tableName="MEMBER_MASTER" attributeName="languageCode"
									value="${memberMaster?.language?.code}">
								</g:secureTextField>
								<fmsui:cdoLookup lookupElementId="memberMaster.${ memberMaster?.memberDBID }.language.code"
									   lookupElementName="memberMaster.${ memberMaster?.memberDBID }.language.code" 
									   lookupElementValue="${memberMaster?.language?.code}"
									   lookupCDOClassName="com.perotsystems.diamond.bom.Language"
									   lookupCDOClassAttribute="code"/>
								<div class="fms_form_error" id="PrimaryLanguage_error"></div>
							</div>

							<label class="control-label" id="EmploymentStatus_label"
								for="EmploymentStatus"> <g:message
									code="memberMaster.employmentStatusCode.label"
									default="Employment Status :" />
							</label>
							<div class="fms_form_input">
								<g:secureSystemCodeToken systemCodeType="EMPSTAT" languageId="0"
									cssClass="form-control" tableName="MEMBER_MASTER"
									attributeName="employmentStatusCode"
									htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.employmentStatusCode"
									blankValue="Status"
									defaultValue="${memberMaster?.employmentStatusCode}"
									id="EmploymentStatus"
									title="Employment Status of the Member"
									aria-labelledby="EmploymentStatus_label"
									aria-describedby="EmploymentStatus_error"
									aria-required="false">
								</g:secureSystemCodeToken>
								<div class="fms_form_error" id="EmploymentStatus_error"></div>
							</div>

							<label class="control-label" id="MaritalStatus_label"
								for="MaritalStatus"> <g:message
									code="memberMaster.maritalStatus.label"
									default="Marital Status : " />
							</label>
							<div class="fms_form_input">
								<g:secureDiamondDataWindowDetail columnName="marital_status"
									dwName="dw_membr_identification" languageId="0"
									cssClass="form-control"
									htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.maritalStatus"
									defaultValue="${memberMaster?.maritalStatus}"
									blankValue="Status"
									name="memberMaster.${ memberMaster?.memberDBID }.maritalStatus"
									tableName="MEMBER_MASTER" attributeName="maritalStatus"
									value="${memberMaster?.maritalStatus}" 
									id="MaritalStatus"
									title="Marital Status of the Member"
									aria-labelledby="MaritalStatus_label"
									aria-describedby="MaritalStatus_error"
									aria-required="false"/>
								<div class="fms_form_error" id="MaritalStatus_error"></div>
							</div>

							<label class="control-label" id="HIXEffectuation_label"
								for="HIXEffectuation"> <g:message
									code="memberMaster.hixEffectuation.label"
									default="HIX Effectuation : " />
							</label>
							<div class="fms_form_input">
								<g:secureTextField type="text" maxlength="1" size="30"
									name="memberMaster.${ memberMaster?.memberDBID }.hixEffectuation"
									tableName="MEMBER_MASTER" attributeName="hixEffectuation"
									value="${memberMaster.hixEffectuation}" class="form-control"
									id="HIXEffectuation" title="HIX Effectuation Status for the Member"
									aria-labelledby="HIXEffectuation_label"
									aria-describedby="HIXEffectuation_error" aria-required="false">
								</g:secureTextField>
								<div class="fms_form_error" id="HIXEffectuation_error"></div>
							</div>

							<label class="control-label" id="Medicaid_label" for="Medicaid">
								<g:message code="memberMaster.medicaidNo.label"
									default="Medicaid No :" />
							</label>
							<div class="fms_form_input">
								<g:secureTextField maxlength="50" size="30"
									name="memberMaster.${ memberMaster?.memberDBID }.medicaidNo"
									tableName="MEMBER_MASTER" attributeName="medicaidNo"
									value="${memberMaster.medicaidNo}" type="text"
									class="form-control" id="Medicaid"
									title="Medicaid Number for the Member"
									aria-labelledby="Medicaid_label"
									aria-describedby="Medicaid_error" aria-required="false">
								</g:secureTextField>
								<div class="fms_form_error" id="Medicaid_error"></div>
							</div>


							<label class="control-label" id="Salutation_label"
								for="Salutation"> <g:message
									code="memberMaster.namePrefix.label" default="Salutation:" />
							</label>
							<div class="fms_form_input">
								<g:secureCdoSelectBox
									cdoClassName="com.perotsystems.diamond.dao.cdo.ContactTitleMaster"
									className="form-control" tableName="MEMBER_MASTER"
									attributeName="middleInitial" cdoAttributeWhereValue="S"
									cdoAttributeWhere="titleType" cdoAttributeSelect="contactTitle"
									cdoAttributeSelectDesc="description" languageId="0"
									htmlElelmentId="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.prefixName"
									defaultValue="${memberMaster?.primaryMemberAddress?.prefixName}"
									blankValue="Salutation"
									aria-labelledby="Salutation_label"
									aria-describedby="Salutation_error"
									aria-required="false">
								</g:secureCdoSelectBox>
								<div class="fms_form_error" id="Salutation_error"></div>
							</div>


							<label for="userDate1" class="control-label" id="userDate1_label" > 
									<g:message code="memberMaster.userDate1.label" default="User Date 1 : " />
							</label>
							<div class="fms_form_input">                                                                                                                                                                                                  
									<g:securejqDatePickerUIUX maxlength="5"
											tableName="MEMBER_MASTER" attributeName="userDate1" 
											dateElementId="memberMaster.${ memberMaster?.memberDBID }.userDate1" 
											dateElementName="memberMaster.${ memberMaster?.memberDBID }.userDate1" 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100',maxDate:'+10y'" 
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberMaster?.userDate1)}"
											ariaAttributes="aria-labelledby='userDate1_label' aria-describedby='userDate1_error' aria-required='false'" 
											classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${isShowCalendarIcon}"/>
									<div class="fms_form_error" id="userDate1_error"></div>
							</div> 
							
							<label for="userDate2" class="control-label" id="userDate2_label" > 
									<g:message code="memberMaster.userDate2.label" default="User Date 2 : " />
							</label>
							<div class="fms_form_input">                                                                                                                                                                                                  
									<g:securejqDatePickerUIUX 
											tableName="MEMBER_MASTER" attributeName="userDate2" maxlength="5"
											dateElementId="memberMaster.${ memberMaster?.memberDBID }.userDate2" 
											dateElementName="memberMaster.${ memberMaster?.memberDBID }.userDate2" 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100', maxDate:'+10y'" 
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberMaster?.userDate2)}"
											ariaAttributes="aria-labelledby='userDate2_label' aria-describedby='userDate2_error' aria-required='false'" 
											classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${isShowCalendarIcon}"/>
									<div class="fms_form_error" id="userDate2_error"></div>
							</div> 

							<label for="userDate3" class="control-label" id="userDate3_label" > 
									<g:message code="memberMaster.userDate3.label" default="User Date 3 : " />
							</label>
							<div class="fms_form_input">                                                                                                                                                                                                  
									<g:securejqDatePickerUIUX 
											tableName="MEMBER_MASTER" attributeName="userDate3" maxlength="5"
											dateElementId="memberMaster.${ memberMaster?.memberDBID }.userDate3" 
											dateElementName="memberMaster.${ memberMaster?.memberDBID }.userDate3" 
											datePickerOptions="changeMonth:true, changeYear:true, yearRange: '-100:+100', maxDate:'+10y'" 
											dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberMaster?.userDate3)}"
											ariaAttributes="aria-labelledby='userDate3_label' aria-describedby='userDate3_error' aria-required='false'" 
											classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
											showIconDefault="${isShowCalendarIcon}"/>
									<div class="fms_form_error" id="userDate3_error"></div>
							</div>							

							<label class="control-label" id="userDefined6_label"
								for="userDefined6"> <g:message
									code="memberMaster.userDefined6.label"
									default="User Defined 6 : " />
							</label>
							<div class="fms_form_input">
								<g:secureTextField class="form-control" id="userDefined6"
									aria-labelledby="userDefined6_label"
									aria-describedby="userDefined6_error" aria-required="false"
									size="30" maxlength="15"
									name="memberMaster.${ memberMaster?.memberDBID }.userDefined6"
									tableName="MEMBER_MASTER" attributeName="userDefined6"
									value="${memberMaster?.userDefined6}"></g:secureTextField>
								<div class="fms_form_error" id="userDefined6_error"></div>
							</div>

							<label class="control-label" id="userDefined7_label"
								for="userDefined7"> <g:message
									code="memberMaster.userDefined7.label"
									default="User Defined 7 : " />
							</label>
							<div class="fms_form_input">
								<g:secureTextField class="form-control" id="userDefined7"
									aria-labelledby="userDefined7_label"
									aria-describedby="userDefined7_error" aria-required="false"
									size="30" maxlength="15"
									name="memberMaster.${ memberMaster?.memberDBID }.userDefined7"
									tableName="MEMBER_MASTER" attributeName="userDefined7"
									value="${memberMaster?.userDefined7}"></g:secureTextField>
								<div class="fms_form_error" id="userDefined7_error"></div>
							</div>

						</div>
					</div>
				</fieldset>
	
	          </div>
	        <!-- END - WIDGET: General Information -->
	
	
	        <!-- START - WIDGET: Primary Address -->
	          <div id="widgetAddress" class="fms_widget">
	
	            <fieldset>
					<legend>
						<h2>Primary Address</h2>
						<g:if test="${memberMaster?.memberDBID}">
							<button type="button" class="btn btn-default btn-xs"
								onclick="location.href='/FMSAdminConsole/memberMaintenance/show/${subscriberMember.subscriberID}?editType=ADDRESS'">
								<span class="glyphicon glyphicon-pencil"></span> Edit
							</button>
						</g:if>
						<g:else>
							<button type="button" class="btn btn-default btn-xs" onClick="displayAddressMessage()">
								<span class="glyphicon glyphicon-pencil"></span> Edit
							</button>
						</g:else>
					<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" data-target="#InfoAlert"><span class="glyphicon glyphicon-repeat"></span></button>
					</legend>

					<div class="fms_form_layout_2column">                  
	                <div class="fms_form_column fms_long_labels">
	
	                  <label class="control-label" id="Address1_label" for="Address1">
	                  	<g:message code="memberMaster.address1.label" default="Address1 :"/>
	                  </label>
	                  <div class="fms_form_input">
						<g:secureTextField class="form-control" id="Address1" 
								aria-labelledby="Address1_label" aria-describedby="Address1_error" aria-required="false" maxlength="60"
								name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.address1" 
								tableName="MEMBER_ADDRESS" attributeName="addressLine1" 
								value="${memberMaster?.primaryMemberAddress?.address1}" disabled="disabled"></g:secureTextField>		                    
	                    <div class="fms_form_error" id="Address1_error"></div>
	                  </div>
	
	                  <label class="control-label" id="Address2_label" for="Address2">
	                  	<g:message code="memberMaster.address2.label" default="Address2 :"/>
	                  </label>
	                  <div class="fms_form_input">
						<g:secureTextField class="form-control" id="Address2" maxlength="60"
							aria-labelledby="Address2_label" aria-describedby="Address2_error" aria-required="false"
							name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.address2"
							tableName="MEMBER_ADDRESS" attributeName="addressLine2" 
							value="${memberMaster?.primaryMemberAddress?.address2}"
							maxlength="60" disabled="disabled" />	                    
	                    <div class="fms_form_error" id="Address2_error"></div>
	                  </div>
	
	                  <label class="control-label" id="SCity_label" for="City">
	                  	<g:message code="memberMaster.city.label" default="City :" />
	                  </label>
	                  <div class="fms_form_input">
	                    <g:secureTextField class="form-control" id="City" aria-labelledby="City_label" aria-describedby="City_error" aria-required="false" 
										name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.city"
										tableName="MEMBER_ADDRESS" attributeName="city" 
										value="${memberMaster?.primaryMemberAddress?.city}"
										maxlength="30" disabled="disabled"/>
	                    <div class="fms_form_error" id="City_error"></div>
	                  </div>
	
	                  <label class="control-label" id="County_label" for="County">
	                  	<g:message code="memberMaster.county.label" default="County :" />
	                  </label>
	                  <div class="fms_form_input">
	                    <g:secureTextField class="form-control" id="County" aria-labelledby="County_label" aria-describedby="County_error" aria-required="false"
										name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.county"
										tableName="MEMBER_ADDRESS" attributeName="county" 
										value="${memberMaster?.primaryMemberAddress?.county}"
										maxlength="30" disabled="disabled"/>
	                    <div class="fms_form_error" id="County_error"></div>
	                  </div>                                                      
	
	                </div>
	                <div class="fms_form_column fms_long_labels">
	
	                  <label class="control-label fms_required" id="state_label" for="state">
	                  	<g:message code="memberMaster.memberState.label" default="State :" />
	                  </label>
	                  <div class="fms_form_input">
						<g:secureComboBox
							class="form-control" id="state" aria-labelledby="state_label" aria-describedby="state_error" aria-required="false"
							name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.state" optionKey="stateCode"
							tableName="MEMBER_ADDRESS" attributeName="state" disabled="disabled"
							optionValue="stateName" id="state.name" from="${states}"
							noSelection="['':'-- Select a State --']"
							value="${memberMaster.primaryMemberAddress?.state}">
						</g:secureComboBox>
	                    <div class="fms_form_error" id="state_error"></div>
	                  </div>
	
	                  <label class="control-label" id="ZIP_label" for="ZIP">
	                  	<g:message code="memberMaster.zipCode.label" default="Zip Code :" />
	                  </label>
	                  <div class="fms_form_input">
	                    <input value="${memberMaster?.primaryMemberAddress?.zip}" type="text" class="form-control fms_zip_mask" id="ZIP" disabled="disabled" aria-labelledby="ZIP_label" aria-describedby="ZIP_error" aria-required="false" maxlength="11"/>
	                    <div class="fms_form_error" id="ZIP_error"></div>
	                  </div>
	

	                  <label class="control-label" id="Country_label" for="Country">
	                  	<g:message code="memberMaster.country.label" default="Country :" />
	                  </label>
	                  <div class="fms_form_input">
						  <g:secureTextField class="form-control" id="Country" aria-labelledby="Country_label" aria-describedby="Country_error" aria-required="false"
											name="memberMaster.${ memberMaster?.memberDBID }.memberAddress.0.address1"
											tableName="MEMBER_ADDRESS" attributeName="country" 
											value="${memberMaster?.primaryMemberAddress?.country}"
											maxlength="30" disabled="disabled"/>
		                   <div class="fms_form_error" id="Country_error"></div>
	                   </div>  	                  
	
	                </div>
	              </div>
	            </fieldset>
	          </div>	   		
	        <!-- Start - WIDGET: Current Eligibility -->
	          <div id="widgetEligibility" class="fms_widget">
	
	            <fieldset>

					<legend>
						<h2>Current Eligibility</h2>
						<%MemberEligHistory eligibilityHistoryVar = currentMemberEligibilityHistory.get(memberMaster.memberDBID)
							if(dependentFlag && dependentEligibilityHistory != null) eligibilityHistoryVar = dependentEligibilityHistory
							%>
							<button type="button" id="BtnEligibilityEdit" class="btn btn-default btn-xs"
								onclick="location.href='/FMSAdminConsole/memberMaintenance/show/${subscriberMember.subscriberID}?editType=DETAIL'">
								<span class="glyphicon glyphicon-pencil"></span> Edit
							</button>
					</legend>


				<g:render template="layout_1/memberMasterFormEligibilityForm" model="[isShowCalendarIcon:isShowCalendarIcon, eligibilityHistoryVar:eligibilityHistoryVar, memberMaster:memberMaster]"/>
	
	         </fieldset>
	        </div>
	        <!-- END - WIDGET: Current Eligibility -->
			<!-- Start - WIDGET: Employer Information -->
			<g:if test="${memberMaster.insertDate}">
			<!-- Start - WIDGET: Employer Information -->
			<div id="widgetEmployer" class="fms_widget">

				<fieldset>
					<legend>
						<h2>Employer Information</h2>
							<%GroupMaster groupMasterVar = memberMasterGroupMasterMap.get(memberMaster.memberDBID)%>
							<%AgentMaster agentMasterVar = memberMasterAgentDetails.get(memberMaster.memberDBID)%>
							<%GroupContactPerson groupContactPersonVar = memberMasterContactMap.get(memberMaster.memberDBID)%>
					</legend>

					<div class="fms_form_layout_2column">
						<div class="fms_form_column fms_long_labels">
						
			                  <label class="control-label" id="EmployerName_label" for="EmployerName">
			                  	<g:message code="groupMaster.groupName1.label" default="Employer Name :" />
			                  </label>
			                  <div class="fms_form_input">
									<g:textField class="form-control" aria-labelledby="EmployerName_label" aria-describedby="EmployerName_error" aria-required="false"
										maxlength="18" name="groupMaster.${memberMaster.memberDBID }.groupName1" value="${groupMasterVar?.groupName1}" disabled="disabled"/>
			                     <div class="fms_form_error" id="EmployerName_error"></div>
			                  </div>	

			                  <label class="control-label" id="EmployerContact_label" for="EmployerContact">
			                  	<g:message code="groupContact.contactName.label" default="Employer Contact :" />
			                  </label>
			                  <div class="fms_form_input">
									<g:textField class="form-control" aria-labelledby="EmployerContact_label" aria-describedby="EmployerContact_error" aria-required="false"
										maxlength="18" name="groupContact.${memberMaster.memberDBID }.contactName" value="${groupContactPersonVar?.contactName}" disabled="disabled"/>
			                     <div class="fms_form_error" id="EmployerContact_error"></div>
			                  </div>

							<label for="dateCreated" class="control-label" id="dateCreated_label" > 
								<g:message code="eligHistory.hireDate.label" default="Date Created :" />
							</label>
							<div class="fms_form_input">                                                                                                                                                                                                  
								<fmsui:jqDatePickerUIUX  
									disabled="true"
									dateElementId="memberMaster.${ memberMaster?.memberDBID }.insertDate" 
									dateElementName="memberMaster.${ memberMaster?.memberDBID }.insertDate" 
									dateElementValue="${formatDate(format:'MM/dd/yyyy',date: memberMaster?.insertDate)}"
									ariaAttributes="aria-labelledby='dateCreated_label' aria-describedby='dateCreated_error' aria-required='false'" 
									classAttributes ="class='form-control fms_date_mask fms_small_input onDelete' "
									showIconDefault="false"/>
								<div class="fms_form_error" id="hireDate_error"></div>
							</div> 
			                  			                  
			                  					
						</div>
						<div class="fms_form_column fms_long_labels">
						
			                  <label class="control-label" id="BrokerFirstName_label" for="BrokerFirstName">
			                  	<g:message code="agentMaster.firstName.label" default="Broker First Name :" />
			                  </label>
			                  <div class="fms_form_input">
									<g:textField class="form-control" aria-labelledby="BrokerFirstName_label" aria-describedby="BrokerFirstName_error" aria-required="false"
										maxlength="18" name="agentMaster.${memberMaster.memberDBID }.firstName" value="${agentMasterVar?.firstName}" disabled="disabled"/>
			                     <div class="fms_form_error" id="FirstName_error"></div>
			                  </div>
			                  
			                  <label class="control-label" id="BrokerLastName_label" for="BrokerLastName">
			                  	<g:message code="agentMaster.lastName.label" default="Broker Last Name :" />
			                  </label>
			                  <div class="fms_form_input">
									<g:textField class="form-control" aria-labelledby="BrokerLastName_label" aria-describedby="BrokerLastName_error" aria-required="false"
										maxlength="18" name="agentMaster.${memberMaster.memberDBID }.lastName" value="${agentMasterVar?.lastName}" disabled="disabled"/>
			                     <div class="fms_form_error" id="BrokerLastName_error"></div>
			                  </div>			                  

							  <label class="control-label" id="licenseNo_label" for="licenseNo">
								  <g:message code="memberMaster.medicaidNo.label"
									default="Broker License Number :" />
							  </label>
							  <div class="fms_form_input">
								  <g:textField name="agentMaster.${memberMaster.memberDBID }.licenseNo"
										 id="agentMaster.${memberMaster.memberDBID }.licenseNo"
										 value="${agentMasterVar?.licenseNo}" disabled="disabled"
										 class="form-control" aria-labelledby="licenseNo_label" aria-describedby="licenseNo_error" aria-required="false" />
									  <div class="fms_form_error" id="Medicaid_error"></div>
							  </div>
							  

							  			                  						
						</div>
					</div>									

				</fieldset>			
			</div>
			</g:if> 
			<!-- END - WIDGET: Employer Information -->
	        
	        <div id="addGroupPlaceHolder">&nbsp;</div>
		</div>
				
	</g:each>
    </div>

	<div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>To populate primary address fields, complete and save this member master page. Then under the 'Addresses' tab, add a primary address with an appropriate effective date.</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
	<!-- START - Search Group ID Modal -->
<div class="modal fade" id="SearchAlertModalInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->	

<!-- START - Search Valid Group ID Modal -->
<div class="modal fade" id="SearchAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter a valid Group Id.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->	

	<script>
		var memberSelectObject = document.getElementById('memberIdSelectList')
		showAddress(memberSelectObject)
	</script>