<%@ page import="com.dell.diamond.service.auth.SecurityService" %>
<%@ page import="com.perotsystems.diamond.bom.AgencyJob" %>
<g:checkURIAuthorization uri="/commissions/jobs"/>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
	<!-- Main menu select -->
	<meta name="navSelector" content="maint"/>
	<!-- Child menu select -->
	<meta name="navChildSelector" content="searchJobs"/>
	<g:set var="entityName" value="${message(code: 'AgencyJob.label', default: 'AgencyJob')}" />
	<g:set var="appContext" bean="grailsApplication"/>
	
	<title>Search Jobs</title>
		
	<%-- JavaScript Includes --%>
	<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
	<script>
		$(function($){
			
			   $("#jobId").alphanum({
				    allowLatin         : false,  // a-z A-Z
					allowSpace         : false,
				});
				
			})
		</script>
	
	<script language="javascript">	
			function clearSearchCriteria() {
				
				$('#SearchResults').hide();  
				$('.message').hide();
				$('.errors').hide();
				$('#SearchNoResults').hide();
				$('#SearchNoResults1').show();
				
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
	
			function checkForSearchCritera(){
				var elements = document.getElementsByTagName("input");
				var searchCriteria = false;
				
				var selects = document.getElementsByTagName("select");
				for (var ii=0; ii < selects.length; ii++) {
				  if (selects[ii]) {
				  	
				  	if(selects[ii].value == "I"){
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "C"){
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "B"){
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "A"){
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "G"){
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "0") {
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "1") {
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "2") {
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "3") {
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "4") {
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "5") {
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "6") {
						searchCriteria = true;
						break;
					}
					
					if(selects[ii].value == "7") {
						searchCriteria = true;
						break;
					}
					
					else{
					    searchCriteria = false;
					}
					
				  }
				}
				
				for (var ii=0; ii < elements.length; ii++) {
				  if (elements[ii].type == "text") {
				    if(elements[ii].value){
					    searchCriteria = true;
					}
				  }
				  else if (elements[ii].type == "number") {
				    if(elements[ii].value){
					    searchCriteria = true;
					}
				  }
				  else if (elements[ii].type == "radio") {
					    if(elements[ii].checked){
						    searchCriteria = true;
						}
					}
				}
		
			    if(searchCriteria == false){
					//	alert ("Please enter search criteria to find results.");
					document.getElementById('BtnInfoAlertId').click();
			  	}
			  
			  	return searchCriteria;
			
			}
			
function confirmBeforeCalc(){
	document.getElementById('BtnInfoAlertId1').click();
}

function confirmBeforePay(){
	document.getElementById('BtnInfoAlertId3').click();
}

function confirmAfterCalc(){
	document.getElementById('BtnInfoAlertId2').click();
}

function confirmAfterPay(){
	document.getElementById('BtnInfoAlertId4').click();
}


</script>
<script type="text/javascript">
	$(document).ready(function() { 
	
		$('.btnInfoAlert').hide();  
		$('.btnInfoAlert').click(function(e){ 
	    	$('#BlankAlertModal').modal('show');
	    });
	 	$('#BlankAlertModal').modal({
	    	backdrop: 'static',
	       show: false
	   	});
	});
	
	</script>
<script type="text/javascript">

$(document).ready(function() {

	$('.BtnInfoRow1').hide();	
	 $('.BtnInfoRow1').click(function(e){
         $('#DeleteAlertModal1').modal('show');
     });
     $('#DeleteAlertModal1').modal( {
	      backdrop: 'static',
	       show: false 
	  });

    

     $('.BtnDeleteRow2').hide();
     $('.BtnDeleteRow2').click(function(e){
         $('#DeleteAlertModal2').modal('show');
     });
     $('#DeleteAlertModal2').modal( {
	      backdrop: 'static',
	       show: false 
	  });

     $('.BtnDeleteRow3').hide();
     $('.BtnDeleteRow3').click(function(e){
         $('#DeleteAlertModal3').modal('show');
     });
     $('#DeleteAlertModal3').modal( {
	      backdrop: 'static',
	       show: false 
	  });
    
     $('.BtnDeleteRow4').hide();
     $('.BtnDeleteRow4').click(function(e){
         $('#DeleteAlertModal4').modal('show');
     });
     $('#DeleteAlertModal4').modal( {
	      backdrop: 'static',
	       show: false 
	  });
		
});

</script>


<script type="text/javascript">

$(document).ready(function() {

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
	
</head>

<div id="fms_content">
	<div id="fms_content_header">
		<div class="fms_content_header_note">
		<a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a> / Search Jobs
		</div>

		<div class="fms_content_title">
			<h1>Search Jobs</h1>
			<!--  <h1>Add MEMMC LIS to Member : MEM461 Person Number : 01</h1> -->
		</div>
	</div>
	<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
				<li><g:link class="active" action="searchJobs" params="${[editType :'searchJobs']}">Search Jobs</g:link></li>
				<li><g:link class="list" action="batchSearch" params="${[editType :'searchBatch']}">Search Batch</g:link></li>
				<li><a class="list" href="<g:createLinkTo dir="/rateSchedule/list"/>">Commission - Incentive Rate Schedule</a></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>

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
						<li>
							${error}
						</li>
					</g:each>
				</ul>
			</g:if>
			<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
			<%-- Error messages end--%>
		</div>

		<form name="searchForm"
			action="/${appContext.metadata['app.name']}/commissions/search">
			<input type="hidden" name="searchRef" value="searchForm">

			<!-- START - Group Search Form -->
			<div class="fms_widget fms_form_container">
				<div class="fms_form_header">
					<h2>Search Jobs</h2>
					<a href="#" class="fms_form_header_close" title="Hide Form"><i
						class="fa fa-minus-square"></i></a>
				</div>

				<div class="fms_form">
					<div class="fms_form_body">

						<div class="fms_form_layout_2column">
							<div class="fms_form_column fms_long_labels">

								<label class="control-label" id="jobId_label" for="jobId">Job
									ID :</label>
								<div class="fms_form_input">
									<input type="text" class="form-control" autofocus="autofocus"
										name="jobId" id="jobId" value="${params.jobId}" maxlength="19">
									<div class="fms_form_error" id="jobId_error"></div>
								</div>

								<label class="control-label" id="jobType_label" for="jobType">Job
									Type :</label>
								<div class="fms_form_input">
									<select class="form-control" name="jobType" id="jobType"
										selected="">
										<option value="" ${"".equals(params.jobType)? 'selected' :'' }>--All--</option>
										<option value="I"
											${"I".equals(params.jobType)? 'selected' :'' }>I -
											Incentive</option>
										<option value="C"
											${"C".equals(params.jobType)? 'selected' :'' }>C -
											Commission</option>
									</select>
									<div class="fms_form_error" id="jobType_error"></div>
								</div>

							</div>


							<div class="fms_form_column fms_long_labels">
							
							<label class="control-label" id="jobOption"
									for="jobOption">Job SubType:</label>
								<div class="fms_form_input">
										<select class="form-control" id="jobOption" name="jobOption"
											aria-labelledby="searchCriteria_label"
											aria-describedby="searchCriteria_error" aria-required="false">
											 <option selected disabled>--Select--</option>
											<option name="jobOption" value="B" ${'B'.equals(request.getParameter("jobOption"))? 'selected':''  } >Batch</option>
											<option name="jobOption" value="A" ${'A'.equals(request.getParameter("jobOption"))? 'selected':'' } >Agency/Agent</option>
											<option name="jobOption" value="G" ${'G'.equals(request.getParameter("jobOption"))? 'selected':''  } >Group</option>
										</select>
										
									<div class="fms_form_error" id="jobOption_error"></div>
								</div>
							

								<label class="control-label" id="status_label" for="status">Status
									:</label>
								<div class="fms_form_input">
									<select class="form-control" name="status" id="status">
										<option value="">--All--</option>
										<option value="0" ${"0".equals(request.getParameter("status"))? 'selected' :'' }>New</option>
										<option value="1" ${"1".equals(request.getParameter("status"))? 'selected' :'' }>Running</option>
										<option value="2" ${"2".equals(request.getParameter("status"))? 'selected' :'' }>Calculated</option>
										<option value="3" ${"3".equals(request.getParameter("status"))? 'selected' :'' }>Calculated	with Errors</option>
										<option value="4" ${"4".equals(request.getParameter("status"))? 'selected' :'' }>Payment Processed</option>
										<option value="5" ${"5".equals(request.getParameter("status"))? 'selected' :'' }>Payment Processed With Error</option>
										<option value="6" ${"6".equals(request.getParameter("status"))? 'selected' :'' }>Loading Error</option>
									</select>
									<div class="fms_form_error" id="status_error"></div>
								</div>

							</div>
						</div>
					</div>

					<div class="fms_form_button">
						<input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCritera()">
						<input class="btn btn-default" type="button" value="Reset" onClick="document.forms['searchForm'].reset(); ">
						<input id="BtnClear" type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria()">
						<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to search Job." data-target="#InfoAlertModal"></button>
						<button id="BtnInfoAlertId1" type="button" class="btn fms_btn_icon btn-sm BtnInfoRow1" data-target="#DeleteAlertModal1"></button>
						<button id="BtnInfoAlertId2" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow2" data-target="#DeleteAlertModal2"></button>
					</div>
				</div>
			</div>
		</form>

		<!-- END  - Group Search Form -->
		<!-- If no records found -->
		<div id="SearchNoResults1" class="fms_widget fms_widget_border fms_widget_bgnd-color">
			<g:link class="btn btn-primary" action="jobsDetail">Create Job</g:link>
		</div>
		<br></br>

		<g:if test="${searchTotal > 0}">

			<div id="SearchResults" class="fms_widget">
				<div class="fms_widget">

					<h2>Search Job Results</h2>

					<div class="row">
						<div id="DataTableFound" class="col-xs-6 fms-results-found">
							${searchTotal}
							Results Found
						</div>
						<div class="col-xs-6 fms-column-selector">

							<div class="columnSelectorWrapper">
								<input id="colSelect1" type="checkbox"
									class="hidden columnSelectorcolSelect1"> <label
									class="columnSelectorButton" for="colSelect1"
									title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i
									class="fa fa-caret-down"></i></label>
								<div id="columnSelector" class="columnSelector">
									<!-- this div is where the column selector is added -->

								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="fms_table_wrapper">
					<table id="SearchResults1"
						class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector"
						role="grid" aria-describedby="SearchResults_pager_info">
						<thead>
							<tr role="row" class="tablesorter-headerRow">
								<fmsui:sortableColumn property="jobId"
									class="show-disable-icon tablesorter-header  "
									data-sorter="false" data-priority="1" data-column="0"
									aria-disabled="false"
									title="${message(code: 'jobId.label', default: 'Job Id')}"
									params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
								<fmsui:sortableColumn property="jobType"
									class="show-disable-icon tablesorter-header  "
									data-sorter="false" data-priority="1" data-column="0"
									aria-disabled="false"
									title="${message(code: 'jobType.label', default: 'Job Type')}"
									params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
								<fmsui:sortableColumn property="jobOption"
									class="show-disable-icon tablesorter-header  "
									data-sorter="false" data-priority="1" data-column="0"
									aria-disabled="false"
									title="${message(code: 'jobOption.label', default: 'Job Sub Type')}"
									params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
								<th class="{sorter: false} tablesorter-header sorter-false"
									data-column="0" aria-disabled="true">Job Sub ID</th>
								<fmsui:sortableColumn property="status"
									class="show-disable-icon tablesorter-header  "
									data-sorter="false" data-priority="1" data-column="0"
									aria-disabled="false"
									title="${message(code: 'productType.label', default: 'Status')}"
									params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
								<th class="{sorter: false} tablesorter-header sorter-false"
									data-column="0" aria-disabled="true">Created By User</th>
								<th class="{sorter: false} tablesorter-header sorter-false"
									data-column="6" data-columnselector="disable"
									aria-disabled="true">Actions</th>
							</tr>
						</thead>

						<tfoot>
							<g:if
								test="${searchTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
								<th colspan="12" data-column="0" class="tablesorter-headerAsc">
									<div id="SearchResultsPager" class="pager tablesorter-pager">
										<span class="right">
											<div class="pagination">
												<g:paginate total="${searchTotal}"
													params="${[jobId:params.jobId, jobType:params.jobType, jobOption:params.jobOption, status:params.status, GPL:GPL, offset:request.getParameter('offset')]}" />
											</div>
										</span>
									</div>
								</th>
							</g:if>
						</tfoot>

						<tbody aria-live="polite" aria-relevant="all">

							<g:each in="${searchList}" status="i" var="result">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
									<td>
										${result?.jobId}
									</td>
									<td><g:if
											test="${fieldValue(bean: result, field: "jobType").equals('C') }">Commission</g:if>
										<g:elseif
											test="${fieldValue(bean: result, field: "jobType").equals('I') }">Incentive</g:elseif>
										<g:else>
											${fieldValue(bean: result, field: "jobType")}
										</g:else></td>
									<td><g:if
											test="${fieldValue(bean: result, field: "jobOption").equals('A') }">Agency/Agent</g:if>
										<g:elseif
											test="${fieldValue(bean: result, field: "jobOption").equals('B') }">Batch</g:elseif>
										<g:elseif
											test="${fieldValue(bean: result, field: "jobOption").equals('G') }">Group</g:elseif>
										<g:elseif
											test="${fieldValue(bean: result, field: "jobOption").equals('P') }">Plan</g:elseif>
										<g:else>
											${fieldValue(bean: result, field: "jobOption")}
										</g:else></td>
									<td><g:if
											test="${fieldValue(bean: result, field: "jobOption").equals('A') }">
											${result?.seqAgencyId}
										</g:if> <g:elseif
											test="${fieldValue(bean: result, field: "jobOption").equals('B') }">
											${result?.batchId}
										</g:elseif> <g:elseif
											test="${fieldValue(bean: result, field: "jobOption").equals('G') }">
											${result?.seqGroupId}
										</g:elseif> <g:elseif
											test="${fieldValue(bean: result, field: "jobOption").equals('P') }">
											${result?.planCode}
										</g:elseif> <g:else></g:else></td>
									<td><g:if
											test="${fieldValue(bean: result, field: "status").equals('0') }">New</g:if>
										<g:elseif
											test="${fieldValue(bean: result, field: "status").equals('1') }">Running</g:elseif>
										<g:elseif
											test="${fieldValue(bean: result, field: "status").equals('2') }">Calculated</g:elseif>
										<g:elseif
											test="${fieldValue(bean: result, field: "status").equals('3') }">Calculated With Errors</g:elseif>
										<g:elseif
											test="${fieldValue(bean: result, field: "status").equals('4') }">Payment Processed</g:elseif>
										<g:elseif
											test="${fieldValue(bean: result, field: "status").equals('5') }">Payment Processed With Errors</g:elseif>
										<g:elseif
											test="${fieldValue(bean: result, field: "status").equals('6') }">Loading Error</g:elseif>
										<g:else>
											${fieldValue(bean: result, field: "status")}
										</g:else>
									</td>
									<td>
										${result?.insertAuditInfo?.auditUser}
									</td>
									<td><g:link class="btn fms_btn_icon btn-sm BtnEditRow" title="Click to edit detail." action="editJobDetail"	params="${[jobId:result.jobId]}"><span class="glyphicon glyphicon-pencil"></span>
										</g:link> 
											<g:if test="${fieldValue(bean: result, field: "status").equals('4') || fieldValue(bean: result, field: "status").equals('6') || fieldValue(bean: result, field: "status").equals('0') || fieldValue(bean: result, field: "status").equals('1') }">
										</g:if> 
										<g:else>
											<g:remoteLink class="btn btn-primary" before="confirmBeforePay()" action="payJob" params="${[jobId:result.jobId]}">Pay</g:remoteLink>
										</g:else> 
										<g:if test="${fieldValue(bean: result, field: "status").equals('4') || fieldValue(bean: result, field: "status").equals('6') || fieldValue(bean: result, field: "status").equals('2') }">
										</g:if> 
										<g:else>
											<g:remoteLink class="btn btn-primary" before="confirmBeforeCalc()" action="calculateJob" params="${[jobId:result.jobId]}">Calculate</g:remoteLink>
										</g:else>
									</td>
								</tr>
							</g:each>
						</tbody>
					</table>
				</div>
			</div>
		</g:if>
	</div>
</div>

<!-- START - BlankAlertModal  -->
<div class="modal fade" id="BlankAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error-sm">
			<div class="modal-body">
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  <h5>Please enter search criteria to find results</h5>            
			</div>

				<div class="modal-footer text-center">
					<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>     
				</div>
			</div>
		</div>
</div>
<!-- END - BlankAlertModal -->	

<!-- START - Info Notice Modal -->
<div class="modal fade" id="DeleteAlertModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	<div class="modal-dialog">
		<div class="modal-content fms_modal_error-sm">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4>Are you sure?</h4>            
			</div>
			<div class="modal-footer text-center">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button id="BtnDeleteRowYes" type="button" class="btn btn-default" data-dismiss="modal" onClick="confirmAfterPay()">Ok</button>
				<button id="BtnInfoAlertId3" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow3" data-target="#DeleteAlertModal3"></button>
			</div>
		</div>
	</div>
</div>
<!-- END - Info Notice Modal -->

<!-- START - Info Notice Modal -->
	<div class="modal fade" id="DeleteAlertModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>Pay initiated successfully</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal" onClick="location.reload();">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
<!-- END - Info Notice Modal -->	

	<!-- START - Info Notice Modal -->
<div class="modal fade" id="DeleteAlertModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	<div class="modal-dialog">
		<div class="modal-content fms_modal_error">
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4>Are you sure?</h4>            
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button id="BtnDeleteRowYes1" type="button" class="btn btn-primary" data-dismiss="modal" onClick="confirmAfterCalc()">Ok</button>
				<button id="BtnInfoAlertId4" type="button" class="btn fms_btn_icon btn-sm BtnDeleteRow4" data-target="#DeleteAlertModal4"></button>
			</div>
		</div>
	</div>
</div>
<!-- END - Info Notice Modal -->	

<!-- START - Info Notice Modal -->
	<div class="modal fade" id="DeleteAlertModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>Calculation initiated successfully</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal" onClick="location.reload();">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
<!-- END - Info Notice Modal -->									
											
</html>