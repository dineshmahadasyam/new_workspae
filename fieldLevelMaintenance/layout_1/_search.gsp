<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.maskedinput.js')}"></script>
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="userMaintenance"/>
		
		<script>
			function createSecColMaster() {
				var createSecColMasterCoded = "${params.sfldlId}";
				window.location.assign('<g:createLinkTo dir="/fieldLevelMaintenance/create?sfldlId="/>'
					+ createSecColMasterCoded );
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
			
					
				  if(searchCriteria == false){
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
		</script>
		<script type="text/javascript">
			$(function($){
				   
				   $("#sfldlId").alphanum({
						allow 		: '-_',
						allowSpace  : false
					});	
			})	  
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

		<meta name="layout" content="main">
	</head>

	<!-- START - FMS Content -->
	<div id="fms_content">
		<!-- START - FMS Content Header -->
		<div id="fms_content_header">
			<div class="fms_content_header_note">
				<a href="/FMSAdminConsole/userMaintenance/landing">Security Maintenance</a> / Field Level Security
        	</div>
			
			<div class="fms_content_title">
          		<h1>Field Level Security</h1>
          		<%--<div class="fms_content_header_startpage">
            		<div class="checkbox">
                		<label>
                  			<input id="myStartPage" name="myStartPage" type="checkbox" /> My start page
                		</label>
              		</div>
          		</div>
				<div class="fms_content_header_tabs">
            		<a href="#" title="Click to add individual."><i class="fa fa-user-plus"></i></a>          
            		<a id="BookmarkTab" href="#" title="Click to bookmark this page."><i class="fa fa-bookmark-o"></i></a>
          		</div> --%>
        	</div> 
      	</div>
		<!-- END - FMS Content Header -->
		
		<%--<div id="fms_content_message" class="arrow_bgnd parent_close_this">      
          	<h4>Did you know that you can change your FMS start page?</h4>
          	<p>You can select a new default start page just be navigating to the other page and clicking the checkbox.</p>
          	<a href="#" class="fms_content_message_close btn_close_this" title="Hide Form"><i class="fa fa-times-circle"></i></a>      
        </div>--%>
        
		<div id="fms_content_tabs" class="fms_tab_action">
			<ul>
		    	<li><a class="list" href="<g:createLinkTo dir="/userMaintenance/list"/>">User Security</a></li>
				<li><a class="active" href="<g:createLinkTo dir="/fieldLevelMaintenance/search"/>">Field Level Security</a></li>
				<li><a class="list" href="<g:createLinkTo dir="/userMaintenance/search?sort=funcId&order=asc"/>">Function Description</a></li>
          	</ul>
			<div id="mobile_tabs_select"></div>
		</div>

		<!-- START - FMS Content Body -->
		<div id="fms_content_body">
			
           	<p>           		
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

			<div id="DataTableSection">
	          	
	          	<!-- START - Search Form -->
				<div class="fms_widget fms_form_container">        
	              	<div class="fms_form_header">            
	                	<h2>Field Level Security Search</h2>
	                	<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
	              	</div>

					<!-- START - FMS Form -->
					<div class="fms_form">
						<form name="searchForm" action='<g:createLinkTo dir="/fieldLevelMaintenance/search"/>'>
							<input type="hidden" name="searchRef" value="searchForm">
							
							<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'sfldlId'}" />
      						<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
      						
							<div class="fms_form_body">
	
	                  			<div class="fms_form_layout_2column">                  
	                    			<div class="fms_form_column fms_long_labels">
										
										<label class="control-label" for="sfldlId" id="sfldlId_label">Field Level Security Id : </label>
	                     				<div class="fms_form_input">
					                        <input 
					                        	autofocus="autofocus"
					                        	type="text"  
					                        	maxlength="9" 
					                        	id="sfldlId" 
					                        	name="sfldlId" 
					                        	value="${params.sfldlId}"
					                        	title="Field Level Security ID"
					                        	class="form-control" 
					                            aria-labelledby="sfldlId_label" 
					                        	aria-describedby="sfldlId_error" >
					                        <div class="fms_form_error" id="sfldlId_error"></div>
	                     				</div>
	                     			</div>

									<div class="fms_form_column fms_long_labels">	
										<label class="control-label" for="description" id="description_label">Description : </label>
	                     				<div class="fms_form_input">
					                        <input 
					                        	type="text"  
					                        	maxlength="50" 
					                        	id="description" 
					                        	name="description" 
					                        	value="${params.description}"
					                        	class="form-control" 
					                            aria-labelledby="description_label" 
					                        	aria-describedby="description_error" >
					                        <div class="fms_form_error" id="description_error"></div>
	                     				</div>
	                     			</div>
	                     		</div>
	                     	</div> 
	                     	<div class="fms_form_button">
	                  			<button id="BtnSearch" onClick="return checkForSearchCritera()" type="submit" value="Search" class="btn btn-primary">Search</button>
	                  			<input type="button" class="btn btn-default" value="Reset"	onClick="document.forms['searchForm'].reset();setFirstElementFocus()">
	                  			<button id="BtnClear" class="btn btn-default" onClick="clearSearchCriteria()">Clear</button>
	                  			<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="btnInfoAlert" data-target="#InfoAlertModal"></button>
	                		</div>
	                     </form>
					</div>
					<!-- END - FMS Form -->
				</div>
				<!-- END - Search Form -->
				
				<!-- If no records found -->
				<g:if test="${params.sfldlId && iscreateSecColMasterFlag == true}">
					<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
						<g:checkURIAuthorization uri="/secColMaster/create">
							<g:if test="${iscreateSecColMasterFlag == true}">
								<input type="button" class="btn btn-primary btn-sm" 
									value="Create a Field Level Security - ${params.sfldlId}"
									onClick="createSecColMaster()" />	
							</g:if>														
						</g:checkURIAuthorization>
					</div>
					<br></br>
				</g:if>
				<!-- If records found --> 

				<g:if test="${ secColMasterCount >0}">
				
					<div id="SearchResults" class="fms_widget">
	          			
	            		<div class="fms_widget">
		              		<h2>Field Level Security Search Results</h2>
							
							<!-- Column Selector starts here -->
							<div class="row fms-col_selector_row">
								<div id="SearchResultsFound" class="col-xs-6 fms-results-found">${secColMasterCount} Results Found</div>
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
		                		<table id="DataTable" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info">
		                  			<thead>
		                    			<tr role="row" class="tablesorter-headerRow">
		                    				<fmsui:sortableColumn property="sfldlId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
												title="${message(code: 'secColMaster.secColMaster.label', default: 'Field Level Security Id')}"
												params="${[sfldlId:params.sfldlId,description:params.description, offset:request.getParameter('offset')]}" />
											<fmsui:sortableColumn property="description" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
												title="${message(code: 'secColMaster.description.label', default: 'Description')}"
												params="${[sfldlId:params.sfldlId,description:params.description, offset:request.getParameter('offset')]}"/>
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" data-columnselector="disable" aria-disabled="true">Actions</th>
		                    			</tr>
		                  			</thead>
		                  			
		                  			<tfoot>
		                  				<g:if test="${secColMasterCount > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
											<th colspan="12" data-column="0" class="tablesorter-headerAsc">
												<div id="SearchResultsPager" class="pager tablesorter-pager">
													<span class="right">
														<div class="pagination">
															<g:paginate total="${secColMasterCount}" params="${[sfldlId:params.sfldlId, description :params.description , offset:request.getParameter('offset')]}" />
														</div>
													</span>
												</div>               
											</th>  
										</g:if> 
		                  			</tfoot>
		                  			
		             				<tbody>
		                  				<g:each in="${secColMasterCollection}" status="i" var="secColMasterInstance">
			                  				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
		    									<td>${fieldValue(bean: secColMasterInstance, field: "sfldlId")}</td>
		               					       	<td>${fieldValue(bean: secColMasterInstance, field: "description")}</td>
		               					       	<td>		               					       	           				
								                    <ul class="fms_table_action">
								                      <li><g:link class="btn fms_btn_icon btn-sm" title="Click to view Master Record." action="show" params="${[editType:'MASTER', sfldlId: secColMasterInstance.sfldlId]}"><i class="fa fa-folder-open"></i></g:link></li>
								                      <li class="fms_table_action_sub">
								                        <button class="btn fms_btn_icon btn-sm" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
								                        <ul>
								                          <li><g:link class="list" action="show" params="${[editType:'DETAIL', sfldlId: secColMasterInstance.sfldlId]}">Detail Records</g:link></li>
								                        </ul>
								                      </li>
								                    </ul>
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
	</div>
	<!-- START - Search Notice Modal -->
	<div class="modal fade" id="InfoAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog">
			<div class="modal-content fms_modal_error-sm">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h5>Please enter search criteria to find Field Level Security Id.</h5>            
				</div>
			
				<div class="modal-footer text-center">
					<button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>     
				</div>
			</div>
		</div>
	</div>
	<!-- END - Search Notice Modal -->
</html>