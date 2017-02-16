<%@ page import="com.dell.diamond.fms.enums.PageNameEnum" %>
<g:set var="showMember" value="" />
<g:checkURIAuthorization uri="/memberMaintenance/show">
	<g:set var="showMember" value="true" />
</g:checkURIAuthorization>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'memberMaster.label', default: 'MemberMaster')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		<g:set var="isShowCalendarIcon" value="${PageNameEnum.MEMBER_LIST.equals(currentPage)?true:false}" />
		<!-- Main menu select -->
		<meta name="navSelector" content="maint"/>
		<!-- Child menu select -->
		<meta name="navChildSelector" content="memberMaintenance"/>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		
<script type="text/javascript">
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

		function createMember() {
			var createMemberID = "${params.subscriberID}";
			var appName = "${appContext.metadata['app.name']}";
			window.location.assign("/"+appName+"/memberMaintenance/create?subscriberID="
							+ createMemberID + "&editType=MASTER");
		}

		function autoGenMember() {
			var parameter2 = "${parameter2}";
			//var generateAutoSubId = "${generateAutoSubId}"
			var appName = "${appContext.metadata['app.name']}";
			if(parameter2)
			{
				window.location.assign("/"+appName+"/memberMaintenance/create?&editType=MASTER");
			}
			
		}
		
</script>

<script type="text/javascript">
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
//			alert ("Please enter search criteria to find Members.");
			  document.getElementById('BtnInfoAlertId').click();
		  }
		  
		  return searchCriteria;
		
	}

	$(function($){
		
		   $("#idSocialSecurityNumber").mask("?999-99-9999");
		   
		   $("#idissuerSubscriberId").alphanum({
				allow 		: '-_',
				allowSpace  : false
			});
			
		   $("#idSubscriberID").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});

		   $("#idFirstName").alphanum({
			    allowSpace  : false
			});

		   $("#idlastName").alphanum({
			  	allow 		: '\'',
			    allowSpace  : false
			});
			
		   $("#idSystemID").alphanum({
			   	allow 		: '-_',
				allowSpace  : false
			});

		   $("#idstreet").alphanum({
			    allow 		: '-_#.',
			    allowSpace  : true
			});

		   $("#idcity").alphanum({
			    allowSpace  : true
			});
			
		})
		
			  
</script>

	</head>

    <div id="fms_content">
      <div id="fms_content_header">
        <div class="fms_content_header_note"></div>       

        <div class="fms_content_title">
          <h1>Member Maintenance</h1>

          <div class="fms_content_header_startpage">
         <!--    <div class="checkbox">
                <label>
                  <input id="myStartPage" name="myStartPage" type="checkbox" /> My start page
                </label>
              </div> -->
          </div>

          <div class="fms_content_header_tabs">
          <!-- <a href="#" title="Click to add individual."><i class="fa fa-user-plus"></i></a>          
            <a id="BookmarkTab" href="#" title="Click to bookmark this page."><i class="fa fa-bookmark-o"></i></a>-->
          </div>

        </div>
      </div> 

         <!-- <div id="fms_content_message" class="arrow_bgnd parent_close_this">      
         <h4>Did you know that you can change your FMS start page?</h4>
          <p>You can select a new default start page just be navigating to the other page and clicking the checkbox.</p>
          <a href="#" class="fms_content_message_close btn_close_this" title="Hide Form"><i class="fa fa-times-circle"></i></a>      
        </div>--> 


    
		
      <div id="fms_content_body">
      
      	<div id="error_Messages">
      	
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
      		</div>
      	
      	<form name="searchForm" action="/${appContext.metadata['app.name']}/memberMaintenance/list">
      	<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'subscriberID'}" />
      	<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
      	
        <!-- START - Member Search Form -->
          <div class="fms_widget fms_form_container">
            <div class="fms_form_header">            
              <h2>Member Search</h2>
              <a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
            </div>

            <div class="fms_form">
              <div class="fms_form_body">

                <div class="fms_form_layout_2column">                  
                  <div class="fms_form_column fms_long_labels">


                    <label class="control-label" id="IssuerID_label" for="IssuerID">Issuer Subscriber ID:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="IssuerID_label" aria-describedby="IssuerID_error" aria-required="false"  
                      		name="issuerSubscriberId" id="idissuerSubscriberId" value="${params.issuerSubscriberId}" maxlength="50" />
                      <div class="fms_form_error" id="IssuerID_error"></div>
                    </div>


                    <label class="control-label" id="SubscriberID_label" for="SubscriberID">Subscriber ID:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="SubscriberID_label" aria-describedby="SubscriberID_error" aria-required="false" 
                      		autofocus="autofocus" type="text" name="subscriberID" id="idSubscriberID" value="${params.subscriberID}" maxlength="50" />
                      <div class="fms_form_error" id="SubscriberID_error"></div>
                    </div>


                    <label class="control-label" id="FirstName_label" for="FirstName">First Name:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="FirstName_label" aria-describedby="FirstName_error" aria-required="false" 
                      		name="firstName" id="idFirstName" maxlength="35" value="${params.firstName}"/>
                      <div class="fms_form_error" id="FirstName_error"></div>
                    </div>


                    <label class="control-label" id="LastName_label" for="LastName">Last Name:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="LastName_label" aria-describedby="LastName_error" aria-required="false" 
                      		name="lastName" id="idlastName" maxlength="60" value="${params.lastName}" />
                      <div class="fms_form_error" id="LastName_error"></div>
                    </div>



                     <label class="control-label" id="DOB_label" for="DOB">Date of Birth:</label>  
                     <div class="fms_form_input">
	                     <fmsui:jqDatePickerUIUX 
	                     datePickerOptions="changeMonth: true, changeYear: true, maxDate:0, yearRange: '-100:+0', numberOfMonths: 1" dateElementValue="${params.dob}"  dateElementId="dob" dateElementName="dob" 
	                     ariaAttributes="aria-labelledby='DOB_label' aria-describedby='DOB_error' aria-required='false'" 
	                     classAttributes ="class='form-control fms_date_mask fms_small_input onDelete hasDatepicker' "
						 showIconDefault="${isShowCalendarIcon}"/>
	                     <div class="fms_form_error" id="DOB_error"></div>
					</div>


                  </div>
                  <div class="fms_form_column">


                    <label class="control-label" id="SystemID_label" for="SystemID">System ID:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="SystemID_label" aria-describedby="SystemID_error" aria-required="false" 
                      		 name="systemId" id="idSystemID" maxlength="12" value="${params.systemId}"/>
                      <div class="fms_form_error" id="SystemID_error"></div>
                    </div>

                    <label class="control-label" id="SSN_label" for="SSN">SSN:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control fms_ssn_mask" aria-labelledby="SSN_label" aria-describedby="SSN_error" aria-required="false" placeholder="000-00-0000" 
                      		name="socialSecurityNumber" id="idSocialSecurityNumber" maxlength="11" value="${params.socialSecurityNumber}"/>
                      <div class="fms_form_error" id="SSN_error"></div>
                    </div>

                    <label class="control-label" id="Address1_label" for="Address1">Address 1:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="Address1_label" aria-describedby="Address1_error" aria-required="false" 
                      		 name="street" id="idstreet" maxlength="60" value="${params.street}"/>
                      <div class="fms_form_error" id="Address1_error"></div>
                    </div>

                    <label class="control-label" id="City_label" for="City">City:</label>
                    <div class="fms_form_input">
                      <input type="text" class="form-control" aria-labelledby="City_label" aria-describedby="City_error" aria-required="false" 
                      		name="city" id="idcity" maxlength="30" value="${params.city}"/>
                      <div class="fms_form_error" id="City_error"></div>
                    </div>

                  </div>
                </div>

              </div>

              <div class="fms_form_button">
                <input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCritera()">
                <input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
                <button  type="button" id="BtnClear" class="btn btn-default" onClick="clearSearchCriteria()">Clear</button>
				<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset address form." data-target="#DeleteAlertModal"></button>              
              </div>
            </div>
          
          </div>
         </form>
        <!-- END  - Member Search Form -->
		
	<g:if test="${create && params.subscriberID}">
	 	<g:checkURIAuthorization uri="/memberMaintenance/create">
	 		<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
           		<button class="btn btn-primary btn-sm" id="Create_id" title="Click to create member." onClick="createMember()"><i class="fa fa-plus"></i> Create Member - ${params.subscriberID}</button>
           	</div>
      	</g:checkURIAuthorization>
  	</g:if>    	
	<g:if test="${parameter2=='Y'}">
		<div id="SearchNoResults1" class="fms_widget fms_widget_border fms_widget_bgnd-color" 
			style="display: ${parameter1=='Y'?'block':'none' }">
       		<input type="button" class="btn btn-primary" id="Create_id" value="Auto Assign Member ID" onClick="autoGenMember()" />
       	</div>
	<br></br>
	</g:if>
	<g:if test="${memberMasterTotal > 0}">

        <div id="SearchResults" class="fms_widget">
        	<div class="fms_widget">
        	
          <h2>Member Search Results</h2>


          <div class="row">
            <div id="SearchResultsFound" class="col-xs-6 fms-results-found">${memberMasterTotal} Results Found</div>
            <div class="col-xs-6 fms-column-selector">
              <div class="columnSelectorWrapper">
                <input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1" />
                <label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
                <div id="columnSelector" class="columnSelector">
					<!-- this div is where the column selector is added -->
				    
				</div> 
              </div>
            </div>
          </div>
		</div>
          <div class="fms_table_wrapper">
            <table id="SearchResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="SearchResults_pager_info">
              <thead>
                <tr role="row" class="tablesorter-headerRow" >
                  <fmsui:sortableColumn property="subscriberID" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
						title="${message(code: 'simpleMember.subscriberID.label', default: 'Subscriber Id')}"
						params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					<g:if test="${showMember}">
						<fmsui:sortableColumn property="personNumber" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1" aria-disabled="false"
							title="${message(code: 'simpleMember.getPersonNumber.label', default: 'P/N')}"
							params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					</g:if>
					<g:else>
							<fmsui:sortableColumn property="personNumber" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1" aria-disabled="false"
							title="${message(code: 'simpleMember.getPersonNumber.label', default: 'Subs/Memb')}"
							params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					</g:else>
					<fmsui:sortableColumn property="diamondID" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="3" data-column="2"  aria-disabled="false"
						title="${message(code: 'simpleMember.diamondID.label', default: 'System Id')}"
						params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					<fmsui:sortableColumn property="firstName" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="4" data-column="3" aria-disabled="false"
						title="${message(code: 'simpleMember.firstName.label', default: 'First Name')}"
						params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					<fmsui:sortableColumn property="lastName" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="5" data-column="4"    aria-disabled="false"
						title="${message(code: 'simpleMember.lastName.label', default: 'Last Name')}" 
						params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					<fmsui:sortableColumn property="gender" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="6" data-column="5" aria-disabled="false"
						title="${message(code: 'simpleMember.gender.label', default: 'Gender')}" 
						params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					<fmsui:sortableColumn property="dob" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="7" data-column="6" aria-disabled="false"
						title="${message(code: 'simpleMember.dob.label', default: 'Date of Birth')}"
						params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					<fmsui:sortableColumn property="socialSecurityNumber" class="show-disable-icon tablesorter-header"  data-sorter="false" data-priority="8" data-column="7" aria-disabled="false"
						title="${message(code: 'simpleMember.socialSecurityNumber.label', default: 'SSN')}"
						params="${[subscriberID:params.subscriberID ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
					<th class="{sorter: false} tablesorter-header sorter-false" data-column="8" aria-disabled="true">Address 1</th>
					<th class="{sorter: false} tablesorter-header sorter-false" data-column="9" aria-disabled="true">City</th>
					<th class="{sorter: false} tablesorter-header sorter-false" data-column="10" aria-disabled="true">Date Created</th>
					<th class="{sorter: false} tablesorter-header sorter-false" data-column="11" data-columnselector="disable" aria-disabled="true">Actions</th>
                </tr>
              </thead>
              <tfoot>
              <g:if test="${memberMasterTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
                <th colspan="12" data-column="0" class="tablesorter-headerAsc">
                        <div id="SearchResultsPager" class="pager tablesorter-pager">
                          <span class="right">
	                          <div class="pagination">
	                            <g:paginate total="${memberMasterTotal}" params="${[subscriberID:params.subscriberID, issuerSubscriberId:params.issuerSubscriberId ,lastName:params.lastName, firstName:params.firstName, systemId:params.systemId, dob:params.dob, socialSecurityNumber:params.socialSecurityNumber, street:params.street, city:params.city, offset:request.getParameter('offset')]}" />
	                          </div>
                          </span>
                        </div>               
                      </th>  
                      </g:if>  
              </tfoot>
              <tbody>
              	<g:each in="${memberMasterList}" status="i"var="memberMasterInstance">
                <tr role="row">
                	<td>${fieldValue(bean: memberMasterInstance, field: "subscriberID")}</td>
                	<td>${fieldValue(bean: memberMasterInstance, field: "personNumber")}</td>
                	<td>${fieldValue(bean: memberMasterInstance, field: "diamondID")}</td>
                	<td>${fieldValue(bean: memberMasterInstance, field: "firstName")}</td>
                	<td>${fieldValue(bean: memberMasterInstance, field: "lastName")}</td>
                	<td>${fieldValue(bean: memberMasterInstance, field: "gender")}</td>
                	<td><g:if test="${memberMasterInstance?.dob}"><g:formatDate format="MM/dd/yyyy" date="${memberMasterInstance.dob}" /></g:if></td>
                	<td>
						<g:if test="${memberMasterInstance?.socialSecurityNumber?.length() == 9}">***-**-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt( -Math.min(4,length())..-1):''}}</g:if>
						  <g:else>
							<g:if test="${memberMasterInstance?.socialSecurityNumber?.length() == 9}">***-**-${memberMasterInstance?.socialSecurityNumber.with {length()? getAt( -Math.min(4,length())..-1):''}}</g:if>
						  </g:else>	
					</td>
                	<td>${fieldValue(bean: memberMasterInstance.primaryMemberAddress, field: "address1")}</td>
                	<td>${fieldValue(bean: memberMasterInstance.primaryMemberAddress, field: "city")}</td>
                	<td><g:formatDate format="MM/dd/yyyy" date="${memberMasterInstance.insertDate}" /></td>
                	<td>

                    <ul class="fms_table_action">
                    
                      <li><g:link action="memberDashboard1" class="btn fms_btn_icon btn-sm" title="Click to view Dashboard." id="${memberMasterInstance.subscriberID}" params="${[subscriberId: memberMasterInstance.subscriberID, personNumber: memberMasterInstance.personNumber, issuerSubscriberId:params.issuerSubscriberId]}"><i class="fa fa-desktop"></i></g:link></li>
                      <li><g:link class="btn fms_btn_icon btn-sm" title="Click to view Master Record." action="show" id="${memberMasterInstance.subscriberID}" params="${[editType:'MASTER', personNumber: memberMasterInstance.personNumber]}"><i class="fa fa-folder-open"></i></g:link></li>
                      <li class="fms_table_action_sub">
                        <button class="btn fms_btn_icon btn-sm" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
                        <ul>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'DETAIL']}">Eligibility Details</g:link></li>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'ADDRESS']}">Addresses</g:link></li>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'BILLING']}">Billing</g:link></li>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'BENEFICIARY']}">Manage Beneficiaries</g:link></li>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'BENEFICIARY_ALLOCATION']}">Beneficiary Allocation</g:link></li>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'MEDICARE_ENROLLMENT_INFO']}">Medicare Enrollment Information</g:link></li>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'MEMMC_LIS_INFO']}">Medicare Low Income Subsidy Info</g:link></li>
                          <li><g:link class="list" action="show" id="${memberMasterInstance.subscriberID}" params="${[editType :'MMR_PMT_DTL']}">CMS MMR Payment Detail</g:link></li>
                        </ul>
                      </li>
                    </ul>
                </td></tr>
                </g:each>
              </tbody>
            </table>
          </div>
        </div>
       </g:if>
  </div>
</div>

	<!-- START - Delete Notice Modal -->
<div class="modal fade" id="DeleteAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter search criteria to find Members.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - Delete Notice Modal -->
	
<script type="text/javascript">

$(document).ready(function() { 
	
	$('.btnInfoAlert').hide();  
	$('.btnInfoAlert').click(function(e){ 
    	$('#DeleteAlertModal').modal('show');
    });
 	$('#DeleteAlertModal').modal({
    	backdrop: 'static',
       show: false
   	});

	
	// Add datepicker to Date of Birth input
	   /* $( "#dob" ).datepicker({
	      numberOfMonths: 1,
	      showOn: "button",
	      buttonText: "<i class='fa fa-calendar'></i>",
	    });*/
		
		var SearchNoResults1 = document.getElementById("SearchNoResults1")
		$('#BtnClear').click(function(e){
			$('#SearchNoResults, #SearchResults, #error_Messages').addClass('hidden');
			SearchNoResults1.style.display = "block"
		});
	});


$(document).ready(function () {

    $(".tablesorter").tablesorter({
        theme: 'blue',
        initialized: function (table) {
            $(".tablesorter").find(".show-disable-icon").removeClass("sorter-false");
            
            var sortvar = getQueryVariable('sort');
            var order = getQueryVariable('order');
            var expr = 'tr[class="tablesorter-headerRow"] th[id^="' + sortvar + '"]'
            var sortID = $(expr).attr('id');
            
            if(sortvar!== -1) {
                $("#" + sortID).removeClass("tablesorter-headerDesc");
                $("#" + sortID).removeClass("tablesorter-headerAsc");
                if (order === 'desc') {
                    $("#" + sortID).addClass("tablesorter-headerDesc");
                } else {
                    $("#" + sortID).addClass("tablesorter-headerAsc");
                }
            }            
        },

        widgets: ['zebra', 'columnSelector'],
        widgetOptions : {
          columnSelector_container : $('#columnSelector'),
          columnSelector_saveColumns: true,
          columnSelector_mediaquery: false,      
          columnSelector_layout : '<label><input type="checkbox">{name}</label>',
          columnSelector_cssChecked : 'checked',

          // Hide/Show columns based on viewport width 
          columnSelector_mediaquery: true,
          columnSelector_mediaqueryState: false,
          columnSelector_mediaqueryName: 'Auto display columns: ',
          columnSelector_priority : 'data-priority'      
        }
    });
    
    $(".show-disable-icon").click(function (evt) {
        var columnRef = evt.currentTarget.id;
        var url = $("#" + columnRef).attr("data-sorturl");
        //var ad = Math.floor(Math.random() * 2);
        
        var newURL = url;// + "&sort=" + columnRef+"&order="+ad;
        window.location = newURL;
        
    });

    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (pair[0] == variable) {
                return pair[1];
            }
        }
        return -1;
    }
    
});

    </script>          
</html>
           