<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'systemParameter.label', default: 'Parameter')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="sysMaint"/> 
		<script>
			function createSystemParameter() {
				var createSystemParameterCoded = "${params.parameterId}";
				window.location.assign('<g:createLinkTo dir="/systemParameter/create?parameterId="/>'
					+ createSystemParameterCoded );
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
				  if (elements[ii].type == "text" && selects[ii]) {
				    if(selects[ii].value != ""){
					    searchCriteria = true;
					}
				  }
				}
					
				  if(searchCriteria == false){
					  //alert ("Please enter search criteria to find plan.");
					  document.getElementById('BtnInfoAlertId').click();
				}
				  
				  return searchCriteria;
				
			}
			
			function clearSearchCriteria() {
				var elements = document.getElementsByTagName("input");
				var firstText = true;
				for (var ii=0; ii < elements.length; ii++) {
				  if (elements[ii].type == "text") {			
				    elements[ii].value = "";
				    if (firstText) {
				    	 elements[ii].focus();
					    firstText = false;
					 }
				  }
				}
			}
			
			function setFirstElementFocus() {
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
			
				$(document).ready(function() { 
			
			      $('#BtnClear').click(function(e){
			        $('#SearchNoResults, #SearchResults').addClass('hidden');
			      });
				});
				
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
          		<a href="/FMSAdminConsole/sysMaint/list">System Maintenance</a> / System Parameter
        	</div>
		    <div class="fms_content_title">
          		<h1>System Parameter</h1>
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
			                <li><a class="active" href="<g:createLinkTo dir="/systemParameter/search"/>">Parameter</a></li>
			                <li><a class="list" href="<g:createLinkTo dir="/planMaintenance/search"/>">Plan</a></li>
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
	  	<div id="SearchNoResults">
		<%-- Error messages start--%>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
		</div>	
		<g:if test="${fieldErrors}">
			<ul class="errors" role="alert">
				<g:each in="${fieldErrors}" var="error">
					<li>${error}</li>
				</g:each>
			</ul>
		</g:if>
		<ul id="errorDisplay" style="display: none;" class="errors" role="alert" style="float:left; margin: -5px 10px 0px 0px; "></ul>
		<%-- Error messages end--%>

        <div id="DataTableSection">
         	<!-- START - Search Form -->
            	<div class="fms_widget fms_form_container">        
              		<div class="fms_form_header">            
                		<h2>System Parameter Search</h2>
                			<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
              		</div>
					<div class="fms_form">
              			<form name="searchForm" action='<g:createLinkTo dir="/systemParameter/search"/>'>
        				   <input type="hidden" name="searchRef" value="searchForm">
      				       		<div class="fms_form_body">
				                  <div class="fms_form_layout_2column">                  
                    				<div class="fms_form_column fms_long_labels">
                 						<label class="control-label" for="parameterId" id="parameterId_label">System Parameter :</label>
                      					<div class="fms_form_input">
                        				   <input type="text" 
			                        	   autofocus="autofocus" 
			                        	   maxlength="12" 
			                        	   id="parameterId" 
			                        	   name="parameterId" 
			                        	   value="${params.parameterId}"
			                        	   onclick='javascript: parameterId.value = ""'
			                        	   class="form-control" 
			                        	   aria-labelledby="parameterId_label" 
			                        	   aria-describedby="parameterId_error" 
			                        	   aria-required="false" >
                        	   			   <div class="fms_form_error" id="parameterId_error"></div>
							        	</div>
									</div>
									<div class="fms_form_column">
                						<label class="control-label" for="description" id="description_label">Description :</label>
                      					<div class="fms_form_input">
	                        			   <input type="text"
			                        	   name="description"
			                        	   maxlength="1500" 
			                        	   class="form-control" 
			                        	   id="description" 
			                        	   value="${params.description}"
			                        	   onclick='javascript: description.value = ""'
			                        	   aria-labelledby="description_label" 
			                        	   aria-describedby="description_error" 
			                        	   aria-required="false" >
                        	  			   <div class="fms_form_error" id="description_error"></div>
										</div>
					     			</div>
                       			</div>
                      		</div>
		                	<div class="fms_form_button">
			                  <button id="BtnSearch" type="submit" value="Search" onClick="return checkForSearchCritera()" class="btn btn-primary">Search</button>
			                  <input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
			                  <input id="BtnClear" type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria()">
			                  <button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset plan form." data-target="#BlankAlertModal"><span class="glyphicon glyphicon-repeat"></span></button>              
		           		    </div>
						</form>
            		</div>
            	</div>
            
      			<g:if test="${(systemParameterCount == 0)&& ( (params.parameterId != null && params.parameterId.length() > 0))}">
      				<g:if test="${(params.parameterId) && (params.parameterId.length() > 5)}">
						<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
          					<div id="createSystemParameterDiv">
             					<g:checkURIAuthorization uri="/systemParameter/create">
	                       			<button 
		                               id="BtnAddNew" 
		                               class="btn btn-primary btn-sm" 
		                               title="Click to add new parameter." 
		                               onClick="createSystemParameter()">
		                               <i class="fa fa-plus"></i>
		                                Create a System Parameter - ${params.parameterId}
	              					</button>
                        		</g:checkURIAuthorization>
               		 		</div>
               		 	</div>
			   		</g:if>
				</g:if>
     			<g:if test="${systemParameterCount > 0}">
					<div id="SearchResults" class="fms_widget">
            			<div class="fms_widget">
            				<h2>System Parameter Search Results</h2>
		  					<div class="row fms-col_selector_row">
                				<div id="DataTableFound" class="col-xs-6 fms-results-found">${systemParameterCount} Results Found</div>
                				<div class="col-xs-6 fms-column-selector">
                					<div class="columnSelectorWrapper">
                    					<input id="colSelect1" type="checkbox" class="hidden columnSelectorcolSelect1">
                    					<label class="columnSelectorButton" for="colSelect1" title="Hide and Show Columns"><i class="fa fa-columns"></i>&nbsp;&nbsp;<i class="fa fa-caret-down"></i></label>
                    					<div id="columnSelector" class="columnSelector">
                        			</div>
                				</div>
              				</div>
             			</div>
            		</div>
					<div class="fms_table_wrapper">
                		<table id="SearchResults1" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="SearchResults_pager_info">
                  			<thead>
                    			<tr role="row" class="tablesorter-headerRow">
                      				<fmsui:sortableColumn property="parameterId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="1" aria-disabled="false"
											title="${message(code: 'systemParameter.parameterId.label', default: 'Parameter Id')}"
											params="${[parameterId:params.parameterId,description:params.description, offset:request.getParameter('offset')]}" />
									<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Actions</th>
                    			</tr>
                  			</thead>
                  			<tfoot>
                    			<g:if test="${systemParameterCount > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
                      				<th colspan="3" data-column="0" class="tablesorter-headerAsc">
                        				<div id="DataTablePager" class="pager tablesorter-pager">
                          					<span class="right">
					                          	<div class="pagination">
					                            	<g:paginate total="${systemParameterCount}"	params="${[parameterId:params.parameterId, description :params.description , offset:request.getParameter('offset')]}" />
										   		</div>
                          					</span>
                        				</div>               
                      				</th>
                    			</g:if>
                  			</tfoot>
                  			<tbody aria-live="polite" aria-relevant="all">
                  				<g:each in="${systemParameterCollection}" status="i" var="systemParameterInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										<td>
											${fieldValue(bean: systemParameterInstance, field: "parameterId")}
										</td>
										<td>
											<div title="${systemParameterInstance.parameterId}">			                        				
												<g:link action="show"
													id="${systemParameterInstance.parameterId}"
													params="${[editType:'MASTER', parameterId: systemParameterInstance.parameterId]}">
													<span class="glyphicon glyphicon-pencil"></span>
												</g:link>
											</div>
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
</div>
<!-- START - BlankAlertModal -->
<div class="modal fade" id="BlankAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<!-- <div class="modal fade" id="InfoAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->        
	  	 <div class="modal-dialog">
          <div class="modal-content fms_modal_error-sm">
            <div class="modal-body">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h5>Please enter search criteria to find results.</h5>            
            </div>

	           <div class="modal-footer text-center">
              <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
            </div>
          </div>
        </div>
      </div>
<!-- END - BlankAlertModal -->

</html>
