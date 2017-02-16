<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		
		<g:set var="appContext" bean="grailsApplication"/>	
		
		<meta name="navSelector" content="maint"/> 
		<meta name="navChildSelector" content="userMaintenance"/> 
			
		<title>Search Users</title>
		
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.alphanum.js')}"></script>	
		<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.validate.js')}"></script>
		
		<script type="text/javascript">
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
		
			function clearSearchCriteria() {
				
				// Below line is added as on click of clear button we have to clear records as well.				
				$('#SearchResults').hide();
				$('.message').hide();
				$('.errors').hide();
				$('#SearchNoResults').hide();
				
				var elements = document.getElementsByTagName("input");
				var firstText = true;
				for ( var ii = 0; ii < elements.length; ii++) {
					if (elements[ii].type == "text") {
						elements[ii].value = "";
						if (firstText) {
							firstText = false;
							elements[ii].focus();
							var clear_btn = document.getElementById('Create_id')
					        if(clear_btn!=null)
						        {
					        	clear_btn.style.display="none"
					        	var usr_maintance_message_div = document.getElementById("usr_maintance_message_id")
						    	if(usr_maintance_message_div !=null){	
						    		var usr_maintance_message_div_value_1 = document.getElementById("usr_maintance_message_id").innerHTML
						    		if(usr_maintance_message_div_value_1!=null)
						  	        {
						  	         usr_maintance_message_div.style.display="none"
						  	        }
						    	}
						    
						        }
					        else
						        {
					        	var usr_maintance_message_div_1 = document.getElementById("usr_maintance_message_id")
					        	if(usr_maintance_message_div_1 !=null){		
					        		var usr_maintance_message_div_value_1 = document.getElementById("usr_maintance_message_id").innerHTML
					        		usr_maintance_message_div_value_1.style.display="none"
					        	}
						        }
					        
						}
					}
					/*if (elements[ii].type == "radio") {
						elements[ii].checked = false;
					}*/
				}
				var elements = document.getElementsByTagName("select");
				for ( var ii = 0; ii < elements.length; ii++) {
					elements[ii].selectedIndex = 0;
				}
			}
		
			function createUser() {
		
				var createUserId = document.getElementById("userId").value;
				var appName = "${appContext.metadata['app.name']}";
				
				window.location.assign("/"+appName+"/userMaintenance/create?userId="
						+ createUserId + "&groupEditType=master");
			}
		
			function clearForm() {
				$('#userId').val('');
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
					
				  if(searchCriteria == false){
				//	alert ("Please enter search criteria to find results.");
					document.getElementById('BtnInfoAlertId').click();
				  }
				  
				  return searchCriteria;
				
			}
			
			$(function($){
					   
			   $("#userId").alphanum({
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
	</head>

	<!-- START - FMS Content -->
	<div id="fms_content">
		<div id="fms_content_header">
			<div class="fms_content_header_note">
				<a href="/FMSAdminConsole/userMaintenance/list">Security Maintenance</a> / User Security
        	</div>
        	<div class="fms_content_title">
          		<h1>User Maintenance</h1>
          	</div>
		</div>
        
        <!-- START - Tabs -->
        <div id="fms_content_tabs" class="fms_tab_action">
          	<ul>
                <li><a class="active" href="<g:createLinkTo dir="/userMaintenance/list"/>">User Security</a></li>
                <li><a class="list" href="<g:createLinkTo dir="/fieldLevelMaintenance/search"/>">Field Level Security</a></li>
				<li><a class="list" href="<g:createLinkTo dir="/userMaintenance/search?sort=funcId&order=asc"/>">Function Description</a></li>
          	</ul>
    		<div id="mobile_tabs_select"></div>
		</div>
      	<!-- END - Tabs --> 
        
        <div id="fms_content_body">
	        <div id="DataTableSection">
	          	
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
					
	          	<!-- START - Search Form -->
	            <div class="fms_widget fms_form_container">        
	              	<div class="fms_form_header">            
	                	<h2>User Maintenance Search</h2>
	                	<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
	              	</div>
	              	
	              	<!-- START - FMS Form -->
          			<div class="fms_form">
	              		<form name="userSearchForm" action="/${appContext.metadata['app.name']}/userMaintenance/list">
	              			
	              			<!-- Default Column Sorting -->
	              			<input type="hidden" name="sort" value="${request.getParameter('sort') != null ?request.getParameter('sort'):'userId'}" />
      						<input type="hidden" name="order" value="${request.getParameter('order') != null ?request.getParameter('order'):'asc'}" />
      				 		
	                		<div class="fms_form_body">
      	
      							<div class="fms_form_layout_2column">                  
	                    			<div class="fms_form_column fms_long_labels">
	              	
        								<label class="control-label" for="userId" id="userId_label">User Id: </label>
	                     				<div class="fms_form_input">
					                        <input 
					                        	autofocus="autofocus"
					                        	type="text"  
					                        	maxlength="8" 
					                        	id="userId" 
					                        	name="userId" 
					                        	value="${params.userId}"
					                        	class="form-control" 
 					                            aria-labelledby="userId_label" 
					                        	aria-describedby="userId_error" >
					                        <div class="fms_form_error" id="userId_error">Error Text Error Text Error Text Error Text Error Text Error Text</div>
	                     				</div>
        							</div>
	                     		</div>
	                     	</div>
	                     	
	                     	<div class="fms_form_button">
          						<input type="submit" value="Search" class="btn btn-primary" onClick="return checkForSearchCritera()">
          						<input type="button" class="btn btn-default" value="Reset" onClick="document.forms['userSearchForm'].reset();setFirstElementFocus()">
          						<input id="BtnClear" type="button" class="btn btn-default" value="Clear" onClick="clearSearchCriteria()">
	                  			<button id="BtnInfoAlertId" type="button" class="btn fms_btn_icon btn-sm btnInfoAlert" title="" data-target="#InfoAlertModal"></button>
	                		</div>
          				</form>
          			</div>
          			<!-- END - FMS Form -->
          		</div>
				<!-- END - Search Form -->
				
				<!-- If no records found -->
				<g:if test="${create && request.getParameter('userId')}">
	          		<div id="SearchNoResults" class="fms_widget fms_widget_border fms_widget_bgnd-color">
	            		<button 
            				id="Create_id" 
            				class="btn btn-primary btn-sm" 
            				title="Click to add new User" 
            				onClick="createUser()">
            				<i class="fa fa-plus"></i>
            				Create a User - ${request.getParameter('userId')}
            			</button>
	            	</div>
	            	<br></br>
		      	</g:if>									
												
				<!-- If records found -->								
				<g:if test="${userTotal>0}">
					<div id="SearchResults" class="fms_widget">
	            		<div class="fms_widget">
		              		<h2>User Maintenance Search Results</h2>
							
							<div class="row fms-col_selector_row">
								<div id="SearchResultsFound" class="col-xs-6 fms-results-found">${userTotal} Results Found</div>
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
		                    				
		                    				<fmsui:sortableColumn property="userId" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="1" data-column="0" aria-disabled="false"
												title="${message(code: 'secUser.subscriberID.label', default: 'User Id')}"
												params="${[userId:request.getParameter('userId')]}" />
		                    				
		                    				<fmsui:sortableColumn property="userType" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="2" data-column="1" aria-disabled="false"
												title="${message(code: 'secUser.getPersonNumber.label', default: 'User Type')}"
												params="${[userId:request.getParameter('userId')]}" />
											
											<fmsui:sortableColumn property="userCategory" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="3" data-column="2" aria-disabled="false"
												title="${message(code: 'secUser.diamondID.label', default: 'User Category')}"
												params="${[userId:request.getParameter('userId')]}" />
		                    				
		                    				<fmsui:sortableColumn property="fname" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="4" data-column="3" aria-disabled="false"
												title="${message(code: 'secUser.firstName.label', default: 'First Name')}"
												params="${[userId:request.getParameter('userId')]}" />
											
											<fmsui:sortableColumn property="lname" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="5" data-column="4" aria-disabled="false"
												title="${message(code: 'secUser.lastName.label', default: 'Last Name')}"
												params="${[userId:request.getParameter('userId')]}" />
		                    				
		                    				<fmsui:sortableColumn property="dfltTemplate" class="show-disable-icon tablesorter-header" data-sorter="false" data-priority="6" data-column="5" aria-disabled="false"
												title="${message(code: 'secUser.gender.label', default: 'Template')}"
												params="${[userId:request.getParameter('userId')]}" />
											<th class="{sorter: false} tablesorter-header sorter-false" data-column="6" data-columnselector="disable" aria-disabled="true">Actions</th>
		                    			</tr>
		                  			</thead>
									
									<tfoot>
		                  				<g:if test="${userTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
											<th colspan="7" data-column="0" class="tablesorter-headerAsc">
												<div id="SearchResultsPager" class="pager tablesorter-pager">
													<span class="right">
														<div class="pagination">
															<g:paginate total="${userTotal}" params="${[userId:request.getParameter('userId')]}" />
														</div>
													</span>
												</div>               
											</th>  
										</g:if> 
		                  			</tfoot>
		                  			
				                	<tbody>
			               				<g:each in="${userList}" status="i" var="userInstance">
											<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
			 									<td>${fieldValue(bean: userInstance, field: "userId")}</td>
			            					   	<td>${fieldValue(bean: userInstance, field: "userType")}</td> 
			            					   	<td>${fieldValue(bean: userInstance, field: "userCategory")}</td>
			            					   	<td>${fieldValue(bean: userInstance, field: "fname")}</td>
			            					   	<td>${fieldValue(bean: userInstance, field: "lname")}</td>
			            					   	<td>${fieldValue(bean: userInstance, field: "dfltTemplate")}</td>             				
			               						<td>
			               							<ul class="fms_table_action">
				                  						<li>
				                  							<g:link class="btn fms_btn_icon btn-sm BtnEditRow" title="Click to view Master Record." action="edit" id="${userInstance.userId}">
				                        						<i class="fa fa-folder-open"></i>
				                        					</g:link>
				                        				</li>
	
				                        				<li class="fms_table_action_sub">
									                        <button class="btn fms_btn_icon btn-sm" title="Click to view more options."><i class="glyphicon glyphicon-option-horizontal"></i></button>
									                        <ul>
									                        	<li><g:link class="list" action="edit" title="Click to Change Password." id="${userInstance.userId}" params="${[editType :'PASSWORD']}">Change Password</g:link></li>
									                        	<li><g:link class="list" action="edit" title="Click to Reset Password." id="${userInstance.userId}" params="${[editType :'RESET']}">Reset Password</g:link></li>
									                        	<g:if test="${params.dfltTemplate == null}">
																	<li><g:link class="list" action="edit" title="Click to go to Function Access." id="${userInstance.userId}" params="${[editType :'FUNCTIONACCESS']}">Function Access</g:link></li>
																</g:if>
																<g:else>
																	<li><a class="list" title="Template ID is assigned to this User ID. Function Level Access cannot be assigned.">Function Access</a></li>
																</g:else>
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
		<!-- START - FMS Content Body -->		
	</div>          		
	<!-- END - FMS Content -->	
	
	<!-- START - Search Notice Modal -->
	<div class="modal fade" id="InfoAlertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
	<!-- END - Search Notice Modal -->								
</html>