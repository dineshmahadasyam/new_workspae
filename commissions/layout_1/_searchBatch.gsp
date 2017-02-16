<%@ page import="com.dell.diamond.service.auth.SecurityService" %>
<%@ page import="com.perotsystems.diamond.bom.AgencyBatchJob"%>

<g:checkURIAuthorization uri="/commissions/searchBatch"/>

<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<!-- Main menu select -->
<meta name="navSelector" content="maint"/>
<!-- Child menu select -->
<meta name="navChildSelector" content="searchJobs"/>

<g:set var="entityName"
	value="${message(code: 'searchBatch.label', default: 'SearchBatch')}" />
	
<g:set var="appContext" bean="grailsApplication"/>

<title>Search Jobs</title>
<%-- JavaScript Includes --%>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>

<script type="text/javascript">
		$(document).ready(function() {
			$('#SearchNoResultsAutoAssign').hide();
		});
		
		function clearSearchCriteria() {
			// Below line is added as on click of clear button we have to clear records as well.	
				
				$('#SearchResults').hide();  
				$('.message').hide();
				$('.errors').hide();
				$('#SearchNoResults').hide();
				$('#SearchNoResultsAutoAssign').show();
				
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
		
		$(function($){
		   $("#batchId").alphanum({
			    allow 		: '-_',
			    allowSpace  : false
			});
		})
		
		function checkForSearchCritera(){
		var elements = document.getElementsByTagName("input");
		var searchCriteria = false;
		
		for (var ii=0; ii < elements.length; ii++) {
		  if (elements[ii].type == "text") {
		    if(elements[ii].value){
			    searchCriteria = true;
			    }
		  }
		  if (elements[ii].type == "number") {
			    if(elements[ii].value){
				    searchCriteria = true;
				    }
			  }
		}

		var selects = document.getElementsByTagName("select");
		for (var ii=1; ii < selects.length; ii++) {
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

	function deleteBatch(seqId){
	    document.getElementById('seqBatchId').value = seqId;
	    return true;
	}
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

	 	$('.BtnDeleteRow');
	      $('.BtnDeleteRow').click(function(e){
	          $('#DeleteAlertModal').modal('show');
	      });
	      $('#DeleteAlertModal').modal( {
		      backdrop: 'static',
		       show: false 
		  });
	      $("#BtnDeleteRowYes").click(function(e){	      
	               var appName = "${appContext.metadata['app.name']}";
	               var myFm = document.getElementById("searchForm") ; 			
	               myFm.action = "/"+appName+"/commissions/deleteBatch";     	
	               myFm.submit();
	           
	  		});
	});
	
	</script>
</head>
<div id="fms_content">
		<!-- START - FMS Content Header -->
		<div id="fms_content_header">
			<div class="fms_content_header_note">
				<a href="/FMSAdminConsole/commissions/searchJobs">Commissions Maintenance</a> / Search Batch
        	</div>
			
			<div class="fms_content_title">
          		<h1>Search Batch</h1>
          		
        	</div> 
      	</div>
		<!-- END - FMS Content Header -->
		<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
		    	<li><g:link class="list" action="searchJobs" params="${[editType :'searchJobs']}">Search Jobs</g:link></li>
				<li><g:link class="active" action="batchSearch" params="${[editType :'searchBatch']}">Search Batch</g:link></li>
				<li><a class="list" href="<g:createLinkTo dir="/rateSchedule/list"/>">Commission - Incentive Rate Schedule</a></li>
			</ul>
			<div id="mobile_tabs_select"></div>
		</div>

		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
			
           	<p>     
           	<div id="list-planMaster" class="content scaffold-list" role="main">      		
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
			</p>
			<form name="searchForm" id="searchForm" action="/${appContext.metadata['app.name']}/commissions/searchBatch">
			<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'batchId'}" />
      		<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
			<input type="hidden" name="searchRef" value="searchForm">
			<g:hiddenField name="seqBatchId" value=""/>
			<div class="fms_widget fms_form_container">
	            <div class="fms_form_header">            
	              <h2>Commission-Incentive Group Batch</h2>
	              <a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
	            </div>
		          <div class="fms_form">
		          	<div class="fms_form_body">
		
		               <div class="fms_form_layout_2column">                  
		                  <div class="fms_form_column fms_long_labels">
	          	
	                    				<label class="control-label" for="batchId" id="batchId_label">
	                    				 Batch ID : 
	                    				</label>
	                     				<div class="fms_form_input">
					                        <input 
					                        type="text" 
					                        autofocus="autofocus" 
					                       	name="batchId" 
					                       	id="batchId" 
					                       	value="${params.batchId}" 
					                       	maxlength="19" 
					                       	Class="form-control"
					                       	aria-labelledby="batchId_label" 
											aria-describedby="batchId_error" 
											aria-required="false" >
					                        <div class="fms_form_error" id="batchId_error"></div>
	                     				</div>
	                     				<label class="control-label" for="dw_grupb_de" id="dw_grupb_de_label"> 
	                     				 Batch Schedule : 
	                     				</label>
	                     				<div class="fms_form_input">
					                        <g:getDiamondDataWindowDetail 
					                        columnName="billing_frequency"
											dwName="dw_grupb_de" 
											languageId="0"
											htmlElelmentId="scheduleType"
											defaultValue="${params.scheduleType}"
											blankValue="Schedule Type" 
											cssClass="form-control"
											aria-labelledby="dw_grupb_de_label" 
											aria-describedby="dw_grupb_de_error" 
											aria-required="false" />
					                        <div class="fms_form_error" id="dw_grupb_de_error"></div>
	                     				</div>
	                     			</div>
	                     			<div class="fms_form_column fms_long_labels">	
										<label class="control-label" for="batchType" id="batchType_label">
										 Batch Type : 
										</label>
	                     				<div class="fms_form_input">
					                      <select name="batchType" id="batchType" Class="form-control"aria-labelledby="batchType_label" 
											aria-describedby="batchType_error" 
											aria-required="false">
													<option value="" >-- All --</option>
													<option value="I"
														${"I".equals(params.batchType)? 'selected' :'' }>I - Incentive</option>
													<option value="C"
														${"C".equals(params.batchType)? 'selected' :'' }>C - Commission</option>
													</select>
					                        <div class="fms_form_error" id="batchType_error"></div>
	                     				</div>
	                     				
	                     				<label class="control-label" for="excludeAutoSchedule" id="excludeAutoSchedule_label">
	                     				 Exclude Auto Schedule : 
	                     				</label>
	                     				<div class="fms_form_input">
					                      <select name="excludeAutoSchedule" id="excludeAutoSchedule" Class="form-control"aria-labelledby="excludeAutoSchedule_label" 
											aria-describedby="excludeAutoSchedule_error" 
											aria-required="false">
														<option value="">-- All --</option>
														<option value="N"
															${"N".equals(params.excludeAutoSchedule) ? 'selected':'' }>No</option>
														<option value="Y"
															${"Y".equals(params.excludeAutoSchedule) ? 'selected':'' }>Yes</option>
													</select>
					                        <div class="fms_form_error" id="excludeAutoSchedule_error"></div>
	                     				 </div>					
																
										</div>
					                </div>
					              </div>
			                     	<div class="fms_form_button">
			                     		<input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCritera()">
										<input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
			  							<input id="BtnClear" type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria();setFirstElementFocus()">	
										<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to search Batch form." data-target="#InfoAlertModal"></button>
			                		  </div>
					             </div>
					           </div>
					      </form>
						
						<!-- END - Search Form -->
						<!-- If no records found -->
							 <div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
								<g:link action="createBatch" params="${[batchId:params.batchId, scheduleType:params.scheduleType, batchType:params.batchType, excludeAutoSchedule:params.excludeAutoSchedule]}" class="btn btn-primary" >Create Batch</g:link>
							</div>
							<div id="SearchNoResultsAutoAssign" class="fms_widget fms_widget_border fms_widget_bgnd-color">
								<g:link action="createBatch" class="btn btn-primary" >Create Batch</g:link>
							</div>
						<br></br>
									<!-- If records found --> 
								<g:if test="${searchTotal > 0}">
									<div id="SearchResults" class="fms_widget">
					          			
					            		<div class="fms_widget">
						              		<h2>Batch Search Results</h2>
											
											<!-- Column Selector starts here -->
											<div class="row fms-col_selector_row">
												<div id="SearchResultsFound" class="col-xs-6 fms-results-found">${searchTotal} Results Found</div>
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
										<!-- Column Selector ends here -->
										<div class="fms_table_wrapper">
											<table id="SearchResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="SearchResults_pager_info">
											   <thead>
												  <tr role="row" class="tablesorter-headerRow" >
					                    				<fmsui:sortableColumn property="batchId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
															title="${message(code: 'bb.batchId.label', default: 'Batch Id')}"
															params="${[batchId:params.batchId, scheduleType:params.scheduleType, batchType:params.batchType, excludeAutoSchedule:params.excludeAutoSchedule, offset:request.getParameter('offset')]}" />
														<fmsui:sortableColumn property="scheduleType" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1" aria-disabled="false"
															title="${message(code: 'bb.scheduleType.label', default: 'Billing Schedule Type')}"
															params="${[batchId:params.batchId, scheduleType:params.scheduleType, batchType:params.batchType, excludeAutoSchedule:params.excludeAutoSchedule, offset:request.getParameter('offset')]}" />
														<fmsui:sortableColumn property="batchType" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="3" data-column="2" aria-disabled="false"
															title="${message(code: 'bb.batchType.label', default: 'Batch Type')}"
															params="${[batchId:params.batchId, scheduleType:params.scheduleType, batchType:params.batchType, excludeAutoSchedule:params.excludeAutoSchedule, offset:request.getParameter('offset')]}" />
														<fmsui:sortableColumn property="excludeAutoSchedule" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="4" data-column="3" aria-disabled="false"
															title="${message(code: 'bb.excludeAutoSchedule.label', default: 'Exclude Auto Schedule')}"
															params="${[batchId:params.batchId, scheduleType:params.scheduleType, batchType:params.batchType, excludeAutoSchedule:params.excludeAutoSchedule, offset:request.getParameter('offset')]}" />
														<th class="{sorter: false} tablesorter-header sorter-false" data-column="4" data-columnselector="disable" aria-disabled="true">Actions</th>
					                    			</tr>
					                  			</thead>
					                  			
					                  			<tfoot>
												<g:if test="${searchTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
												<th colspan="5" data-column="0" class="tablesorter-headerAsc">
													<div id="DataTablePager" class="pager tablesorter-pager">
														<span class="right">
															<div class="pagination">
																<g:paginate total="${searchTotal}"
																	params="${[batchId:params.batchId, scheduleType:params.scheduleType, batchType:params.batchType, excludeAutoSchedule:params.excludeAutoSchedule, offset:request.getParameter('offset')]}" />
															</div>               
														</th>  
												</g:if> 
						                  		</tfoot>			
												<g:each in="${searchList}" status="i" var="result">
													<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
														<td>
																${fieldValue(bean: result, field: "batchId")}
														</td>
														<td >
																<g:if test="${fieldValue(bean: result, field: "scheduleType").equals('A') }">Annually</g:if>
																<g:elseif test="${fieldValue(bean: result, field: "scheduleType").equals('B') }">Fortnightly</g:elseif>
																<g:elseif test="${fieldValue(bean: result, field: "scheduleType").equals('M') }">Monthly</g:elseif>
																<g:elseif test="${fieldValue(bean: result, field: "scheduleType").equals('Q') }">Quarterly</g:elseif>
																<g:elseif test="${fieldValue(bean: result, field: "scheduleType").equals('S') }">Semi-annually</g:elseif>
																<g:elseif test="${fieldValue(bean: result, field: "scheduleType").equals('T') }">Tenthly</g:elseif>
																<g:elseif test="${fieldValue(bean: result, field: "scheduleType").equals('W') }">Weekly</g:elseif>
																<g:else>${fieldValue(bean: result, field: "scheduleType")}</g:else>
														</td>
														<td>
																<g:if test="${fieldValue(bean: result, field: "batchType").equals('C') }">Commission</g:if>
																<g:elseif test="${fieldValue(bean: result, field: "batchType").equals('I') }">Incentive</g:elseif>
																<g:else>${fieldValue(bean: result, field: "batchType")}</g:else>
														</td>
														<td >
																<g:if test="${fieldValue(bean: result, field: "excludeAutoSchedule").equals('N') }">No</g:if>
																<g:elseif test="${fieldValue(bean: result, field: "excludeAutoSchedule").equals('Y') }">Yes</g:elseif>
																<g:else>${fieldValue(bean: result, field: "excludeAutoSchedule")}</g:else>
															
														</td>
														<td>
															<g:link action="editBatch" class="btn fms_btn_icon btn-sm BtnEditRow" title="Click to edit detail." id="${result.seqBatchId}" params="${[seqBatchId:result.seqBatchId]}"><span class="glyphicon glyphicon-pencil"></span></g:link>&nbsp																							
															<button class="btn fms_btn_icon btn-sm BtnDeleteRow" title="Click to delete Batch." data-target="#DeleteAlertModal" onclick="deleteBatch(${result?.seqBatchId})" ><i class="fa fa-trash"></i></button>
														</td>																															
													</tr>
												</g:each>
											</tbody>
										</table>
									</div>
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
		<!-- END - DBlankAlertModal -->
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
	</div>
	</html>
