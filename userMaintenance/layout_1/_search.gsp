<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName"
			value="${message(code: 'user.label', default: 'User')}" />
		
		<g:set var="appContext" bean="grailsApplication"/>	
		
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="userMaintenance"/> 
			
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.window.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.window.css')}" type="text/css" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'forms.css')}" type="text/css" />
		
		<script type="text/javascript">

			//Copy Function screen - Set the Search Button as the default button when enter button is clicked. If the search 
			//results are already populated then the copy button will be the default button when enter button is clicked.
			$(document).keypress(function(event) {
				var keycode = (event.keyCode ? event.keyCode : event.which);
				if(keycode == '13'){
					var actionStr = $("#searchForm").attr('action');
					if (actionStr.indexOf("copyFunction") >= 0 ) {
						var i = $(':input:submit').length;
						var j = $(':input:button').length;
						if ((parseInt(i) + parseInt(j)) == 4) {
							$(".searchButton").click();
							return false;
						}
						else {
							return getFunctionstoCopy();
						}	
					} 	
				}
				
			});
		
			function setFirstElementFocus() {
				var firstText = true;
				var elements = document.getElementsByTagName("input");
				for ( var ii = 0; ii < elements.length; ii++) {
					if (elements[ii].type == "text") {
						if (firstText) {
							firstText = false;
							elements[ii].focus();
							//break;
						}
					}
				}
			}

			//Clear all input fields which are not disabled/read only
			function clearSearchCriteria() {
				
				// Below line is added as on click of clear button we have to clear records as well.				
				$('#SearchResults').hide();  
				$('.message').hide();
				$('.errors').hide();
				$('#SearchNoResults').hide();
				
				var elements = document.getElementsByTagName("input");
				var firstText = true;
				for ( var ii = 0; ii < elements.length; ii++) {
					if ((elements[ii].type == "text") && (!(elements[ii].disabled))) {
						elements[ii].value = "";
						if (firstText) {
							firstText = false;
							elements[ii].focus();
						 }     
					}
				}
			}
		
			function checkForSearchCriteria() {
				var elements = document.getElementsByTagName("input");
				var searchCriteria = false;
				
				for (var ii=0; ii < elements.length; ii++) {
					if (elements[ii].type == "text") {
						if(elements[ii].value){
						searchCriteria = true;
						}
					}
				}
					
				if(searchCriteria == false){
					//	alert ("Please enter search criteria to find results.");
					document.getElementById('BtnInfoAlertId2').click();
				}
				return searchCriteria;
			}
			
			//Get a list of all functions that needs to be added 
			function getFunctionstoAdd() {
				var idSelector = function() {
					return this.id;
				};
				
				var checkedValues = $('input:checkbox:checked').map(idSelector).get();

				document.getElementById('functionList').value = checkedValues;

				if (checkedValues.length < 4) {
					document.getElementById('BtnInfoAlertId3').click();
					return false;

				} else {
					$(".addFunctionButtonHidden").click();
				}

			}

			//Call Search action on the controller passing userID and addfunction
			//Which will then search functions within Add functions screen for that user
			function searchFunctionForUserToAdd() 
			{
				var paramsToPass = {};
				if (location.search) {
				    var parts = location.search.substring(1).split('&');
				    for (var i = 0; i < parts.length; i++) {
				        var nv = parts[i].split('=');
				        if (!nv[0]) continue;
				        paramsToPass[nv[0]] = nv[1] || true;
				    }
				}
				
				var userId = paramsToPass.userId
				var funcId  = $("#funcId").val(); 
				var sdescr =  $("#sdescr").val();  
				var ldescr = $("#ldescr").val(); 	
				
				window.location.assign('<g:createLinkTo dir="/userMaintenance/search?userId="/>' + 
						userId + '&addFunction=${true}' 
						+ '&funcId=' + funcId 
						+ '&sdescr=' + sdescr
						+ '&ldescr=' + ldescr);
			}

			//Call Search action on the controller passing userID and copyfunction
			//which will then search functions for that User ID 
			function searchFunctionForUserToCopy() 
			{
				var userIdToCopyFrom = $("#userIdToCopyFrom").val().toUpperCase();
				var userIdTo = $("#userIdTo").val().toUpperCase();

				if (userIdToCopyFrom == '') {
				//	alert("Please enter a User Id to copy functions from.");
					
					document.getElementById('BtnInfoAlertId').click();
					return false;
				} 
				else if (userIdToCopyFrom == userIdTo) {
				//	alert("Copy To and From User Id cannot be the same.");
					document.getElementById('BtnInfoAlertId1').click();
					return false;
				}
				else {
					window.location.assign('<g:createLinkTo dir="/userMaintenance/search?userId="/>' + 
							userIdTo + '&copyFunction=${true}' 
							+ '&userIdToCopyFrom=' + userIdToCopyFrom
							);
				}
			}
			

			//Get a list of all functions that needs to be copied 
			function getFunctionstoCopy() {
				var idSelector = function() {
					return this.id;
				};
				var checkedValues = $('input:checkbox:checked').map(idSelector).get();
				
				document.getElementById('functionList').value = checkedValues;
				
				if (checkedValues.length < 4) {
					document.getElementById('BtnInfoAlertId4').click();
					return false;
				} else {
					$(".copyFunctionButtonHidden").click();
				}

			}
			
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
		
		<script type="text/javascript">
			
			$(document).ready(function() { 
				
				$('.btnInfoAlert').hide();  
				$('.btnInfoAlert').click(function(e){ 
			    	$('#InfoAlertModal').modal('show');
			    });
			 	$('#InfoAlertModal').modal({
			    	backdrop: 'static',
			       show: false
			   	});
			});
				
		</script>
		
		<script type="text/javascript">
			$(document).ready(function() { 
				$('.btnInfoAlert1').hide();  
				$('.btnInfoAlert1').click(function(e){ 
			    	$('#InfoAlertModal1').modal('show');
			    });
			 	$('#InfoAlertModal1').modal({
			    	backdrop: 'static',
			       show: false
			   	});
			});	
		</script>
		
		<script type="text/javascript">
			
			$(document).ready(function() { 
			
				$('.btnInfoAlert2').hide();  
				$('.btnInfoAlert2').click(function(e){ 
			    	$('#InfoAlertModal2').modal('show');
			    });
			 	$('#InfoAlertModal2').modal({
			    	backdrop: 'static',
			       show: false
			   	});
			});
				
		</script> 
		
		<script type="text/javascript">
			
			$(document).ready(function() { 
			
				$('.btnInfoAlert3').hide();  
				$('.btnInfoAlert3').click(function(e){ 
			    	$('#InfoAlertModal3').modal('show');
			    });
			 	$('#InfoAlertModal3').modal({
			    	backdrop: 'static',
			       show: false
			   	});
			
			});
				
		</script>
		
		<script type="text/javascript">
			
			$(document).ready(function() { 
			
				$('.btnInfoAlert4').hide();  
				$('.btnInfoAlert4').click(function(e){ 
			    	$('#InfoAlertModal4').modal('show');
			    });
			 	$('#InfoAlertModal4').modal({
			    	backdrop: 'static',
			       show: false
			   	});
			
			});
				
		</script>
		
	</head>

	<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
			<div class="fms_content_header_note">
				<g:if test="${request.getParameter('addFunction') == "true" }">
					<a href="/FMSAdminConsole/userMaintenance/list">Security Maintenance</a> /
	          		<a href="/FMSAdminConsole/userMaintenance/list"/> User Maintenance </a> / 
	          		User Records for User Id (${params.userId})
				</g:if>
				<g:elseif test="${request.getParameter('copyFunction') == "true" }">
					<a href="/FMSAdminConsole/userMaintenance/list">Security Maintenance</a> /
	          		<a href="/FMSAdminConsole/userMaintenance/list"/> User Maintenance </a> / 
	          		User Records for User Id (${params.userId})
				</g:elseif>
				<g:else>
						<a href="/FMSAdminConsole/userMaintenance/list">Security Maintenance</a> / Function Description
				</g:else>
			</div>
        	<div class="fms_content_title">
          		<h1>User Maintenance</h1>
        	</div>
      	</div>

		<g:if test="${request.getParameter('addFunction') == "true" }"></g:if>
		<g:elseif test="${request.getParameter('copyFunction') == "true" }"></g:elseif>
		<g:else>
			 <!-- START - Tabs -->
	        <div id="fms_content_tabs" class="fms_tab_action">
	          	<ul>
	                <li><a class="list" href="<g:createLinkTo dir="/userMaintenance/list"/>">User Security</a></li>
	                <li><a class="list" href="<g:createLinkTo dir="/fieldLevelMaintenance/search"/>">Field Level Security</a></li>
					<li><a class="active" href="<g:createLinkTo dir="/userMaintenance/search"/>">Function Description</a></li>
	          	</ul>
	    		<div id="mobile_tabs_select"></div>
			</div>
	      	<!-- END - Tabs -->
		</g:else>
			      	
      	<div id="fms_content_body">
      		
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
	
			<%-- START OF ADD FUNCTION CODE --%>
			<g:if test="${request.getParameter('addFunction') == "true" }">
				<div id="DataTableSection">
					
					<g:form name="searchForm" method="post" action="search"  params="[userId : params?.userId, addFunction : true]">
						<input type="hidden" name="searchRef" value="searchForm">
						<div class="right-corner" align="right" title="The keyword for this screen that can be used for audit trail">SFUNC</div>
						
						<!-- START - Search Form -->
		              	<div class="fms_form_header">            
		                	<h2>Search Function</h2>
		                	<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
		              	</div>
			              	
		              	<!-- START - FMS Form -->
	          			<div class="fms_form">
		                	<div class="fms_form_body">
		                	
		                		<div class="fms_form_layout_2column">                  
	                    			<div class="fms_form_column">
        								<label class="control-label" for="funcId" id="funcId_label">Function: </label>
	                     				<div class="fms_form_input">
					                        <input 
					                        	autofocus="autofocus"
					                        	type="text"  
					                        	maxlength="255" 
					                        	id="funcId" 
					                        	name="funcId" 
					                        	value="${params.funcId}"
					                        	class="form-control" 
					                            aria-labelledby="funcId_label" 
					                        	aria-describedby="funcId_error" >
					                        <div class="fms_form_error" id="funcId_error"></div>
	                     				</div>
	                     			</div>
	                     			<div class="fms_form_column">
	                     				<label class="control-label" for="sdescr" id="sdescr_label">Short Description: </label>
	                     				<div class="fms_form_input">
					                        <input 
					                        	type="text"  
					                        	maxlength="32" 
					                        	id="sdescr" 
					                        	name="sdescr" 
					                        	value="${params.sdescr}"
					                        	class="form-control" 
					                            aria-labelledby="sdescr_label" 
					                        	aria-describedby="sdescr_error" >
					                        <div class="fms_form_error" id="sdescr_error"></div>
	                     				</div>
	                     				
	                     				<label class="control-label" for="ldescr" id="ldescr_label">Long Description: </label>
	                     				<div class="fms_form_input">
					                        <input 
					                        	type="text"  
					                        	maxlength="128" 
					                        	id="ldescr" 
					                        	name="ldescr" 
					                        	value="${params.ldescr}"
					                        	class="form-control" 
					                            aria-labelledby="ldescr_label" 
					                        	aria-describedby="ldescr_error" >
					                        <div class="fms_form_error" id="ldescr_error"></div>
	                     				</div>
        							</div>
	                     		</div>
	                     	</div>
		              			
	              			<div class="fms_form_button">
	              				<input type="submit" class="btn btn-primary" value="Search" onClick="var temp = searchFunctionForUserToAdd();checkForSearchCriteria1(); return temp;">
          						<input type="button" class="btn btn-default" value="Reset"	onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
          						<input type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria()">
          						<button id="BtnInfoAlertId3" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert3" title="" data-target="#InfoAlertModal3"></button>
	                		</div>
	                	</div>
					</g:form>
			                		
					<g:form name="searchForm" method="post" action="addFunction">
						<input type="hidden" name="searchRef" value="searchForm">
						<div id="list-user" class="content scaffold-list" role="main">			
							<!-- START - Search Form -->
				            <div class="fms_widget fms_form_container">        
				              	
				              	<!-- START - FMS Form -->
			          			<div class="fms_form">
			                		<table style="width: 100%; overflow-x: scroll; font-size: 13px;display:none;">
										<tr>
											<td>
												<g:javascript>
													if ($.browser.mozilla) {
														<g:actionSubmit class="addFunctionButtonHidden" value="Add" action="addFunction"/>
													}
													else {
														<g:actionSubmit class="addFunctionButtonHidden" value="Add"/>
													}
												</g:javascript>
												<g:hiddenField name="functionList" id="functionList" value="" />
												<g:hiddenField name="userId" id="userId" value="${params.userId}"/>
												<g:hiddenField  name="editType" id="editType" value="FUNCTIONACCESS"/>
												<g:hiddenField name="id" id="id" value="${params.userId}"/>
											</td>
										</tr>
									</table>
			                	</div>
			                </div>

							<g:if test="${functionDescriptionTotal > 0}">
								<div id="SearchResults" class="fms_widget">
									<div class="fms_widget">

										<h2>Function Search Results</h2>
										<g:submitButton class="btn btn-primary" name="addFunctionButton" value="Add" onclick="return getFunctionstoAdd();" />
										
										<div class="row fms-col_selector_row">
											<div id="SearchResultsFound" class="col-xs-6 fms-results-found">Number of Functions available to add - ${functionDescriptionTotal}</div>
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
										
										<div class="fms_table_wrapper">
					                		<table id="DataTable" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info">
					                  			
					                  			<thead>
					                    			<tr role="row" class="tablesorter-headerRow">
					                    				<fmsui:sortableColumn property="funcId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.funcId.label', default: 'Function')}"
															params="${[offset:request.getParameter('offset'),
																addFunction:true,
																userId: request.getParameter('userId'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                    				
					                    				<fmsui:sortableColumn property="sdescr" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.sdescr.label', default: 'Short Description')}"
															params="${[offset:request.getParameter('offset'),
																addFunction:true,
																userId: request.getParameter('userId'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                    				
					                    				<fmsui:sortableColumn property="ldescr" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="3" data-column="2"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.ldescr.label', default: 'Long Description')}"
															params="${[offset:request.getParameter('offset'),
																addFunction:true,
																userId: request.getParameter('userId'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                      				<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="2" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</div></th>
					                    			</tr>
					                  			</thead>
			                					
			                					<tfoot>
					                  				<g:if test="${functionDescriptionTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
														<th colspan="4" data-column="0" class="tablesorter-headerAsc">
															<div id="SearchResultsPager" class="pager tablesorter-pager">
																<span class="right">
																	<div class="pagination">
																		<g:paginate total="${functionDescriptionTotal}" params="${[addFunction:true, userId:params.userId , offset:request.getParameter('offset'), funcId:request.getParameter('funcId'), sdescr:request.getParameter('sdescr'), ldescr:request.getParameter('ldescr')]}" />
																	</div>
																</span>
															</div>               
														</th>  
													</g:if> 
					                  			</tfoot>
					                  			
					                  			<g:each in="${functionDescriptionList}" status="i" var="functionDescription">
						                  			<tbody>
							               				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						 									<td>${fieldValue(bean: functionDescription, field: "funcId")}</td>
						            					   	<td>${fieldValue(bean: functionDescription, field: "sdescr")}</td> 
						            					   	<td>${fieldValue(bean: functionDescription, field: "ldescr")}</td>
						               						<td><g:checkBox name="${functionDescription.funcId}.checkBox" /></td>                    
						               					</tr>
							               			</tbody>
					                  			</g:each>
					                  		</table>
			                			</div>
			                		</div>
			                	</div>
			                </g:if>
						</div>
					</g:form>
					<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'funcId' }">
					<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'asc' }">
					<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">
				</div>
			</g:if>
			<%-- END OF ADD FUNCTION CODE --%>
			
			<%-- START OF COPY FUNCTION CODE --%>
			<g:elseif test="${request.getParameter('copyFunction') == "true" }">
				<div id="DataTableSection">
					<g:form name="searchForm" method="post" action="copyFunction">
			
						<input type="hidden" name="searchRef" value="searchForm">
						<div id="list-user" class="content scaffold-list" role="main">
						<div class="right-corner" align="right" title="The keyword for this screen that can be used for audit trail">SFUNC</div>	
							<!-- START - Search Form -->
				            <div class="fms_widget fms_form_container">        
				              	<div class="fms_form_header">            
				                	<h2>Search Function</h2>
				                	<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
				              	</div>
				              	
				              	<!-- START - FMS Form -->
			          			<div class="fms_form">
				                	<div class="fms_form_body">
				                	
				                		<div class="fms_form_layout_2column">                  
			                    			<div class="fms_form_column">
		        								<label class="control-label" for="userIdTo" id="userIdTo_label">User Id:<br/>(Copy To) </b></label>
			                     				<div class="fms_form_input">
							                        <input 
							                        	disabled="true"
							                        	type="text"  
							                        	maxlength="8" 
							                        	id="userIdTo" 
							                        	name="userIdTo" 
							                        	value="${params.userId}"
							                        	class="form-control" 
							                            aria-labelledby=""userIdTo_label"" 
							                        	aria-describedby="userIdTo_error" >
							                        <div class="fms_form_error" id="userIdTo_error"></div>
			                     				</div>
			                     			</div>
			                     			
			                     			<div class="fms_form_column">	
			                     				<label class="control-label" for="userIdToCopyFrom" id="userIdToCopyFrom_label">User Id:<br/>(Copy From)</b></label>
			                     				<div class="fms_form_input">
							                        <input 
							                        	autofocus="autofocus"
							                        	type="text"  
							                        	maxlength="8" 
							                        	id="userIdToCopyFrom" 
							                        	name="userIdToCopyFrom" 
							                        	value="${params.userIdToCopyFrom}"
							                        	class="form-control" 
							                            aria-labelledby="userIdToCopyFrom_label" 
							                        	aria-describedby="userIdToCopyFrom_error" >
							                        <div class="fms_form_error" id="userIdToCopyFrom_error"></div>
			                     				</div>	
			                     			</div>
			                     		</div>
			                     	</div>
			              			<div class="fms_form_button">
			              				<input type="button" class="btn btn-primary" value="Search" onClick="return searchFunctionForUserToCopy();">
										<input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
			          					<input type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria()">
			          					<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="Click to search Trading Partner form." data-target="#InfoAlertModal"></button>
			          					<button id="BtnInfoAlertId1" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert1" title="Click to search Trading Partner form." data-target="#InfoAlertModal1"></button>
			          					<button id="BtnInfoAlertId4" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert4" title="" data-target="#InfoAlertModal4"></button>
			                		</div>
			              			
			              			<table style="width: 100%; overflow-x: scroll; font-size: 13px;display:none;">
										<tr>
											<td>
												<g:actionSubmit class="copyFunctionButtonHidden" value="Copy" action="copyFunction"/>
												<g:hiddenField name="functionList" id="functionList" value="" />
												<g:hiddenField name="userId" id="userId" value="${params.userId}"/>
												<g:hiddenField  name="editType" id="editType" value="FUNCTIONACCESS"/>
												<g:hiddenField name="id" id="id" value="${params.userId}"/>
											</td>
										</tr>
									</table>
								</div>
							</div>
							
							<g:if test="${functionDescriptionTotal > 0}">     
								<div id="SearchResults" class="fms_widget">
									<div class="fms_widget">
										<h2>Function Search Results</h2>
										<g:submitButton class="btn btn-primary" name="copyFunctionButton" value="Copy" onclick=" return getFunctionstoCopy();" />
										
										<div class="row fms-col_selector_row">
					                		<div id="DataTableFound" class="col-xs-6 fms-results-found">Number of Functions available to copy - ${functionDescriptionTotal}</div>
					         				
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
										
										<div class="fms_table_wrapper">
					                		<table id="DataTable" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info">
					                  			<thead>
					                    			<tr role="row" class="tablesorter-headerRow">
					                      				<fmsui:sortableColumn property="funcId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.funcId.label', default: 'Function')}"
															params="${[offset:request.getParameter('offset'),
																copyFunction:true,
																userId: request.getParameter('userId'),
																userIdToCopyFrom: request.getParameter('userIdToCopyFrom'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                    				
					                    				<fmsui:sortableColumn property="sdescr" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.sdescr.label', default: 'Short Description')}"
															params="${[offset:request.getParameter('offset'),
																copyFunction:true,
																userId: request.getParameter('userId'),
																userIdToCopyFrom: request.getParameter('userIdToCopyFrom'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                    				
					                    				<fmsui:sortableColumn property="ldescr" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1"  aria-disabled="false"
															title="${message(code: 'functionDescription.ldescr.label', default: 'Long Description')}"
															params="${[offset:request.getParameter('offset'),
																copyFunction:true,
																userId: request.getParameter('userId'),
																userIdToCopyFrom: request.getParameter('userIdToCopyFrom'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                      				<th data-columnselector="disable" class="{sorter: false} tablesorter-header sorter-false tablesorter-headerUnSorted" data-column="2" scope="col" role="columnheader" aria-disabled="true" unselectable="on" aria-sort="none" style="-webkit-user-select: none;"><div class="tablesorter-header-inner">Actions</div></th>
					                    			</tr>
					                  			</thead>
										
												<tfoot>
					                  				<g:if test="${functionDescriptionTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
														<th colspan="4" data-column="0" class="tablesorter-headerAsc">
															<div id="SearchResultsPager" class="pager tablesorter-pager">
																<span class="right">
																	<div class="pagination">
																		<g:paginate total="${functionDescriptionTotal}" params="${[copyFunction:true, userId:params.userId, userIdToCopyFrom:params.userIdToCopyFrom, offset:request.getParameter('offset'), funcId:request.getParameter('funcId'), sdescr:request.getParameter('sdescr'), ldescr:request.getParameter('ldescr')]}" />
																	</div>
																</span>
															</div>               
														</th>  
													</g:if> 
					                  			</tfoot>
			                  			
					                  			<g:each in="${functionDescriptionList}" status="i" var="functionDescription">
						                  			<tbody>
							               				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						 									<td>${fieldValue(bean: functionDescription, field: "funcId")}</td>
						            					   	<td>${fieldValue(bean: functionDescription, field: "sdescr")}</td> 
						            					   	<td>${fieldValue(bean: functionDescription, field: "ldescr")}</td>
						               						<td><g:checkBox name="${functionDescription.funcId}.checkBox" /></td>                    
						               					</tr>
							               			</tbody>
					                  			</g:each>
					                  		</table>
					                  	</div>
									</div>
								</div>
							</g:if>					                  
						</div>
					</g:form>
					<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'funcId' }">
					<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'asc' }">
					<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">
				</div>
			</g:elseif>
			<%-- END OF COPY FUNCTION CODE --%>
		
			<%-- START OF PLAIN SEARCH CODE --%>
			<g:else>
				<div id="DataTableSection">
					<g:form name="searchForm" method="post" action="search">
						<input type="hidden" name="searchRef" value="searchForm">
						<div id="list-user" class="content scaffold-list" role="main">
			
							<!-- START - Search Form -->
		            		<div class="fms_widget fms_form_container">        
				              	<div class="fms_form_header">    
									<h2>Search Function</h2>
				                	<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
				              	</div>
				              	
				              	<!-- START - FMS Form -->
			          			<div class="fms_form">
			                		<div class="fms_form_body">
		      							<div class="fms_form_layout_2column">                  
			                    			<div class="fms_form_column">
		        								<label class="control-label" for="funcId" id="funcId_label">Function: </label>
			                     				<div class="fms_form_input">
							                        <input 
							                        	autofocus="autofocus"
							                        	type="text"  
							                        	maxlength="255" 
							                        	id="funcId" 
							                        	name="funcId" 
							                        	value="${params.funcId}"
							                        	class="form-control" 
							                            aria-labelledby="funcId_label" 
							                        	aria-describedby="funcId_error" >
							                        <div class="fms_form_error" id="funcId_error"></div>
			                     				</div>
			                     			</div>
			                     			<div class="fms_form_column">
			                     				
			                     				<label class="control-label" for="sdescr" id="sdescr_label">Short Description: </label>
			                     				<div class="fms_form_input">
							                        <input 
							                        	type="text"  
							                        	maxlength="32" 
							                        	id="sdescr" 
							                        	name="sdescr" 
							                        	value="${params.sdescr}"
							                        	class="form-control" 
							                            aria-labelledby="sdescr_label" 
							                        	aria-describedby="sdescr_error" >
							                        <div class="fms_form_error" id="sdescr_error"></div>
			                     				</div>
			                     				
			                     				<label class="control-label" for="ldescr" id="ldescr_label">Long Description: </label>
			                     				<div class="fms_form_input">
							                        <input 
							                        	type="text"  
							                        	maxlength="128" 
							                        	id="ldescr" 
							                        	name="ldescr" 
							                        	value="${params.ldescr}"
							                        	class="form-control" 
							                            aria-labelledby="ldescr_label" 
							                        	aria-describedby="ldescr_error" >
							                        <div class="fms_form_error" id="ldescr_error"></div>
			                     				</div>
		        							</div>	
			                     		</div>
			                     	</div>
			              			<div class="fms_form_button">
										<g:submitButton name="search" class="btn btn-primary" value="${message(code: 'default.button.search.label', default: 'Search')}" onClick="return checkForSearchCriteria()"/>			
										<input type="button" class="btn btn-default" value="Reset" onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
			          					<input type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria()">
			          					<button id="BtnInfoAlertId2" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert2" title="btnInfoAlert" data-target="#InfoAlertModal2"></button>
			                		</div>
			              			
			              			<table style="width: 100%; overflow-x: scroll; font-size: 13px;display:none;">
										<tr>
											<td><g:hiddenField name="functionList" id="functionList" value="" />
												<g:hiddenField name="userId" id="userId" value="${params.userId}"/>
												<g:hiddenField  name="editType" id="editType" value="FUNCTIONACCESS"/>
												<g:hiddenField name="id" id="id" value="${params.userId}"/>
											</td>
										</tr>
									</table>
								</div>
							</div>
							
							<g:if test="${functionDescriptionTotal > 0}">        			
								<div id="SearchResults" class="fms_widget">
									<div class="fms_widget">
										<h2>Function Search Results</h2>
										
										<div class="row fms-col_selector_row">
											<div id="SearchResultsFound" class="col-xs-6 fms-results-found">Number of Function Description - ${functionDescriptionTotal}</div>
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
										
										<div class="fms_table_wrapper">
					                		<table id="DataTable" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info">
					                  			<thead>
					                    			<tr role="row" class="tablesorter-headerRow">
					                      				<fmsui:sortableColumn property="funcId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.funcId.label', default: 'Function')}"
															params="${[offset:request.getParameter('offset'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                    				
					                    				<fmsui:sortableColumn property="sdescr" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.sdescr.label', default: 'Short Description')}"
															params="${[offset:request.getParameter('offset'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                    				
					                    				<fmsui:sortableColumn property="ldescr" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="3" data-column="2"  aria-disabled="false"
					                    					title="${message(code: 'functionDescription.ldescr.label', default: 'Long Description')}"
															params="${[offset:request.getParameter('offset'),
																funcId:request.getParameter('funcId'),
																sdescr:request.getParameter('sdescr'),
																ldescr:request.getParameter('ldescr')]}" />
					                    			</tr>
					                  			</thead>
										
												<tfoot>
					                  				<g:if test="${functionDescriptionTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
														<th colspan="4" data-column="0" class="tablesorter-headerAsc">
															<div id="SearchResultsPager" class="pager tablesorter-pager">
																<span class="right">
																	<div class="pagination">
																		<g:paginate total="${functionDescriptionTotal}" params="${[offset:request.getParameter('offset'), funcId:request.getParameter('funcId'), sdescr:request.getParameter('sdescr'), ldescr:request.getParameter('ldescr')]}" />
																	</div>
																</span>
															</div>               
														</th>  
													</g:if> 
					                  			</tfoot>			
		
					                  			<g:each in="${functionDescriptionList}" status="i" var="functionDescription">
						                  			<tbody>
							               				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						 									<td>${fieldValue(bean: functionDescription, field: "funcId")}</td>
						            					   	<td>${fieldValue(bean: functionDescription, field: "sdescr")}</td> 
						            					   	<td>${fieldValue(bean: functionDescription, field: "ldescr")}</td>
						               						<%--<td><g:checkBox name="${functionDescription.funcId}.checkBox" /></td> --%>                    
						               					</tr>
							               			</tbody>
					                  			</g:each>
					                  		</table>
					                  	</div>	
									</div>
								</div>
							</g:if>
						</div>
					</g:form>
					<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'funcId' }">
					<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'asc' }">
					<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">
				</div>
			</g:else>
			<%-- END OF PLAIN SEARCH CODE --%>
		</div>
	</div>
	
	<!-- START - Search Notice Modal -->
	<div class="modal fade" id="InfoAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error-sm">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h5>Please enter a User Id to copy functions from.</h5>            
				</div>
			
				<div class="modal-footer text-center">
					<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
				</div>
			</div>
		</div>
	</div>
	<!-- END - Search Notice Modal -->
	
	<!-- START - Search Notice Modal -->
	<div class="modal fade" id="InfoAlertModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error-sm">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h5>Copy To and From User Id cannot be the same.</h5>            
				</div>
			
				<div class="modal-footer text-center">
					<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
				</div>
			</div>
		</div>
	</div>
	<!-- END - Search Notice Modal -->
	
	<!-- START - Search Notice Modal -->
	<div class="modal fade" id="InfoAlertModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
	<!-- END - Search Notice Modal -->
	
	<!-- START - Add Notice Modal -->
	<div class="modal fade" id="InfoAlertModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>Please select atleast one function to add.</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
	<!-- END - Add Notice Modal -->
		<div class="modal fade" id="InfoAlertModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">        
	  	<div class="modal-dialog">
	       	<div class="modal-content fms_modal_info">
	           	<div class="modal-body">
	           		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	           		<h4>Please select atleast one function to copy.</h4>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
	          	</div>
	      	</div>
	  	</div>
	</div>
	<!-- START - Copy Notice Modal -->
	
	<!-- END - Copy Notice Modal -->
	
</html>
