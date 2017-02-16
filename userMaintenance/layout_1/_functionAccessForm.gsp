<%@ page import="com.perotsystems.diamond.dao.cdo.SecUser" %>

<script type="text/javascript">
	function addFunction() {		
		window.location.assign('<g:createLinkTo dir="/userMaintenance/search"/>?userId=${user?.userId}&addFunction=${true}');
	}

	function copyFunction() {		
		window.location.assign('<g:createLinkTo dir="/userMaintenance/search"/>?userId=${user?.userId}&copyFunction=${true}');
	}
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

<div id="fms_content_body">
 
 			<div class="right-corner" align="right">
				<g:if test="${request.getParameter('editType') && 'FUNCTIONACCESS'.equals(request.getParameter('editType'))}">
					<div title="The keyword for this screen that can be used for audit trail" class="right-corner" >SFUNC</div>
				</g:if>
				<g:else>
					<div class="right-corner">SUSER</div>
				</g:else>
			</div>
 
    		
    <div id="SearchNoResults">
         	
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
	
    <div id="DataTableSection">
      	
	    <!-- START - Search Form -->
		<div class="fms_widget fms_form_container">        
         	<div class="fms_form_header">            
	           	<h2>Edit User</h2>
	           	<a href="#" class="fms_form_header_close" title="Hide Form"><i class="fa fa-minus-square"></i></a>
	        </div> 
 	
	 		<!-- START - FMS Form -->
	     	<div class="fms_form">
	     			
	     		<div class="fms_form_body">
	 				<div class="fms_form_layout_2column">                  
	                	<div class="fms_form_column fms_very_long_labels">
	                			
	                 		<label class="control-label" id="userId_label" for="userId">
								<g:message code="user.userId.label" default="User Id:" />
							</label>
							<div class="fms_form_input">
								<g:textField 
									readonly="true"
									name="userId"  
									value="${user.userId}"  
									class="form-control"
									aria-labelledby="userId_label" 
									aria-describedby="userId_error" 
									aria-required="false"/>						
								<div class="fms_form_error" id="userId_error"></div>	                  
							</div> 
	
							<label class="control-label" id="userType_label" for="userType">
								<g:message code="user.userType.label" default="User Type:" />
							</label>
							<div class="fms_form_input">		
								<g:if test="${'G'.equals(user?.userType)}">			
									<g:textField class="form-control" name="userType" value="Group" disabled="true"/>
								</g:if>	
								<g:if test="${'M'.equals(user?.userType)}">			
									<g:textField class="form-control" name="userType" value="Member" disabled="true"/>
								</g:if>	
								<g:if test="${'O'.equals(user?.userType)}">			
									<g:textField class="form-control" name="userType" value="Operator" disabled="true"/>
								</g:if>	
								<g:if test="${'P'.equals(user?.userType)}">			
									<g:textField class="form-control" name="userType" value="Provider" disabled="true"/>
								</g:if>	
								<div class="fms_form_error" id="userType_error"></div>			
							</div>
							
							<label class="control-label" id="curUsrDept_label" for="curUsrDept">
								<g:message code="user.curUsrDept.label" default="Department:"   />
							</label>
							<div class="fms_form_input">
								<g:textField 
									name="curUsrDept" 
									value="${user?.curUsrDept}" 
									disabled="true"
									class="form-control"
									aria-labelledby="curUsrDept_label" 
									aria-describedby="curUsrDept_error" 
									aria-required="false"/>					
								<div class="fms_form_error" id="curUsrDept_error"></div>	                  
							</div>
							
							<label class="control-label" id="templateFlg_label" for="templateFlg">
								<g:message code="user.templateFlg.label" default="Template:" />
							</label>
							<div class="fms_form_input">
								<g:if test="${'Y'.equals(user?.templateFlg)}">			
									<g:textField class="form-control" name="suPriv" value="Yes" disabled="true"/>
								</g:if>
								<g:if test="${'N'.equals(user?.templateFlg)}">			
									<g:textField class="form-control" name="suPriv" value="No" disabled="true"/>
								</g:if>			
								<div class="fms_form_error" id="templateFlg_error"></div>	                  
							</div>
						</div>
						
						<div class="fms_form_column fms_long_labels">
							<label class="control-label" id="fullName_label" for="fullName">
								<g:message code="user.name.label" default="Name:" />
							</label>
							<div class="fms_form_input">
								<g:textField 
									name="fullName" 
									value="${user?.fname?: ''} ${user?.lname?: ''}" 
									disabled="true"
									class="form-control"
									aria-labelledby="fullName_label" 
									aria-describedby="fullName_error" 
									aria-required="false"/>					
								<div class="fms_form_error" id="fullName_error"></div>	                  
							</div> 
							
							<label class="control-label" id="suPriv_label" for="suPriv">
								<g:message code="user.suPriv.label" default="Super User:" />
							</label>
							<div class="fms_form_input">	
								<g:textField 
									name="suPriv" 
									value="${user?.suPriv}" 
									disabled="true"
									class="form-control"
									aria-labelledby="suPriv_label" 
									aria-describedby="suPriv_error" 
									aria-required="false"/>
								<div class="fms_form_error" id="suPriv_error"></div>	
							</div>
							
							<label class="control-label" id="usrLocation_label" for="usrLocation">
								<g:message code="user.usrLocation.label" default="Location:" />
							</label>
							<div class="fms_form_input">
								<g:textField 
									name="usrLocation" 
									value="${user?.usrLocation}" 
									disabled="true"
									class="form-control"
									aria-labelledby="usrLocation_label" 
									aria-describedby="usrLocation_error" 
									aria-required="false"/>					
								<div class="fms_form_error" id="usrLocation_error"></div>	                  
							</div>	
							
							<label class="control-label" id="sfldlID_label" for="sfldlID">
								<g:message code="user.sfldlId.label" default="Field Level Security ID:" />
							</label>
							<div class="fms_form_input">
								<g:textField 
									name="sfldlID" 
									value="${user?.sfldlId}" 
									disabled="true"
									class="form-control"
									aria-labelledby="sfldlID_label" 
									aria-describedby="sfldlID_error" 
									aria-required="false"/>					
								<div class="fms_form_error" id="sfldlID_error"></div>	                  
							</div>
						</div>
					</div>
				</div>
				
				<div class="fms_form_button">
	              	<g:checkURIAuthorization uri="/userMaintenance/search">
						<input type="button" name="addFunctionAccessButton" class="btn btn-primary" value="Add Function"  onClick="addFunction()">
					</g:checkURIAuthorization>
					
					<g:checkURIAuthorization uri="/userMaintenance/copyFunctionAccess">
						<input type="button" name="copyFunctionAccessButton" class="btn btn-default" value="Copy Function"  onClick="copyFunction()">
					</g:checkURIAuthorization>
	           	</div>
			</div>
			<!-- END - FMS Form -->
	    </div>
		<!-- END - Search Form -->
	
		<g:if test="${userFunctionTotal > 0}">
			<div id="SearchResults" class="fms_widget">
	          		<div class="fms_widget">
					
					<div class="row">
						<div id="SearchResultsFound" class="col-xs-6 fms-results-found">Number of Functions - ${userFunctionTotal}</div>
					</div>
					
					<div class="fms_table_wrapper">
	               		<table id="DataTable" class="tablesorter tablesorter-fms tablesorter26ba9e6columnselector" role="grid" aria-describedby="DataTable_pager_info">
	                 			<thead>
	                 				<tr role="row" class="tablesorter-headerRow">
	                 					<th class="{sorter: false} tablesorter-header sorter-false" data-column="1" aria-disabled="true">Function</th>
	                 					<th class="{sorter: false} tablesorter-header sorter-false" data-column="2" aria-disabled="true">Access</th>
	                    		</tr>
	                  		</thead>
	                  		
	                  		<tfoot>
                  				<g:if test="${userFunctionTotal > Integer.parseInt(grailsApplication.config.fms.admin.pageSize)}">
									<th colspan="7" data-column="0" class="tablesorter-headerAsc">
										<div id="SearchResultsPager" class="pager tablesorter-pager">
											<span class="right">
												<div class="pagination">
													<g:paginate total="${userFunctionTotal}" params="${[id:user?.userId, editType:'FUNCTIONACCESS',offset:request.getParameter('offset')]}" />
												</div>
											</span>
										</div>               
									</th>  
								</g:if> 
                  			</tfoot>
                  			
	                  		<tbody>
	               				<g:each in="${userFunctionList}" status="i" var="userFunction">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
	 									<td>${fieldValue(bean: userFunction, field: "funcId")}</td>
	            					   	<td>
	            					   		<g:checkBox name="${userFunctionList.funcId[i]}.checkBox" 
												value="${fieldValue(bean: userFunction, field: "pExe").equals('Y')}"/>
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
	
	<input type="hidden" name="editType" value="FUNCTIONACCESS"/>
	<input type="hidden" name="sort" value="${request.getParameter('sort') ? request.getParameter('sort') : 'insertAuditInfo' }">
	<input type="hidden" name="order" value="${request.getParameter('order') ? request.getParameter('order') : 'desc' }">
	<input type="hidden" name="offset" value="${request.getParameter('offset') ? request.getParameter('offset') : '0' }">
	<input type="hidden" name="userID" value="${user?.userId}"/>
</div>