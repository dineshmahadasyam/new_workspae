<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'planMaster.label', default: 'PlanMaster')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:set var="appContext" bean="grailsApplication"/>
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="sysMaint"/> 
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'datetimepicker_css.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		
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

			$(function($){
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
				var selects = document.getElementsByTagName("select");
				for (var ii=0; ii < selects.length; ii++) {
				  if (selects[ii]) {
				    if(selects[ii].value != "/FMSAdminConsole/planMaintenance/search"){
					    searchCriteria = true;
					    if(selects[ii].value == ""){
						    searchCriteria = false;
					    }	
					}
				  }
				}
				
				for (var ii=0; ii < elements.length; ii++) {
				  if (elements[ii].type == "text") {
				    if(elements[ii].value){
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
			$(document).ready(function() { 
			
				$('.btnInfoAlert').hide();  
				$('.btnInfoAlert').click(function(e){ 
			    	$('#BlankAlertModal1').modal('show');
			    });
			 	$('#BlankAlertModal1').modal({
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
                				<h2>Plan Master Search</h2>
                					<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
              				</div>
					        <div class="fms_form">
              					<form name="searchForm" action="/${appContext.metadata['app.name']}/planMaintenance/search">
              					
              					<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'planCode'}" />
      							<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
              					<input type="hidden" name="searchRef" value="searchForm">
              					  
      								  <div class="fms_form_body">
								      	<div class="fms_form_layout_2column">                  
                    						<div class="fms_form_column fms_long_labels">
												<label class="control-label" for="planCode" id="planCode_label">Plan Code:</label>
					                    		<div class="fms_form_input">
						                    		<input autofocus="autofocus" 
							                   		type="text" 
							                   		class="form-control"
							                   		maxlength="50"
							                   		name="planCode"
							                   		id="planCode"
							                   		value="${params.planCode}"
							                   		maxlength="100" 
							                   		aria-labelledby="planCode_label" 
							                   		aria-describedby="planCode_error" 
							                   		aria-required="false"> 
							          				<div class="fms_form_error" id="planCode_error"></div>
							              		</div>
      				  							<label class="control-label" for="productType" id="productType_label">Product Type:</label>
                      							<div class="fms_form_input">
						                     		<g:getSystemCodes
					                     			cssClass="form-control"
													systemCodeType="PRODUCT_TYPE" 
													systemCodeActive = "Y"
													htmlElelmentId="productType"
													blankValue="productType"
													defaultValue="${params.productType}" 
													title = "Select the type of coverage for the plan from list"
													aria-labelledby="productType_label" 
							                    	aria-describedby="productType_error" 
							                    	aria-required="false"/> 
							                   		<div class="fms_form_error" id="productType_error"></div>
		              							</div>
      										</div>
      										<div class="fms_form_column">
												<label class="control-label" for="shortDescription" id="shortDescription_label">Description :</label>
                    							<div class="fms_form_input">
	                    						   <input type="text" 
								                   class="form-control"
								                   maxlength="20"
								                   name="shortDescription"
								                   id="shortDescription"
								                   value="${params.shortDescription}"
								                   maxlength="150" 
								                   aria-labelledby="shortDescription_label" 
								                   aria-describedby="shortDescription_error" 
								                   aria-required="false"> 
								                   <div class="fms_form_error" id="shortDescription_error"></div>
								            	</div>
		         								<label class="control-label" for="hixProductCode" id="hixProductCode_label">HIX Product Code :</label>
                   								<div class="fms_form_input">
		                    					   <input type="text" 
								                   class="form-control"
								                   maxlength="15"
								                   name="hixProductCode"
								                   id="hixProductCode"
								                   value="${params.hixProductCode}"
								                   title = "Enter valid HIX Product Code"
								                   aria-labelledby="hixProductCode_label" 
								                   aria-describedby="hixProductCode_error" 
								                   aria-required="false"> 
			           							   <div class="fms_form_error" id="hixProductCode_error"></div>
		           	 							</div>
    			   							</div>
                  						</div>
				 					</div>
									<div class="fms_form_button">
					                  <button id="BtnSearch" type="submit" value="Search" onClick="return checkForSearchCritera()" class="btn btn-primary">Search</button>
					                  <input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
					                  <input id="BtnClear" type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria()">
					                  <button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to reset plan form." data-target="#BlankAlertModal1"><span class="glyphicon glyphicon-repeat"></span></button>              
					           		</div>
			  					</form>
           					</div>
         				</div>
				        <g:if test="${create && ( (params.planCode != null && params.planCode.length() > 0))}"> 
				          	<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
				            	<g:checkURIAuthorization uri="/planMaintenance/plan">
				            		<button id="BtnAddNew" class="btn btn-primary btn-sm" title="Click to add new plan."onClick="createNew()"><i class="fa fa-plus"></i>Create Plan - ${params.planCode}</button>
				          		</g:checkURIAuthorization>
				          	</div>
				          	<br>
				        </g:if>
				        <g:if test="${searchTotal > 0}">
          					<div id="SearchResults" class="fms_widget">
            					<div class="fms_widget">
            						<h2>Plan Maintenance Search Results</h2>
								   	<div class="row fms-col_selector_row">
                						<div id="DataTableFound" class="col-xs-6 fms-results-found">${searchTotal} Results Found</div>
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
	                    						    <fmsui:sortableColumn property="planCode" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="1" aria-disabled="false"
																		  title="${message(code: 'planMaster.planCode.label', default: 'Plan Code')}"
																		  params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />
													<fmsui:sortableColumn property="shortDescription" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="2" aria-disabled="false"
																		  title="${message(code: 'planMaster.shortDescription.label', default: 'Short Description')}"
																		  params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />
													<fmsui:sortableColumn property="productType" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="3" aria-disabled="false"
																		  title="${message(code: 'planMaster.productType.label', default: 'Product Type')}"
																		  params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />											
													
										        	<th class="{sorter: false} tablesorter-header sorter-false" data-column="3" data-columnselector="disable" aria-disabled="true">Actions</th>
	                   							</tr>
                 							</thead>
                 							<tfoot>
                   								<g:if test="${searchTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
                     								<th colspan="4" data-column="0" class="tablesorter-headerAsc">
                       									<div id="DataTablePager" class="pager tablesorter-pager">
                        									<span class="right">
                         										<div class="pagination">
																	<g:paginate total="${searchTotal}"
																		params="${[planCode:params.planCode, shortDescription:params.shortDescription, productType:params.productType, hixProductCode:params.hixProductCode, offset:request.getParameter('offset')]}" />
																</div>
										                        <div style="display: none">
																	<input type="button" onClick="closeAllIFrames()" id="closeIframes">
																	<input type="button" onClick="iFrameSearchTradp()" id="ifSearchTradp">
																	<input type="button" onClick="iFrameSearchBatch()" id="ifSearchBatch">
																</div>
                         									</span>
                       									</div>               
                     								</th>
                   								</g:if>
                 							</tfoot>
							                <tbody aria-live="polite" aria-relevant="all">
												<g:each in="${searchList}" status="i" var="result">
							                    	<tr id="Row${i}" role="row" class="tablesorter-hasChildRow" style="">
							                      		<td>${fieldValue(bean: result, field: "planCode")}</td>
							                      		<td>${fieldValue(bean: result, field: "shortDescription")}</td>
							                      		<td>${fieldValue(bean: result, field: "productType")}</td>
							                      		<td>
									                        <g:link class="btn fms_btn_icon btn-sm BtnEditRow" 
									                        		title="Click to edit plan." 
									                        		action="edit" 
									                        		id="${result.planCode}" 
									                        		params="${[planCode:result.planCode]}">
									                        		<span class="glyphicon glyphicon-pencil"></span>
									                        </g:link>
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
<div class="modal fade" id="BlankAlertModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
</html>
